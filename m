From: Riccardo Magliocchetti <riccardo.magliocchetti@gmail.com>
Subject: Re: capturing data from the microphone
Date: Tue, 05 Jan 2010 23:12:25 +0100
Message-ID: <4B43B949.5010702@gmail.com>
References: <4B4227BC.70705@gmail.com>
	<6160a5131001050848r48f9c6ecw4db2e56bb6fd7533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 7141024450
	for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2010 23:12:31 +0100 (CET)
Received: by bwz9 with SMTP id 9so25948930bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 05 Jan 2010 14:12:30 -0800 (PST)
In-Reply-To: <6160a5131001050848r48f9c6ecw4db2e56bb6fd7533@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

pl bossart ha scritto:
> You haven't specified the buffer/period size in the hw params. See
> alsa-lib/test/pcm.c
> - Pierre

They fail when opening default device so I had to remove them, work fine when opening 
plughw:0,0 though.

> On Mon, Jan 4, 2010 at 11:39 AM, Riccardo Magliocchetti
> <riccardo.magliocchetti@gmail.com> wrote:
>> [the same message is waiting in moderator queue, sorry if you receive it two times]
>>
>> Hello,
>>
>> i'm trying to capture audio data from the microphone, but i'm not able to
>> read any frames.
>> The frames are always 0 and delay is fixed to 2730. I've tried calling
>> snd_pcm_avail_delay,  snd_pcm_avail_update but does not make a difference.
>> The soundcard is driven by  snd_hda_intel. The code is more or less the
>> same as Paul Davis' tutorial on using the alsa api.
>>
>> This is the code for init and the loop that tries to read the data:
>>
>> #define MIC_BUFSIZE 4096
>>
>> static gpointer snd_pcm_read(gpointer data)
>> {
>>   int error;
>>   snd_pcm_sframes_t frames = MIC_BUFSIZE;
>>
>>   while (TRUE) {
>>
>>     if ((error = snd_pcm_wait (pcm_handle, 1000)) < 0) {
>>         g_printerr("Failed to poll: %s\n", snd_strerror(error));
>>         continue;
>>     }
>>
>>     if ((error = snd_pcm_avail(pcm_handle)) < 0) {
>>       if (error == -EPIPE) {
>>         g_printerr("xrun! %s\n", snd_strerror(error));
>>         continue;
>>         //return GINT_TO_POINTER(FALSE);
>>       } else {
>>         g_printerr("alsa_pcm_avail_update error %s\n", snd_strerror(error));
>>         continue;
>>         //return GINT_TO_POINTER(FALSE);
>>       }
>>     }
>>
>>     frames = error;
>>     if (frames == 0)
>>       continue;
>>
>>     frames = frames > MIC_BUFSIZE ? MIC_BUFSIZE : frames;
>>     g_printerr ("frames: %ld\n", frames);
>>     g_static_mutex_lock(&mutex);
>>     error = snd_pcm_readi(pcm_handle, Mic_Buffer[Mic_WriteBuf], frames);
>>     g_static_mutex_unlock(&mutex);
>>     if (error < 0)
>>         error = snd_pcm_recover(pcm_handle, error, 0);
>>     if (error < 0) {
>>        LOG("snd_pcm_readi FAIL!: %s\n", snd_strerror(error));
>>     }
>>   }
>>
>>   return GINT_TO_POINTER(TRUE);
>> }
>>
>> BOOL Mic_Init()
>> {
>>     snd_pcm_hw_params_t *hwparams;
>>     snd_pcm_sw_params_t *swparams;
>>     int err;
>>
>>     if (Mic_Inited)
>>         return TRUE;
>>
>>     // Open the default sound card in capture
>>     if ((err = snd_pcm_open(&pcm_handle, "default", SND_PCM_STREAM_CAPTURE,
>> /*SND_PCM_NONBLOCK*/ 0)) < 0) {
>>         g_printerr("Failed to open device: %s\n", snd_strerror(err));
>>         return FALSE;
>>     }
>>
>>     // Allocate the snd_pcm_hw_params_t structure and fill it.
>>     snd_pcm_hw_params_alloca(&hwparams);
>>     if ((err = snd_pcm_hw_params_any(pcm_handle, hwparams)) < 0) {
>>         g_printerr("Failed to setup hw parameters: %s\n", snd_strerror(err));
>>         return FALSE;
>>     }
>>
>>     //Set the access
>>     if ((err = snd_pcm_hw_params_set_access(pcm_handle, hwparams,
>> SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
>>         g_printerr("Failed to set access: %s\n", snd_strerror(err));
>>         return FALSE;
>>     }
>>
>>     //dir 0 == exacte (Rate = 16K exacte)
>>     if ((err = snd_pcm_hw_params_set_rate(pcm_handle, hwparams, 16000, 0)) < 0) {
>>         g_printerr("Failed to set rate: %s\n", snd_strerror(err));
>>         return FALSE;
>>     }
>>
>>     /* Set sample format */
>>     if ((err = snd_pcm_hw_params_set_format(pcm_handle, hwparams, SND_PCM_FORMAT_S8)) < 0) {
>>         g_printerr("Failed to set format: %s\n", snd_strerror(err));
>>         return FALSE;
>>     }
>>
>>     // Set one channel (mono)
>>     if ((err = snd_pcm_hw_params_set_channels(pcm_handle, hwparams, 1)) < 0) {
>>         g_printerr("Failed to set channels: %s\n", snd_strerror(err));
>>         return FALSE;
>>     }
>>
>>     //Set the params
>>     if ((err = snd_pcm_hw_params(pcm_handle, hwparams)) < 0) {
>>         g_printerr("Failed to set hw parameters: %s\n", snd_strerror(err));
>>         return FALSE;
>>     }
>>
>>     snd_pcm_sw_params_alloca(&swparams);
>>     if ((err = snd_pcm_sw_params_current (pcm_handle, swparams)) < 0) {
>>         g_printerr("Failed to set current sw parameters: %s\n", snd_strerror(err));
>>         return FALSE;
>>     }
>>
>>     if ((err = snd_pcm_sw_params_set_avail_min (pcm_handle, swparams, MIC_BUFSIZE)) < 0) {
>>         g_printerr("Failed to set minimum available count: %s\n", snd_strerror(err));
>>         return FALSE;
>>     }
>>
>>     if ((err = snd_pcm_sw_params_set_start_threshold (pcm_handle, swparams, 0U)) < 0) {
>>         g_printerr("Failed to set start mode: %s\n", snd_strerror(err));
>>         return FALSE;
>>     }
>>
>>     if ((err = snd_pcm_sw_params (pcm_handle, swparams)) < 0) {
>>         g_printerr("Failed to set sw parameters: %s\n", snd_strerror(err));
>>         return FALSE;
>>     }
>>
>>     if ((err = snd_pcm_prepare (pcm_handle)) < 0) {
>>         g_printerr("Failed to prepare audio interface to use: %s\n", snd_strerror(err));
>>         return FALSE;
>>     }
>>
>>     Mic_Inited = TRUE;
>>     Mic_Reset();
>>
>>     mic_reader = g_thread_create(snd_pcm_read, NULL, TRUE, NULL);
>>
>>     return TRUE;
>> }
>>
>>
>> thanks,
>> Riccardo
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
