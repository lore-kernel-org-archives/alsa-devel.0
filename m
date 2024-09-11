Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BE4FA3745
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Sep 2024 11:14:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2A2E14F7;
	Fri, 13 Sep 2024 13:14:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2A2E14F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1726226090;
	bh=LhFedJCR94M2rhZThQJpmVrhF9jDCYHsq2BK8/AdHs4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=nr37m2Fyacw0hOcDozKwQfyWWnKovummVhYYiugmozheK0QA9yRjAxQNo/A9kgUmO
	 FXevL7NOIFlr9ZOH1UQfOXm/9pCk3Z4Xxp7EoTlpAzqY0rwws9vQZp4VKoM7YtBTEG
	 l1wL+un/K+TBArW8+lUsrGUOfgX2k8QIoAQnrfA8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 97C7BF8071F; Fri, 13 Sep 2024 13:12:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 88650F806F5;
	Fri, 13 Sep 2024 13:12:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1767FF801F5; Wed, 11 Sep 2024 13:55:12 +0200 (CEST)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by alsa1.perex.cz (Postfix) with SMTP id 3DD10F80027
	for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2024 13:55:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3DD10F80027
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 7A6326096305A;
	Wed, 11 Sep 2024 19:54:58 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: herve.codina@bootlin.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: codecs: avoid possible garbage value in
 peb2466_reg_read()
Date: Wed, 11 Sep 2024 19:54:50 +0800
Message-Id: <20240911115448.277828-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: suhui@nfschina.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: VXZRBDQ7V233BFM2RYTDXIXEVLBSKR2P
X-Message-ID-Hash: VXZRBDQ7V233BFM2RYTDXIXEVLBSKR2P
X-Mailman-Approved-At: Fri, 13 Sep 2024 11:12:12 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VXZRBDQ7V233BFM2RYTDXIXEVLBSKR2P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Clang static checker (scan-build) warning:
sound/soc/codecs/peb2466.c:232:8:
Assigned value is garbage or undefined [core.uninitialized.Assign]
  232 |                 *val = tmp;
      |                      ^ ~~~

When peb2466_read_byte() fails, 'tmp' will have a garbage value.
Add a judgemnet to avoid this problem.

Fixes: 227f609c7c0e ("ASoC: codecs: Add support for the Infineon PEB2466 codec")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 sound/soc/codecs/peb2466.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/peb2466.c b/sound/soc/codecs/peb2466.c
index 76ee7e3f4d9b..67ea70cef0c7 100644
--- a/sound/soc/codecs/peb2466.c
+++ b/sound/soc/codecs/peb2466.c
@@ -229,7 +229,8 @@ static int peb2466_reg_read(void *context, unsigned int reg, unsigned int *val)
 	case PEB2466_CMD_XOP:
 	case PEB2466_CMD_SOP:
 		ret = peb2466_read_byte(peb2466, reg, &tmp);
-		*val = tmp;
+		if (!ret)
+			*val = tmp;
 		break;
 	default:
 		dev_err(&peb2466->spi->dev, "Not a XOP or SOP command\n");
-- 
2.30.2

