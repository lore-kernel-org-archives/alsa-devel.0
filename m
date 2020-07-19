Return-Path: <SRS0=8d/u=A6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16579C433E4
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2020 18:10:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927F320684
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2020 18:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uf7YEjis";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ohp3Gz9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927F320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA20B1661;
	Sun, 19 Jul 2020 20:09:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA20B1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595182249;
	bh=omGVsh55COPRJTe7js4am35W7GNXDD8W9P79YYMV8h0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uf7YEjisKCspY2beRR1o3gL0fLYx6p98qlXmZiaEOqERG2nIeBKPOv2KS/y31xEGE
	 EsnV2grFnMLVerrG2Pr3o8qSVNlirUsHdxtIbxJePxEOmYbYv/1Uwc6oqLVfeOTAjf
	 hYhqlK6aP6+LFIxDKj8zTrHd033Dct8tPhPYAHbs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A44B8F8015C;
	Sun, 19 Jul 2020 20:09:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0E2EF8015D; Sun, 19 Jul 2020 20:09:10 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16C30F8015C
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2020 20:09:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16C30F8015C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="Ohp3Gz9O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=iPaO1K0bu25pKqHZF+1ghwNegEI493yaKvwjy1Nvz34=; b=Ohp3Gz9OWNM5lu4juCjHWk7mQV
 wohMQnY5qMf9gLilT3+O1ya1aJ0LN6N+vQaiFLSlmdFWbs6aEtbwgvrOTq4fL+cAS3WR3Rnt//T26
 ybnQIontyas3pSlQrPpm2qg9PlMcFnLGnblCXQZdC42THweTmoMs0areLFnqF8Dhsb00CHnPMPCvn
 aXpEUpioD9Zwxq/C8IBMqK5PSihOgIAq8CnXlijcDNZUU53HPeVoygkk34FLRfBq6fycAl8S9W2ux
 8rceBVKvmv74KV9WGKk+fHlO8UNeEw704iF7cl7fpO+Wy5Va8TpvCLToIKDnwxtDbt57queUfoSLz
 x3ihyPzA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxDkF-0006Dj-QY; Sun, 19 Jul 2020 18:09:04 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wcd9335.h: fix duplicated word
Date: Sun, 19 Jul 2020 11:09:01 -0700
Message-Id: <20200719180901.30720-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
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

Fix the doubled word "in" in a comment by adding punctuation
in 3 places and capitalization.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/wcd9335.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200717.orig/sound/soc/codecs/wcd9335.h
+++ linux-next-20200717/sound/soc/codecs/wcd9335.h
@@ -4,9 +4,9 @@
 #define __WCD9335_H__
 
 /*
- * WCD9335 register base can change according to the mode it works in
- * in slimbus mode the reg base starts from 0x800
- * in i2s/i2c mode the reg base is 0x0
+ * WCD9335 register base can change according to the mode it works in.
+ * In slimbus mode the reg base starts from 0x800.
+ * In i2s/i2c mode the reg base is 0x0.
  */
 #define WCD9335_REG(pg, r)	((pg << 8) | (r))
 #define WCD9335_REG_OFFSET(r)	(r & 0xFF)
