From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: capturing data from the microphone
Date: Tue, 5 Jan 2010 10:48:25 -0600
Message-ID: <6160a5131001050848r48f9c6ecw4db2e56bb6fd7533@mail.gmail.com>
References: <4B4227BC.70705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id 10B20243A1
	for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2010 17:48:28 +0100 (CET)
Received: by pwi18 with SMTP id 18so40765965pwi.32
	for <alsa-devel@alsa-project.org>; Tue, 05 Jan 2010 08:48:27 -0800 (PST)
In-Reply-To: <4B4227BC.70705@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Riccardo Magliocchetti <riccardo.magliocchetti@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

You haven't specified the buffer/period size in the hw params. See
alsa-lib/test/pcm.c
- Pierre

On Mon, Jan 4, 2010 at 11:39 AM, Riccardo Magliocchetti
<riccardo.magliocchetti@gmail.com> wrote:
> [the same message is waiting in moderator queue, sorry if you receive it =
two times]
>
> Hello,
>
> i'm trying to capture audio data from the microphone, but i'm not able to
> read any frames.
> The frames are always 0 and delay is fixed to 2730. I've tried calling
> snd_pcm_avail_delay, =A0snd_pcm_avail_update but does not make a differen=
ce.
> The soundcard is driven by =A0snd_hda_intel. The code is more or less the
> same as Paul Davis' tutorial on using the alsa api.
>
> This is the code for init and the loop that tries to read the data:
>
> #define MIC_BUFSIZE 4096
>
> static gpointer snd_pcm_read(gpointer data)
> {
> =A0 int error;
> =A0 snd_pcm_sframes_t frames =3D MIC_BUFSIZE;
>
> =A0 while (TRUE) {
>
> =A0 =A0 if ((error =3D snd_pcm_wait (pcm_handle, 1000)) < 0) {
> =A0 =A0 =A0 =A0 g_printerr("Failed to poll: %s\n", snd_strerror(error));
> =A0 =A0 =A0 =A0 continue;
> =A0 =A0 }
>
> =A0 =A0 if ((error =3D snd_pcm_avail(pcm_handle)) < 0) {
> =A0 =A0 =A0 if (error =3D=3D -EPIPE) {
> =A0 =A0 =A0 =A0 g_printerr("xrun! %s\n", snd_strerror(error));
> =A0 =A0 =A0 =A0 continue;
> =A0 =A0 =A0 =A0 //return GINT_TO_POINTER(FALSE);
> =A0 =A0 =A0 } else {
> =A0 =A0 =A0 =A0 g_printerr("alsa_pcm_avail_update error %s\n", snd_strerr=
or(error));
> =A0 =A0 =A0 =A0 continue;
> =A0 =A0 =A0 =A0 //return GINT_TO_POINTER(FALSE);
> =A0 =A0 =A0 }
> =A0 =A0 }
>
> =A0 =A0 frames =3D error;
> =A0 =A0 if (frames =3D=3D 0)
> =A0 =A0 =A0 continue;
>
> =A0 =A0 frames =3D frames > MIC_BUFSIZE ? MIC_BUFSIZE : frames;
> =A0 =A0 g_printerr ("frames: %ld\n", frames);
> =A0 =A0 g_static_mutex_lock(&mutex);
> =A0 =A0 error =3D snd_pcm_readi(pcm_handle, Mic_Buffer[Mic_WriteBuf], fra=
mes);
> =A0 =A0 g_static_mutex_unlock(&mutex);
> =A0 =A0 if (error < 0)
> =A0 =A0 =A0 =A0 error =3D snd_pcm_recover(pcm_handle, error, 0);
> =A0 =A0 if (error < 0) {
> =A0 =A0 =A0 =A0LOG("snd_pcm_readi FAIL!: %s\n", snd_strerror(error));
> =A0 =A0 }
> =A0 }
>
> =A0 return GINT_TO_POINTER(TRUE);
> }
>
> BOOL Mic_Init()
> {
> =A0 =A0 snd_pcm_hw_params_t *hwparams;
> =A0 =A0 snd_pcm_sw_params_t *swparams;
> =A0 =A0 int err;
>
> =A0 =A0 if (Mic_Inited)
> =A0 =A0 =A0 =A0 return TRUE;
>
> =A0 =A0 // Open the default sound card in capture
> =A0 =A0 if ((err =3D snd_pcm_open(&pcm_handle, "default", SND_PCM_STREAM_=
CAPTURE,
> /*SND_PCM_NONBLOCK*/ 0)) < 0) {
> =A0 =A0 =A0 =A0 g_printerr("Failed to open device: %s\n", snd_strerror(er=
r));
> =A0 =A0 =A0 =A0 return FALSE;
> =A0 =A0 }
>
> =A0 =A0 // Allocate the snd_pcm_hw_params_t structure and fill it.
> =A0 =A0 snd_pcm_hw_params_alloca(&hwparams);
> =A0 =A0 if ((err =3D snd_pcm_hw_params_any(pcm_handle, hwparams)) < 0) {
> =A0 =A0 =A0 =A0 g_printerr("Failed to setup hw parameters: %s\n", snd_str=
error(err));
> =A0 =A0 =A0 =A0 return FALSE;
> =A0 =A0 }
>
> =A0 =A0 //Set the access
> =A0 =A0 if ((err =3D snd_pcm_hw_params_set_access(pcm_handle, hwparams,
> SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
> =A0 =A0 =A0 =A0 g_printerr("Failed to set access: %s\n", snd_strerror(err=
));
> =A0 =A0 =A0 =A0 return FALSE;
> =A0 =A0 }
>
> =A0 =A0 //dir 0 =3D=3D exacte (Rate =3D 16K exacte)
> =A0 =A0 if ((err =3D snd_pcm_hw_params_set_rate(pcm_handle, hwparams, 160=
00, 0)) < 0) {
> =A0 =A0 =A0 =A0 g_printerr("Failed to set rate: %s\n", snd_strerror(err));
> =A0 =A0 =A0 =A0 return FALSE;
> =A0 =A0 }
>
> =A0 =A0 /* Set sample format */
> =A0 =A0 if ((err =3D snd_pcm_hw_params_set_format(pcm_handle, hwparams, S=
ND_PCM_FORMAT_S8)) < 0) {
> =A0 =A0 =A0 =A0 g_printerr("Failed to set format: %s\n", snd_strerror(err=
));
> =A0 =A0 =A0 =A0 return FALSE;
> =A0 =A0 }
>
> =A0 =A0 // Set one channel (mono)
> =A0 =A0 if ((err =3D snd_pcm_hw_params_set_channels(pcm_handle, hwparams,=
 1)) < 0) {
> =A0 =A0 =A0 =A0 g_printerr("Failed to set channels: %s\n", snd_strerror(e=
rr));
> =A0 =A0 =A0 =A0 return FALSE;
> =A0 =A0 }
>
> =A0 =A0 //Set the params
> =A0 =A0 if ((err =3D snd_pcm_hw_params(pcm_handle, hwparams)) < 0) {
> =A0 =A0 =A0 =A0 g_printerr("Failed to set hw parameters: %s\n", snd_strer=
ror(err));
> =A0 =A0 =A0 =A0 return FALSE;
> =A0 =A0 }
>
> =A0 =A0 snd_pcm_sw_params_alloca(&swparams);
> =A0 =A0 if ((err =3D snd_pcm_sw_params_current (pcm_handle, swparams)) < =
0) {
> =A0 =A0 =A0 =A0 g_printerr("Failed to set current sw parameters: %s\n", s=
nd_strerror(err));
> =A0 =A0 =A0 =A0 return FALSE;
> =A0 =A0 }
>
> =A0 =A0 if ((err =3D snd_pcm_sw_params_set_avail_min (pcm_handle, swparam=
s, MIC_BUFSIZE)) < 0) {
> =A0 =A0 =A0 =A0 g_printerr("Failed to set minimum available count: %s\n",=
 snd_strerror(err));
> =A0 =A0 =A0 =A0 return FALSE;
> =A0 =A0 }
>
> =A0 =A0 if ((err =3D snd_pcm_sw_params_set_start_threshold (pcm_handle, s=
wparams, 0U)) < 0) {
> =A0 =A0 =A0 =A0 g_printerr("Failed to set start mode: %s\n", snd_strerror=
(err));
> =A0 =A0 =A0 =A0 return FALSE;
> =A0 =A0 }
>
> =A0 =A0 if ((err =3D snd_pcm_sw_params (pcm_handle, swparams)) < 0) {
> =A0 =A0 =A0 =A0 g_printerr("Failed to set sw parameters: %s\n", snd_strer=
ror(err));
> =A0 =A0 =A0 =A0 return FALSE;
> =A0 =A0 }
>
> =A0 =A0 if ((err =3D snd_pcm_prepare (pcm_handle)) < 0) {
> =A0 =A0 =A0 =A0 g_printerr("Failed to prepare audio interface to use: %s\=
n", snd_strerror(err));
> =A0 =A0 =A0 =A0 return FALSE;
> =A0 =A0 }
>
> =A0 =A0 Mic_Inited =3D TRUE;
> =A0 =A0 Mic_Reset();
>
> =A0 =A0 mic_reader =3D g_thread_create(snd_pcm_read, NULL, TRUE, NULL);
>
> =A0 =A0 return TRUE;
> }
>
>
> thanks,
> Riccardo
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
