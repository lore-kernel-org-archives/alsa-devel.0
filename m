Return-Path: <SRS0=JknX=K5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97D4C47082
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 17:15:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D6E613DC
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 17:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D6E613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D32F61753;
	Thu,  3 Jun 2021 19:14:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D32F61753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622740521;
	bh=ZJEJ+ezvyNiiZ1HMcpI0t6S34kzYxeNrMghwbFkwJiI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Aqibf61/5IIcDkM1LY3Wx//9f8DCspMxufCyG4opkMFtHutQFpnk8COVutmnxLML6
	 IfosR7QAO2ZYYS23PDp9Ov5F9MhkmJ/1SdiE9OwVkBEu8UVwrEGmAr93Ew8od/dWV2
	 tSaRX3idChpc+3MBjdiwTZIu5rP9DZHmJCg4T4/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DDFEFF80527;
	Thu,  3 Jun 2021 19:10:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5539BF80528; Thu,  3 Jun 2021 19:10:10 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74EFEF80526
 for <alsa-devel@alsa-project.org>; Thu,  3 Jun 2021 19:10:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74EFEF80526
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Rql02ZSz"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 540A261430;
 Thu,  3 Jun 2021 17:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622740206;
 bh=ZJEJ+ezvyNiiZ1HMcpI0t6S34kzYxeNrMghwbFkwJiI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Rql02ZSzlMFaUfyGK7w+GX0t6cIxwUJ1pLgUkdy5c+vxRLiBlJcY+j0jEjDQCRce7
 oFRGSTRgZG6ujfvkzomBz0ItkWMFDaaILePxS3nElnsYolGpyYk9Thv3aMc9qM/bJZ
 XPnp/Y+4dp+fqeyLZtjvqfOZYtVscc2oRN9vA3wrSEYCgq6sTDU7gMvsYxI5zJCeKe
 Ip743VStg4+BaeEm+/cQzsDFIYugTGLqb2vWNFyYwJbd9Hao6ovbIof65pJJk/4OLC
 6pj44UJC/vgdmdTyAmt7CAi/RUgyEQ4uTbS2VoYaba7IjuzRtDd17SSvJAFj/Hu1SD
 Mspzpd/bx4UBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/23] ASoC: sti-sas: add missing
 MODULE_DEVICE_TABLE
Date: Thu,  3 Jun 2021 13:09:41 -0400
Message-Id: <20210603170959.3169420-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603170959.3169420-1-sashal@kernel.org>
References: <20210603170959.3169420-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Hulk Robot <hulkci@huawei.com>,
 Zou Wei <zou_wei@huawei.com>, Mark Brown <broonie@kernel.org>,
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

From: Zou Wei <zou_wei@huawei.com>

[ Upstream commit e072b2671606c77538d6a4dd5dda80b508cb4816 ]

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Link: https://lore.kernel.org/r/1620789145-14936-1-git-send-email-zou_wei@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/sti-sas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 7316c80b8179..27196126f710 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -411,6 +411,7 @@ static const struct of_device_id sti_sas_dev_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, sti_sas_dev_match);
 
 static int sti_sas_driver_probe(struct platform_device *pdev)
 {
-- 
2.30.2

