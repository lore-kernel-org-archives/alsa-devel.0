Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF69C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 17:24:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2E361186
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 17:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B2E361186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4105B17C7;
	Wed, 15 Sep 2021 19:24:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4105B17C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631726691;
	bh=11IfLlG7/d+bq2n5fIVzsKIoKm0HuIFUadH/5zMFKqg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BjznqAUUhtXfnd43PZip5r/T5ptjuqmyXs1Xo0OyXySA4Yu25Tk/uKxpcBWuzoj/O
	 cGN92YKPuwzYzgHZ4+zCzCCTvlg5S9PqA2RNEwEiQSNKA9HllROQQsSR+mq5ehLgAS
	 tM36Qk+q3OURywFsRKrfG+3ePUcv2M4gD/RYUfao=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AEA64F80227;
	Wed, 15 Sep 2021 19:24:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4BE86F8027C; Wed, 15 Sep 2021 19:23:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A08EBF800EF
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 19:23:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A08EBF800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GOnsMkjN"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4EB161101;
 Wed, 15 Sep 2021 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631726632;
 bh=11IfLlG7/d+bq2n5fIVzsKIoKm0HuIFUadH/5zMFKqg=;
 h=From:To:Cc:Subject:Date:From;
 b=GOnsMkjN9qIEJYYTbAkDJ9vUFJxn+HiP70EmuerwRH1OA7GOCi9t15huEyHdh4tMj
 QaGtbIf2Nrb5WeP2TQXtTSyZ+r5Aa4PK+L5603gUFAOClILSHtdpAG8N6W6D/ikzyb
 PN97z9trBAGp1sHcCb63SzdGniBkJ3C9Y6XqOayephFmYjRG1xNNgypfREEMJJMjtr
 PBlIjVnngQq6sVF7jBwjg36K3zBqzggA/PESNyFGReB1lOzz04pxOt3IG48gplkb6u
 to/gzg4Fzmr/FLallLNYPkM1GkBJ461nOhWfhWjJUFyD3pXKoj1ZwRIjImmP2u7M+R
 wr2C/pLzyEl7g==
From: Mark Brown <broonie@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Subject: [PATCH] sh: Use modern ASoC DAI format terminology
Date: Wed, 15 Sep 2021 18:23:02 +0100
Message-Id: <20210915172302.36677-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; h=from:subject;
 bh=11IfLlG7/d+bq2n5fIVzsKIoKm0HuIFUadH/5zMFKqg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhQiuXiTtFN7sR9hC2A9+mw8lS+S1V4ZnUOkdg225s
 /FUf64SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUIrlwAKCRAk1otyXVSH0IcKB/
 9fuMZQxMg6bWtUAO2pQqJ3TuHZAvt6Rsc2ZfV2RcL82q19i8UfXTbNp6KHul/89ynMxfSt7zgCubih
 ksMF+6Ts8W80LlsI5v0PR0x82lhaJIHE3IaHTwkZlr2chVi9ES9a1XJsdTTFgxVUV0swPT4o8rOQr5
 zB/C4mvZCumEcXsJLJbcX3tdWw9aKoxh3RjtCxYipQ1LCTfIcm4DHqB2kqmHdVDvhh4Gb8jaucjU1g
 HTRpk1IEYOI0KJUbtxp8sqrAlGS6/vrXCo027EPJftRf8xmQPPwLGMsD3B0Ex2JV/3o0RFUfePmDn/
 JpvSoUzeCpM35VvDLtt4q5r+aKNYu4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-sh@vger.kernel.org
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

The SH machine drivers have some ASoC DAI format specifications that use
older defines based on outdated terminology which we're trying to retire,
update to the new bindings.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/sh/boards/mach-ecovec24/setup.c | 2 +-
 arch/sh/boards/mach-se/7724/setup.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index bab91a99124e..97c5703b1818 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -886,7 +886,7 @@ static struct asoc_simple_card_info fsi_da7210_info = {
 	.card		= "FSIB-DA7210",
 	.codec		= "da7210.0-001a",
 	.platform	= "sh_fsi.0",
-	.daifmt		= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM,
+	.daifmt		= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBP_CFP,
 	.cpu_dai = {
 		.name	= "fsib-dai",
 	},
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 8d6541ba0186..d9b31d4560c0 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -305,7 +305,7 @@ static struct asoc_simple_card_info fsi_ak4642_info = {
 	.card		= "FSIA-AK4642",
 	.codec		= "ak4642-codec.0-0012",
 	.platform	= "sh_fsi.0",
-	.daifmt		= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBM_CFM,
+	.daifmt		= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBP_CFP,
 	.cpu_dai = {
 		.name	= "fsia-dai",
 	},
-- 
2.20.1

