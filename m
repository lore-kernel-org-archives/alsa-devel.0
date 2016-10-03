From: Petr Kulhavy <brain@jikos.cz>
Subject: [PATCH 5/5] ASoC: tas571x: move mixer volume controls
	from TAS5711 to TAS5717
Date: Mon,  3 Oct 2016 16:40:50 +0200
Message-ID: <1475505650-8572-6-git-send-email-brain@jikos.cz>
References: <1475505650-8572-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep12.mx.upcmail.net (fep12.mx.upcmail.net [62.179.121.32])
 by alsa0.perex.cz (Postfix) with ESMTP id 96F60266BC9
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 16:41:09 +0200 (CEST)
Received: from edge01.upcmail.net ([192.168.13.236]) by viefep12-int.chello.at
 (InterMail vM.8.01.05.13 201-2260-151-135-20130320) with ESMTP
 id <20161003144109.RATT657.viefep12-int.chello.at@edge01.upcmail.net>
 for <alsa-devel@alsa-project.org>; Mon, 3 Oct 2016 16:41:09 +0200
In-Reply-To: <1475505650-8572-1-git-send-email-brain@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

Channel 1 and 2 Mixer Volume controls (registers 0x72/0x73 and 0x76/0x77)
were wrongly assigned to tas5711_controls in commit f252d2346022
("ASoC: tas571x: add input channel mixer for TAS5717/19")

Therefore move them to tas5717_controls.

Signed-off-by: Petr Kulhavy <brain@jikos.cz>
---
 sound/soc/codecs/tas571x.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index f3252af..71790a1 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -391,16 +391,6 @@ static const struct snd_kcontrol_new tas5711_controls[] = {
 		   TAS571X_SOFT_MUTE_REG,
 		   TAS571X_SOFT_MUTE_CH1_SHIFT, TAS571X_SOFT_MUTE_CH2_SHIFT,
 		   1, 1),
-
-	SOC_DOUBLE_R_RANGE("CH1 Mixer Volume",
-			   TAS5717_CH1_LEFT_CH_MIX_REG,
-			   TAS5717_CH1_RIGHT_CH_MIX_REG,
-			   16, 0, 0x80, 0),
-
-	SOC_DOUBLE_R_RANGE("CH2 Mixer Volume",
-			   TAS5717_CH2_LEFT_CH_MIX_REG,
-			   TAS5717_CH2_RIGHT_CH_MIX_REG,
-			   16, 0, 0x80, 0),
 };
 
 static const struct regmap_range tas571x_readonly_regs_range[] = {
@@ -478,6 +468,16 @@ static const struct snd_kcontrol_new tas5717_controls[] = {
 		   TAS571X_SOFT_MUTE_CH1_SHIFT, TAS571X_SOFT_MUTE_CH2_SHIFT,
 		   1, 1),
 
+	SOC_DOUBLE_R_RANGE("CH1 Mixer Volume",
+			   TAS5717_CH1_LEFT_CH_MIX_REG,
+			   TAS5717_CH1_RIGHT_CH_MIX_REG,
+			   16, 0, 0x80, 0),
+
+	SOC_DOUBLE_R_RANGE("CH2 Mixer Volume",
+			   TAS5717_CH2_LEFT_CH_MIX_REG,
+			   TAS5717_CH2_RIGHT_CH_MIX_REG,
+			   16, 0, 0x80, 0),
+
 	/*
 	 * The biquads are named according to the register names.
 	 * Please note that TI's TAS57xx Graphical Development Environment
-- 
2.7.4
