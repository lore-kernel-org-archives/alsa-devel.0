Return-Path: <SRS0=ofI3=IX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564F3C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:35:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A923E61A24
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A923E61A24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15C5F852;
	Thu, 25 Mar 2021 12:34:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15C5F852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616672119;
	bh=sZroW6ZD33NImc7OmNg0DCW18XpmCtLFFO8WzF2ZY0U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CeLSX2q9Eu6O6phEbw6Bb+NOP6x4j9le3eC2EEtEHcwO93NmkQpEwRJdVPDr6DBk4
	 mdts2xTIH55nz93Z4awbxxL9KQQaJ8Tu53LH8DA4OAIGNzadZmgFDC/mgsx5cd6Hko
	 GUHKBDnTNYSCNMVgdJ7S0E+D+7CVzbixyw1zFJYI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA8D0F80544;
	Thu, 25 Mar 2021 12:26:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B9C1F8053B; Thu, 25 Mar 2021 12:26:52 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FDD7F8051D
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 12:26:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FDD7F8051D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WDHwCLkK"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1FFF61A2E;
 Thu, 25 Mar 2021 11:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616671597;
 bh=sZroW6ZD33NImc7OmNg0DCW18XpmCtLFFO8WzF2ZY0U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WDHwCLkKWGCpnQUh7rLv1BBU3gZFjs3lY6yon63MdYSvkYeqYR99OtL7mMKapPOea
 fn27ALXE1id2IOA1SMIvByS2AySwbjnez29URWFz3Id7MpXKbprlEGyy7MMz+FaJuk
 ef1y0KxH24jZYtx/lSt+fULVf4YZhXZ3je6b4WutM5eEM4YLIagI5DzU02kAItvNgz
 TwQ0LCtQ6wQXMRRl3RE2L5lTcqan6ot82S79XiM+/O+SWgV/eor2aoExwzpibA6DUF
 RVgV0Gf9+zDocjDoqLBAHfo4NSS80p7KBwrmkoZhNtOAB947hBNctvq7tbIJE+cdDy
 LikrNQKhvoW2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 29/39] ASoC: rt711: add snd_soc_component remove
 callback
Date: Thu, 25 Mar 2021 07:25:48 -0400
Message-Id: <20210325112558.1927423-29-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112558.1927423-1-sashal@kernel.org>
References: <20210325112558.1927423-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, Mark Brown <broonie@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 899b12542b0897f92de9ba30944937c39ebb246d ]

We do some IO operations in the snd_soc_component_set_jack callback
function and snd_soc_component_set_jack() will be called when soc
component is removed. However, we should not access SoundWire registers
when the bus is suspended.
So set regcache_cache_only(regmap, true) to avoid accessing in the
soc component removal process.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Link: https://lore.kernel.org/r/20210316005254.29699-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt711.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt711.c b/sound/soc/codecs/rt711.c
index a9b1b4180c47..93d86f7558e0 100644
--- a/sound/soc/codecs/rt711.c
+++ b/sound/soc/codecs/rt711.c
@@ -895,6 +895,13 @@ static int rt711_probe(struct snd_soc_component *component)
 	return 0;
 }
 
+static void rt711_remove(struct snd_soc_component *component)
+{
+	struct rt711_priv *rt711 = snd_soc_component_get_drvdata(component);
+
+	regcache_cache_only(rt711->regmap, true);
+}
+
 static const struct snd_soc_component_driver soc_codec_dev_rt711 = {
 	.probe = rt711_probe,
 	.set_bias_level = rt711_set_bias_level,
@@ -905,6 +912,7 @@ static const struct snd_soc_component_driver soc_codec_dev_rt711 = {
 	.dapm_routes = rt711_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(rt711_audio_map),
 	.set_jack = rt711_set_jack_detect,
+	.remove = rt711_remove,
 };
 
 static int rt711_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
-- 
2.30.1

