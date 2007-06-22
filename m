From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Input/output error while playing a file using aplay
Date: Sat, 23 Jun 2007 01:42:22 +0530
Message-ID: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by alsa0.perex.cz (Postfix) with ESMTP id BFF8B24358
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2007 22:12:24 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so911433nzf
	for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2007 13:12:23 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

I am testing my audio driver using aplay. I trying to play an audio file using:

#aplay -Dplughw:0,0 --rate=44100 --format=S16 --channels=2 test.wav
 The log is as follows,

snd_card_omap_alsa_open start
snd_card_omap_alsa_open end
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
snd_omap_alsa_hw_params start
snd_omap_alsa_prepare start
snd_omap_alsa_prepare end
snd_omap_alsa_trigger start
audio_start_dma_chain start
audio_start_dma_chain end
omap_start_alsa_sound_dma end
snd_omap_alsa_trigger end
snd_omap_alsa_pointer start
audio_get_dma_pos start
audio_get_dma_pos end

It waits here for sometime and then I get
snd_omap_alsa_trigger starte error: Input/output error

Then the things are wound up as:

audio_stop_dma start
omap_stop_alsa_sound_dma start
omap_stop_alsa_sound_dma end
omap_clear_alsa_sound_dma start
omap_clear_alsa_sound_dma end
snd_omap_alsa_trigger end

snd_omap_alsa_hw_free start
snd_omap_alsa_hw_free end
snd_card_omap_alsa_close start
snd_card_omap_alsa_close end


So basically the problem is in trigger where it waits for something
and then winds up things. Any idea, what could be the reason. I am
thinking it has to do something with
DMA interrupts etc.
