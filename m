From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: SNDRV_PCM_TRIGGER_STOP and audio still queued in
	the driver
Date: Wed, 19 Aug 2009 12:50:09 -0400
Message-ID: <9e4733910908190950r409c6c1dgd9019ebda4ccd6be@mail.gmail.com>
References: <9e4733910908150806x38a395bev99f042a563d76edf@mail.gmail.com>
	<9e4733910908150853k60d76150n2130fe217b432d1e@mail.gmail.com>
	<9e4733910908152040g1f229833x37bde85264f98a7f@mail.gmail.com>
	<s5h63ckc86r.wl%tiwai@suse.de>
	<9e4733910908190802s334788feyd36cad62dd6861f2@mail.gmail.com>
	<s5h8whfsuqq.wl%tiwai@suse.de>
	<9e4733910908190819l19d99236xbf27106d742a54a6@mail.gmail.com>
	<s5h4os3rf80.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 2770924338
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 18:50:11 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so1735966anc.2
	for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2009 09:50:10 -0700 (PDT)
In-Reply-To: <s5h4os3rf80.wl%tiwai@suse.de>
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

On Wed, Aug 19, 2009 at 11:33 AM, Takashi Iwai<tiwai@suse.de> wrote:
> At Wed, 19 Aug 2009 11:19:45 -0400,
> Jon Smirl wrote:
>>
>> On Wed, Aug 19, 2009 at 11:12 AM, Takashi Iwai<tiwai@suse.de> wrote:
>> > At Wed, 19 Aug 2009 11:02:31 -0400,
>> > Jon Smirl wrote:
>> >>
>> >> On Wed, Aug 19, 2009 at 8:14 AM, Takashi Iwai<tiwai@suse.de> wrote:
>> >> > At Sat, 15 Aug 2009 23:40:36 -0400,
>> >> > Jon Smirl wrote:
>> >> >>
>> >> >> On Sat, Aug 15, 2009 at 11:53 AM, Jon Smirl<jonsmirl@gmail.com> wr=
ote:
>> >> >> > void
>> >> >> > bfio_synch_stop(void)
>> >> >> > {
>> >> >> > =A0 =A0int n;
>> >> >> >
>> >> >> > =A0 =A0if (base_handle =3D=3D NULL) {
>> >> >> > =A0 =A0 =A0 =A0return;
>> >> >> > =A0 =A0}
>> >> >> > =A0 =A0FOR_IN_AND_OUT {
>> >> >> > =A0 =A0 =A0 =A0for (n =3D 0; n < n_handles[IO]; n++) {
>> >> >>
>> >> >> I added:
>> >> >> snd_pcm_nonblock(handles[IO][n], 0)
>> >> >> snd_pcm_drain(handles[IO][n])
>> >> >> snd_pcm_nonblock(handles[IO][n], SND_PCM_NONBLOCK )
>> >> >>
>> >> >> > =A0 =A0 =A0 =A0 =A0 =A0snd_pcm_close(handles[IO][n]);
>> >> >> > =A0 =A0 =A0 =A0}
>> >> >> > =A0 =A0}
>> >> >> > }
>> >> >>
>> >> >> This is not working correctly.
>> >> >> snd_pcm_nonblock(handles[IO][n], 0)
>> >> >> It does not remove O_NONBLOCK for some unknown reason.
>> >> >>
>> >> >> I added printf() to snd_pcm_hw_nonblock()
>> >> >> The fcntl is not getting an error.
>> >> >> =A0 =A0 =A0 if (fcntl(fd, F_SETFL, flags) < 0) {
>> >> >> Flags being set are 2 (O_RDWR).
>> >> >>
>> >> >> But when I get over to snd_pcm_pre_drain_init(), I get the -EAGAIN=
 error.
>> >> >> static int snd_pcm_pre_drain_init(struct snd_pcm_substream *substr=
eam,
>> >> >> int state)
>> >> >> {
>> >> >> =A0 =A0 =A0 printk("snd_pcm_pre_drain_init\n");
>> >> >> =A0 =A0 =A0 if (substream->f_flags & O_NONBLOCK)
>> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
>> >> >> =A0 =A0 =A0 printk("snd_pcm_pre_drain_init 1\n");
>> >> >> =A0 =A0 =A0 substream->runtime->trigger_master =3D substream;
>> >> >> =A0 =A0 =A0 return 0;
>> >> >> }
>> >> >> So I have to conclude that fcntl(fd, F_SETFL, flags) is not removi=
ng
>> >> >> the O_NONBLOCK flag.
>> >> >
>> >> > Yeah, you found a long-standing bug :)
>> >> >
>> >> > Honestly, I think the current designed behavior is just annoying.
>> >> > An ioctl may be blocked, thus there is no real merit to return -EAG=
AIN
>> >> > with DRAIN ioctl.
>> >>
>> >> Brutefir is a server type app, so pulseaudio should be having trouble
>> >> with this too.
>> >
>> > Maybe not. =A0Otherwise we've got already many bug reports.
>> >
>> > The difference is how to wait until all data is out. =A0PA would likely
>> > wait using its own timer stuff without sleeping in drain ioctl.
>>
>> Can you implement a polled drain by checking if state is RUNNING and
>> the looking for the transition to STOPPED?
>
> Could you elaborate?
>
>> Is there anything special about being in state DRAINING?
>
> Yes. =A0The drain needs the following active procedure:
>
> 1. app notifies the driver that the stream is drained.
> 2. app go to sleep (in drain ioctl)
> 3. the driver marks the PCM state DRAIN
> 4. when the all data has been sent out, the driver stops the stream,
> =A0wakes up the sleeper
> 5. app returns
>
> Without the explicit notification, the driver cannot know whether
> the stream is supposed to be stopped successfully or just get an
> XRUN.
>
> I guess you think that ioctl(DRAIN) just marks and returns, then

That would be a function of being in OF_NONBLOCKED state.

> app does poll() to wait until all data sent out. =A0This would work,
> too, after some amount of work. =A0But, just fixing the existing DRAIN
> ioctl is far less work in the end...

Right now drain() is a synchronous API. There is no alternative for
asynchronously starting a drain and then polling or getting signaled
when it is finished. If the app is not threaded it will go
unresponsive while in the drain IOCTL (20 seconds in my case).
Currently brutefir is not written at a threaded app.

I haven't started working with the user space API yet (I'm just trying
to fix brutefir). For server type apps it would be nice to integrate
ALSA into the poll/select process. Is that something that can be done?

-- =

Jon Smirl
jonsmirl@gmail.com
