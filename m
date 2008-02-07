From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: PATCH: remove duplicate controls in alc268 test mixer
Date: Fri, 8 Feb 2008 09:29:51 +1030 (CST)
Message-ID: <200802072259.m17MxphY014539@turbo.physics.adelaide.edu.au>
References: <mailman.1.1202382001.5496.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id A789C2466C
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 23:59:55 +0100 (CET)
In-Reply-To: <mailman.1.1202382001.5496.alsa-devel@alsa-project.org> from
	"alsa-devel-request@alsa-project.org" at Feb 07, 2008 12:00:01 PM
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
Cc: tiwai@suse.de, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi guys

I've just noticed that there are a handful of duplicate controls in the
ALC268 test model mixer.  This patch (against alsa-driver 1.0.16) removes
them.

Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

--- patch_realtek.c-orig	2008-02-05 19:53:24.000000000 +1030
+++ patch_realtek.c	2008-02-08 09:23:02.000000000 +1030
@@ -9834,11 +9834,6 @@
 
 #ifdef CONFIG_SND_DEBUG
 static struct snd_kcontrol_new alc268_test_mixer[] = {
-	HDA_CODEC_VOLUME("Front Playback Volume", 0x2, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Front Playback Switch", 0x14, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x3, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
-
 	/* Volume widgets */
 	HDA_CODEC_VOLUME("LOUT1 Playback Volume", 0x02, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("LOUT2 Playback Volume", 0x03, 0x0, HDA_OUTPUT),
