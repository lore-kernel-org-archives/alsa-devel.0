Return-Path: <SRS0=FVIg=OV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B87C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 10:45:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC7361361
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 10:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BC7361361
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BE4F16CC;
	Fri,  1 Oct 2021 12:44:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BE4F16CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633085121;
	bh=s9ytTJxv7Waltvl/Tl/nJrGqPwwyyl+SButVvilLW2E=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iJaxgEBwYPGF93xsUvd3HOJdMR49lYxM7HlmGt7KYebVynwoNBUObTf6AllrVY4/J
	 FZ7ciLxE1V7vwwWEVPtdpL+AnEMOPA9u0tsNxeM1Bxi8guy44OG7/zP4QlscWvM6Vy
	 pHQneh3kC2QpKowSu2lRIeJo6bu0tEkEhe/AUseI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 000D3F80227;
	Fri,  1 Oct 2021 12:44:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03E67F801F7; Fri,  1 Oct 2021 12:44:28 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 242BCF801F7
 for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2021 12:44:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 242BCF801F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="FRbiFYtv"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 34FFF4030D; 
 Fri,  1 Oct 2021 10:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1633085058;
 bh=O34Y8o/c2Wg1erpZ/C1tknCRMa2cDe1ONW7Pxy5f7KE=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=FRbiFYtvNJVvHal744VlOkzNohq/kvTF9ENdDvKyoLLPVOR7Na50w7YQ3ZNG4Ir5D
 Kf09w6RvoGJGWvGyvvnGUt282b825SeVUJVVqPhjQD0Q1OIgknkK1cjZ/gc8zSW+0D
 l8eoeT9PUb+xx85OZyvrr4rzdPc+MV7oR3cXM3wKGqCA+mQTAABPbmSNbEEyve/PiT
 NAxYwgPwZu8E98jSc6kZ/Q9trBs+cXFtVN/AbS7lq/NdPlHIg8LmqwskNCwPVB2DjI
 2gHAN6I9QRBS13ySBLMYa30oIUlehbi9fMDL/DemmIru6W669Ei+mUn5kAozbc/KEG
 JwtCugeT+lvCg==
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Alexander Tsoy <alexander@tsoy.me>, alsa-devel@alsa-project.org
Subject: [PATCH][next] ALSA: usb-audio: Fix sum of uninitialized variable
 sample_accum
Date: Fri,  1 Oct 2021 11:44:17 +0100
Message-Id: <20211001104417.14291-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

Variable sample_accum is not being intialized and then has
ep->sample_rem added to it, leading to a bogus value. One solution
is to initialize it to zero at declaration time, but it is probably
best to just assign it to ep->sample_rem on first use.

Addresses-Coveriry: ("Uninitialized scalar variable")
Fixes: f0bd62b64016 ("ALSA: usb-audio: Improve frames size computation")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/endpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 42c0d2db8ba8..c6a33732db3f 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -182,7 +182,7 @@ static int next_packet_size(struct snd_usb_endpoint *ep, unsigned int avail)
 	if (ep->fill_max)
 		return ep->maxframesize;
 
-	sample_accum += ep->sample_rem;
+	sample_accum = ep->sample_rem;
 	if (sample_accum >= ep->pps) {
 		sample_accum -= ep->pps;
 		ret = ep->packsize[1];
-- 
2.32.0

