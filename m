Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E73CC07E99
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:57:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803FF611CD
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803FF611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18BA517CF;
	Sat, 10 Jul 2021 04:56:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18BA517CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625885854;
	bh=JbCjgc8ev0nZxAc//eKoDLMYRNLvBgKM6lXAiMftk6k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vEvYW5luBJWi2fkt+7SLzISM5sqBRaijgcmT7DE3up4UmknOB6hhEZ51QREbE49oZ
	 HU3DzlqhNahP73g4+7ryL17Mn7LKxVbwj7pNw18zsv7YeYXQaap2vuoESC/Wv7/8B8
	 e3xJKCUgZgotrpbOo4+bRiFI/3rLia51hFYNt7/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42B94F80605;
	Sat, 10 Jul 2021 04:26:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96A83F804EC; Sat, 10 Jul 2021 04:26:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0347FF804E5
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:26:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0347FF804E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dZOCvpqA"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 171DA613CC;
 Sat, 10 Jul 2021 02:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625884000;
 bh=JbCjgc8ev0nZxAc//eKoDLMYRNLvBgKM6lXAiMftk6k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dZOCvpqAuSDe2S2bqt0gP3rTypJoqvFc/y2NWY903Zf9Zwa9K9OXCEyM9Kl/QdY7U
 VOybHB3jCWHEIMvID/dgW+IHv+8VLAYcDePt1f6t53YKNyPimBu4iQYuQgHiejIg+W
 v/1YjKRGIqr2zvP7XtF9c7lgtV81w55PSS7a1R7v1YV++VdpZJRLhvY5qjc6p9OJdI
 cmUeQeK91auL0S+l6vsmB6qyLUqPc1ImIXYsynsFUyhdvSbeXrGO0yolQSbe6OAzgv
 IuZqOMpbUkSv+MlUFYmLr0iO7SgQLtUOwobAUqY91rg5Ngc5V8LGMK7rodxxNRXN+I
 8el5OGIQbC0yA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 75/93] ALSA: usb-audio: scarlett2: Fix 18i8 Gen 2
 PCM Input count
Date: Fri,  9 Jul 2021 22:24:09 -0400
Message-Id: <20210710022428.3169839-75-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022428.3169839-1-sashal@kernel.org>
References: <20210710022428.3169839-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, "Geoffrey D. Bennett" <g@b4.vu>
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

From: "Geoffrey D. Bennett" <g@b4.vu>

[ Upstream commit c5210f213456383482b4a77c5310282a89a106b5 ]

The 18i8 Gen 2 has 8 PCM Inputs, not 20. Fix the ports entry in
s18i8_gen2_info.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Link: https://lore.kernel.org/r/20210620164625.GA9165@m.b4.vu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett_gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 9a98b0c048e3..e605ec5a91ba 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -356,7 +356,7 @@ static const struct scarlett2_device_info s18i8_gen2_info = {
 		},
 		[SCARLETT2_PORT_TYPE_PCM] = {
 			.id = 0x600,
-			.num = { 20, 18, 18, 14, 10 },
+			.num = { 8, 18, 18, 14, 10 },
 			.src_descr = "PCM %d",
 			.src_num_offset = 1,
 			.dst_descr = "PCM %02d Capture"
-- 
2.30.2

