From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] conf: Add card config for Intel HDMI/DP LPE
	audio
Date: Tue,  7 Feb 2017 21:14:27 +0100
Message-ID: <20170207201427.15035-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 26E34266569
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 21:14:29 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 54F4DAB9D
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 20:14:29 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It's a playback-only device with a single PCM dedicated for HDMI/DP
output.  The dmix is working with the latest driver code, so enable it
for default, while providing the hdmi PCM dev for the accesses with
AES bits.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/conf/cards/HdmiLpeAudio.conf | 85 ++++++++++++++++++++++++++++++++++++++++
 src/conf/cards/Makefile.am       |  1 +
 2 files changed, 86 insertions(+)
 create mode 100644 src/conf/cards/HdmiLpeAudio.conf

diff --git a/src/conf/cards/HdmiLpeAudio.conf b/src/conf/cards/HdmiLpeAudio.conf
new file mode 100644
index 000000000000..f5836c05219e
--- /dev/null
+++ b/src/conf/cards/HdmiLpeAudio.conf
@@ -0,0 +1,85 @@
+#
+# Configuration for the Intel HDMI/DP LPE audio
+#
+
+<confdir:pcm/front.conf>
+
+HdmiLpeAudio.pcm.front.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type softvol
+	slave.pcm {
+		type hw
+		card $CARD
+	}
+	control {
+		name "PCM Playback Volume"
+		card $CARD
+	}
+}
+
+# default with dmix+softvol
+HdmiLpeAudio.pcm.default {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type plug
+	slave.pcm {
+		type softvol
+		slave.pcm {
+			@func concat
+			strings [ "dmix:" $CARD ]
+		}
+		control {
+			name "PCM Playback Volume"
+			card $CARD
+		}
+	}
+}
+
+<confdir:pcm/surround40.conf>
+<confdir:pcm/surround21.conf>
+<confdir:pcm/surround41.conf>
+<confdir:pcm/surround50.conf>
+<confdir:pcm/surround51.conf>
+
+<confdir:pcm/hdmi.conf>
+
+HdmiLpeAudio.pcm.hdmi.0 {
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
+	}
+	hooks.0 {
+		type ctl_elems
+		hook_args [
+			{
+				interface PCM
+				name "IEC958 Playback Default"
+				lock true
+				preserve true
+				value [ $AES0 $AES1 $AES2 $AES3 ]
+			}
+		]
+	}
+}
diff --git a/src/conf/cards/Makefile.am b/src/conf/cards/Makefile.am
index 60b5309fb621..e8b530e80a8f 100644
--- a/src/conf/cards/Makefile.am
+++ b/src/conf/cards/Makefile.am
@@ -30,6 +30,7 @@ cfg_files = aliases.conf \
 	FireWave.conf \
 	GUS.conf \
 	HDA-Intel.conf \
+	HdmiLpeAudio.conf \
 	ICE1712.conf \
 	ICE1724.conf \
 	ICH.conf \
-- 
2.11.0
