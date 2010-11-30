From: Amit Nagal <helloin.amit@gmail.com>
Subject: Re: reset of kernel input buffer for /dev/dsp
Date: Tue, 30 Nov 2010 11:51:33 +0900
Message-ID: <AANLkTi=DL5x_sHVQj4N5r_1FknyB2HB8x-DV4iYmdrVq@mail.gmail.com>
References: <AANLkTi=EzbQc__Z+4JCrMNbGpWoKWKmyX+BFhuLcKt7T@mail.gmail.com>
	<4CF35D9B.40202@ladisch.de>
	<AANLkTimAqNDjnFpumTQrTC2+9wcA=N9g72ccVvrqTXMY@mail.gmail.com>
	<s5hoc98pktq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E61D1038D4
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 03:51:39 +0100 (CET)
Received: by qwe4 with SMTP id 4so857917qwe.38
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 18:51:33 -0800 (PST)
In-Reply-To: <s5hoc98pktq.wl%tiwai@suse.de>
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
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi ,

Thanx for the patch . Application of this patch resolves kernel pcm
ring buffer flush problem .
Now SNDCTL_DSP_RESET works properly .


On a suggestive note  ,  as this bug is present in main stream kernel also ,
this patch should also be applied as well .

Thanx & Regards
Amit Nagal




On Mon, Nov 29, 2010 at 5:58 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 29 Nov 2010 17:40:03 +0900,
> Amit Nagal wrote:
>>
>> Hi ,
>>
>> Thanx for the reply .
>>
>> we tried SNDCTL_DSP_RESET , but it is not flushing =A0the kernel pcm
>> buffer for us =A0.
>
> It should. =A0It abandons the pending data and resets to the initial
> state before starting the stream.
>
> But, it might be a bug in OSS emulation later. =A0It doesn't seem to
> reset the internal buffer. =A0Try the patch below.
>
>> any other method which we can use ?
>
>> also please lets us the function available with alsa - lib which
>> serves the purpose of flushing
>> the kernel pcm buffer .
>
> snd_pcm_drop() corresponds to it.
>
>
> Takashi
>
> ---
> diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
> index 5c8c7df..a4411a3 100644
> --- a/sound/core/oss/pcm_oss.c
> +++ b/sound/core/oss/pcm_oss.c
> @@ -1510,16 +1510,19 @@ static ssize_t snd_pcm_oss_read1(struct snd_pcm_s=
ubstream *substream, char __use
> =A0static int snd_pcm_oss_reset(struct snd_pcm_oss_file *pcm_oss_file)
> =A0{
> =A0 =A0 =A0 =A0struct snd_pcm_substream *substream;
> + =A0 =A0 =A0 struct snd_pcm_runtime *runtime;
> + =A0 =A0 =A0 int i;
>
> - =A0 =A0 =A0 substream =3D pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBA=
CK];
> - =A0 =A0 =A0 if (substream !=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_pcm_kernel_ioctl(substream, SNDRV_PCM_I=
OCTL_DROP, NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 substream->runtime->oss.prepare =3D 1;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 substream =3D pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTUR=
E];
> - =A0 =A0 =A0 if (substream !=3D NULL) {
> + =A0 =A0 =A0 for (i =3D 0; i < 2; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 substream =3D pcm_oss_file->streams[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!substream)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 runtime =3D substream->runtine;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_pcm_kernel_ioctl(substream, SNDRV_PCM_=
IOCTL_DROP, NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 substream->runtime->oss.prepare =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 runtime->oss.prepare =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 runtime->oss.buffer_used =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 runtime->oss.prev_hw_ptr_period =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 runtime->oss.period_ptr =3D 0;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
