Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFB0C43334
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jul 2022 04:34:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50DD218EE;
	Thu, 14 Jul 2022 06:33:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50DD218EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657773254;
	bh=JG031+SIFPqD7zsmkiMMSaalhVUkd4njI1+DibBd8D0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EehnYJqmxhwnxBvjcSPub9tjtS4yIuLUhjTftEyoovHYHXhPLZuPVInvhhuPB5eCm
	 dagfPRute6TahFY3m3LA26PW48BiSKDH6j9oMIcwL5Qm45poWK8SdMbzFxTU63jet1
	 dLjOs1OKjzuSTk7EjC8q18QEjoaWS7KnhWIa9FDI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F24AF8063D;
	Thu, 14 Jul 2022 06:25:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0FDA3F80638; Thu, 14 Jul 2022 06:25:12 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8C75F80570
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2022 06:25:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8C75F80570
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="A2bScdU0"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 848B1B82371;
 Thu, 14 Jul 2022 04:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01998C34114;
 Thu, 14 Jul 2022 04:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657772704;
 bh=JG031+SIFPqD7zsmkiMMSaalhVUkd4njI1+DibBd8D0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A2bScdU0+i25KMkQ9ghHWKtGHiHwDeibjH+HgztOkOw38LEIh6uKAloWPzj1Gb55K
 emcTPm/5A+hWVFjHZC+ITyrX8QUEXRcnvGHntQnyUQFteFumP0t22hYGYkEnubmKf/
 sl26YQ3697hVFd0UHPPMdvKS5EmKMnODDccbOGTIbMdQE1Cz2jhK+5S0EQ4Zf4AMZi
 MSHFapP1to12uGZaJ3AuQvZd2w5DasQ5k6sbC6lUpV/Y4HHku8XRZRuQ1nCne9RzND
 3iZOKco1WGUeAvkoh4DSmsCotzZNXyEWicDZXqz0PpwMQz8Q/sqdKOO1fE0Wg227k4
 qRqVXVeJxlZEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 13/28] ASoC: wm5110: Fix DRE control
Date: Thu, 14 Jul 2022 00:24:14 -0400
Message-Id: <20220714042429.281816-13-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714042429.281816-1-sashal@kernel.org>
References: <20220714042429.281816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com,
 simont@opensource.cirrus.com, tiwai@suse.com, lgirdwood@gmail.com,
 Mark Brown <broonie@kernel.org>
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

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 0bc0ae9a5938d512fd5d44f11c9c04892dcf4961 ]

The DRE controls on wm5110 should return a value of 1 if the DRE state
is actually changed, update to fix this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20220621102041.1713504-2-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm5110.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 5c2d45d05c97..7c6e01720d65 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -413,6 +413,7 @@ static int wm5110_put_dre(struct snd_kcontrol *kcontrol,
 	unsigned int rnew = (!!ucontrol->value.integer.value[1]) << mc->rshift;
 	unsigned int lold, rold;
 	unsigned int lena, rena;
+	bool change = false;
 	int ret;
 
 	snd_soc_dapm_mutex_lock(dapm);
@@ -440,8 +441,8 @@ static int wm5110_put_dre(struct snd_kcontrol *kcontrol,
 		goto err;
 	}
 
-	ret = regmap_update_bits(arizona->regmap, ARIZONA_DRE_ENABLE,
-				 mask, lnew | rnew);
+	ret = regmap_update_bits_check(arizona->regmap, ARIZONA_DRE_ENABLE,
+				       mask, lnew | rnew, &change);
 	if (ret) {
 		dev_err(arizona->dev, "Failed to set DRE: %d\n", ret);
 		goto err;
@@ -454,6 +455,9 @@ static int wm5110_put_dre(struct snd_kcontrol *kcontrol,
 	if (!rnew && rold)
 		wm5110_clear_pga_volume(arizona, mc->rshift);
 
+	if (change)
+		ret = 1;
+
 err:
 	snd_soc_dapm_mutex_unlock(dapm);
 
-- 
2.35.1

