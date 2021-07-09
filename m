Return-Path: <SRS0=Xr4r=MB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD26C07E99
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Jul 2021 15:30:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F934613C1
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Jul 2021 15:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F934613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CFD915E2;
	Fri,  9 Jul 2021 17:29:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CFD915E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625844646;
	bh=jKuv6F+dqS5LXCQxH+vA7lyavItzhoXoMp9fkGgyKB0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WZ9VKUqNw96IvKqSgqU2eAe1670fdNcaeg6sSqGDnh5GJAUMRklgN7YIVL+f0eL7J
	 imoHldp9HWZ7caQgXPXt/RcPuo/RT7T50FgREzT8dV3VcTNG6jlNRq2eGtBpbzT5XT
	 /0uWzzfPwkYRzkodPdsGk3vBrorMOKnkwnU9xvPs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2C62F80171;
	Fri,  9 Jul 2021 17:29:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3712CF80224; Fri,  9 Jul 2021 17:29:51 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E266DF8012A
 for <alsa-devel@alsa-project.org>; Fri,  9 Jul 2021 17:29:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E266DF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="gvlHziTO"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1DEBB404A1; 
 Fri,  9 Jul 2021 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1625844579;
 bh=xe5I//6AkaPs41liKKGn0Rijuw2VMft/GmwfbTDfTB4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=gvlHziTOkfNokIk4C7ZzIf+ycYDnRmq+TVn0amcF7qMr42pkhAvLx9yG/Y95QVYoJ
 BzNxeWDIXG9vO7GtjUEnN5bF7lYIRlwCRWm/aJ45tS/NDhRnFNkobJFLRhT740h8K9
 aY0FASt7wBhIz7C60NS1hDkrX3cFQqbucicYWy69MYfImR9Wp9H63REh2lJ6/TpuVI
 1RgvpvrzOVTybmig9KzI82PyDaM7yh1Bm1m5WgDbG2MbHWDokAPfkaJ5Mb9RzgN+t4
 nIlKS8QActTeAg/wO/R5rZhNaM7IGDTp4qB7REgfAeeOQzQnxxSP6wV8LZUpF3/YK0
 3gklXvJCl7upA==
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Connor McAdams <conmanx360@gmail.com>, alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/ca0132: remove redundant initialization of variable
 status
Date: Fri,  9 Jul 2021 16:29:38 +0100
Message-Id: <20210709152938.460763-1-colin.king@canonical.com>
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

The variable status is being initialized with a value that is never
read, the assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index b66e7bdbf483..50ca72ee586e 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2270,7 +2270,7 @@ static int dspio_send_scp_message(struct hda_codec *codec,
 				  unsigned int *bytes_returned)
 {
 	struct ca0132_spec *spec = codec->spec;
-	int status = -1;
+	int status;
 	unsigned int scp_send_size = 0;
 	unsigned int total_size;
 	bool waiting_for_resp = false;
-- 
2.31.1

