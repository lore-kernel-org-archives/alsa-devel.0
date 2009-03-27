From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: xrun on sdp340 with small buffers
Date: Thu, 26 Mar 2009 23:02:29 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ED076A6E@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 888D910388F
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 05:02:57 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

I use the sdp3430 machine driver for my board, which connects twl4030
codec and OMAP McBSP/DMA drivers. Everything works fine, I can play
audio files (using aplay).

However, I tried to force 'aplay' to use a different buffer size and
period count, and it misbehaves. My experiment was setting buffer time
to 10ms and periods to 4, and play a 8kHz sample file; this only
generates underrun messages. Under that configuration, for 8kHz, it
means a buffer size of 320B (16-bits, stereo) divided into 4 periods of
80B each. omap-pcm driver will report interrupts each 80B, as it uses a
single DMA transfer for the buffer and generates interrupts each frame.

I enabled the SND_PCM_XRUN_DEBUG option in the kernel and set
xrun_debug proc-entry to 1. And this is what I get:

# aplay audio_8000.wav --buffer-time=10000 --period-time=2500
Playing WAVE 'audio_8000.wav' : Signed 16 bit Little Endian, Rate 8000
Hz, Stereo
Unexpected hw_pointer value [1] (stream = 0, delta: -67, max jitter = 
80): wrong interrupt acknowledge?
Unexpected hw_pointer value [1] (stream = 0, delta: -6, max jitter = 
80): wrong interrupt acknowledge?

What I understand it reports is that when an interrupt happens, the
position of the transfer queried (using a dma get_pos) is lower than
the position it (at least) should be. Let's say if in the third period
(80B/period) of the buffer I should get at least a position greater
than 240, and the position returned by query is -67B behind. Is my
understanding correct? If so, does that mean the issue is with the DMA
mechanism?

Don't know if it's worth to say that adding the xrun_debung only prints
some debug messages and then playback works. But disabling the debug
shows only underrun messages.

-Misa   
