From: Luke Yelavich <themuso@ubuntu.com>
Subject: [PATCH] Add support for Echo3G devices. Thanks to
	unimatrix.
Date: Wed,  8 Feb 2012 15:09:55 +1100
Message-ID: <1328674195-26275-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id CFA6A24539
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 05:10:03 +0100 (CET)
Received: from cpe-58-160-38-86.phzl1.ken.bigpond.net.au ([58.160.38.86]
	helo=acapella.yelavich.home) by youngberry.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <themuso@ubuntu.com>) id 1Ruyr4-0003g2-Kd
	for alsa-devel@alsa-project.org; Wed, 08 Feb 2012 04:10:03 +0000
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

From: Luke Yelavich <luke.yelavich@canonical.com>

BugLink: https://bugs.launchpad.net/bugs/433573

Signed-off-by: Luke Yelavich <luke.yelavich@canonical.com>
---
 src/conf/cards/Echo_Echo3G.conf |  318 +++++++++++++++++++++++++++++++++++++++
 src/conf/cards/Makefile.am      |    1 +
 2 files changed, 319 insertions(+), 0 deletions(-)
 create mode 100644 src/conf/cards/Echo_Echo3G.conf

diff --git a/src/conf/cards/Echo_Echo3G.conf b/src/conf/cards/Echo_Echo3G.conf
new file mode 100644
index 0000000..766f13f
--- /dev/null
+++ b/src/conf/cards/Echo_Echo3G.conf
@@ -0,0 +1,318 @@
+#
+# Configuration for the Echo3G driver
+#
+
+<confdir:pcm/front.conf>
+Echo_Echo3G.pcm.front.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type hw
+	card $CARD
+	device 0
+	subdevice 0
+}
+
+<confdir:pcm/rear.conf>
+Echo_Echo3G.pcm.rear.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type hw
+	card $CARD
+	device 0
+	subdevice 4
+}
+
+<confdir:pcm/center_lfe.conf>
+Echo_Echo3G.pcm.center_lfe.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type hw
+	card $CARD
+	device 0
+	subdevice 2
+}
+
+<confdir:pcm/side.conf>
+Echo_Echo3G.pcm.side.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type hw
+	card $CARD
+	device 0
+	subdevice 6
+}
+
+<confdir:pcm/surround40.conf>
+Echo_Echo3G.pcm.surround40.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type multi
+	slaves [
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.front.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.rear.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+	]
+	bindings [
+		{ slave 0 channel 0 }
+		{ slave 0 channel 1 }
+		{ slave 1 channel 0 }
+		{ slave 1 channel 1 }
+	]
+}
+
+<confdir:pcm/surround41.conf>
+Echo_Echo3G.pcm.surround41.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type multi
+	slaves [
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.front.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.rear.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.center_lfe.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+	]
+	bindings [
+		{ slave 0 channel 0 }
+		{ slave 0 channel 1 }
+		{ slave 1 channel 0 }
+		{ slave 1 channel 1 }
+		{ slave 2 channel 0 }
+	]
+}
+
+<confdir:pcm/surround50.conf>
+Echo_Echo3G.pcm.surround50.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type multi
+	slaves [
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.front.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.rear.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.center_lfe.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+	]
+	bindings [
+		{ slave 0 channel 0 }
+		{ slave 0 channel 1 }
+		{ slave 1 channel 0 }
+		{ slave 1 channel 1 }
+		{ slave 2 channel 1 }
+	]
+}
+
+<confdir:pcm/surround51.conf>
+Echo_Echo3G.pcm.surround51.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type multi
+	slaves [
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.front.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.rear.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.center_lfe.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+	]
+	bindings [
+		{ slave 0 channel 0 }
+		{ slave 0 channel 1 }
+		{ slave 1 channel 0 }
+		{ slave 1 channel 1 }
+		{ slave 2 channel 0 }
+		{ slave 2 channel 1 }
+	]
+}
+
+<confdir:pcm/surround71.conf>
+Echo_Echo3G.pcm.surround71.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type multi
+	slaves [
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.front.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.rear.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.center_lfe.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.Echo_Echo3G.pcm.side.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+	]
+	bindings [
+		{ slave 0 channel 0 }
+		{ slave 0 channel 1 }
+		{ slave 1 channel 0 }
+		{ slave 1 channel 1 }
+		{ slave 2 channel 0 }
+		{ slave 2 channel 1 }
+		{ slave 3 channel 0 }
+		{ slave 3 channel 1 }
+	]
+}
+
+<confdir:pcm/iec958.conf>
+Echo_Echo3G.pcm.iec958.0 {
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
+
+	hooks.0 {
+		type ctl_elems
+		hook_args [
+			{
+				interface PCM
+				name "IEC958 Playback Default"
+				preserve true
+				optional true
+				value [ $AES0 $AES1 $AES2 $AES3 ]
+			}
+		]
+	}
+}
diff --git a/src/conf/cards/Makefile.am b/src/conf/cards/Makefile.am
index b7190e7..ee7991b 100644
--- a/src/conf/cards/Makefile.am
+++ b/src/conf/cards/Makefile.am
@@ -19,6 +19,7 @@ cfg_files = aliases.conf \
 	CMI8738-MC8.conf \
 	CMI8788.conf \
 	CS46xx.conf \
+	Echo_Echo3G.conf \
 	EMU10K1.conf \
 	EMU10K1X.conf \
 	ENS1370.conf \
-- 
1.7.9
