From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] wss: reuse CS4231 controls for AD1848
Date: Sun, 11 Oct 2009 12:38:49 +0200
Message-ID: <20091011123849.0c0179d0.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1964145870144131721=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E34D1037F7
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Oct 2009 12:21:55 +0200 (CEST)
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

--===============1964145870144131721==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The C4231 control set is a superset of the AD1848 control
set so reuse the CS4231 controls definitions for the AD1848.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/wss/wss_lib.c |   79 +++++++++++++---------------------------------
 1 files changed, 23 insertions(+), 56 deletions(-)

diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 754a208..2ba1897 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -2200,49 +2200,12 @@ static const DECLARE_TLV_DB_SCALE(db_scale_5bit_12db_max, -3450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_rec_gain, 0, 150, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_4bit, -4500, 300, 0);
 
-static struct snd_kcontrol_new snd_ad1848_controls[] = {
-WSS_DOUBLE("PCM Playback Switch", 0, CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT,
-	   7, 7, 1, 1),
-WSS_DOUBLE_TLV("PCM Playback Volume", 0,
-	       CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1,
-	       db_scale_6bit),
-WSS_DOUBLE("Aux Playback Switch", 0,
-	   CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-WSS_DOUBLE_TLV("Aux Playback Volume", 0,
-	       CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 0, 0, 31, 1,
-	       db_scale_5bit_12db_max),
-WSS_DOUBLE("Aux Playback Switch", 1,
-	   CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-WSS_DOUBLE_TLV("Aux Playback Volume", 1,
-	       CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1,
-	       db_scale_5bit_12db_max),
-WSS_DOUBLE_TLV("Capture Volume", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT,
-		0, 0, 15, 0, db_scale_rec_gain),
-{
-	.name = "Capture Source",
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.info = snd_wss_info_mux,
-	.get = snd_wss_get_mux,
-	.put = snd_wss_put_mux,
-},
-WSS_DOUBLE("Mic Boost", 0,
-		CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 5, 5, 1, 0),
-WSS_SINGLE("Loopback Capture Switch", 0, CS4231_LOOPBACK, 0, 1, 0),
-WSS_SINGLE_TLV("Loopback Capture Volume", 0, CS4231_LOOPBACK, 2, 63, 1,
-	       db_scale_6bit),
-};
-
 static struct snd_kcontrol_new snd_wss_controls[] = {
 WSS_DOUBLE("PCM Playback Switch", 0,
 		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
 WSS_DOUBLE_TLV("PCM Playback Volume", 0,
 		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 63, 1,
 		db_scale_6bit),
-WSS_DOUBLE("Line Playback Switch", 0,
-		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
-WSS_DOUBLE_TLV("Line Playback Volume", 0,
-		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1,
-		db_scale_5bit_12db_max),
 WSS_DOUBLE("Aux Playback Switch", 0,
 		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
 WSS_DOUBLE_TLV("Aux Playback Volume", 0,
@@ -2253,15 +2216,6 @@ WSS_DOUBLE("Aux Playback Switch", 1,
 WSS_DOUBLE_TLV("Aux Playback Volume", 1,
 		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 0, 0, 31, 1,
 		db_scale_5bit_12db_max),
-WSS_SINGLE("Mono Playback Switch", 0,
-		CS4231_MONO_CTRL, 7, 1, 1),
-WSS_SINGLE_TLV("Mono Playback Volume", 0,
-		CS4231_MONO_CTRL, 0, 15, 1,
-		db_scale_4bit),
-WSS_SINGLE("Mono Output Playback Switch", 0,
-		CS4231_MONO_CTRL, 6, 1, 1),
-WSS_SINGLE("Mono Output Playback Bypass", 0,
-		CS4231_MONO_CTRL, 5, 1, 0),
 WSS_DOUBLE_TLV("Capture Volume", 0, CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT,
 		0, 0, 15, 0, db_scale_rec_gain),
 {
@@ -2277,6 +2231,20 @@ WSS_SINGLE("Loopback Capture Switch", 0,
 		CS4231_LOOPBACK, 0, 1, 0),
 WSS_SINGLE_TLV("Loopback Capture Volume", 0, CS4231_LOOPBACK, 2, 63, 1,
 		db_scale_6bit),
+WSS_DOUBLE("Line Playback Switch", 0,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
+WSS_DOUBLE_TLV("Line Playback Volume", 0,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 31, 1,
+		db_scale_5bit_12db_max),
+WSS_SINGLE("Mono Playback Switch", 0,
+		CS4231_MONO_CTRL, 7, 1, 1),
+WSS_SINGLE_TLV("Mono Playback Volume", 0,
+		CS4231_MONO_CTRL, 0, 15, 1,
+		db_scale_4bit),
+WSS_SINGLE("Mono Output Playback Switch", 0,
+		CS4231_MONO_CTRL, 6, 1, 1),
+WSS_SINGLE("Mono Output Playback Bypass", 0,
+		CS4231_MONO_CTRL, 5, 1, 0),
 };
 
 static struct snd_kcontrol_new snd_opti93x_controls[] = {
@@ -2343,22 +2311,21 @@ int snd_wss_mixer(struct snd_wss *chip)
 			if (err < 0)
 				return err;
 		}
-	else if (chip->hardware & WSS_HW_AD1848_MASK)
-		for (idx = 0; idx < ARRAY_SIZE(snd_ad1848_controls); idx++) {
-			err = snd_ctl_add(card,
-					snd_ctl_new1(&snd_ad1848_controls[idx],
-						     chip));
-			if (err < 0)
-				return err;
-		}
-	else
-		for (idx = 0; idx < ARRAY_SIZE(snd_wss_controls); idx++) {
+	else {
+		int count = ARRAY_SIZE(snd_wss_controls);
+
+		/* Use only the first 11 entries on AD1848 */
+		if (chip->hardware & WSS_HW_AD1848_MASK)
+			count = 11;
+
+		for (idx = 0; idx < count; idx++) {
 			err = snd_ctl_add(card,
 					snd_ctl_new1(&snd_wss_controls[idx],
 						     chip));
 			if (err < 0)
 				return err;
 		}
+	}
 	return 0;
 }
 EXPORT_SYMBOL(snd_wss_mixer);
-- 
1.6.0.3


----------------------------------------------------------------------
Szukasz pracy? Chcesz lepiej zarabiaæ?
Sprawd¼ oferty na http://link.interia.pl/f23ba


--===============1964145870144131721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1964145870144131721==--
