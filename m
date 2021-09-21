Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592D5C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:12:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A9860F70
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 21:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 82A9860F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20DB9827;
	Tue, 21 Sep 2021 23:11:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20DB9827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632258746;
	bh=zSHBaEge3vIffxUMJGRccMptS+Nr4Yr8WQuKISPrvVI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gymIZip2i4ysot/z3+2UF3H2FFf39N+s3FHIlciqL64A3CY8HOvwSskh76rjYxmNN
	 yf7hX3gzbOyK04MPp4yaLTR8ZmT5QSUjuPcZQ0k2ZyXV6fqyOogU3Ntvh/17azIMhe
	 v0ywUncQuqXAvhDE56VOGDflgQBRjCSvzJzuVm8E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F0BAF8026A;
	Tue, 21 Sep 2021 23:11:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4AB1EF80268; Tue, 21 Sep 2021 23:11:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8929F8016E
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 23:11:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8929F8016E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ct/epNrz"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC36261211;
 Tue, 21 Sep 2021 21:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632258685;
 bh=zSHBaEge3vIffxUMJGRccMptS+Nr4Yr8WQuKISPrvVI=;
 h=From:To:Cc:Subject:Date:From;
 b=ct/epNrzkQmnSnMxonGErrOp/QZVEaNhSQbCRjdCHaNAA1gi1j2DkTL7Yns28QQpb
 PDXOyMMn6OzB2yeNLnitJus96FtwKGWmAc8qzGHbE7aCZxBjgIrH4/LcLo3zN4eXWX
 o04e65caFex96H//m+77IxrOJrPwH4gzfyZkcAk+nBQ1RoLvMaSd47/36Q3CCNCGy7
 iPmSIq1yLUCIFB5X6lC+D5TbM12U2r6d39Ai+/yQQ5fgUwYagng0dgIWIkIZZsvyx2
 Abu6ZAq6GR7tMWo6cpQM1D5ULb6sL+qgsoPh0rDMI23RmmhtbVzrLLVke+4vlR1WFE
 vA7iZ28sYtRKQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH 01/16] ASoC: eureka-tlv320: Update to modern clocking
 terminology
Date: Tue, 21 Sep 2021 22:10:25 +0100
Message-Id: <20210921211040.11624-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=818; h=from:subject;
 bh=zSHBaEge3vIffxUMJGRccMptS+Nr4Yr8WQuKISPrvVI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSknbj/RSRUcVVBm/LLpoHGroCue6wcCm71p7LgUe
 WE1IRW2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUpJ2wAKCRAk1otyXVSH0JuDB/
 9IvULyXNpryV6KS+Qr/RWVSc51PvQdZ8MoHr+5G70pOzWBEvNhgPG4jFfKOiHXDcYu0LBZxQw4SJgC
 9Zsu7PU+CAKe7IO3d/IEI88a7MLpGzdPrkOhd9y3lmodAFNjUev4ARL52eq3UD+4UUFAhb94J3yjn9
 HbzjgiQXQ1Qg2fwGKN0gsWMqQCjehPTetC0ScZUQSPzMFdPNZUCyyuTJPRUpRTm1/LlEstdq/kyDbt
 CZT5ifot9tQnk3plaLGrpZZ3XG1Ef7UPB4M/Rh1MTNe3iri4JEkcMJxFD5PiU3YOZdHgv6APriv6db
 fh/ex1a4LLFZy2ZqTShw0PZBTHdgvo
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
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

As part of moving to remove the old style defines for the bus clocks update
the eureka-tlv320 driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/eukrea-tlv320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index e13271ea84de..8b61582753c8 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -70,7 +70,7 @@ static struct snd_soc_dai_link eukrea_tlv320_dai = {
 	.name		= "tlv320aic23",
 	.stream_name	= "TLV320AIC23",
 	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			  SND_SOC_DAIFMT_CBM_CFM,
+			  SND_SOC_DAIFMT_CBP_CFP,
 	.ops		= &eukrea_tlv320_snd_ops,
 	SND_SOC_DAILINK_REG(hifi),
 };
-- 
2.20.1

