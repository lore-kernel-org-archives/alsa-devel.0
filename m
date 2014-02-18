From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] conf: Add surround 2.1 support to all cards
Date: Tue, 18 Feb 2014 16:41:49 +0100
Message-ID: <1392738109-9956-3-git-send-email-david.henningsson@canonical.com>
References: <1392738109-9956-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C0D4A265512
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 16:41:53 +0100 (CET)
In-Reply-To: <1392738109-9956-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

All cards that support 4.1 surround now also support 2.1 surround,
because they both have surround 5.1 as slave.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/cards/ATIIXP-SPDMA.conf | 1 +
 src/conf/cards/ATIIXP.conf       | 1 +
 src/conf/cards/Audigy.conf       | 1 +
 src/conf/cards/Audigy2.conf      | 1 +
 src/conf/cards/Aureon51.conf     | 1 +
 src/conf/cards/Aureon71.conf     | 1 +
 src/conf/cards/CA0106.conf       | 1 +
 src/conf/cards/CMI8738-MC6.conf  | 1 +
 src/conf/cards/CMI8738-MC8.conf  | 1 +
 src/conf/cards/CMI8788.conf      | 2 +-
 src/conf/cards/CS46xx.conf       | 1 +
 src/conf/cards/EMU10K1.conf      | 1 +
 src/conf/cards/EMU10K1X.conf     | 1 +
 src/conf/cards/FM801.conf        | 1 +
 src/conf/cards/FireWave.conf     | 1 +
 src/conf/cards/HDA-Intel.conf    | 1 +
 src/conf/cards/ICE1712.conf      | 1 +
 src/conf/cards/ICE1724.conf      | 1 +
 src/conf/cards/ICH.conf          | 1 +
 src/conf/cards/ICH4.conf         | 1 +
 src/conf/cards/Loopback.conf     | 1 +
 src/conf/cards/NFORCE.conf       | 1 +
 src/conf/cards/SB-XFi.conf       | 1 +
 src/conf/cards/SI7018.conf       | 1 +
 src/conf/cards/USB-Audio.conf    | 1 +
 src/conf/cards/VIA8233.conf      | 1 +
 src/conf/cards/VIA8233A.conf     | 1 +
 src/conf/cards/VIA8237.conf      | 1 +
 28 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/src/conf/cards/ATIIXP-SPDMA.conf b/src/conf/cards/ATIIXP-SPDMA.conf
index 5c80815..42540d6 100644
--- a/src/conf/cards/ATIIXP-SPDMA.conf
+++ b/src/conf/cards/ATIIXP-SPDMA.conf
@@ -77,6 +77,7 @@ ATIIXP-SPDMA.pcm.surround40.0 {
 	}
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/ATIIXP.conf b/src/conf/cards/ATIIXP.conf
index 38d8023..c4d33ef 100644
--- a/src/conf/cards/ATIIXP.conf
+++ b/src/conf/cards/ATIIXP.conf
@@ -77,6 +77,7 @@ ATIIXP.pcm.surround40.0 {
 	}
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/Audigy.conf b/src/conf/cards/Audigy.conf
index 4fe3873..1c92496 100644
--- a/src/conf/cards/Audigy.conf
+++ b/src/conf/cards/Audigy.conf
@@ -143,6 +143,7 @@ Audigy.pcm.center_lfe.0 {
 	}
 }	
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround40.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
diff --git a/src/conf/cards/Audigy2.conf b/src/conf/cards/Audigy2.conf
index db45776..cbec783 100644
--- a/src/conf/cards/Audigy2.conf
+++ b/src/conf/cards/Audigy2.conf
@@ -195,6 +195,7 @@ Audigy2.pcm.side.0 {
 	}
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround40.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
diff --git a/src/conf/cards/Aureon51.conf b/src/conf/cards/Aureon51.conf
index 24b4d94..07be4a7 100644
--- a/src/conf/cards/Aureon51.conf
+++ b/src/conf/cards/Aureon51.conf
@@ -86,6 +86,7 @@ Aureon51.pcm.surround40.0 {
 	channels 4
 }	
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/Aureon71.conf b/src/conf/cards/Aureon71.conf
index 1479c25..a43ce2c 100644
--- a/src/conf/cards/Aureon71.conf
+++ b/src/conf/cards/Aureon71.conf
@@ -86,6 +86,7 @@ Aureon71.pcm.surround40.0 {
 	channels 4
 }	
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/CA0106.conf b/src/conf/cards/CA0106.conf
index 9d21770..2f0eaf0 100644
--- a/src/conf/cards/CA0106.conf
+++ b/src/conf/cards/CA0106.conf
@@ -108,6 +108,7 @@ CA0106.pcm.surround40.0 {
 	]
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/CMI8738-MC6.conf b/src/conf/cards/CMI8738-MC6.conf
index 171c772..edc67d4 100644
--- a/src/conf/cards/CMI8738-MC6.conf
+++ b/src/conf/cards/CMI8738-MC6.conf
@@ -77,6 +77,7 @@ CMI8738-MC6.pcm.surround40.0 {
 	}
 }	
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/CMI8738-MC8.conf b/src/conf/cards/CMI8738-MC8.conf
index a5bf6cb..ddff753 100644
--- a/src/conf/cards/CMI8738-MC8.conf
+++ b/src/conf/cards/CMI8738-MC8.conf
@@ -105,6 +105,7 @@ CMI8738-MC8.pcm.surround40.0 {
 }	
 
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/CMI8788.conf b/src/conf/cards/CMI8788.conf
index 0ca71e9..edcb0c9 100644
--- a/src/conf/cards/CMI8788.conf
+++ b/src/conf/cards/CMI8788.conf
@@ -48,7 +48,7 @@ CMI8788.pcm.surround40.0 {
 	channels 4
 }	
 
-
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/CS46xx.conf b/src/conf/cards/CS46xx.conf
index 1983142..b71c30a 100644
--- a/src/conf/cards/CS46xx.conf
+++ b/src/conf/cards/CS46xx.conf
@@ -112,6 +112,7 @@ CS46xx.pcm.surround40.0 {
 	]
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/EMU10K1.conf b/src/conf/cards/EMU10K1.conf
index d51f6dc..ef193fe 100644
--- a/src/conf/cards/EMU10K1.conf
+++ b/src/conf/cards/EMU10K1.conf
@@ -217,6 +217,7 @@ EMU10K1.pcm.surround40.0 {
 	]
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/EMU10K1X.conf b/src/conf/cards/EMU10K1X.conf
index b5fc708..f742863 100644
--- a/src/conf/cards/EMU10K1X.conf
+++ b/src/conf/cards/EMU10K1X.conf
@@ -96,6 +96,7 @@ EMU10K1X.pcm.surround40.0 {
 	]
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/FM801.conf b/src/conf/cards/FM801.conf
index 997b218..0ddf799 100644
--- a/src/conf/cards/FM801.conf
+++ b/src/conf/cards/FM801.conf
@@ -40,6 +40,7 @@ FM801.pcm.default {
 
 FM801.pcm.surround40.0 "cards.FM801.pcm.front.0"
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/FireWave.conf b/src/conf/cards/FireWave.conf
index 63fb23d..fcfc83c 100644
--- a/src/conf/cards/FireWave.conf
+++ b/src/conf/cards/FireWave.conf
@@ -25,6 +25,7 @@ FireWave.pcm.front.0 {
 	card $CARD
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/HDA-Intel.conf b/src/conf/cards/HDA-Intel.conf
index 7976b6c..fa9f694 100644
--- a/src/conf/cards/HDA-Intel.conf
+++ b/src/conf/cards/HDA-Intel.conf
@@ -71,6 +71,7 @@ HDA-Intel.pcm.default {
 	hint.device 0
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround40.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
diff --git a/src/conf/cards/ICE1712.conf b/src/conf/cards/ICE1712.conf
index f5b8add..398fa7a 100644
--- a/src/conf/cards/ICE1712.conf
+++ b/src/conf/cards/ICE1712.conf
@@ -74,6 +74,7 @@ ICE1712.pcm.surround40.0 {
 	slave.channels 10
 }	
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/ICE1724.conf b/src/conf/cards/ICE1724.conf
index e806b36..61cac01 100644
--- a/src/conf/cards/ICE1724.conf
+++ b/src/conf/cards/ICE1724.conf
@@ -95,6 +95,7 @@ ICE1724.pcm.surround40.0 {
 	}
 }	
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/ICH.conf b/src/conf/cards/ICH.conf
index 47ffef9..6fc9a5a 100644
--- a/src/conf/cards/ICH.conf
+++ b/src/conf/cards/ICH.conf
@@ -98,6 +98,7 @@ ICH.pcm.surround40.0 {
 	}
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/ICH4.conf b/src/conf/cards/ICH4.conf
index 1bf5605..64ec883 100644
--- a/src/conf/cards/ICH4.conf
+++ b/src/conf/cards/ICH4.conf
@@ -98,6 +98,7 @@ ICH4.pcm.surround40.0 {
 	}
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/Loopback.conf b/src/conf/cards/Loopback.conf
index 5365fa1..974aa75 100644
--- a/src/conf/cards/Loopback.conf
+++ b/src/conf/cards/Loopback.conf
@@ -63,6 +63,7 @@ Loopback.pcm.default {
 	hint.device 0
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround40.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
diff --git a/src/conf/cards/NFORCE.conf b/src/conf/cards/NFORCE.conf
index 6ebefe3..64d1547 100644
--- a/src/conf/cards/NFORCE.conf
+++ b/src/conf/cards/NFORCE.conf
@@ -98,6 +98,7 @@ NFORCE.pcm.surround40.0 {
 	}
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/SB-XFi.conf b/src/conf/cards/SB-XFi.conf
index 38d0027..eb2218b 100644
--- a/src/conf/cards/SB-XFi.conf
+++ b/src/conf/cards/SB-XFi.conf
@@ -53,6 +53,7 @@ SB-XFi.pcm.side.0 {
 	hint.device 3
 }	
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround40.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
diff --git a/src/conf/cards/SI7018.conf b/src/conf/cards/SI7018.conf
index 7417bd5..02b8fc8 100644
--- a/src/conf/cards/SI7018.conf
+++ b/src/conf/cards/SI7018.conf
@@ -78,6 +78,7 @@ SI7018.pcm.surround40.0 {
 	]
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 8a6d9ca..ce3ae01 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -314,6 +314,7 @@ USB-Audio.pcm.surround40_two_stereo_devices {
 	}
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/VIA8233.conf b/src/conf/cards/VIA8233.conf
index 668bfd9..9ad321f 100644
--- a/src/conf/cards/VIA8233.conf
+++ b/src/conf/cards/VIA8233.conf
@@ -86,6 +86,7 @@ VIA8233.pcm.surround40.0 {
 	}
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/VIA8233A.conf b/src/conf/cards/VIA8233A.conf
index 97d2a7d..679fccf 100644
--- a/src/conf/cards/VIA8233A.conf
+++ b/src/conf/cards/VIA8233A.conf
@@ -84,6 +84,7 @@ VIA8233A.pcm.surround40.0 {
 	}
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/VIA8237.conf b/src/conf/cards/VIA8237.conf
index 404e190..29d8e00 100644
--- a/src/conf/cards/VIA8237.conf
+++ b/src/conf/cards/VIA8237.conf
@@ -79,6 +79,7 @@ VIA8237.pcm.surround40.0 {
 	}
 }
 
+<confdir:pcm/surround21.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
-- 
1.9.rc1
