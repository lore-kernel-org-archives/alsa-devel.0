From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 070/102] ASoC: tlv320aic23: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:26 +0100
Message-ID: <1392723517-12772-43-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AEF832655DE
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:38:39 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Just replace with the helper macro.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/tlv320aic23.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 5d430cc56f51..139f11f4dd8b 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -64,16 +64,16 @@ static const struct regmap_config tlv320aic23_regmap = {
 static const char *rec_src_text[] = { "Line", "Mic" };
 static const char *deemph_text[] = {"None", "32Khz", "44.1Khz", "48Khz"};
 
-static const struct soc_enum rec_src_enum =
-	SOC_ENUM_SINGLE(TLV320AIC23_ANLG, 2, 2, rec_src_text);
+static SOC_ENUM_SINGLE_DECL(rec_src_enum,
+			    TLV320AIC23_ANLG, 2, rec_src_text);
 
 static const struct snd_kcontrol_new tlv320aic23_rec_src_mux_controls =
 SOC_DAPM_ENUM("Input Select", rec_src_enum);
 
-static const struct soc_enum tlv320aic23_rec_src =
-	SOC_ENUM_SINGLE(TLV320AIC23_ANLG, 2, 2, rec_src_text);
-static const struct soc_enum tlv320aic23_deemph =
-	SOC_ENUM_SINGLE(TLV320AIC23_DIGT, 1, 4, deemph_text);
+static SOC_ENUM_SINGLE_DECL(tlv320aic23_rec_src,
+			    TLV320AIC23_ANLG, 2, rec_src_text);
+static SOC_ENUM_SINGLE_DECL(tlv320aic23_deemph,
+			    TLV320AIC23_DIGT, 1, deemph_text);
 
 static const DECLARE_TLV_DB_SCALE(out_gain_tlv, -12100, 100, 0);
 static const DECLARE_TLV_DB_SCALE(input_gain_tlv, -1725, 75, 0);
-- 
1.8.5.2
