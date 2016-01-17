From: tom.ty89@gmail.com
Subject: [PATCH - alsa-lib 2/3] add surround30 and surround31
	definitions
Date: Sun, 17 Jan 2016 21:44:05 +0800
Message-ID: <569b9abb.d944620a.28b6f.ffffc261@mx.google.com>
References: <1453038246-5240-1-git-send-email-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1453038246-5240-1-git-send-email-me>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Tom Yan <tom.ty89@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Tom Yan <tom.ty89@gmail.com>

Signed-off-by: Tom Yan <tom.ty89@gmail.com>

diff --git a/src/conf/alsa.conf b/src/conf/alsa.conf
index 2ea7cb0..43cec5d 100644
--- a/src/conf/alsa.conf
+++ b/src/conf/alsa.conf
@@ -92,6 +92,10 @@ defaults.pcm.side.card defaults.pcm.card
 defaults.pcm.side.device defaults.pcm.device
 defaults.pcm.surround21.card defaults.pcm.card
 defaults.pcm.surround21.device defaults.pcm.device
+defaults.pcm.surround30.card defaults.pcm.card
+defaults.pcm.surround30.device defaults.pcm.device
+defaults.pcm.surround31.card defaults.pcm.card
+defaults.pcm.surround31.device defaults.pcm.device
 defaults.pcm.surround40.card defaults.pcm.card
 defaults.pcm.surround40.device defaults.pcm.device
 defaults.pcm.surround41.card defaults.pcm.card
@@ -136,6 +140,8 @@ pcm.rear cards.pcm.rear
 pcm.center_lfe cards.pcm.center_lfe
 pcm.side cards.pcm.side
 pcm.surround21 cards.pcm.surround21
+pcm.surround30 cards.pcm.surround30
+pcm.surround31 cards.pcm.surround31
 pcm.surround40 cards.pcm.surround40
 pcm.surround41 cards.pcm.surround41
 pcm.surround50 cards.pcm.surround50
diff --git a/src/conf/cards/ATIIXP-SPDMA.conf b/src/conf/cards/ATIIXP-SPDMA.conf
index 42540d6..a125b65 100644
--- a/src/conf/cards/ATIIXP-SPDMA.conf
+++ b/src/conf/cards/ATIIXP-SPDMA.conf
@@ -78,6 +78,8 @@ ATIIXP-SPDMA.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/ATIIXP.conf b/src/conf/cards/ATIIXP.conf
index c4d33ef..4e27be6 100644
--- a/src/conf/cards/ATIIXP.conf
+++ b/src/conf/cards/ATIIXP.conf
@@ -78,6 +78,8 @@ ATIIXP.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/Audigy.conf b/src/conf/cards/Audigy.conf
index 1c92496..250192a 100644
--- a/src/conf/cards/Audigy.conf
+++ b/src/conf/cards/Audigy.conf
@@ -144,6 +144,8 @@ Audigy.pcm.center_lfe.0 {
 }	
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround40.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
diff --git a/src/conf/cards/Audigy2.conf b/src/conf/cards/Audigy2.conf
index e4544a6..fc71866 100644
--- a/src/conf/cards/Audigy2.conf
+++ b/src/conf/cards/Audigy2.conf
@@ -196,6 +196,8 @@ Audigy2.pcm.side.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround40.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
diff --git a/src/conf/cards/Aureon51.conf b/src/conf/cards/Aureon51.conf
index 07be4a7..a8be4a7 100644
--- a/src/conf/cards/Aureon51.conf
+++ b/src/conf/cards/Aureon51.conf
@@ -87,6 +87,8 @@ Aureon51.pcm.surround40.0 {
 }	
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/Aureon71.conf b/src/conf/cards/Aureon71.conf
index 1f08b34..474d002 100644
--- a/src/conf/cards/Aureon71.conf
+++ b/src/conf/cards/Aureon71.conf
@@ -87,6 +87,8 @@ Aureon71.pcm.surround40.0 {
 }	
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/CA0106.conf b/src/conf/cards/CA0106.conf
index c06adfc..56e8c2d 100644
--- a/src/conf/cards/CA0106.conf
+++ b/src/conf/cards/CA0106.conf
@@ -109,6 +109,8 @@ CA0106.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/CMI8738-MC6.conf b/src/conf/cards/CMI8738-MC6.conf
index edc67d4..0623a80 100644
--- a/src/conf/cards/CMI8738-MC6.conf
+++ b/src/conf/cards/CMI8738-MC6.conf
@@ -78,6 +78,8 @@ CMI8738-MC6.pcm.surround40.0 {
 }	
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/CMI8738-MC8.conf b/src/conf/cards/CMI8738-MC8.conf
index b74e476..b24647c 100644
--- a/src/conf/cards/CMI8738-MC8.conf
+++ b/src/conf/cards/CMI8738-MC8.conf
@@ -106,6 +106,8 @@ CMI8738-MC8.pcm.surround40.0 {
 
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/CMI8788.conf b/src/conf/cards/CMI8788.conf
index 1d52512..c605b50 100644
--- a/src/conf/cards/CMI8788.conf
+++ b/src/conf/cards/CMI8788.conf
@@ -49,6 +49,8 @@ CMI8788.pcm.surround40.0 {
 }	
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/CS46xx.conf b/src/conf/cards/CS46xx.conf
index b71c30a..5321b99 100644
--- a/src/conf/cards/CS46xx.conf
+++ b/src/conf/cards/CS46xx.conf
@@ -113,6 +113,8 @@ CS46xx.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/EMU10K1.conf b/src/conf/cards/EMU10K1.conf
index ef193fe..b1ca48b 100644
--- a/src/conf/cards/EMU10K1.conf
+++ b/src/conf/cards/EMU10K1.conf
@@ -218,6 +218,8 @@ EMU10K1.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/EMU10K1X.conf b/src/conf/cards/EMU10K1X.conf
index f742863..ba1b4c2 100644
--- a/src/conf/cards/EMU10K1X.conf
+++ b/src/conf/cards/EMU10K1X.conf
@@ -97,6 +97,8 @@ EMU10K1X.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/Echo_Echo3G.conf b/src/conf/cards/Echo_Echo3G.conf
index 4a29c4e..dc95de6 100644
--- a/src/conf/cards/Echo_Echo3G.conf
+++ b/src/conf/cards/Echo_Echo3G.conf
@@ -50,6 +50,75 @@ Echo_Echo3G.pcm.side.0 {
 	subdevice 6
 }
 
+<confdir:pcm/surround30.conf>
+Echo_Echo3G.pcm.surround30.0 {
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
+					"cards.Echo_Echo3G.pcm.center_lfe.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+	]
+	bindings [
+		{ slave 0 channel 0 }
+		{ slave 0 channel 1 }
+		{ slave 1 channel 1 }
+	]
+}
+
+<confdir:pcm/surround31.conf>
+Echo_Echo3G.pcm.surround31.0 {
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
+	]
+}
+
 <confdir:pcm/surround40.conf>
 Echo_Echo3G.pcm.surround40.0 {
 	@args [ CARD ]
diff --git a/src/conf/cards/FM801.conf b/src/conf/cards/FM801.conf
index 0ddf799..5152cad 100644
--- a/src/conf/cards/FM801.conf
+++ b/src/conf/cards/FM801.conf
@@ -41,6 +41,8 @@ FM801.pcm.default {
 FM801.pcm.surround40.0 "cards.FM801.pcm.front.0"
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/FireWave.conf b/src/conf/cards/FireWave.conf
index fcfc83c..d12a7ae 100644
--- a/src/conf/cards/FireWave.conf
+++ b/src/conf/cards/FireWave.conf
@@ -26,6 +26,8 @@ FireWave.pcm.front.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/HDA-Intel.conf b/src/conf/cards/HDA-Intel.conf
index f04fae0..074c664 100644
--- a/src/conf/cards/HDA-Intel.conf
+++ b/src/conf/cards/HDA-Intel.conf
@@ -72,6 +72,8 @@ HDA-Intel.pcm.default {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround40.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
diff --git a/src/conf/cards/ICE1712.conf b/src/conf/cards/ICE1712.conf
index 16d793a..0fc2f58 100644
--- a/src/conf/cards/ICE1712.conf
+++ b/src/conf/cards/ICE1712.conf
@@ -75,6 +75,8 @@ ICE1712.pcm.surround40.0 {
 }	
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/ICE1724.conf b/src/conf/cards/ICE1724.conf
index 6072eab..35a3520 100644
--- a/src/conf/cards/ICE1724.conf
+++ b/src/conf/cards/ICE1724.conf
@@ -96,6 +96,8 @@ ICE1724.pcm.surround40.0 {
 }	
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/ICH.conf b/src/conf/cards/ICH.conf
index 6fc9a5a..25a32e6 100644
--- a/src/conf/cards/ICH.conf
+++ b/src/conf/cards/ICH.conf
@@ -99,6 +99,8 @@ ICH.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/ICH4.conf b/src/conf/cards/ICH4.conf
index 64ec883..160676a 100644
--- a/src/conf/cards/ICH4.conf
+++ b/src/conf/cards/ICH4.conf
@@ -99,6 +99,8 @@ ICH4.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/Loopback.conf b/src/conf/cards/Loopback.conf
index ab76670..7f40d21 100644
--- a/src/conf/cards/Loopback.conf
+++ b/src/conf/cards/Loopback.conf
@@ -64,6 +64,8 @@ Loopback.pcm.default {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround40.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
diff --git a/src/conf/cards/NFORCE.conf b/src/conf/cards/NFORCE.conf
index 4ccf58e..ef025d5 100644
--- a/src/conf/cards/NFORCE.conf
+++ b/src/conf/cards/NFORCE.conf
@@ -99,6 +99,8 @@ NFORCE.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/SB-XFi.conf b/src/conf/cards/SB-XFi.conf
index 25fe7b7..d524dff 100644
--- a/src/conf/cards/SB-XFi.conf
+++ b/src/conf/cards/SB-XFi.conf
@@ -54,6 +54,8 @@ SB-XFi.pcm.side.0 {
 }	
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround40.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
diff --git a/src/conf/cards/SI7018.conf b/src/conf/cards/SI7018.conf
index 02b8fc8..16954dd 100644
--- a/src/conf/cards/SI7018.conf
+++ b/src/conf/cards/SI7018.conf
@@ -79,6 +79,8 @@ SI7018.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index c8a21c5..68dd482 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -329,6 +329,8 @@ USB-Audio.pcm.surround40_two_stereo_devices {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/VIA8233.conf b/src/conf/cards/VIA8233.conf
index 9ad321f..d8fa05f 100644
--- a/src/conf/cards/VIA8233.conf
+++ b/src/conf/cards/VIA8233.conf
@@ -87,6 +87,8 @@ VIA8233.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/VIA8233A.conf b/src/conf/cards/VIA8233A.conf
index 679fccf..5cde142 100644
--- a/src/conf/cards/VIA8233A.conf
+++ b/src/conf/cards/VIA8233A.conf
@@ -85,6 +85,8 @@ VIA8233A.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/cards/VIA8237.conf b/src/conf/cards/VIA8237.conf
index 29d8e00..d04c5c1 100644
--- a/src/conf/cards/VIA8237.conf
+++ b/src/conf/cards/VIA8237.conf
@@ -80,6 +80,8 @@ VIA8237.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
+<confdir:pcm/surround30.conf>
+<confdir:pcm/surround31.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
diff --git a/src/conf/pcm/Makefile.am b/src/conf/pcm/Makefile.am
index b1f87fe..745d47e 100644
--- a/src/conf/pcm/Makefile.am
+++ b/src/conf/pcm/Makefile.am
@@ -1,7 +1,9 @@
 cfg_files = default.conf front.conf rear.conf center_lfe.conf side.conf\
-	    surround21.conf surround40.conf surround41.conf \
-	    surround50.conf surround51.conf surround70.conf \
-	    surround71.conf iec958.conf hdmi.conf modem.conf \
+	    surround21.conf surround30.conf surround31.conf \
+	    surround40.conf surround41.conf \
+	    surround50.conf surround51.conf \
+	    surround70.conf surround71.conf \
+	    iec958.conf hdmi.conf modem.conf \
 	    dmix.conf dsnoop.conf \
 	    dpl.conf
 
diff --git a/src/conf/pcm/surround30.conf b/src/conf/pcm/surround30.conf
new file mode 100644
index 0000000..8172d95
--- /dev/null
+++ b/src/conf/pcm/surround30.conf
@@ -0,0 +1,61 @@
+#
+#  Hardware output from 3.0 speakers.
+#  Samples must be positioned:
+#    chn0 - front left
+#    chn1 - front right
+#    chn2 - center
+#
+
+pcm.!surround30 {
+	@args [ CARD DEV ]
+	@args.CARD {
+		type string
+		default {
+			@func getenv
+			vars [
+				ALSA_SURROUND30_CARD
+				ALSA_PCM_CARD
+				ALSA_CARD
+			]
+			default {
+				@func refer
+				name defaults.pcm.surround30.card
+			}
+		}
+	}
+	@args.DEV {
+		type integer
+		default {
+			@func igetenv
+			vars [
+				ALSA_SURROUND30_DEVICE
+			]
+			default {
+				@func refer
+				name defaults.pcm.surround30.device
+			}
+		}
+	}
+	type route
+	slave.pcm {
+		@func refer
+		name {
+			@func concat
+			strings [
+				"cards."
+				{
+					@func card_driver
+					card $CARD
+				}
+				".pcm.surround51." $DEV ":CARD=" $CARD
+			]
+		}
+	}
+	ttable.0.FL 1
+	ttable.1.FR 1
+	ttable.2.FC 1
+	hint {
+		description "3.0 Surround output to Front and Center speakers"
+		device $DEV
+	}
+}
diff --git a/src/conf/pcm/surround31.conf b/src/conf/pcm/surround31.conf
new file mode 100644
index 0000000..67d8e14
--- /dev/null
+++ b/src/conf/pcm/surround31.conf
@@ -0,0 +1,63 @@
+#
+#  Hardware output from 3.1 speakers.
+#  Samples must be positioned:
+#    chn0 - front left
+#    chn1 - front right
+#    chn2 - center
+#    chn3 - LFE
+#
+
+pcm.!surround31 {
+	@args [ CARD DEV ]
+	@args.CARD {
+		type string
+		default {
+			@func getenv
+			vars [
+				ALSA_SURROUND31_CARD
+				ALSA_PCM_CARD
+				ALSA_CARD
+			]
+			default {
+				@func refer
+				name defaults.pcm.surround31.card
+			}
+		}
+	}
+	@args.DEV {
+		type integer
+		default {
+			@func igetenv
+			vars [
+				ALSA_SURROUND31_DEVICE
+			]
+			default {
+				@func refer
+				name defaults.pcm.surround31.device
+			}
+		}
+	}
+	type route
+	slave.pcm {
+		@func refer
+		name {
+			@func concat
+			strings [
+				"cards."
+				{
+					@func card_driver
+					card $CARD
+				}
+				".pcm.surround51." $DEV ":CARD=" $CARD
+			]
+		}
+	}
+	ttable.0.FL 1
+	ttable.1.FR 1
+	ttable.2.FC 1
+	ttable.3.LFE 1
+	hint {
+		description "3.1 Surround output to Front, Center and Subwoofer speakers"
+		device $DEV
+	}
+}
-- 
2.7.0
