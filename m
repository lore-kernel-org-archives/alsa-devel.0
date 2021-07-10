Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AFBC11F6C
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:33:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE116124C
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE116124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68BA71711;
	Sat, 10 Jul 2021 04:33:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68BA71711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625884437;
	bh=Cq5+2Ebc6c6hl+v8/BtGJsmNhPOn2K1nEcnUhiM6loc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ehC0rvtB1JteiOCigVimQwoyNgKRc/bXItipn9sYMeeQ/YrKqqG9txOyCPrnJolyt
	 PVstDMp75t313FkgaG4h+INR5iTIXE/Ht1hIDJsQWQplcBcDKGuow6sa7cUJl0ps33
	 HQ1/tmTf9yG4rSuITLLQPqOV1FjM/YUcU4+Vdg64=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6D70F805BA;
	Sat, 10 Jul 2021 04:24:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4DE5F805B1; Sat, 10 Jul 2021 04:24:19 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4DA7F805AC
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:24:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4DA7F805AC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="G0FkytNQ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B812613D6;
 Sat, 10 Jul 2021 02:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625883852;
 bh=Cq5+2Ebc6c6hl+v8/BtGJsmNhPOn2K1nEcnUhiM6loc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G0FkytNQYuk4HbGoFJoPx2iwXMGrQSHCZz9vpWqlaZTWjFH7AY7sQPEQYBOM7nlmp
 aTK8jO5h//Ao4AjcCDzZk/lp9Ucp3wI7iu+SyAqh9suwqZz+r1sU+hvNBvyOqXrEJj
 MSY5IwomtUeQ1GpgaogBDjARF2DjWBSN52DHgJ/gfYfLQeDDxr+wpYhvQ/XFFEPhvq
 uep2wflXsvLuB6Q/AxnAdLtr6vgub7DrwQsPPYywXumujl5kvZ7vXfdwnAsk8+JBxu
 81hhvNtTF6+OTqYRoFFIRK6OEQK5Zmd2XEQY5UzYbuuAsCLKfQSOYvNKcVDFRdBoFj
 wLoHEyjLfh/ZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 095/104] ALSA: usb-audio: scarlett2: Fix 6i6 Gen
 2 line out descriptions
Date: Fri,  9 Jul 2021 22:21:47 -0400
Message-Id: <20210710022156.3168825-95-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022156.3168825-1-sashal@kernel.org>
References: <20210710022156.3168825-1-sashal@kernel.org>
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

[ Upstream commit c712c6c0ff2d60478582e337185bcdd520a7dc2e ]

There are two headphone outputs, and they map to the four analogue
outputs.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Link: https://lore.kernel.org/r/205e5e5348f08ded0cc4da5446f604d4b91db5bf.1624294591.git.g@b4.vu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett_gen2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index a829c3c7a30c..558b51dc37da 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -254,10 +254,10 @@ static const struct scarlett2_device_info s6i6_gen2_info = {
 	.pad_input_count = 2,
 
 	.line_out_descrs = {
-		"Monitor L",
-		"Monitor R",
-		"Headphones L",
-		"Headphones R",
+		"Headphones 1 L",
+		"Headphones 1 R",
+		"Headphones 2 L",
+		"Headphones 2 R",
 	},
 
 	.ports = {
-- 
2.30.2

