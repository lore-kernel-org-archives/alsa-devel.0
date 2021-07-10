Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B064C07E9C
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:35:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB446141D
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB446141D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E7D51732;
	Sat, 10 Jul 2021 04:34:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E7D51732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625884548;
	bh=PFPsC1bwNfkre24GbZAloHDyURgIzkgS9yrhCz7qWhA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZXFmJbthzOf5OUIR+SNv1KV2QSlyERDetvCm19YbfQfwIvrz/7zMoJNAnPDTmNrit
	 waweX2rOVIITEgtiC+t3tRWxmzObIjW3w2NvCXGh2NsjanwAltyHcELAP2ULdzpm/v
	 UZiLZn0Bxiezg/mHRUtQNmhmi40sFvtDr7b2g5R4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4C18F805E2;
	Sat, 10 Jul 2021 04:24:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9158AF805E3; Sat, 10 Jul 2021 04:24:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D59DEF805DF
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:24:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D59DEF805DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="h17jTR+0"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 088C2613ED;
 Sat, 10 Jul 2021 02:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625883893;
 bh=PFPsC1bwNfkre24GbZAloHDyURgIzkgS9yrhCz7qWhA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h17jTR+0rbrLhs31i+6KgY6xnoEGFiAJr5dSjopSLnXo/UV3frhT835HIv0J/51pt
 uXbzc0d6FCbtot4XuLTlU39LMUajOp80+UDdPWGpj4rAz0j2jjDi/zP3cRV8oI2uO9
 yArw3fmhC0cz/1FtJsKK6OlBScFs7u4tSkSIwGm/lUHcIlMvv4oXd8GxnDTXgm/xCi
 NBfeXiTQua2o5YZuJAEjTlwlmETUoVWA5oYE/CMCDW6AgfYfn9S1U10iqu5cSPvp8+
 XMzpFHmff6H2l6norTzEXcmfDBfMu6PVksRJeYdMGuFIFtYOm3JQnGkzu358PWAdOC
 JzA7EDiBBON3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 18/93] ALSA: usx2y: Don't call free_pages_exact()
 with NULL address
Date: Fri,  9 Jul 2021 22:23:12 -0400
Message-Id: <20210710022428.3169839-18-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022428.3169839-1-sashal@kernel.org>
References: <20210710022428.3169839-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit cae0cf651adccee2c3f376e78f30fbd788d0829f ]

Unlike some other functions, we can't pass NULL pointer to
free_pages_exact().  Add a proper NULL check for avoiding possible
Oops.

Link: https://lore.kernel.org/r/20210517131545.27252-10-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/usx2y/usb_stream.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
index 091c071b270a..cff684942c4f 100644
--- a/sound/usb/usx2y/usb_stream.c
+++ b/sound/usb/usx2y/usb_stream.c
@@ -142,8 +142,11 @@ void usb_stream_free(struct usb_stream_kernel *sk)
 	if (!s)
 		return;
 
-	free_pages_exact(sk->write_page, s->write_size);
-	sk->write_page = NULL;
+	if (sk->write_page) {
+		free_pages_exact(sk->write_page, s->write_size);
+		sk->write_page = NULL;
+	}
+
 	free_pages_exact(s, s->read_size);
 	sk->s = NULL;
 }
-- 
2.30.2

