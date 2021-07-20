Return-Path: <SRS0=et8u=MM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5C6C07E9B
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jul 2021 15:38:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFCBF601FD
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jul 2021 15:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCBF601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CCB61663;
	Tue, 20 Jul 2021 17:38:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CCB61663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626795533;
	bh=CZpj9W3gO2JslcWyEv/KYgvOZcZ6Bm3Do2qtFX3bfUk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ei4Y32TV1zUQBfmrO3pLDxZa1Z8VEgchWnAFCSEHClPTqOLiKgR6GMZks/KtL5xhp
	 hQL5vMwiALUrXC9AJXyL2T3HtIZdDQPEbedtPujWwEtqTZXVA5t6vDTiyKcY3MR9C4
	 ousq4iDPWWuKSMvDJj213HyIHVQIgFXHkguwGj7w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A04DBF80169;
	Tue, 20 Jul 2021 17:38:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F9C4F8020D; Tue, 20 Jul 2021 17:38:02 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BB58F800DA
 for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2021 17:37:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BB58F800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="AWXqm5bp"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8CF2D40601; 
 Tue, 20 Jul 2021 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1626795469;
 bh=vSe9B2XKzwjqZRJOAWXj0xGJqQPCF7dn+Fs2x2z3Q1I=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=AWXqm5bpaoeROqEvOTnTWyCjK4OkcAn9n7m1/mRm13jhExQrZuXnXvdpW96IMiphy
 grMU6M85EtazGbM+1gKalYq8jm5SoubL/fwFxMIMXerLFz/YRZuaHnZiannfgZIjV9
 Q8zP/eoKSnFbGPCnI0sFWFa+j/FD6WxQdqbJymskqIqh0Z8iFwtqzZopoowtDmbOip
 cS/80tYRdfAx2wRpvtQIXVcT34nNJi0G64YDvf4PA49+ymeytfN6RCa+isSeArvxp8
 W28rja8512PMiUUx6Lt95FEMcOwgPIo6/Y5j6YvC3g//9gl3h8zTxVoSyziCxzR+s0
 qk4o7F3MEjuIQ==
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH][next] ALSA: opti9xx: fix missing { } around an if block
Date: Tue, 20 Jul 2021 16:37:41 +0100
Message-Id: <20210720153741.73230-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
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

Currently the { } braces are missing around an if block causing subsequent
code after the return to become unreachable. Fix this by adding the
missing { }.

Addresses-Coverity: ("Structurally dead code")
Fixes: 2973ee4a5b54 ("ALSA: opti9xx: Allocate resources with device-managed APIs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/opti9xx/opti92x-ad1848.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 8988de8cca96..4beeb32fe2a7 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -1096,9 +1096,10 @@ static int snd_opti9xx_pnp_probe(struct pnp_card_link *pcard,
 	if (error)
 		return error;
 	error = snd_opti9xx_read_check(card, chip);
-	if (error)
+	if (error) {
 		snd_printk(KERN_ERR "OPTI chip not found\n");
 		return error;
+	}
 	error = snd_opti9xx_probe(card);
 	if (error < 0)
 		return error;
-- 
2.31.1

