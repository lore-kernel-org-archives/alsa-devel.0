Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B64C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jun 2022 10:49:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4006183E;
	Fri, 24 Jun 2022 12:49:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4006183E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656067797;
	bh=sEtRBhxM1rDhwev4tv8Ux2lP84NN8gT9990pnhrLamQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TmxizHCpaEsFp3vk/SDK5bh6F58+8mKO3nkAoLD/AH+rN9Ix3jZqKYV3hJipb6TrL
	 NIJBebUbNc4tIFslowzd/MCkZoC7y64VJS/kdG/PUo/Mo4hcZJU3s3nfC6cq3TqRcU
	 F9iSUnzxpZhLh9as34yUKlcBd9FQxTx8fV5X864g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9266FF80544;
	Fri, 24 Jun 2022 12:48:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 108BEF80139; Fri, 24 Jun 2022 12:48:07 +0200 (CEST)
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa1.perex.cz (Postfix) with ESMTP id D3D46F8016E
 for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2022 12:47:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3D46F8016E
Received: from hq-00021.holoplot.net (unknown [176.126.217.202])
 by mail.bugwerft.de (Postfix) with ESMTPSA id C070D504578;
 Fri, 24 Jun 2022 10:47:24 +0000 (UTC)
From: Daniel Mack <daniel@zonque.org>
To: broonie@kernel.org,
	ryan.lee.analog@gmail.com
Subject: [PATCH 5/8] ASoC: max98396: Improve some error prints
Date: Fri, 24 Jun 2022 12:47:09 +0200
Message-Id: <20220624104712.1934484-6-daniel@zonque.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624104712.1934484-1-daniel@zonque.org>
References: <20220624104712.1934484-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org,
 Daniel Mack <daniel@zonque.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Let's log what actually failed and log at some more places.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/codecs/max98396.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98396.c b/sound/soc/codecs/max98396.c
index 06ac637f2696..faa81b4bb709 100644
--- a/sound/soc/codecs/max98396.c
+++ b/sound/soc/codecs/max98396.c
@@ -372,7 +372,8 @@ static int max98396_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		break;
 
 	default:
-		dev_err(component->dev, "DAI invert mode unsupported\n");
+		dev_err(component->dev, "DAI invert mode %d unsupported\n",
+			fmt & SND_SOC_DAIFMT_INV_MASK);
 		return -EINVAL;
 	}
 
@@ -391,6 +392,8 @@ static int max98396_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		format |= MAX98396_PCM_FORMAT_TDM_MODE0;
 		break;
 	default:
+		dev_err(component->dev, "DAI format %d unsupported\n",
+			fmt & SND_SOC_DAIFMT_FORMAT_MASK);
 		return -EINVAL;
 	}
 
@@ -461,8 +464,9 @@ static int max98396_set_clock(struct snd_soc_component *component,
 		/* BCLK configuration */
 		value = max98396_get_bclk_sel(blr_clk_ratio);
 		if (!value) {
-			dev_err(component->dev, "format unsupported %d\n",
-				params_format(params));
+			dev_err(component->dev,
+				"blr_clk_ratio %d unsupported, format %d\n",
+				blr_clk_ratio, params_format(params));
 			return -EINVAL;
 		}
 
@@ -647,7 +651,7 @@ static int max98396_dai_tdm_slot(struct snd_soc_dai *dai,
 		chan_sz = MAX98396_PCM_MODE_CFG_CHANSZ_32;
 		break;
 	default:
-		dev_err(component->dev, "format unsupported %d\n",
+		dev_err(component->dev, "slot width %d unsupported\n",
 			slot_width);
 		return -EINVAL;
 	}
-- 
2.36.1

