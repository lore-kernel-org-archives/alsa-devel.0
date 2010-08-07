From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] Fix missing stream for second ADC on Realtek
	ALC260 HDA codec
Date: Sun, 8 Aug 2010 00:17:05 +0930 (CST)
Message-ID: <201008071447.o77El5x2026067@mercury.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 24B83244C3
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 16:47:20 +0200 (CEST)
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
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi all

I discovered tonight that ALSA no longer sets up a stream for the second ADC
provided by the Realtek ALC260 HDA codec.  At some point alc_build_pcms()
started using stream_analog_alt_capture when constructing the second ADC
stream, but patch_alc260() was never updated accordingly.  I have no idea
when this regression occurred.  The trivial patch to patch_alc260() given
below fixes the problem as far as I can tell.  The patch is against 2.6.35.

Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

--- linux-2.6.35-orig/sound/pci/hda/patch_realtek.c	2010-08-02 07:41:14.000000000 +0930
+++ linux-2.6.35/sound/pci/hda/patch_realtek.c	2010-08-08 00:06:19.670695899 +0930
@@ -6863,6 +6863,7 @@
 
 	spec->stream_analog_playback = &alc260_pcm_analog_playback;
 	spec->stream_analog_capture = &alc260_pcm_analog_capture;
+	spec->stream_analog_alt_capture = &alc260_pcm_analog_capture;
 
 	spec->stream_digital_playback = &alc260_pcm_digital_playback;
 	spec->stream_digital_capture = &alc260_pcm_digital_capture;
