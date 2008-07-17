From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: PCM/ALSA loopback (codec-->DMA_RX-->DMA_TX-->codec)
Date: Thu, 17 Jul 2008 12:58:02 +0200
Message-ID: <487F25BA.6070902@aimvalley.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr6.xs4all.nl (smtp-vbr6.xs4all.nl [194.109.24.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A62510381B
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 12:58:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

to be able to easily check our entire analog audio in/out cicuits
(with a sweep generator feeding mic in and measuring the signal from
audio out) I'd like to know whether there's any low level loopback
available in ALSA core (or ALSA lib).

The closer to HW the better it is.

This is what our analog/digital audio path look like:

mic in -> analog in circuitry -> CODEC -> analog out circuitry -> out
                                   | |
                                   v ^
                                   | |
                                  -----
                                   CPU
                                  -----
                                  kernel
                                alsa core
                                ---------
                                 alsa lib
                              aplay/arecord


The problem is there's no loopback/echo nor sidetone possible with
the CODEC we use.
Also the DMA between CPU and CODEC cannot be looped (no DMA_RX-->DMA_TX
possible).

I know it's possible to loop digital audio in user-space with
arecord -D hw:0,0 .. | aplay -D hw:0,0 ..
This will probably give latencies of 10-100ms (depending upon CPU,
DMA priority, SW load, period_size, etc...). These are too high for the
sweep generator.

Is it possible to loopback a PCM in stream to a PCM out stream somehow
in ALSA core/lib ?

How does the latency ALSA lib example program do this ?


-- 
This message has been scanned for viruses and is believed to be clean
