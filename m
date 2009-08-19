From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: SNDRV_PCM_TRIGGER_STOP and audio still queued in
	the driver
Date: Wed, 19 Aug 2009 11:02:31 -0400
Message-ID: <9e4733910908190802s334788feyd36cad62dd6861f2@mail.gmail.com>
References: <9e4733910908150806x38a395bev99f042a563d76edf@mail.gmail.com>
	<9e4733910908150853k60d76150n2130fe217b432d1e@mail.gmail.com>
	<9e4733910908152040g1f229833x37bde85264f98a7f@mail.gmail.com>
	<s5h63ckc86r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181])
	by alsa0.perex.cz (Postfix) with ESMTP id A007F1037EE
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 17:02:32 +0200 (CEST)
Received: by ywh11 with SMTP id 11so6973753ywh.16
	for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2009 08:02:31 -0700 (PDT)
In-Reply-To: <s5h63ckc86r.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 19, 2009 at 8:14 AM, Takashi Iwai<tiwai@suse.de> wrote:
> At Sat, 15 Aug 2009 23:40:36 -0400,
> Jon Smirl wrote:
>>
>> On Sat, Aug 15, 2009 at 11:53 AM, Jon Smirl<jonsmirl@gmail.com> wrote:
>> > void
>> > bfio_synch_stop(void)
>> > {
>> > =A0 =A0int n;
>> >
>> > =A0 =A0if (base_handle =3D=3D NULL) {
>> > =A0 =A0 =A0 =A0return;
>> > =A0 =A0}
>> > =A0 =A0FOR_IN_AND_OUT {
>> > =A0 =A0 =A0 =A0for (n =3D 0; n < n_handles[IO]; n++) {
>>
>> I added:
>> snd_pcm_nonblock(handles[IO][n], 0)
>> snd_pcm_drain(handles[IO][n])
>> snd_pcm_nonblock(handles[IO][n], SND_PCM_NONBLOCK )
>>
>> > =A0 =A0 =A0 =A0 =A0 =A0snd_pcm_close(handles[IO][n]);
>> > =A0 =A0 =A0 =A0}
>> > =A0 =A0}
>> > }
>>
>> This is not working correctly.
>> snd_pcm_nonblock(handles[IO][n], 0)
>> It does not remove O_NONBLOCK for some unknown reason.
>>
>> I added printf() to snd_pcm_hw_nonblock()
>> The fcntl is not getting an error.
>> =A0 =A0 =A0 if (fcntl(fd, F_SETFL, flags) < 0) {
>> Flags being set are 2 (O_RDWR).
>>
>> But when I get over to snd_pcm_pre_drain_init(), I get the -EAGAIN error.
>> static int snd_pcm_pre_drain_init(struct snd_pcm_substream *substream,
>> int state)
>> {
>> =A0 =A0 =A0 printk("snd_pcm_pre_drain_init\n");
>> =A0 =A0 =A0 if (substream->f_flags & O_NONBLOCK)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
>> =A0 =A0 =A0 printk("snd_pcm_pre_drain_init 1\n");
>> =A0 =A0 =A0 substream->runtime->trigger_master =3D substream;
>> =A0 =A0 =A0 return 0;
>> }
>> So I have to conclude that fcntl(fd, F_SETFL, flags) is not removing
>> the O_NONBLOCK flag.
>
> Yeah, you found a long-standing bug :)
>
> Honestly, I think the current designed behavior is just annoying.
> An ioctl may be blocked, thus there is no real merit to return -EAGAIN
> with DRAIN ioctl.

Brutefir is a server type app, so pulseaudio should be having trouble
with this too.

Brutefir is processing audio asynchronously while monitoring for
network traffic and doing background FIR computations. The FIR
operation is heavily pipelined so it is using a 2MB ALSA buffer.

So what happens when the source stream ends? Brutefir wants to close
(or mute) the device when the stream is finished.  What brutefir wants
to do is sit in a loop calling drain() until it stops returning
EAGAIN.  That way it can keep monitoring the network for incoming
traffic.  When drain stops returning EAGAIN it is safe to close the
device.  An alternative solution is to use a thread with a blocking
drain(). But brutefir is not currently threaded.

The current brutefir code just ignores the drain state and chops off
the last 2MB of the stream. That's probably because streams don't end
very often.

I noticed this because I was sending test files one at a time to
brutefir instead of streaming. My test files would play a couple of
seconds and then get chopped off.

So what does pulse do when it runs out of input data? Does it feed the
device zeros or close/mute it?



>
> So, my preferred solution is simply to remove the O_NONBLOCK check
> in the code path above.
>
> Another solution would be a patch like below (totally untested)...
>
> Comments?
>
>
> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index d89c816..5d6b9ad 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -1343,8 +1343,6 @@ static int snd_pcm_prepare(struct snd_pcm_substream=
 *substream,
>
> =A0static int snd_pcm_pre_drain_init(struct snd_pcm_substream *substream,=
 int state)
> =A0{
> - =A0 =A0 =A0 if (substream->f_flags & O_NONBLOCK)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
> =A0 =A0 =A0 =A0substream->runtime->trigger_master =3D substream;
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -1404,7 +1402,8 @@ static int snd_pcm_drop(struct snd_pcm_substream *s=
ubstream);
> =A0* After this call, all streams are supposed to be either SETUP or DRAI=
NING
> =A0* (capture only) state.
> =A0*/
> -static int snd_pcm_drain(struct snd_pcm_substream *substream)
> +static int snd_pcm_drain(struct snd_pcm_substream *substream,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct file *file)
> =A0{
> =A0 =A0 =A0 =A0struct snd_card *card;
> =A0 =A0 =A0 =A0struct snd_pcm_runtime *runtime;
> @@ -1412,6 +1411,14 @@ static int snd_pcm_drain(struct snd_pcm_substream =
*substream)
> =A0 =A0 =A0 =A0int result =3D 0;
> =A0 =A0 =A0 =A0int i, num_drecs;
> =A0 =A0 =A0 =A0struct drain_rec *drec, drec_tmp, *d;
> + =A0 =A0 =A0 int f_flags;
> +
> + =A0 =A0 =A0 if (file)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 f_flags =3D file->f_flags;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 f_flags =3D substream->f_flags;
> + =A0 =A0 =A0 if (f_flags & O_NONBLOCK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
>
> =A0 =A0 =A0 =A0card =3D substream->pcm->card;
> =A0 =A0 =A0 =A0runtime =3D substream->runtime;
> @@ -2556,7 +2563,7 @@ static int snd_pcm_common_ioctl1(struct file *file,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return snd_pcm_hw_params_old_user(substrea=
m, arg);
> =A0#endif
> =A0 =A0 =A0 =A0case SNDRV_PCM_IOCTL_DRAIN:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return snd_pcm_drain(substream);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return snd_pcm_drain(substream, file);
> =A0 =A0 =A0 =A0case SNDRV_PCM_IOCTL_DROP:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return snd_pcm_drop(substream);
> =A0 =A0 =A0 =A0case SNDRV_PCM_IOCTL_PAUSE:
>



-- =

Jon Smirl
jonsmirl@gmail.com
