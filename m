From: Petr Kulhavy <brain@jikos.cz>
Subject: [PATCH v2 4/4] ASoC: tas571x: move mixer volume
	controls from TAS5711 to TAS5717
Date: Wed,  5 Oct 2016 15:51:07 +0200
Message-ID: <1475675467-5575-5-git-send-email-brain@jikos.cz>
References: <1475675467-5575-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep19.mx.upcmail.net (fep19.mx.upcmail.net [62.179.121.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 95C83266619
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2016 15:51:22 +0200 (CEST)
Received: from edge03.upcmail.net ([192.168.13.238]) by viefep19-int.chello.at
 (InterMail vM.8.01.05.18 201-2260-151-151-20140610) with ESMTP
 id <20161005135121.HFRR10074.viefep19-int.chello.at@edge03.upcmail.net>
 for <alsa-devel@alsa-project.org>; Wed, 5 Oct 2016 15:51:21 +0200
In-Reply-To: <1475675467-5575-1-git-send-email-brain@jikos.cz>
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
