Return-Path: <SRS0=ofI3=IX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8080BC433C1
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:29:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8436F61A1F
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8436F61A1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F30A91674;
	Thu, 25 Mar 2021 12:28:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F30A91674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616671771;
	bh=ih4y904yWzaAhA7DVefag97qpt+xUl+gClXPC0J6d0w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WX+YP7ABAB5jYhDVF4v8PqTqfDi1zFPc9Mr2ZGsnyMt+zZa2Nbm+j5JvhcH/xA/Ou
	 G60Ayx7oTrfb933xBRDz7f+o6pokd1VqUaeuSBzznATMyo494YRcf1C4MxIaN+StVX
	 c/1Jlhej+6/ygLucqjD4lKfr0IQF6X0aqBuEYb8U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7956FF804E0;
	Thu, 25 Mar 2021 12:25:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1F9AF804E2; Thu, 25 Mar 2021 12:25:52 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 466DDF8042F
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 12:25:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 466DDF8042F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="oH+48p8L"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B49EB61A2F;
 Thu, 25 Mar 2021 11:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616671541;
 bh=ih4y904yWzaAhA7DVefag97qpt+xUl+gClXPC0J6d0w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oH+48p8L1zE0SYgKfDaHlY6455ukG1H4CB2B+Q/YFkKaicp2LNG0nnjjnFN4T7j46
 z0itilF4Mi3R80hZ3DgKieIzq94Lk5tDdh3hd+dbIOK5ht8WX/ch4wAKGc0B4ZZF8i
 EW68Tedt3Y2FdPvwuwpLJSl14tiw4uY6itEMZ6ryu1gtT6mpmmKMUYu+EKuETDO5W/
 Eiw/8ywBhzS87gdioqFsnbypxZXzHoHQxzck8ZtadI5twwXLZbgCUM7C6K5E4gC0rD
 MsH8beA5UUHbl8rUNceVX6p/FWhGJN9gyM/vugG372lzHoLMk8v4BgRqie6tu8XYPv
 YeL9zhlIxurpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 32/44] ASoC: rt711: add snd_soc_component remove
 callback
Date: Thu, 25 Mar 2021 07:24:47 -0400
Message-Id: <20210325112459.1926846-32-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112459.1926846-1-sashal@kernel.org>
References: <20210325112459.1926846-1-sashal@kernel.org>
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
index 85f744184a60..047f4e677d78 100644
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

