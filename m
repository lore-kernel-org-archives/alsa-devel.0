Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BE6C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:22:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0306D61506
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0306D61506
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54D6B166B;
	Tue,  9 Nov 2021 23:22:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54D6B166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636496575;
	bh=d1FIuv/dVVxW19ZgxtqFuPC8CVQXUTdfjD91zC5VN2w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=flQ6hd1WuvEocTvnzobr3bG0EjFSxNK/4gnx7M6P7oJhvuF+VkcYGMksCB75MB1tU
	 /ot8sAXtxc8xQcUEwKicSSHZ6RLKqoKbOFkSivJr6MkGrgkuVvI9tSJFZIbybm72eh
	 gnjOSrbze2lJSB5twLgfQW68oqSHdi8FB47lKShk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E761AF802E3;
	Tue,  9 Nov 2021 23:19:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0A7FF802E3; Tue,  9 Nov 2021 23:19:03 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88FDDF80425
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 23:18:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88FDDF80425
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DLBGruY4"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8FBA61211;
 Tue,  9 Nov 2021 22:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636496335;
 bh=d1FIuv/dVVxW19ZgxtqFuPC8CVQXUTdfjD91zC5VN2w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DLBGruY4GntLaDxwkqGidoZGNE6VAeL+3qfzgTdZGx19pEaXrxYJDASe8FuBR/Tkr
 mjzC3KzFUNMLzgmc0AoKQwkTV6GDk4LhC9ORl9RCPU1+aBVVt9XPCsGfZNzpnbkc1k
 SOVeEFAn0N04qfGH5RE+dmAbhuTyuv9JQHC1roJ003xbIYp7YTguicpwgj1VwdNKQa
 FcrbjJMwB6bmeWPTphc7686Tu+bXJZ/rhGltV4ERPPIvVYZURXpXFCNNrzdM2RcABB
 X80uvdsE2ksieUrqixRzl1L/AC73kKtF9jaVqCG9QuvG+GdaWWY19hxRHq07rX9Ru9
 ySuPsdQy0qQyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 77/82] ALSA: usb-audio: fix null pointer
 dereference on pointer cs_desc
Date: Tue,  9 Nov 2021 17:16:35 -0500
Message-Id: <20211109221641.1233217-77-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109221641.1233217-1-sashal@kernel.org>
References: <20211109221641.1233217-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>, tiwai@suse.com,
 Chengfeng Ye <cyeaa@connect.ust.hk>
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

From: Chengfeng Ye <cyeaa@connect.ust.hk>

[ Upstream commit b97053df0f04747c3c1e021ecbe99db675342954 ]

The pointer cs_desc return from snd_usb_find_clock_source could
be null, so there is a potential null pointer dereference issue.
Fix this by adding a null check before dereference.

Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
Link: https://lore.kernel.org/r/20211024111736.11342-1-cyeaa@connect.ust.hk
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/clock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 81d5ce07d548b..98345a695dccb 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -496,6 +496,10 @@ int snd_usb_set_sample_rate_v2v3(struct snd_usb_audio *chip,
 	union uac23_clock_source_desc *cs_desc;
 
 	cs_desc = snd_usb_find_clock_source(chip, clock, fmt->protocol);
+
+	if (!cs_desc)
+		return 0;
+
 	if (fmt->protocol == UAC_VERSION_3)
 		bmControls = le32_to_cpu(cs_desc->v3.bmControls);
 	else
-- 
2.33.0

