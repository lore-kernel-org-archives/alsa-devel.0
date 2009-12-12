From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opti93x: use dB scale for mixer controls
Date: Sat, 12 Dec 2009 09:51:03 +0100
Message-ID: <20091212095103.81747026.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 9898D24624
	for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2009 10:07:48 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add dB scale for mixer controls. Fix dB scale for
Master Volume control.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
The opti93x control patches can wait till next Linux version. I would like to see
the patch "opti93x: fix irq releasing if the irq cannot be allocated" in this release
as this is a typical bug fix.

Regards,
Krzysztof

 sound/isa/opti9xx/opti92x-ad1848.c |   36 ++++++++++++++++++++++--------------
 1 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 3f55b31..a4af53b 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -547,32 +547,40 @@ __skip_mpu:
 
 #ifdef OPTi93X
 
-static const DECLARE_TLV_DB_SCALE(db_scale_6bit, -9450, 150, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_5bit_3db_step, -9300, 300, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_5bit, -4650, 150, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_4bit_12db_max, -3300, 300, 0);
 
 static struct snd_kcontrol_new snd_opti93x_controls[] = {
 WSS_DOUBLE("Master Playback Switch", 0,
 		OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 7, 7, 1, 1),
 WSS_DOUBLE_TLV("Master Playback Volume", 0,
 		OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 1, 1, 31, 1,
-		db_scale_6bit),
-WSS_DOUBLE("PCM Playback Volume", 0,
-		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 31, 1),
-WSS_DOUBLE("FM Playback Volume", 0,
-		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 1, 1, 15, 1),
+		db_scale_5bit_3db_step),
+WSS_DOUBLE_TLV("PCM Playback Volume", 0,
+		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 31, 1,
+		db_scale_5bit),
+WSS_DOUBLE_TLV("FM Playback Volume", 0,
+		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 1, 1, 15, 1,
+		db_scale_4bit_12db_max),
 WSS_DOUBLE("Line Playback Switch", 0,
 		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
-WSS_DOUBLE("Line Playback Volume", 0,
-		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 15, 1),
+WSS_DOUBLE_TLV("Line Playback Volume", 0,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 15, 1,
+		db_scale_4bit_12db_max),
 WSS_DOUBLE("Mic Playback Switch", 0,
 		OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 7, 7, 1, 1),
-WSS_DOUBLE("Mic Playback Volume", 0,
-		OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 1, 1, 15, 1),
-WSS_DOUBLE("CD Playback Volume", 0,
-		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 1, 1, 15, 1),
+WSS_DOUBLE_TLV("Mic Playback Volume", 0,
+		OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 1, 1, 15, 1,
+		db_scale_4bit_12db_max),
+WSS_DOUBLE_TLV("CD Playback Volume", 0,
+		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 1, 1, 15, 1,
+		db_scale_4bit_12db_max),
 WSS_DOUBLE("Aux Playback Switch", 0,
 		OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 7, 7, 1, 1),
-WSS_DOUBLE("Aux Playback Volume", 0,
-		OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 1, 1, 15, 1),
+WSS_DOUBLE_TLV("Aux Playback Volume", 0,
+		OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 1, 1, 15, 1,
+		db_scale_4bit_12db_max),
 };
 
 static int __devinit snd_opti93x_mixer(struct snd_wss *chip)
-- 
1.6.4


----------------------------------------------------------------------
Zbieraj punkty - wygrywaj nagrody!
Kliknij >>> http://link.interia.pl/f24a8
