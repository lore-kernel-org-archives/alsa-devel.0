From: tom.ty89@gmail.com
Subject: [PATCH - alsa-lib 1/3] add surround70 definition
Date: Sun, 17 Jan 2016 21:44:04 +0800
Message-ID: <569b9ab2.d944620a.28b6f.ffffc25b@mx.google.com>
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

i see no reason not to add this if we are keeping surround50. adding it to all card confs that have surround71 definition.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>

diff --git a/src/conf/alsa.conf b/src/conf/alsa.conf
index f22918f..2ea7cb0 100644
--- a/src/conf/alsa.conf
+++ b/src/conf/alsa.conf
@@ -100,6 +100,8 @@ defaults.pcm.surround50.card defaults.pcm.card
 defaults.pcm.surround50.device defaults.pcm.device
 defaults.pcm.surround51.card defaults.pcm.card
 defaults.pcm.surround51.device defaults.pcm.device
+defaults.pcm.surround70.card defaults.pcm.card
+defaults.pcm.surround70.device defaults.pcm.device
 defaults.pcm.surround71.card defaults.pcm.card
 defaults.pcm.surround71.device defaults.pcm.device
 defaults.pcm.iec958.card defaults.pcm.card
@@ -138,6 +140,7 @@ pcm.surround40 cards.pcm.surround40
 pcm.surround41 cards.pcm.surround41
 pcm.surround50 cards.pcm.surround50
 pcm.surround51 cards.pcm.surround51
+pcm.surround70 cards.pcm.surround70
 pcm.surround71 cards.pcm.surround71
 pcm.iec958 cards.pcm.iec958
 pcm.spdif iec958
diff --git a/src/conf/cards/Audigy2.conf b/src/conf/cards/Audigy2.conf
index cbec783..e4544a6 100644
--- a/src/conf/cards/Audigy2.conf
+++ b/src/conf/cards/Audigy2.conf
@@ -199,6 +199,7 @@ Audigy2.pcm.side.0 {
 <confdir:pcm/surround40.conf>
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
+<confdir:pcm/surround70.conf>
 
 Audigy2.pcm.surround40.0 {
 	@args [ CARD ]
diff --git a/src/conf/cards/Aureon71.conf b/src/conf/cards/Aureon71.conf
index a43ce2c..1f08b34 100644
--- a/src/conf/cards/Aureon71.conf
+++ b/src/conf/cards/Aureon71.conf
@@ -101,6 +101,7 @@ Aureon71.pcm.surround51.0 {
 	channels 6
 }
 
+<confdir:pcm/surround70.conf>
 <confdir:pcm/surround71.conf>
 
 Aureon71.pcm.surround71.0 {
diff --git a/src/conf/cards/CA0106.conf b/src/conf/cards/CA0106.conf
index 2f0eaf0..c06adfc 100644
--- a/src/conf/cards/CA0106.conf
+++ b/src/conf/cards/CA0106.conf
@@ -112,6 +112,7 @@ CA0106.pcm.surround40.0 {
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
+<confdir:pcm/surround70.conf>
 <confdir:pcm/surround71.conf>
 
 CA0106.pcm.surround51.0 {
diff --git a/src/conf/cards/CMI8738-MC8.conf b/src/conf/cards/CMI8738-MC8.conf
index ddff753..b74e476 100644
--- a/src/conf/cards/CMI8738-MC8.conf
+++ b/src/conf/cards/CMI8738-MC8.conf
@@ -142,6 +142,7 @@ CMI8738-MC8.pcm.surround51.0 {
 	}
 }	
 
+<confdir:pcm/surround70.conf>
 <confdir:pcm/surround71.conf>
 
 CMI8738-MC8.pcm.surround71.0 {
diff --git a/src/conf/cards/CMI8788.conf b/src/conf/cards/CMI8788.conf
index edcb0c9..1d52512 100644
--- a/src/conf/cards/CMI8788.conf
+++ b/src/conf/cards/CMI8788.conf
@@ -63,6 +63,7 @@ CMI8788.pcm.surround51.0 {
 	channels 6
 }	
 
+<confdir:pcm/surround70.conf>
 <confdir:pcm/surround71.conf>
 
 CMI8788.pcm.surround71.0 {
diff --git a/src/conf/cards/Echo_Echo3G.conf b/src/conf/cards/Echo_Echo3G.conf
index 766f13f..4a29c4e 100644
--- a/src/conf/cards/Echo_Echo3G.conf
+++ b/src/conf/cards/Echo_Echo3G.conf
@@ -221,6 +221,62 @@ Echo_Echo3G.pcm.surround51.0 {
 	]
 }
 
+<confdir:pcm/surround70.conf>
+Echo_Echo3G.pcm.surround70.0 {
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
+		{ slave 2 channel 1 }
+		{ slave 3 channel 0 }
+		{ slave 3 channel 1 }
+	]
+}
+
 <confdir:pcm/surround71.conf>
 Echo_Echo3G.pcm.surround71.0 {
 	@args [ CARD ]
diff --git a/src/conf/cards/HDA-Intel.conf b/src/conf/cards/HDA-Intel.conf
index fa9f694..f04fae0 100644
--- a/src/conf/cards/HDA-Intel.conf
+++ b/src/conf/cards/HDA-Intel.conf
@@ -76,6 +76,7 @@ HDA-Intel.pcm.default {
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
+<confdir:pcm/surround70.conf>
 <confdir:pcm/surround71.conf>
 
 HDA-Intel.pcm.surround40.0 cards.HDA-Intel.pcm.front.0
diff --git a/src/conf/cards/ICE1712.conf b/src/conf/cards/ICE1712.conf
index db62684..16d793a 100644
--- a/src/conf/cards/ICE1712.conf
+++ b/src/conf/cards/ICE1712.conf
@@ -78,6 +78,7 @@ ICE1712.pcm.surround40.0 {
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
+<confdir:pcm/surround70.conf>
 <confdir:pcm/surround71.conf>
 
 ICE1712.pcm.surround51.0 {
diff --git a/src/conf/cards/ICE1724.conf b/src/conf/cards/ICE1724.conf
index 61cac01..6072eab 100644
--- a/src/conf/cards/ICE1724.conf
+++ b/src/conf/cards/ICE1724.conf
@@ -121,6 +121,7 @@ ICE1724.pcm.surround51.0 {
 	}
 }
 
+<confdir:pcm/surround70.conf>
 <confdir:pcm/surround71.conf>
 
 ICE1724.pcm.surround71.0 {
diff --git a/src/conf/cards/Loopback.conf b/src/conf/cards/Loopback.conf
index 1ae6d45..ab76670 100644
--- a/src/conf/cards/Loopback.conf
+++ b/src/conf/cards/Loopback.conf
@@ -68,6 +68,7 @@ Loopback.pcm.default {
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
+<confdir:pcm/surround70.conf>
 <confdir:pcm/surround71.conf>
 
 Loopback.pcm.surround40.0 cards.Loopback.pcm.front.0
diff --git a/src/conf/cards/NFORCE.conf b/src/conf/cards/NFORCE.conf
index 64d1547..4ccf58e 100644
--- a/src/conf/cards/NFORCE.conf
+++ b/src/conf/cards/NFORCE.conf
@@ -172,6 +172,7 @@ NFORCE.pcm.surround51.0 {
 	}
 }
 
+<confdir:pcm/surround70.conf>
 <confdir:pcm/surround71.conf>
 
 NFORCE.pcm.surround71.0 {
diff --git a/src/conf/cards/SB-XFi.conf b/src/conf/cards/SB-XFi.conf
index eb2218b..25fe7b7 100644
--- a/src/conf/cards/SB-XFi.conf
+++ b/src/conf/cards/SB-XFi.conf
@@ -58,6 +58,7 @@ SB-XFi.pcm.side.0 {
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
+<confdir:pcm/surround70.conf>
 <confdir:pcm/surround71.conf>
 
 SB-XFi.pcm.surround40.0 cards.SB-XFi.pcm.front.0
diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index e365f29..c8a21c5 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -364,6 +364,7 @@ USB-Audio.pcm.surround51.0 {
 	}
 }
 
+<confdir:pcm/surround70.conf>
 <confdir:pcm/surround71.conf>
 
 USB-Audio.pcm.surround71.0 {
diff --git a/src/conf/pcm/Makefile.am b/src/conf/pcm/Makefile.am
index c548660..b1f87fe 100644
--- a/src/conf/pcm/Makefile.am
+++ b/src/conf/pcm/Makefile.am
@@ -1,6 +1,6 @@
 cfg_files = default.conf front.conf rear.conf center_lfe.conf side.conf\
 	    surround21.conf surround40.conf surround41.conf \
-	    surround50.conf surround51.conf \
+	    surround50.conf surround51.conf surround70.conf \
 	    surround71.conf iec958.conf hdmi.conf modem.conf \
 	    dmix.conf dsnoop.conf \
 	    dpl.conf
diff --git a/src/conf/pcm/surround70.conf b/src/conf/pcm/surround70.conf
new file mode 100644
index 0000000..482a7f7
--- /dev/null
+++ b/src/conf/pcm/surround70.conf
@@ -0,0 +1,69 @@
+#
+#  Hardware output from 7.0 speakers.
+#  Samples must be positioned:
+#    chn0 - front left
+#    chn1 - front right
+#    chn2 - rear left
+#    chn3 - rear right
+#    chn4 - center
+#    chn5 - side left
+#    chn6 - side right
+#
+
+pcm.!surround70 {
+	@args [ CARD DEV ]
+	@args.CARD {
+		type string
+		default {
+			@func getenv
+			vars [
+				ALSA_SURROUND70_CARD
+				ALSA_PCM_CARD
+				ALSA_CARD
+			]
+			default {
+				@func refer
+				name defaults.pcm.surround70.card
+			}
+		}
+	}
+	@args.DEV {
+		type integer
+		default {
+			@func igetenv
+			vars [
+				ALSA_SURROUND70_DEVICE
+			]
+			default {
+				@func refer
+				name defaults.pcm.surround70.device
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
+				".pcm.surround71." $DEV ":CARD=" $CARD
+			]
+		}
+	}
+	ttable.0.FL 1
+	ttable.1.FR 1
+	ttable.2.RL 1
+	ttable.3.RR 1
+	ttable.4.FC 1
+	ttable.5.SL 1
+	ttable.6.SR 1
+	hint {
+		description "7.0 Surround output to Front, Center, Side and Rear speakers"
+		device $DEV
+	}
+}
-- 
2.7.0
