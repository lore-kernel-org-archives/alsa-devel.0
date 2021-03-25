Return-Path: <SRS0=ofI3=IX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCF5C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:42:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4C161A0A
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4C161A0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A18361711;
	Thu, 25 Mar 2021 12:41:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A18361711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616672557;
	bh=s5OWk1cjPt8bU+1Vjn70hDX3t7XOAuZ7lzsGmHtrdtU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=saq9IfCkMpEQtIAG62R7uCmu5CMN9/FS/iRXV3FpRmu+m6DKGFYx+jx798VM3StGf
	 7JA4Irt1VvL5un+aY5Zxm5co+pWY/AyMaGvhjeEGgHmHfB0QI0P1IePi+7zVzRVtWK
	 5JLZr7gnovgCT6l0tZmehBHvpNUpwzvLDIE8Bjkg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0085F805F8;
	Thu, 25 Mar 2021 12:28:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8FA3F805D6; Thu, 25 Mar 2021 12:28:10 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4573BF805E0
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 12:27:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4573BF805E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WvYKapQM"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EC2661A59;
 Thu, 25 Mar 2021 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616671667;
 bh=s5OWk1cjPt8bU+1Vjn70hDX3t7XOAuZ7lzsGmHtrdtU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WvYKapQM2ReQIstxd9Q0N5tsKlBxslAvWDVGrg/QyvbuFh4GPa/zL9HvxjOz7p+p2
 LH+eRsVbTM0hhmtHwU18lA9nssF1sNaxMfriybA4X1Ha2gW9mlPK6i5gJTTC+UaZEB
 9PbgINAPo6eF6CF6A7ZaSPvHkBstQ2Aqz8ypSO/JAb4fc0UJySkZzII0CGs3eGDXKI
 S5WLVk3lyBZ6tzhs79+AO4a2W3uiAHpK20cSw5VRkypyO5VWuXN85PKz8WnoDtbvgq
 /BZMpQP34OHob+g2kseTuKqxo2kkhHKqM30CS8F747Qx8nZvwgGE2e1hk3A6uQmj+i
 0LOwRgSDoBvDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/20] ASoC: rt5659: Update MCLK rate in
 set_sysclk()
Date: Thu, 25 Mar 2021 07:27:21 -0400
Message-Id: <20210325112724.1928174-17-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112724.1928174-1-sashal@kernel.org>
References: <20210325112724.1928174-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Sameer Pujar <spujar@nvidia.com>,
 Mark Brown <broonie@kernel.org>, Michael Walle <michael@walle.cc>,
 alsa-devel@alsa-project.org
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

From: Sameer Pujar <spujar@nvidia.com>

[ Upstream commit dbf54a9534350d6aebbb34f5c1c606b81a4f35dd ]

Simple-card/audio-graph-card drivers do not handle MCLK clock when it
is specified in the codec device node. The expectation here is that,
the codec should actually own up the MCLK clock and do necessary setup
in the driver.

Suggested-by: Mark Brown <broonie@kernel.org>
Suggested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Link: https://lore.kernel.org/r/1615829492-8972-3-git-send-email-spujar@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5659.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 1c1a521c73cb..b331b3ba61a9 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -3466,12 +3466,17 @@ static int rt5659_set_component_sysclk(struct snd_soc_component *component, int
 {
 	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 	unsigned int reg_val = 0;
+	int ret;
 
 	if (freq == rt5659->sysclk && clk_id == rt5659->sysclk_src)
 		return 0;
 
 	switch (clk_id) {
 	case RT5659_SCLK_S_MCLK:
+		ret = clk_set_rate(rt5659->mclk, freq);
+		if (ret)
+			return ret;
+
 		reg_val |= RT5659_SCLK_SRC_MCLK;
 		break;
 	case RT5659_SCLK_S_PLL1:
-- 
2.30.1

