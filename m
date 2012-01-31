From: Axel Lin <axel.lin@gmail.com>
Subject: [RFC][PATCH] ASoC: cs42l73: Fix Output [X|A|V]SP_SCLK
 Sourcing Mode setting for master mode
Date: Tue, 31 Jan 2012 09:49:04 +0800
Message-ID: <1327974544.4566.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D13710386C
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 02:49:16 +0100 (CET)
Received: by yenl11 with SMTP id l11so2197554yen.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 17:49:14 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

For master mode, set Output [X|A|V]SP_SCLK Sourcing Mode to MCLK Mode.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
Hi Brian,
I think current code of setting priv->config[id].spc for master mode is wrong:
priv->config[id].spc &= MCK_SCLK_64FS; will set priv->config[id].spc to be 0.

I don't have this hardware, I'd appreciate you can review and test this patch.

Regards,
Axel
 sound/soc/codecs/cs42l73.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 9d38db8..78979b3 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1113,7 +1113,7 @@ static int cs42l73_pcm_hw_params(struct snd_pcm_substream *substream,
 		priv->config[id].mmcc &= 0xC0;
 		priv->config[id].mmcc |= cs42l73_mclk_coeffs[mclk_coeff].mmcc;
 		priv->config[id].spc &= 0xFC;
-		priv->config[id].spc &= MCK_SCLK_64FS;
+		priv->config[id].spc |= MCK_SCLK_MCLK;
 	} else {
 		/* CS42L73 Slave */
 		priv->config[id].spc &= 0xFC;
-- 
1.7.5.4
