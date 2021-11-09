Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8757AC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:27:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086976109F
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 086976109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67EB9168D;
	Tue,  9 Nov 2021 23:26:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67EB9168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636496840;
	bh=FBGqdI/gpRB/up5rvyajZVtnMsCexH6EFgCaJlPrnSo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eBnwz2IXtFm7GvHJoSVRf7GvXIUoEFwkpPKHE32QA7H8kn084xL8FklC09U6HRYhK
	 kVMKdctRKjiRzpVytEzPg1wq6X1/FTniz9iFuB8V6BrbjAwEK+HLMATN7HO6YBKvA4
	 ahVqapdNhFrZR97PEw5RRdxO0hR38qswbPGgf53U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7214F8051F;
	Tue,  9 Nov 2021 23:21:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1BDA4F80525; Tue,  9 Nov 2021 23:21:09 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76603F80515
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 23:20:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76603F80515
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="f+bdpwoj"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9150261A83;
 Tue,  9 Nov 2021 22:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636496456;
 bh=FBGqdI/gpRB/up5rvyajZVtnMsCexH6EFgCaJlPrnSo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f+bdpwojp2yVQD7siA7AI0O+IDVg+JIgPD/nIv3CTguTHoCcg1CdekHc+cnlXsB2i
 JK5B9WQkO700nZuI99bb1R2oBRXM8H0zP5n78GFzLo4Q3O6idRGfngNtOOIxhfyUme
 sjkqGbKRwSrlamBKrUixCh7+/bxd1FFTFqylfukvexGtOk+mZgZ1B7A77erJ4UmMUm
 s1XScrn2AZ6FB4oYGjy2HoU0hYxk/KTlbrbudHl0wdFstzNa2DSBICvx6Z57ztClzp
 7msuFXN+035PFKpU1TpsMTce9NkeI4dE24hcWmcKhaAOKeYC35cjk9vSnqkMTPF0ia
 O88569gmiv9cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 71/75] ALSA: usb-audio: fix null pointer
 dereference on pointer cs_desc
Date: Tue,  9 Nov 2021 17:19:01 -0500
Message-Id: <20211109221905.1234094-71-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109221905.1234094-1-sashal@kernel.org>
References: <20211109221905.1234094-1-sashal@kernel.org>
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
index 14456f61539e1..6c3f3312113f6 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -499,6 +499,10 @@ int snd_usb_set_sample_rate_v2v3(struct snd_usb_audio *chip,
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

