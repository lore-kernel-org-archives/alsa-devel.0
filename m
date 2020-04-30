Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C4BC47247
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:07:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F82C2063A
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qzrnNWJN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIKSmQad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F82C2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB6E716C3;
	Thu, 30 Apr 2020 16:06:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB6E716C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588255625;
	bh=LNu0u4m1TpX1W4ZZjSTKvd48EX1thU7V29jKjQvWTMc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qzrnNWJN+MPBsVIvaLxt2U1cUm0A3xrppNYyP4P3UquSXgfRu8DMTe++D6ZKVW7Tj
	 q2dKHxyBsBbUGMnEq02rqOj5MkZlwYTv0craKg9jUkbwI2ANBFtYbM2o+JKgOpCNGw
	 1FX/08zdHU/i7l2jhEnPo5fTw0vEJFzc7uhK3V28=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22B5AF8038D;
	Thu, 30 Apr 2020 15:52:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F37CF80384; Thu, 30 Apr 2020 15:52:52 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99864F8035E
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 15:52:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99864F8035E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vIKSmQad"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 89E7024956;
 Thu, 30 Apr 2020 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588254754;
 bh=LNu0u4m1TpX1W4ZZjSTKvd48EX1thU7V29jKjQvWTMc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vIKSmQad2MdmAkFHv0XEozlv8HCZJ/6BBbb6YhQxu3ZKqUraDsWRGFrMekBjR5EcD
 LAp5n9Be9atpTacv4CvjO/M7iU4lQCSW0lzyfs13/KaWDw/RVJ+9jXdG208vWE2W5E
 pGEmpE4ueNCWqTHu3MLYlleteRMYlT2ubojI9W7g=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 13/57] ASoC: topology: Fix endianness issue
Date: Thu, 30 Apr 2020 09:51:34 -0400
Message-Id: <20200430135218.20372-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135218.20372-1-sashal@kernel.org>
References: <20200430135218.20372-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 26d87881590fd55ccdd8f829498d7b3033f81990 ]

As done in already existing cases, we should use le32_to_cpu macro while
accessing hdr->magic. Found with sparse.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20200415162435.31859-2-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 2d4a5a3058c41..65c91abb9462f 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2559,7 +2559,7 @@ static int soc_valid_header(struct soc_tplg *tplg,
 	}
 
 	/* big endian firmware objects not supported atm */
-	if (hdr->magic == SOC_TPLG_MAGIC_BIG_ENDIAN) {
+	if (le32_to_cpu(hdr->magic) == SOC_TPLG_MAGIC_BIG_ENDIAN) {
 		dev_err(tplg->dev,
 			"ASoC: pass %d big endian not supported header got %x at offset 0x%lx size 0x%zx.\n",
 			tplg->pass, hdr->magic,
-- 
2.20.1

