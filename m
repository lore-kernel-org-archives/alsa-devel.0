From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH] HDA-Intel: present all 4 HDMI outputs instead
	of just the first one
Date: Tue,  3 Aug 2010 20:27:49 +0300
Message-ID: <1280856469-31989-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sypressi.dnainternet.net (sypressi.dnainternet.net
	[83.102.40.135])
	by alsa0.perex.cz (Postfix) with ESMTP id 31DF5103865
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 19:27:57 +0200 (CEST)
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
Cc: Anssi Hannula <anssi.hannula@iki.fi>
List-Id: alsa-devel@alsa-project.org

Commit 92608badc519a8c1f65d93743396517aaa582b53 in linux kernel added
the possibility of 3 additional HDMI devices on indexes 7-9.

Present all those additional devices using the "hdmi" alias as well.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
Note that the hints for these devices do not appear properly and the
devices therefore do not appear in the output of "aplay -L" until the
issue described in "Device name hints and the value of DEV" thread is
fixed (with the exception of DEV=3 which happens to match the device
index of the first hdmi device and is therefore shown).

Also, I don't know what the "hint.device 3" was doing there and
therefore I couldn't test if it continues to work as intended after
changing it to "hint.device $DEVICE". Please check that it is correct.

 src/conf/cards/HDA-Intel.conf |  108 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/src/conf/cards/HDA-Intel.conf b/src/conf/cards/HDA-Intel.conf
index d3ac002..726e8c9 100644
--- a/src/conf/cards/HDA-Intel.conf
+++ b/src/conf/cards/HDA-Intel.conf
@@ -142,11 +142,17 @@ HDA-Intel.pcm.iec958.0 {
 
 <confdir:pcm/hdmi.conf>
 
-HDA-Intel.pcm.hdmi.0 {
-	@args [ CARD AES0 AES1 AES2 AES3 ]
+HDA-Intel.pcm.hdmi.common {
+	@args [ CARD DEVICE CTLINDEX AES0 AES1 AES2 AES3 ]
 	@args.CARD {
 		type string
 	}
+	@args.DEVICE {
+		type integer
+	}
+	@args.CTLINDEX {
+		type integer
+	}
 	@args.AES0 {
 		type integer
 	}
@@ -163,26 +169,120 @@ HDA-Intel.pcm.hdmi.0 {
 	slave.pcm {
 		type hw
 		card $CARD
-		device 3
+		device $DEVICE
 	}
 	hooks.0 {
 		type ctl_elems
 		hook_args [
 		{
 			name "IEC958 Playback Default"
+			index $CTLINDEX
 			lock true
 			preserve true
 			value [ $AES0 $AES1 $AES2 $AES3 ]
 		}
 		{
 			name "IEC958 Playback Switch"
+			index $CTLINDEX
 			lock true
 			preserve true
 			value true
 		}
 		]
 	}
-	hint.device 3
+	hint.device $DEVICE
+}
+
+HDA-Intel.pcm.hdmi.0 {
+	@args [ CARD AES0 AES1 AES2 AES3 ]
+	@args.CARD { type string }
+	@args.AES0 { type integer }
+	@args.AES1 { type integer }
+	@args.AES2 { type integer }
+	@args.AES3 { type integer }
+	@func refer
+	name {
+		@func concat
+		strings [
+			"cards.HDA-Intel.pcm.hdmi.common:"
+			"CARD=" $CARD ","
+			"DEVICE=3,"
+			"CTLINDEX=0,"
+			"AES0=" $AES0 ","
+			"AES1=" $AES1 ","
+			"AES2=" $AES2 ","
+			"AES3=" $AES3
+		]
+	}
+}
+
+HDA-Intel.pcm.hdmi.1 {
+	@args [ CARD AES0 AES1 AES2 AES3 ]
+	@args.CARD { type string }
+	@args.AES0 { type integer }
+	@args.AES1 { type integer }
+	@args.AES2 { type integer }
+	@args.AES3 { type integer }
+	@func refer
+	name {
+		@func concat
+		strings [
+			"cards.HDA-Intel.pcm.hdmi.common:"
+			"CARD=" $CARD ","
+			"DEVICE=7,"
+			"CTLINDEX=1,"
+			"AES0=" $AES0 ","
+			"AES1=" $AES1 ","
+			"AES2=" $AES2 ","
+			"AES3=" $AES3
+		]
+	}
+}
+
+HDA-Intel.pcm.hdmi.2 {
+	@args [ CARD AES0 AES1 AES2 AES3 ]
+	@args.CARD { type string }
+	@args.AES0 { type integer }
+	@args.AES1 { type integer }
+	@args.AES2 { type integer }
+	@args.AES3 { type integer }
+	@func refer
+	name {
+		@func concat
+		strings [
+			"cards.HDA-Intel.pcm.hdmi.common:"
+			"CARD=" $CARD ","
+			"DEVICE=8,"
+			"CTLINDEX=2,"
+			"AES0=" $AES0 ","
+			"AES1=" $AES1 ","
+			"AES2=" $AES2 ","
+			"AES3=" $AES3
+		]
+	}
+}
+
+HDA-Intel.pcm.hdmi.3 {
+	@args [ CARD AES0 AES1 AES2 AES3 ]
+	@args.CARD { type string }
+	@args.AES0 { type integer }
+	@args.AES1 { type integer }
+	@args.AES2 { type integer }
+	@args.AES3 { type integer }
+	@func refer
+	name {
+		@func concat
+		strings [
+			"cards.HDA-Intel.pcm.hdmi.common:"
+			"CARD=" $CARD ","
+			"DEVICE=9,"
+			"CTLINDEX=3,"
+			"AES0=" $AES0 ","
+			"AES1=" $AES1 ","
+			"AES2=" $AES2 ","
+			"AES3=" $AES3
+		]
+	}
 }
 
 <confdir:pcm/modem.conf>
-- 
1.7.2
