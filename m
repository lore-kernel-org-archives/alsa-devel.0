From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] Add config files for more Analog Devices codecs
Date: Wed,  7 Jan 2009 03:44:41 -0500
Message-ID: <1231317881-3798-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 24C611037E3
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 09:44:46 +0100 (CET)
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
Cc: Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 src/conf/cards/AD1836.conf  |   17 +++++++++++++++++
 src/conf/cards/AD1980.conf  |   42 ++++++++++++++++++++++++++++++++++++++++++
 src/conf/cards/AD73311.conf |   14 ++++++++++++++
 src/conf/cards/AD73322.conf |   17 +++++++++++++++++
 src/conf/cards/Makefile.am  |    5 +++++
 src/conf/cards/SSM2602.conf |   12 ++++++++++++
 6 files changed, 107 insertions(+), 0 deletions(-)
 create mode 100644 src/conf/cards/AD1836.conf
 create mode 100644 src/conf/cards/AD1980.conf
 create mode 100644 src/conf/cards/AD73311.conf
 create mode 100644 src/conf/cards/AD73322.conf
 create mode 100644 src/conf/cards/SSM2602.conf

diff --git a/src/conf/cards/AD1836.conf b/src/conf/cards/AD1836.conf
new file mode 100644
index 0000000..0317ec5
--- /dev/null
+++ b/src/conf/cards/AD1836.conf
@@ -0,0 +1,17 @@
+AD1836.pcm.default {
+	type plug
+	slave {
+		pcm {
+			type mmap_emul
+			slave {
+				pcm {
+					type hw
+					card 0
+					format S32_LE
+					rate 48000
+					sync_ptr_ioctl 1
+				}
+			}
+		}
+	}
+}
diff --git a/src/conf/cards/AD1980.conf b/src/conf/cards/AD1980.conf
new file mode 100644
index 0000000..bd0e519
--- /dev/null
+++ b/src/conf/cards/AD1980.conf
@@ -0,0 +1,42 @@
+<confdir:pcm/front.conf>
+
+AD1980.pcm.front.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type hw
+	card $CARD
+	device 0
+}	
+
+AD1980.pcm.default {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type asym
+	playback.pcm {
+		type plug
+		slave.pcm {
+			@func concat
+			strings [ "dmix:CARD=" $CARD ]
+		}
+	}
+	capture.pcm {
+		type plug
+		slave.pcm {
+			@func concat
+			strings [ "dsnoop:CARD=" $CARD ]
+		}
+	}
+}
+
+<confdir:pcm/surround40.conf>
+<confdir:pcm/surround41.conf>
+<confdir:pcm/surround50.conf>
+<confdir:pcm/surround51.conf>
+
+AD1980.pcm.surround40.0 cards.AD1980.pcm.front.0
+AD1980.pcm.surround51.0 cards.AD1980.pcm.front.0
+
diff --git a/src/conf/cards/AD73311.conf b/src/conf/cards/AD73311.conf
new file mode 100644
index 0000000..e271e9c
--- /dev/null
+++ b/src/conf/cards/AD73311.conf
@@ -0,0 +1,14 @@
+AD73311.pcm.default {
+	type plug
+	slave {
+		pcm {
+			type hw
+			card 0
+			format S16_LE
+			rate 8000
+			channels 1
+		}
+
+
+	}
+}
diff --git a/src/conf/cards/AD73322.conf b/src/conf/cards/AD73322.conf
new file mode 100644
index 0000000..e6cbc29
--- /dev/null
+++ b/src/conf/cards/AD73322.conf
@@ -0,0 +1,17 @@
+AD73322.pcm.default {
+	type plug
+	slave {
+		pcm {
+			type mmap_emul
+			slave {
+				pcm {
+					type hw
+					card 0
+					format S16_LE
+					rate 8000
+					channels 1
+				}
+			}
+		}
+	}
+}
diff --git a/src/conf/cards/Makefile.am b/src/conf/cards/Makefile.am
index f4d6c17..f2d34c7 100644
--- a/src/conf/cards/Makefile.am
+++ b/src/conf/cards/Makefile.am
@@ -2,6 +2,10 @@ alsaconfigdir = @ALSA_CONFIG_DIR@
 alsadir = $(alsaconfigdir)/cards
 cfg_files = aliases.conf \
 	AACI.conf \
+	AD1836.conf \
+	AD1980.conf \
+	AD73311.conf \
+	AD73322.conf \
 	ATIIXP.conf \
 	ATIIXP-SPDMA.conf \
 	ATIIXP-MODEM.conf \
@@ -41,6 +45,7 @@ cfg_files = aliases.conf \
 	RME9636.conf \
 	RME9652.conf \
 	SI7018.conf \
+	SSM2602.conf \
 	TRID4DWAVENX.conf \
 	USB-Audio.conf \
 	YMF744.conf \
diff --git a/src/conf/cards/SSM2602.conf b/src/conf/cards/SSM2602.conf
new file mode 100644
index 0000000..a6fbffe
--- /dev/null
+++ b/src/conf/cards/SSM2602.conf
@@ -0,0 +1,12 @@
+SSM2602.pcm.default {
+	type plug
+	slave {
+		pcm {
+			type hw
+			card 0
+			format S32_LE
+			rate 48000
+			channels 2
+			}
+		}
+}
-- 
1.6.0.6
