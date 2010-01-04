From: Riccardo Magliocchetti <riccardo.magliocchetti@gmail.com>
Subject: capturing data from the microphone
Date: Mon, 04 Jan 2010 18:39:08 +0100
Message-ID: <4B4227BC.70705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 30C561037F3
	for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2010 18:39:12 +0100 (CET)
Received: by bwz9 with SMTP id 9so24282158bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 04 Jan 2010 09:39:11 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[the same message is waiting in moderator queue, sorry if you receive it two times]

Hello,

i'm trying to capture audio data from the microphone, but i'm not able to
read any frames.
The frames are always 0 and delay is fixed to 2730. I've tried calling
snd_pcm_avail_delay,  snd_pcm_avail_update but does not make a difference.
The soundcard is driven by  snd_hda_intel. The code is more or less the
same as Paul Davis' tutorial on using the alsa api.

This is the code for init and the loop that tries to read the data:

#define MIC_BUFSIZE 4096

static gpointer snd_pcm_read(gpointer data)
{
   int error;
   snd_pcm_sframes_t frames = MIC_BUFSIZE;

   while (TRUE) {

     if ((error = snd_pcm_wait (pcm_handle, 1000)) < 0) {
         g_printerr("Failed to poll: %s\n", snd_strerror(error));
         continue;
     }

     if ((error = snd_pcm_avail(pcm_handle)) < 0) {
       if (error == -EPIPE) {
         g_printerr("xrun! %s\n", snd_strerror(error));
         continue;
         //return GINT_TO_POINTER(FALSE);
       } else {
         g_printerr("alsa_pcm_avail_update error %s\n", snd_strerror(error));
         continue;
         //return GINT_TO_POINTER(FALSE);
       }
     }

     frames = error;
     if (frames == 0)
       continue;

     frames = frames > MIC_BUFSIZE ? MIC_BUFSIZE : frames;
     g_printerr ("frames: %ld\n", frames);
     g_static_mutex_lock(&mutex);
     error = snd_pcm_readi(pcm_handle, Mic_Buffer[Mic_WriteBuf], frames);
     g_static_mutex_unlock(&mutex);
     if (error < 0)
         error = snd_pcm_recover(pcm_handle, error, 0);
     if (error < 0) {
        LOG("snd_pcm_readi FAIL!: %s\n", snd_strerror(error));
     }
   }

   return GINT_TO_POINTER(TRUE);
}

BOOL Mic_Init()
{
     snd_pcm_hw_params_t *hwparams;
     snd_pcm_sw_params_t *swparams;
     int err;

     if (Mic_Inited)
         return TRUE;

     // Open the default sound card in capture
     if ((err = snd_pcm_open(&pcm_handle, "default", SND_PCM_STREAM_CAPTURE,
/*SND_PCM_NONBLOCK*/ 0)) < 0) {
         g_printerr("Failed to open device: %s\n", snd_strerror(err));
         return FALSE;
     }

     // Allocate the snd_pcm_hw_params_t structure and fill it.
     snd_pcm_hw_params_alloca(&hwparams);
     if ((err = snd_pcm_hw_params_any(pcm_handle, hwparams)) < 0) {
         g_printerr("Failed to setup hw parameters: %s\n", snd_strerror(err));
         return FALSE;
     }

     //Set the access
     if ((err = snd_pcm_hw_params_set_access(pcm_handle, hwparams,
SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
         g_printerr("Failed to set access: %s\n", snd_strerror(err));
         return FALSE;
     }

     //dir 0 == exacte (Rate = 16K exacte)
     if ((err = snd_pcm_hw_params_set_rate(pcm_handle, hwparams, 16000, 0)) < 0) {
         g_printerr("Failed to set rate: %s\n", snd_strerror(err));
         return FALSE;
     }

     /* Set sample format */
     if ((err = snd_pcm_hw_params_set_format(pcm_handle, hwparams, SND_PCM_FORMAT_S8)) < 0) {
         g_printerr("Failed to set format: %s\n", snd_strerror(err));
         return FALSE;
     }

     // Set one channel (mono)
     if ((err = snd_pcm_hw_params_set_channels(pcm_handle, hwparams, 1)) < 0) {
         g_printerr("Failed to set channels: %s\n", snd_strerror(err));
         return FALSE;
     }

     //Set the params
     if ((err = snd_pcm_hw_params(pcm_handle, hwparams)) < 0) {
         g_printerr("Failed to set hw parameters: %s\n", snd_strerror(err));
         return FALSE;
     }

     snd_pcm_sw_params_alloca(&swparams);
     if ((err = snd_pcm_sw_params_current (pcm_handle, swparams)) < 0) {
         g_printerr("Failed to set current sw parameters: %s\n", snd_strerror(err));
         return FALSE;
     }

     if ((err = snd_pcm_sw_params_set_avail_min (pcm_handle, swparams, MIC_BUFSIZE)) < 0) {
         g_printerr("Failed to set minimum available count: %s\n", snd_strerror(err));
         return FALSE;
     }

     if ((err = snd_pcm_sw_params_set_start_threshold (pcm_handle, swparams, 0U)) < 0) {
         g_printerr("Failed to set start mode: %s\n", snd_strerror(err));
         return FALSE;
     }

     if ((err = snd_pcm_sw_params (pcm_handle, swparams)) < 0) {
         g_printerr("Failed to set sw parameters: %s\n", snd_strerror(err));
         return FALSE;
     }

     if ((err = snd_pcm_prepare (pcm_handle)) < 0) {
         g_printerr("Failed to prepare audio interface to use: %s\n", snd_strerror(err));
         return FALSE;
     }

     Mic_Inited = TRUE;
     Mic_Reset();

     mic_reader = g_thread_create(snd_pcm_read, NULL, TRUE, NULL);

     return TRUE;
}


thanks,
Riccardo
