From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 11/11] ASoC: use of_property_read_bool
Date: Fri,  5 Aug 2016 10:56:51 +0200
Message-ID: <1470387411-15879-12-git-send-email-Julia.Lawall@lip6.fr>
References: <1470387411-15879-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CC29265A7F
 for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2016 11:14:30 +0200 (CEST)
In-Reply-To: <1470387411-15879-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Use of_property_read_bool to check for the existence of a property.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e1,e2;
statement S2,S1;
@@
-       if (of_get_property(e1,e2,NULL))
+       if (of_property_read_bool(e1,e2))
        S1 else S2
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/codecs/ab8500-codec.c |   10 +++++-----
 sound/soc/sh/rcar/ssi.c         |    2 +-
 sound/soc/soc-core.c            |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 2fc8915..1d4059c 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2408,28 +2408,28 @@ static void ab8500_codec_of_probe(struct device *dev, struct device_node *np,
 {
 	u32 value;
 
-	if (of_get_property(np, "stericsson,amic1-type-single-ended", NULL))
+	if (of_property_read_bool(np, "stericsson,amic1-type-single-ended"))
 		codec->amics.mic1_type = AMIC_TYPE_SINGLE_ENDED;
 	else
 		codec->amics.mic1_type = AMIC_TYPE_DIFFERENTIAL;
 
-	if (of_get_property(np, "stericsson,amic2-type-single-ended", NULL))
+	if (of_property_read_bool(np, "stericsson,amic2-type-single-ended"))
 		codec->amics.mic2_type = AMIC_TYPE_SINGLE_ENDED;
 	else
 		codec->amics.mic2_type = AMIC_TYPE_DIFFERENTIAL;
 
 	/* Has a non-standard Vamic been requested? */
-	if (of_get_property(np, "stericsson,amic1a-bias-vamic2", NULL))
+	if (of_property_read_bool(np, "stericsson,amic1a-bias-vamic2"))
 		codec->amics.mic1a_micbias = AMIC_MICBIAS_VAMIC2;
 	else
 		codec->amics.mic1a_micbias = AMIC_MICBIAS_VAMIC1;
 
-	if (of_get_property(np, "stericsson,amic1b-bias-vamic2", NULL))
+	if (of_property_read_bool(np, "stericsson,amic1b-bias-vamic2"))
 		codec->amics.mic1b_micbias = AMIC_MICBIAS_VAMIC2;
 	else
 		codec->amics.mic1b_micbias = AMIC_MICBIAS_VAMIC1;
 
-	if (of_get_property(np, "stericsson,amic2-bias-vamic1", NULL))
+	if (of_property_read_bool(np, "stericsson,amic2-bias-vamic1"))
 		codec->amics.mic2_micbias = AMIC_MICBIAS_VAMIC1;
 	else
 		codec->amics.mic2_micbias = AMIC_MICBIAS_VAMIC2;
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 5f848f0..6cb6db0 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -928,7 +928,7 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 		}
 
 		ops = &rsnd_ssi_non_ops;
-		if (of_get_property(np, "pio-transfer", NULL))
+		if (of_property_read_bool(np, "pio-transfer"))
 			ops = &rsnd_ssi_pio_ops;
 		else
 			ops = &rsnd_ssi_dma_ops;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 16369ca..ead49d0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3733,7 +3733,7 @@ unsigned int snd_soc_of_parse_daifmt(struct device_node *np,
 	 * SND_SOC_DAIFMT_CLOCK_MASK area
 	 */
 	snprintf(prop, sizeof(prop), "%scontinuous-clock", prefix);
-	if (of_get_property(np, prop, NULL))
+	if (of_property_read_bool(np, prop))
 		format |= SND_SOC_DAIFMT_CONT;
 	else
 		format |= SND_SOC_DAIFMT_GATED;
