From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] wss: convert CS4231 mixer to dB scale
Date: Sat, 10 Oct 2009 10:25:39 +0200
Message-ID: <20091010102539.0da980bd.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3352556512144989096=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 3A9B5243A0
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Oct 2009 10:09:24 +0200 (CEST)
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

--===============3352556512144989096==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Convert CS4231 mixer to dB scale after AD1848 mixer.

Also, add missing microphone boost control for the AD1848
and correct wrong bits for loopback volume on the AD1848.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

I wonder if it is a good idea to reorder the snd_wss_controls table
so the first part is identical to the snd_ad1848_controls. The 
snd_ad1848_controls can be removed completely and the first
part of the snd_wss_controls can be used for the AD1848 chips.


 sound/isa/wss/wss_lib.c |   43 ++++++++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 5d2ba1b..754a208 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -2198,6 +2198,7 @@ EXPORT_SYMBOL(snd_wss_put_double);
 static const DECLARE_TLV_DB_SCALE(db_scale_6bit, -9450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_5bit_12db_max, -3450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_rec_gain, 0, 150, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_4bit, -4500, 300, 0);
 
 static struct snd_kcontrol_new snd_ad1848_controls[] = {
 WSS_DOUBLE("PCM Playback Switch", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT,
@@ -2224,38 +2225,45 @@ WSS_DOUBLE_TLV("Capture Volume", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT,
 	.get = snd_wss_get_mux,
 	.put = snd_wss_put_mux,
 },
+WSS_DOUBLE("Mic Boost", 0,
+		CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 5, 5, 1, 0),
 WSS_SINGLE("Loopback Capture Switch", 0, CS4231_LOOPBACK, 0, 1, 0),
-WSS_SINGLE_TLV("Loopback Capture Volume", 0, CS4231_LOOPBACK, 1, 63, 0,
+WSS_SINGLE_TLV("Loopback Capture Volume", 0, CS4231_LOOPBACK, 2, 63, 1,
 	       db_scale_6bit),
 };
 
 static struct snd_kcontrol_new snd_wss_controls[] = {
 WSS_DOUBLE("PCM Playback Switch", 0,
 		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
-WSS_DOUBLE("PCM Playback Volume", 0,
-		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1),
+WSS_DOUBLE_TLV("PCM Playback Volume", 0,
+		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1,
+		db_scale_6bit),
 WSS_DOUBLE("Line Playback Switch", 0,
 		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
-WSS_DOUBLE("Line Playback Volume", 0,
-		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1),
+WSS_DOUBLE_TLV("Line Playback Volume", 0,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1,
+		db_scale_5bit_12db_max),
 WSS_DOUBLE("Aux Playback Switch", 0,
 		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-WSS_DOUBLE("Aux Playback Volume", 0,
-		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1),
+WSS_DOUBLE_TLV("Aux Playback Volume", 0,
+		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1,
+		db_scale_5bit_12db_max),
 WSS_DOUBLE("Aux Playback Switch", 1,
 		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-WSS_DOUBLE("Aux Playback Volume", 1,
-		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1),
+WSS_DOUBLE_TLV("Aux Playback Volume", 1,
+		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1,
+		db_scale_5bit_12db_max),
 WSS_SINGLE("Mono Playback Switch", 0,
 		CS4231_MONO_CTRL, 7, 1, 1),
-WSS_SINGLE("Mono Playback Volume", 0,
-		CS4231_MONO_CTRL, 0, 15, 1),
+WSS_SINGLE_TLV("Mono Playback Volume", 0,
+		CS4231_MONO_CTRL, 0, 15, 1,
+		db_scale_4bit),
 WSS_SINGLE("Mono Output Playback Switch", 0,
 		CS4231_MONO_CTRL, 6, 1, 1),
 WSS_SINGLE("Mono Output Playback Bypass", 0,
 		CS4231_MONO_CTRL, 5, 1, 0),
-WSS_DOUBLE("Capture Volume", 0,
-		CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0, 15, 0),
+WSS_DOUBLE_TLV("Capture Volume", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT,
+		0, 0, 15, 0, db_scale_rec_gain),
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Capture Source",
@@ -2267,15 +2275,16 @@ WSS_DOUBLE("Mic Boost", 0,
 		CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 5, 5, 1, 0),
 WSS_SINGLE("Loopback Capture Switch", 0,
 		CS4231_LOOPBACK, 0, 1, 0),
-WSS_SINGLE("Loopback Capture Volume", 0,
-		CS4231_LOOPBACK, 2, 63, 1)
+WSS_SINGLE_TLV("Loopback Capture Volume", 0, CS4231_LOOPBACK, 2, 63, 1,
+		db_scale_6bit),
 };
 
 static struct snd_kcontrol_new snd_opti93x_controls[] = {
 WSS_DOUBLE("Master Playback Switch", 0,
 		OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 7, 7, 1, 1),
-WSS_DOUBLE("Master Playback Volume", 0,
-		OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 1, 1, 31, 1),
+WSS_DOUBLE_TLV("Master Playback Volume", 0,
+		OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 1, 1, 31, 1,
+		db_scale_6bit),
 WSS_DOUBLE("PCM Playback Switch", 0,
 		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
 WSS_DOUBLE("PCM Playback Volume", 0,
-- 
1.6.0.3


----------------------------------------------------------------------
Szukasz pracy? Chcesz lepiej zarabiaæ?
Sprawd¼ oferty na http://link.interia.pl/f23ba


--===============3352556512144989096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3352556512144989096==--
