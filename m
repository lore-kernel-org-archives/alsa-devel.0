From: <danny@mailmij.org>
Subject: [PATCH] buffersize and constraints on pmac
Date: Wed, 15 Dec 2004 21:31:30 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0412152119150.15285-100000@luna.ellen.dexterslabs.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.mailmij.org (a62-216-27-249.adsl.cistron.nl [62.216.27.249])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C2A70229
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2004 21:31:30 +0100 (MET)
Received: from localhost (localhost [127.0.0.1])
	by mail.mailmij.org (Postfix) with ESMTP id 3BF865BBA
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2004 21:31:30 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Ok as promised a small patch to fix choppy sound when buffer/period size 
are set to certain values. I was only able to test this on 'Snapper', so I 
hope some people with other cards can verify that this helps (to reproduce 
the choppy sound you could try xmms (or bmp) with the alsaplugin and set 
period/buffer time to arbitrary values while playing a 32 kHz or 
lower mp3 or OGG file. 
Setting it both very low works best for testing).

----------



Buffersize is a bit small compared to the OSS driver (dmasound.h says 128kb is limit for Amiga, 
for pmac 256kb is used). At least on Snapper, some samplerates cause choppy sound when periods<3 
or buffersize is not a multiple of periodsize.

Signed-off-by: Danny Tholen <obiwan@mailmij.org>

--- linux-2.6.7/sound/ppc/pmac.c.old    2004-11-21 15:14:50.000000000 -0500
+++ linux-2.6.7/sound/ppc/pmac.c        2004-11-21 15:17:13.000000000 -0500
@@ -425,7 +425,7 @@
        .rate_max =             44100,
        .channels_min =         2,
        .channels_max =         2,
-       .buffer_bytes_max =     32768,
+       .buffer_bytes_max =     131072,
        .period_bytes_min =     256,
        .period_bytes_max =     16384,
        .periods_min =          1,
@@ -444,7 +444,7 @@
        .rate_max =             44100,
        .channels_min =         2,
        .channels_max =         2,
-       .buffer_bytes_max =     32768,
+       .buffer_bytes_max =     131072,
        .period_bytes_min =     256,
        .period_bytes_max =     16384,
        .periods_min =          1,
@@ -550,6 +550,9 @@
        if (chip->can_duplex)
                snd_pcm_set_sync(subs);

+       /* constraints to fix choppy sound */
+       snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIODS, 3, UINT_MAX);
+       snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
        return 0;
 }





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
