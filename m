From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/17] ASoC: adav80x: Replace usage deprecated
	MUX/ENUM macros
Date: Mon, 14 Apr 2014 21:30:57 +0200
Message-ID: <1397503872-20864-3-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id A89062656AF
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:21 +0200 (CEST)
In-Reply-To: <1397503872-20864-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

SND_SOC_DAPM_VALUE_MUX and SOC_DAPM_VALUE_ENUM are deprecated and merely an
alias for SND_SOC_DAPM_MUX and SOC_DAPM_ENUM. Replace the deprecated macros so
we can eventually remove their definition.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adav80x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index cf170b5..c43b93f 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -172,14 +172,14 @@ static ADAV80X_MUX_ENUM_DECL(adav80x_capture_enum, ADAV80X_DPATH_CTRL1, 3);
 static ADAV80X_MUX_ENUM_DECL(adav80x_dac_enum, ADAV80X_DPATH_CTRL2, 3);
 
 static const struct snd_kcontrol_new adav80x_aux_capture_mux_ctrl =
-	SOC_DAPM_VALUE_ENUM("Route", adav80x_aux_capture_enum);
+	SOC_DAPM_ENUM("Route", adav80x_aux_capture_enum);
 static const struct snd_kcontrol_new adav80x_capture_mux_ctrl =
-	SOC_DAPM_VALUE_ENUM("Route", adav80x_capture_enum);
+	SOC_DAPM_ENUM("Route", adav80x_capture_enum);
 static const struct snd_kcontrol_new adav80x_dac_mux_ctrl =
-	SOC_DAPM_VALUE_ENUM("Route", adav80x_dac_enum);
+	SOC_DAPM_ENUM("Route", adav80x_dac_enum);
 
 #define ADAV80X_MUX(name, ctrl) \
-	SND_SOC_DAPM_VALUE_MUX(name, SND_SOC_NOPM, 0, 0, ctrl)
+	SND_SOC_DAPM_MUX(name, SND_SOC_NOPM, 0, 0, ctrl)
 
 static const struct snd_soc_dapm_widget adav80x_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DAC", NULL, ADAV80X_DAC_CTRL1, 7, 1),
-- 
1.8.0
