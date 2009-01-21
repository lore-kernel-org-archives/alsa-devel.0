From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: gusclassic alsa configuration
Date: Wed, 21 Jan 2009 22:35:07 +0100
Message-ID: <20090121223507.778f954d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id D49D61037E3
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 22:32:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I have given another go to fix Gravis Ultrasound configuration for ALSA 
and I have found a working configuration. The Gravis Classic card uses
non-mmap and non-interleaved sound format so aplay fails with standard
configuration. Even worse, no default pcm device is defined so someone
who wants just install Linux on old computer won't get any sound.

I have modified the GUS.conf from the /usr/share/alsa/cards and the
GUS card now works with alsa and oss. My changes to the GUS.conf
are below (as a diff).

Does anybody know how to upload MIDI instruments into the GUS card
under ALSA? (like with awesfx for SB AWE)

Regards,
Krzysztof

--- /usr/src/alsa/alsa-lib-1.0.18/src/conf/cards/GUS.conf	2008-10-29 13:42:10.000000000 +0100
+++ GUS.conf	2009-01-21 20:42:42.675215220 +0100
@@ -19,10 +19,12 @@
 }	
 
 #
-# It's a temporary solution.
+# First route two channels to two other channels
+# to drop mmap requirement. Then, use the mmap_emul
+# plugin to allow using noninterleaved channels.
 #
 
-!pcm.hw {
+!pcm.default {
 	@args [ CARD DEV SUBDEV ]
 	@args.CARD {
 		type string
@@ -58,9 +60,16 @@
 			name defaults.pcm.subdevice
 		}
 	}		
-	type hw
-	card $CARD
-	device $DEV
-	subdevice $SUBDEV
-	mmap_emulation on
+	type route
+	slave.pcm {
+		type mmap_emul
+		slave.pcm {
+			type hw
+			card $CARD
+			device $DEV
+			subdevice $SUBDEV
+		}
+	}
+	ttable.0.0 1
+	ttable.1.1 1
 }

----------------------------------------------------------------------
Speak Up. Angielski szybko i skutecznie. 3 miesiace nauki gratis.
Sprawdz. >> http://link.interia.pl/f2019
