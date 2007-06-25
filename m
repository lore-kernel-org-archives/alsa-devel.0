From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Input/output error while playing a file using aplay
Date: Tue, 26 Jun 2007 00:08:44 +0530
Message-ID: <61445c750706251138r290c2a7br6b911be6da7e53ce@mail.gmail.com>
References: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
	<1182754597.9211.1196859135@webmail.messagingengine.com>
	<61445c750706250156p42de468vecbf7ca4f373f2b0@mail.gmail.com>
	<1182769239.15228.1196888507@webmail.messagingengine.com>
	<61445c750706250504k23d02f75y52619c6cd081a5a8@mail.gmail.com>
	<61445c750706250635i61be8752lbf7a7b1930a8ca79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BACC2435A
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 20:38:46 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1306722nzf
	for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2007 11:38:45 -0700 (PDT)
In-Reply-To: <61445c750706250635i61be8752lbf7a7b1930a8ca79@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am pruning the logs in previous e-mails here since its becoming too
lengthy to read. After rewriting the pointer function I am not getting
the input/output error but I am getting underruns. I think I am little
closer to the
working driver now, am I?

here is the log, after getting couple of underrun error messages the
dma just gets halted.

Log:

snd_card_omap_alsa_open start

eac_enable_clocks start
Clocks are already enabled
eac_set_samplerate start

eac_set_samplerate end
after audio init
audio_dma_request start
omap_request_alsa_sound_dma start
omap_request_alsa_sound_dma end
snd_card_omap_alsa_open end
Playing WAVE 'startup.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
snd_omap_alsa_hw_params start
data format is 2 -- Channel 0 rate =2 and buffer size is ac44
snd_omap_alsa_hw_params end
snd_omap_alsa_prepare start
audio_configure_dma_channel start
dma_size is 2000
dma_ptr is c3540000
snd_omap_alsa_prepare end
SNDRV_PCM_IOCTL1_RESET
Inside snd_pcm_lib_ioctl_reset
Inside snd_pcm_do_start
snd_omap_alsa_trigger start
audio_set_dma_params_play start
audio_set_dma_params_play end
audio_start_dma_chain start
/*These are the platform specific dma setup routines*/
Inside omap_start_dma 1
Inside omap_start_dma 2
Inside omap_start_dma 3
audio_start_dma_chain end
snd_omap_alsa_trigger end
sound_dma_irq_handler start
!!! In DMA IRQ handler
lch=0,status=0x20, dma_status=32, data=c3cb5704
callback_omap_alsa_sound_dma start
Inside /snd_pcm_period_elapsed
Inside snd_pcm_update_hw_ptr_interrupt
Inside snd_pcm_update_hw_ptr_pos
snd_omap_alsa_pointer start
Inside snd_pcm_update_hw_ptr_pos, pos is 18153472
/**Here is a BUG**/
ALSA sound/core/pcm_lib.c:167: BUG: stream = 0, pos = 0x1150000,
buffer size = 0x4000, period size = 0x800
Inside snd_pcm_do_stop
snd_omap_alsa_trigger start
audio_stop_dma start
omap_stop_alsa_sound_dma end
omap_clear_alsa_sound_dma start
omap_clear_alsa_sound_dma end
snd_omap_alsa_trigger end
Not active
sound_dma_irq_handler end
Inside snd_pcm_status
/***Under run here ****/
underrun!!! (at least -33.431 mssnd_omap_alsa_prepare start
 long)
audio_configure_dma_channel start
dma_size is 2000
dma_ptr is c3540000
snd_omap_alsa_prepare end
SNDRV_PCM_IOCTL1_RESET
Inside snd_pcm_lib_ioctl_reset
Inside snd_pcm_do_start
snd_omap_alsa_trigger start
audio_set_dma_params_play start
audio_set_dma_params_play end
audio_start_dma_chain start
Inside omap_start_dma 1
Inside omap_start_dma 2
Inside omap_start_dma 3
audio_start_dma_chain end
snd_omap_alsa_trigger end
sound_dma_irq_handler start
!!! In DMA IRQ handler
lch=0,status=0x20, dma_status=32, data=c3cb5704
callback_omap_alsa_sound_dma start
Inside /snd_pcm_period_elapsed
Inside snd_pcm_update_hw_ptr_interrupt
Inside snd_pcm_update_hw_ptr_pos
snd_omap_alsa_pointer start
Inside snd_pcm_update_hw_ptr_pos, pos is 18153472

/***Bug ***/
ALSA sound/core/pcm_lib.c:167: BUG: stream = 0, pos = 0x1150000,
buffer size = 0x4000, period size = 0x800
Inside snd_pcm_do_stop
snd_omap_alsa_trigger start
audio_stop_dma start
omap_stop_alsa_sound_dma end
omap_clear_alsa_sound_dma start
omap_clear_alsa_sound_dma end
snd_omap_alsa_trigger end
Not active
sound_dma_irq_handler end
Inside snd_pcm_status
/***underrun***/
underrun!!! (at least -33.633 mssnd_omap_alsa_prepare start
 long)
audio_configure_dma_channel start
dma_size is 2000
dma_ptr is c3540000
snd_omap_alsa_prepare end
SNDRV_PCM_IOCTL1_RESET
Inside snd_pcm_lib_ioctl_reset
Inside snd_pcm_do_start
snd_omap_alsa_trigger start
audio_set_dma_params_play start
audio_set_dma_params_play end
audio_start_dma_chain start
Inside omap_start_dma 1
Inside omap_start_dma 2
Inside omap_start_dma 3
audio_start_dma_chain end
snd_omap_alsa_trigger end
sound_dma_irq_handler start
!!! In DMA IRQ handler
lch=0,status=0x20, dma_status=32, data=c3cb5704
callback_omap_alsa_sound_dma start
Inside /snd_pcm_period_elapsed
Inside snd_pcm_update_hw_ptr_interrupt
Inside snd_pcm_update_hw_ptr_pos
snd_omap_alsa_pointer start
Inside snd_pcm_update_hw_ptr_pos, pos is 18153472
/***BUG**/
ALSA sound/core/pcm_lib.c:167: BUG: stream = 0, pos = 0x1150000,
buffer size = 0x4000, period size = 0x800
Inside snd_pcm_do_stop
snd_omap_alsa_trigger start
audio_stop_dma start
omap_stop_alsa_sound_dma end
omap_clear_alsa_sound_dma start
omap_clear_alsa_sound_dma end
snd_omap_alsa_trigger end
Not active
sound_dma_irq_handler end
Inside snd_pcm_status
/***Underrun**/
underrun!!! (at least -33.759 mssnd_omap_alsa_prepare start
 long)
audio_configure_dma_channel start
dma_size is 2000
dma_ptr is c3540000
snd_omap_alsa_prepare end
SNDRV_PCM_IOCTL1_RESET
Inside snd_pcm_lib_ioctl_reset
Inside snd_pcm_do_start
snd_omap_alsa_trigger start
audio_set_dma_params_play start
audio_set_dma_params_play end
audio_start_dma_chain start
Inside omap_start_dma 1
Inside omap_start_dma 2

/******It hangs here, the dma halts here and no further messages are
shown*******/
