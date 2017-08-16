From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] conf: HdmiLpeAudio: add support for 3 devices
Date: Wed, 16 Aug 2017 11:08:48 -0500
Message-ID: <20170816160848.19297-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D1D5026755B
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 18:10:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The LPE Audio mode on BYT/CHT supports up to 3 devices, and also supports
IEC61937 passthrough. Add missing alsa-lib configurations so that
apps can use the usual -D'hdmi:CARD=X,DEV=Y,AES0=0x[4|6]' syntax, e.g.

aplay -D'hdmi:CARD=0,DEV=2,AES0=0x6' -c2 -r48000 -fs16_le
ac3_surround_test.spdif

Tested on Zotac PI330 with Onkyo receiver

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 src/conf/cards/HdmiLpeAudio.conf | 77 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/src/conf/cards/HdmiLpeAudio.conf b/src/conf/cards/HdmiLpeAudio.conf
index dae71fa..9fa30da 100644
--- a/src/conf/cards/HdmiLpeAudio.conf
+++ b/src/conf/cards/HdmiLpeAudio.conf
@@ -56,6 +56,83 @@ HdmiLpeAudio.pcm.hdmi.0 {
 			{
 				interface PCM
 				name "IEC958 Playback Default"
+				device 0
+				lock true
+				preserve true
+				value [ $AES0 $AES1 $AES2 $AES3 ]
+			}
+		]
+	}
+}
+
+HdmiLpeAudio.pcm.hdmi.1 {
+	@args [ CARD AES0 AES1 AES2 AES3 ]
+	@args.CARD {
+		type string
+	}
+	@args.AES0 {
+		type integer
+	}
+	@args.AES1 {
+		type integer
+	}
+	@args.AES2 {
+		type integer
+	}
+	@args.AES3 {
+		type integer
+	}
+	type hooks
+	slave.pcm {
+		type hw
+		card $CARD
+		device 1
+	}
+	hooks.0 {
+		type ctl_elems
+		hook_args [
+			{
+				interface PCM
+				name "IEC958 Playback Default"
+				device 1
+				lock true
+				preserve true
+				value [ $AES0 $AES1 $AES2 $AES3 ]
+			}
+		]
+	}
+}
+
+HdmiLpeAudio.pcm.hdmi.2 {
+	@args [ CARD AES0 AES1 AES2 AES3 ]
+	@args.CARD {
+		type string
+	}
+	@args.AES0 {
+		type integer
+	}
+	@args.AES1 {
+		type integer
+	}
+	@args.AES2 {
+		type integer
+	}
+	@args.AES3 {
+		type integer
+	}
+	type hooks
+	slave.pcm {
+		type hw
+		card $CARD
+		device 2
+	}
+	hooks.0 {
+		type ctl_elems
+		hook_args [
+			{
+				interface PCM
+				name "IEC958 Playback Default"
+				device 2
 				lock true
 				preserve true
 				value [ $AES0 $AES1 $AES2 $AES3 ]
-- 
2.9.3
