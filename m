From: tom.ty89@gmail.com
Subject: [PATCH - alsa-lib 1/1] removing surround PCMs built
	with ttable
Date: Wed, 20 Jan 2016 22:57:13 +0800
Message-ID: <569fa051.899d420a.b26df.ffffdd9d@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

Removing surround41 and surround50. surround21 stays untouched because
it was added particularly for laptops with subwoofer speaker recently.
Though i do think that those should be handled with a more specifc and
proper approach, if the conf has really ever worked for them.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>

diff --git a/src/conf/alsa.conf b/src/conf/alsa.conf
index f22918f..d1ba9f5 100644
--- a/src/conf/alsa.conf
+++ b/src/conf/alsa.conf
@@ -94,10 +94,6 @@ defaults.pcm.surround21.card defaults.pcm.card
 defaults.pcm.surround21.device defaults.pcm.device
 defaults.pcm.surround40.card defaults.pcm.card
 defaults.pcm.surround40.device defaults.pcm.device
-defaults.pcm.surround41.card defaults.pcm.card
-defaults.pcm.surround41.device defaults.pcm.device
-defaults.pcm.surround50.card defaults.pcm.card
-defaults.pcm.surround50.device defaults.pcm.device
 defaults.pcm.surround51.card defaults.pcm.card
 defaults.pcm.surround51.device defaults.pcm.device
 defaults.pcm.surround71.card defaults.pcm.card
@@ -135,8 +131,6 @@ pcm.center_lfe cards.pcm.center_lfe
 pcm.side cards.pcm.side
 pcm.surround21 cards.pcm.surround21
 pcm.surround40 cards.pcm.surround40
-pcm.surround41 cards.pcm.surround41
-pcm.surround50 cards.pcm.surround50
 pcm.surround51 cards.pcm.surround51
 pcm.surround71 cards.pcm.surround71
 pcm.iec958 cards.pcm.iec958
diff --git a/src/conf/cards/ATIIXP-SPDMA.conf b/src/conf/cards/ATIIXP-SPDMA.conf
index 42540d6..eb01ebb 100644
--- a/src/conf/cards/ATIIXP-SPDMA.conf
+++ b/src/conf/cards/ATIIXP-SPDMA.conf
@@ -78,8 +78,6 @@ ATIIXP-SPDMA.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 ATIIXP-SPDMA.pcm.surround51.0 {
diff --git a/src/conf/cards/ATIIXP.conf b/src/conf/cards/ATIIXP.conf
index c4d33ef..1db6bd1 100644
--- a/src/conf/cards/ATIIXP.conf
+++ b/src/conf/cards/ATIIXP.conf
@@ -78,8 +78,6 @@ ATIIXP.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 ATIIXP.pcm.surround51.0 {
diff --git a/src/conf/cards/Audigy.conf b/src/conf/cards/Audigy.conf
index 1c92496..dadb7be 100644
--- a/src/conf/cards/Audigy.conf
+++ b/src/conf/cards/Audigy.conf
@@ -145,8 +145,6 @@ Audigy.pcm.center_lfe.0 {
 
 <confdir:pcm/surround21.conf>
 <confdir:pcm/surround40.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 
 Audigy.pcm.surround40.0 {
 	@args [ CARD ]
diff --git a/src/conf/cards/Audigy2.conf b/src/conf/cards/Audigy2.conf
index cbec783..24d55e1 100644
--- a/src/conf/cards/Audigy2.conf
+++ b/src/conf/cards/Audigy2.conf
@@ -197,8 +197,6 @@ Audigy2.pcm.side.0 {
 
 <confdir:pcm/surround21.conf>
 <confdir:pcm/surround40.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 
 Audigy2.pcm.surround40.0 {
 	@args [ CARD ]
diff --git a/src/conf/cards/Aureon51.conf b/src/conf/cards/Aureon51.conf
index 07be4a7..11fd424 100644
--- a/src/conf/cards/Aureon51.conf
+++ b/src/conf/cards/Aureon51.conf
@@ -87,8 +87,6 @@ Aureon51.pcm.surround40.0 {
 }	
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 Aureon51.pcm.surround51.0 {
diff --git a/src/conf/cards/Aureon71.conf b/src/conf/cards/Aureon71.conf
index a43ce2c..36dae9b 100644
--- a/src/conf/cards/Aureon71.conf
+++ b/src/conf/cards/Aureon71.conf
@@ -87,8 +87,6 @@ Aureon71.pcm.surround40.0 {
 }	
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 Aureon71.pcm.surround51.0 {
diff --git a/src/conf/cards/CA0106.conf b/src/conf/cards/CA0106.conf
index 2f0eaf0..78e460f 100644
--- a/src/conf/cards/CA0106.conf
+++ b/src/conf/cards/CA0106.conf
@@ -109,8 +109,6 @@ CA0106.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 <confdir:pcm/surround71.conf>
 
diff --git a/src/conf/cards/CMI8738-MC6.conf b/src/conf/cards/CMI8738-MC6.conf
index edc67d4..fa043f1 100644
--- a/src/conf/cards/CMI8738-MC6.conf
+++ b/src/conf/cards/CMI8738-MC6.conf
@@ -78,8 +78,6 @@ CMI8738-MC6.pcm.surround40.0 {
 }	
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 CMI8738-MC6.pcm.surround51.0 {
diff --git a/src/conf/cards/CMI8738-MC8.conf b/src/conf/cards/CMI8738-MC8.conf
index ddff753..b46cda3 100644
--- a/src/conf/cards/CMI8738-MC8.conf
+++ b/src/conf/cards/CMI8738-MC8.conf
@@ -106,8 +106,6 @@ CMI8738-MC8.pcm.surround40.0 {
 
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 CMI8738-MC8.pcm.surround51.0 {
diff --git a/src/conf/cards/CMI8788.conf b/src/conf/cards/CMI8788.conf
index edcb0c9..cb7d2d8 100644
--- a/src/conf/cards/CMI8788.conf
+++ b/src/conf/cards/CMI8788.conf
@@ -49,8 +49,6 @@ CMI8788.pcm.surround40.0 {
 }	
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 CMI8788.pcm.surround51.0 {
diff --git a/src/conf/cards/CS46xx.conf b/src/conf/cards/CS46xx.conf
index b71c30a..1587f36 100644
--- a/src/conf/cards/CS46xx.conf
+++ b/src/conf/cards/CS46xx.conf
@@ -113,8 +113,6 @@ CS46xx.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 CS46xx.pcm.surround51.0 {
diff --git a/src/conf/cards/EMU10K1.conf b/src/conf/cards/EMU10K1.conf
index ef193fe..bc46e49 100644
--- a/src/conf/cards/EMU10K1.conf
+++ b/src/conf/cards/EMU10K1.conf
@@ -218,8 +218,6 @@ EMU10K1.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 EMU10K1.pcm.surround51.0 {
diff --git a/src/conf/cards/EMU10K1X.conf b/src/conf/cards/EMU10K1X.conf
index f742863..1538ae1 100644
--- a/src/conf/cards/EMU10K1X.conf
+++ b/src/conf/cards/EMU10K1X.conf
@@ -97,8 +97,6 @@ EMU10K1X.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 EMU10K1X.pcm.surround51.0 {
diff --git a/src/conf/cards/Echo_Echo3G.conf b/src/conf/cards/Echo_Echo3G.conf
index 766f13f..1ceda41 100644
--- a/src/conf/cards/Echo_Echo3G.conf
+++ b/src/conf/cards/Echo_Echo3G.conf
@@ -85,96 +85,6 @@ Echo_Echo3G.pcm.surround40.0 {
 	]
 }
 
-<confdir:pcm/surround41.conf>
-Echo_Echo3G.pcm.surround41.0 {
-	@args [ CARD ]
-	@args.CARD {
-		type string
-	}
-	type multi
-	slaves [
-		{
-			pcm {
-				@func concat
-				strings [
-					"cards.Echo_Echo3G.pcm.front.0:CARD=" $CARD
-				]
-			}
-			channels 2
-		}
-		{
-			pcm {
-				@func concat
-				strings [
-					"cards.Echo_Echo3G.pcm.rear.0:CARD=" $CARD
-				]
-			}
-			channels 2
-		}
-		{
-			pcm {
-				@func concat
-				strings [
-					"cards.Echo_Echo3G.pcm.center_lfe.0:CARD=" $CARD
-				]
-			}
-			channels 2
-		}
-	]
-	bindings [
-		{ slave 0 channel 0 }
-		{ slave 0 channel 1 }
-		{ slave 1 channel 0 }
-		{ slave 1 channel 1 }
-		{ slave 2 channel 0 }
-	]
-}
-
-<confdir:pcm/surround50.conf>
-Echo_Echo3G.pcm.surround50.0 {
-	@args [ CARD ]
-	@args.CARD {
-		type string
-	}
-	type multi
-	slaves [
-		{
-			pcm {
-				@func concat
-				strings [
-					"cards.Echo_Echo3G.pcm.front.0:CARD=" $CARD
-				]
-			}
-			channels 2
-		}
-		{
-			pcm {
-				@func concat
-				strings [
-					"cards.Echo_Echo3G.pcm.rear.0:CARD=" $CARD
-				]
-			}
-			channels 2
-		}
-		{
-			pcm {
-				@func concat
-				strings [
-					"cards.Echo_Echo3G.pcm.center_lfe.0:CARD=" $CARD
-				]
-			}
-			channels 2
-		}
-	]
-	bindings [
-		{ slave 0 channel 0 }
-		{ slave 0 channel 1 }
-		{ slave 1 channel 0 }
-		{ slave 1 channel 1 }
-		{ slave 2 channel 1 }
-	]
-}
-
 <confdir:pcm/surround51.conf>
 Echo_Echo3G.pcm.surround51.0 {
 	@args [ CARD ]
diff --git a/src/conf/cards/FM801.conf b/src/conf/cards/FM801.conf
index 0ddf799..9418303 100644
--- a/src/conf/cards/FM801.conf
+++ b/src/conf/cards/FM801.conf
@@ -41,8 +41,6 @@ FM801.pcm.default {
 FM801.pcm.surround40.0 "cards.FM801.pcm.front.0"
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 FM801.pcm.surround51.0 "cards.FM801.pcm.front.0"
diff --git a/src/conf/cards/FireWave.conf b/src/conf/cards/FireWave.conf
index fcfc83c..1305e20 100644
--- a/src/conf/cards/FireWave.conf
+++ b/src/conf/cards/FireWave.conf
@@ -26,8 +26,6 @@ FireWave.pcm.front.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 FireWave.pcm.surround51.0 {
diff --git a/src/conf/cards/HDA-Intel.conf b/src/conf/cards/HDA-Intel.conf
index fa9f694..f96cc4c 100644
--- a/src/conf/cards/HDA-Intel.conf
+++ b/src/conf/cards/HDA-Intel.conf
@@ -73,8 +73,6 @@ HDA-Intel.pcm.default {
 
 <confdir:pcm/surround21.conf>
 <confdir:pcm/surround40.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 <confdir:pcm/surround71.conf>
 
diff --git a/src/conf/cards/ICE1712.conf b/src/conf/cards/ICE1712.conf
index db62684..b3ba596 100644
--- a/src/conf/cards/ICE1712.conf
+++ b/src/conf/cards/ICE1712.conf
@@ -75,8 +75,6 @@ ICE1712.pcm.surround40.0 {
 }	
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 <confdir:pcm/surround71.conf>
 
diff --git a/src/conf/cards/ICE1724.conf b/src/conf/cards/ICE1724.conf
index 61cac01..7cabe6e 100644
--- a/src/conf/cards/ICE1724.conf
+++ b/src/conf/cards/ICE1724.conf
@@ -96,8 +96,6 @@ ICE1724.pcm.surround40.0 {
 }	
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 ICE1724.pcm.surround51.0 {
diff --git a/src/conf/cards/ICH.conf b/src/conf/cards/ICH.conf
index 6fc9a5a..f348d6f 100644
--- a/src/conf/cards/ICH.conf
+++ b/src/conf/cards/ICH.conf
@@ -99,8 +99,6 @@ ICH.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 ICH.pcm.surround51.0 {
diff --git a/src/conf/cards/ICH4.conf b/src/conf/cards/ICH4.conf
index 64ec883..c9d0895 100644
--- a/src/conf/cards/ICH4.conf
+++ b/src/conf/cards/ICH4.conf
@@ -99,8 +99,6 @@ ICH4.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 ICH4.pcm.surround51.0 {
diff --git a/src/conf/cards/Loopback.conf b/src/conf/cards/Loopback.conf
index 1ae6d45..d3e7f8a 100644
--- a/src/conf/cards/Loopback.conf
+++ b/src/conf/cards/Loopback.conf
@@ -65,8 +65,6 @@ Loopback.pcm.default {
 
 <confdir:pcm/surround21.conf>
 <confdir:pcm/surround40.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 <confdir:pcm/surround71.conf>
 
diff --git a/src/conf/cards/NFORCE.conf b/src/conf/cards/NFORCE.conf
index 64d1547..fd236c6 100644
--- a/src/conf/cards/NFORCE.conf
+++ b/src/conf/cards/NFORCE.conf
@@ -99,8 +99,6 @@ NFORCE.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 NFORCE.pcm.surround51.0 {
diff --git a/src/conf/cards/SB-XFi.conf b/src/conf/cards/SB-XFi.conf
index eb2218b..2cce159 100644
--- a/src/conf/cards/SB-XFi.conf
+++ b/src/conf/cards/SB-XFi.conf
@@ -55,8 +55,6 @@ SB-XFi.pcm.side.0 {
 
 <confdir:pcm/surround21.conf>
 <confdir:pcm/surround40.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 <confdir:pcm/surround71.conf>
 
diff --git a/src/conf/cards/SI7018.conf b/src/conf/cards/SI7018.conf
index 02b8fc8..cba7eaa 100644
--- a/src/conf/cards/SI7018.conf
+++ b/src/conf/cards/SI7018.conf
@@ -79,8 +79,6 @@ SI7018.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 SI7018.pcm.surround51.0 {
diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index e365f29..0533fb8 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -329,8 +329,6 @@ USB-Audio.pcm.surround40_two_stereo_devices {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 USB-Audio.pcm.surround51.0 {
diff --git a/src/conf/cards/VIA8233.conf b/src/conf/cards/VIA8233.conf
index 9ad321f..1da835f 100644
--- a/src/conf/cards/VIA8233.conf
+++ b/src/conf/cards/VIA8233.conf
@@ -87,8 +87,6 @@ VIA8233.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 VIA8233.pcm.surround51.0 {
diff --git a/src/conf/cards/VIA8233A.conf b/src/conf/cards/VIA8233A.conf
index 679fccf..5239dc5 100644
--- a/src/conf/cards/VIA8233A.conf
+++ b/src/conf/cards/VIA8233A.conf
@@ -85,8 +85,6 @@ VIA8233A.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 VIA8233A.pcm.surround51.0 {
diff --git a/src/conf/cards/VIA8237.conf b/src/conf/cards/VIA8237.conf
index 29d8e00..566609b 100644
--- a/src/conf/cards/VIA8237.conf
+++ b/src/conf/cards/VIA8237.conf
@@ -80,8 +80,6 @@ VIA8237.pcm.surround40.0 {
 }
 
 <confdir:pcm/surround21.conf>
-<confdir:pcm/surround41.conf>
-<confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
 
 VIA8237.pcm.surround51.0 {
diff --git a/src/conf/pcm/Makefile.am b/src/conf/pcm/Makefile.am
index c548660..ca43006 100644
--- a/src/conf/pcm/Makefile.am
+++ b/src/conf/pcm/Makefile.am
@@ -1,7 +1,7 @@
 cfg_files = default.conf front.conf rear.conf center_lfe.conf side.conf\
-	    surround21.conf surround40.conf surround41.conf \
-	    surround50.conf surround51.conf \
-	    surround71.conf iec958.conf hdmi.conf modem.conf \
+	    surround21.conf surround40.conf \
+	    surround51.conf surround71.conf \
+	    iec958.conf hdmi.conf modem.conf \
 	    dmix.conf dsnoop.conf \
 	    dpl.conf
 
diff --git a/src/conf/pcm/surround41.conf b/src/conf/pcm/surround41.conf
deleted file mode 100644
index 2f82381..0000000
--- a/src/conf/pcm/surround41.conf
+++ /dev/null
@@ -1,65 +0,0 @@
-#
-#  Hardware output from 4.1 speakers.
-#  Samples must be positioned:
-#    chn0 - front left
-#    chn1 - front right
-#    chn2 - rear left
-#    chn3 - rear right
-#    chn4 - LFE
-#
-
-pcm.!surround41 {
-	@args [ CARD DEV ]
-	@args.CARD {
-		type string
-		default {
-			@func getenv
-			vars [
-				ALSA_SURROUND41_CARD
-				ALSA_PCM_CARD
-				ALSA_CARD
-			]
-			default {
-				@func refer
-				name defaults.pcm.surround41.card
-			}
-		}
-	}
-	@args.DEV {
-		type integer
-		default {
-			@func igetenv
-			vars [
-				ALSA_SURROUND41_DEVICE
-			]
-			default {
-				@func refer
-				name defaults.pcm.surround41.device
-			}
-		}
-	}
-	type route
-	slave.pcm {
-		@func refer
-		name {
-			@func concat
-			strings [
-				"cards."
-				{
-					@func card_driver
-					card $CARD
-				}
-				".pcm.surround51." $DEV ":CARD=" $CARD
-			]
-		}
-	}
-	ttable.0.FL 1
-	ttable.1.FR 1
-	ttable.2.RL 1
-	ttable.3.RR 1
-	ttable.4.LFE 1
-	hint {
-		description "4.1 Surround output to Front, Rear and Subwoofer speakers"
-		device $DEV
-	}
-}
diff --git a/src/conf/pcm/surround50.conf b/src/conf/pcm/surround50.conf
deleted file mode 100644
index dc95c17..0000000
--- a/src/conf/pcm/surround50.conf
+++ /dev/null
@@ -1,65 +0,0 @@
-#
-#  Hardware output from 5.0 speakers.
-#  Samples must be positioned:
-#    chn0 - front left
-#    chn1 - front right
-#    chn2 - rear left
-#    chn3 - rear right
-#    chn4 - center
-#
-
-pcm.!surround50 {
-	@args [ CARD DEV ]
-	@args.CARD {
-		type string
-		default {
-			@func getenv
-			vars [
-				ALSA_SURROUND50_CARD
-				ALSA_PCM_CARD
-				ALSA_CARD
-			]
-			default {
-				@func refer
-				name defaults.pcm.surround50.card
-			}
-		}
-	}
-	@args.DEV {
-		type integer
-		default {
-			@func igetenv
-			vars [
-				ALSA_SURROUND50_DEVICE
-			]
-			default {
-				@func refer
-				name defaults.pcm.surround50.device
-			}
-		}
-	}
-	type route
-	slave.pcm {
-		@func refer
-		name {
-			@func concat
-			strings [
-				"cards."
-				{
-					@func card_driver
-					card $CARD
-				}
-				".pcm.surround51." $DEV ":CARD=" $CARD
-			]
-		}
-	}
-	ttable.0.FL 1
-	ttable.1.FR 1
-	ttable.2.RL 1
-	ttable.3.RR 1
-	ttable.4.FC 1
-	hint {
-		description "5.0 Surround output to Front, Center and Rear speakers"
-		device $DEV
-	}
-}
-- 
2.7.0
