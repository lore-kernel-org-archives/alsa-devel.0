Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D41EC4320A
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 13:21:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0135C61A0D
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 13:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0135C61A0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A9781EFA;
	Tue, 27 Jul 2021 15:20:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A9781EFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627392076;
	bh=u1luN1sMFI7o5STBnQbpqlrcozJB2enfmjp0qualJQw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FPKhGdzc+12kZMqJbHtzGGuJsFtro2jgVgP3E2uGEOZyWfyAkw/es86zn7fXG3H40
	 05j0VetHJPxEnlsaDuYql4HSYMGfmPtoAO8llwK+6E+mtssby5+TbiAJM/ncrLFnzb
	 X8CiL2yGmwgl/wfQXRnGAWO3roRd2IUyYdG1fTQg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56E0EF804BD;
	Tue, 27 Jul 2021 15:19:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 316D5F804DF; Tue, 27 Jul 2021 15:19:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2AA23F8026C
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 15:19:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2AA23F8026C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dw/jGL3n"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A46FE61A8A;
 Tue, 27 Jul 2021 13:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627391968;
 bh=u1luN1sMFI7o5STBnQbpqlrcozJB2enfmjp0qualJQw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dw/jGL3nnSEU4BMC/t+CayYx/P8K3KrpiqvfbWAZo1/qqfUH+SD7qRe2Vmwy0ZPBz
 m+A7hF7QDm6PLLL+FyBKi+Ulf/lwRnLv/SeeekLW3rJRbSiY1OjKG6MiyR0vBbg9L7
 bin+fcjFAyD+S2DhgOe49L5yvsz7hZR4U2fNnVYdx1+mhPmNCB2fnGHyRMPPmKnLRS
 kMndzjFi1kL1ISiPssN3UjNV0ZdhTxWOhyIhSIudqcjlkk9DnNVzrSYQgoGj1GqO2G
 jMgySKpaNPaje7Y4S0g/GRz11VOyjm5FLFyqmrcqisZshkMX2E0Hsx1934XX/IDLci
 8MBhE+cZZBNgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 14/21] ASoC: ti: j721e-evm: Check for not
 initialized parent_clk_id
Date: Tue, 27 Jul 2021 09:19:01 -0400
Message-Id: <20210727131908.834086-14-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727131908.834086-1-sashal@kernel.org>
References: <20210727131908.834086-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>
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

From: Peter Ujfalusi <peter.ujfalusi@gmail.com>

[ Upstream commit 82d28b67f780910f816fe1cfb0f676fc38c4cbb3 ]

During probe the parent_clk_id is set to -1 which should not be used to
array index within hsdiv_rates[].

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Link: https://lore.kernel.org/r/20210717122820.1467-3-peter.ujfalusi@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/j721e-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index 017c4ad11ca6..265bbc5a2f96 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -197,7 +197,7 @@ static int j721e_configure_refclk(struct j721e_priv *priv,
 		return ret;
 	}
 
-	if (priv->hsdiv_rates[domain->parent_clk_id] != scki) {
+	if (domain->parent_clk_id == -1 || priv->hsdiv_rates[domain->parent_clk_id] != scki) {
 		dev_dbg(priv->dev,
 			"%s configuration for %u Hz: %s, %dxFS (SCKI: %u Hz)\n",
 			audio_domain == J721E_AUDIO_DOMAIN_CPB ? "CPB" : "IVI",
-- 
2.30.2

