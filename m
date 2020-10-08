Return-Path: <SRS0=AlSY=DP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06EFC4363C
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:08:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D394B206E5
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NkT3dFXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D394B206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineo.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC15116B0;
	Thu,  8 Oct 2020 15:07:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC15116B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602162480;
	bh=QzF7/YN1y4QeqEzugTY9mNjHTeizqOo1n4iWuUIy8AY=;
	h=From:Subject:To:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NkT3dFXU3MgyGZugvU/djaohRSAIhaelNfAQQ1/PGBGt4wJr6SEABOMUwG4eMSIAA
	 A+xV2FE9QW7+HNqJUx4XI4Gs+wfXQdFzUVOFbA2uofYypiaPg9z7LmtBUMACn6rpzR
	 n+w/AESFcmQrYErvC/HXg0WW3ilyNalufoPrLI3A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40B14F80167;
	Thu,  8 Oct 2020 15:06:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9203F8015B; Thu,  8 Oct 2020 10:47:53 +0200 (CEST)
Received: from mail.lineo.co.jp (ns.lineo.co.jp [203.141.200.203])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3637AF8015A
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2020 10:47:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3637AF8015A
Received: from [172.31.78.0] (unknown [203.141.200.204])
 by mail.lineo.co.jp (Postfix) with ESMTPSA id 4AA6580535E29;
 Thu,  8 Oct 2020 17:47:44 +0900 (JST)
From: Naoki Hayama <naoki.hayama@lineo.co.jp>
Subject: [PATCH 4/6] ALSA: hdspm: Fix typo arbitary
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Message-ID: <e04a8c5b-8c59-3f02-34d3-c1a871d08cc2@lineo.co.jp>
Date: Thu, 8 Oct 2020 17:47:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 08 Oct 2020 15:06:18 +0200
Cc: Naoki Hayama <naoki.hayama@lineo.co.jp>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

Fix comment typo.
s/arbitary/arbitrary/

Signed-off-by: Naoki Hayama <naoki.hayama@lineo.co.jp>
---
 sound/pci/rme9652/hdspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 572350aaf18d..a808b445afd8 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1217,7 +1217,7 @@ static int snd_hdspm_use_is_exclusive(struct hdspm *hdspm)
 	return ret;
 }
 
-/* round arbitary sample rates to commonly known rates */
+/* round arbitrary sample rates to commonly known rates */
 static int hdspm_round_frequency(int rate)
 {
 	if (rate < 38050)
-- 
2.17.1
