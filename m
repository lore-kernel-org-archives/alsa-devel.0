Return-Path: <SRS0=/b47=CC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B463C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:41:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021C12067C
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j3uAtybz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaGA0heC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021C12067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DF6416A4;
	Mon, 24 Aug 2020 18:40:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DF6416A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598287268;
	bh=NQ8Uop4X/nfXaBjKjluTzejNzJ/9/EIsfBRYORrCU24=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j3uAtybzPpAVyk++fMKL0MREcqkLs3n//1SgV3UMksiUOueFWNw3INvpfILwIdRU9
	 8SkGYCzmRvrw4zWUR3AsYv7+2btVtG3x0Ydy0HthXaVHNvPyARUKSq7vSwGQn2jMao
	 x58ZsHuyYrfc83NwWXuaZ2b/tGsUjDa5hjpkY+Kg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E4ACF802C2;
	Mon, 24 Aug 2020 18:38:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC493F801F2; Mon, 24 Aug 2020 18:38:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8243F8016F
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2020 18:38:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8243F8016F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uaGA0heC"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 164B323106;
 Mon, 24 Aug 2020 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598287098;
 bh=NQ8Uop4X/nfXaBjKjluTzejNzJ/9/EIsfBRYORrCU24=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uaGA0heC3Lg1xrweO23p3DUJ+4SE4d3bAfsS3fFrzJur5fUxs0xTAMNjO6vtNmAvR
 AkvmDjw0EVra1BJwi2BJcZ5uObeW22jL75c/zTSxjFr4sNoAKZsizTz2zOPQplavYN
 ouGNeazovTNeotSS3/ptY6xwjlyHrXdonzu6vDew=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 20/38] ALSA: hda/realtek: Add model
 alc298-samsung-headphone
Date: Mon, 24 Aug 2020 12:37:32 -0400
Message-Id: <20200824163751.606577-20-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163751.606577-1-sashal@kernel.org>
References: <20200824163751.606577-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Mike Pozulp <pozulp.kernel@gmail.com>,
 alsa-devel@alsa-project.org, Sasha Levin <sashal@kernel.org>
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

From: Mike Pozulp <pozulp.kernel@gmail.com>

[ Upstream commit 23dc958689449be85e39351a8c809c3d344b155b ]

The very quiet and distorted headphone output bug that afflicted my
Samsung Notebook 9 is appearing in many other Samsung laptops. Expose
the quirk which fixed my laptop as a model so other users can try it.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207423
Signed-off-by: Mike Pozulp <pozulp.kernel@gmail.com>
Link: https://lore.kernel.org/r/20200817043219.458889-1-pozulp.kernel@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 88629906f314c..e230909af980c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7926,6 +7926,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC299_FIXUP_PREDATOR_SPK, .name = "predator-spk"},
 	{.id = ALC298_FIXUP_HUAWEI_MBX_STEREO, .name = "huawei-mbx-stereo"},
 	{.id = ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE, .name = "alc256-medion-headset"},
+	{.id = ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET, .name = "alc298-samsung-headphone"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.25.1

