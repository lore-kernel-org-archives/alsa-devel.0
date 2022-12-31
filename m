Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68767C4332F
	for <alsa-devel@archiver.kernel.org>; Sat, 31 Dec 2022 20:07:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42FF54314;
	Sat, 31 Dec 2022 21:06:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42FF54314
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672517242;
	bh=nbEQCC/a/+NsXj6d7pAHo1OtVx4lNUjq9z845PL8KLE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=qmz7/in6L0h15CqpTCdN9F1bW27vtY+sr6Qe5r7h11Dub9WLY0+/Qqe2RSMcHr2k+
	 +lwcZeGoSXrsIogNFfhQRKAUBwOuhgE6IxcOqxt84qku1Ww8UHNzGcq6bbT7ZlZ1ld
	 DUizgrZ9t78m0lnOZSMqGKWHAdmWJXCpdjdFLuag=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B9F3F804D0;
	Sat, 31 Dec 2022 21:05:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6236CF80564; Sat, 31 Dec 2022 21:05:41 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBA54F80536;
 Sat, 31 Dec 2022 21:05:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBA54F80536
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XIYJ1Xhn
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2126260A6F;
 Sat, 31 Dec 2022 20:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EE6C433D2;
 Sat, 31 Dec 2022 20:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672517136;
 bh=nbEQCC/a/+NsXj6d7pAHo1OtVx4lNUjq9z845PL8KLE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XIYJ1XhnrhflgRMfxmD/e/9im96567mbddgFDNBYEE2ohnUE43ga2bCoUDMTnG9fP
 0CIMGcaEjapfoBItehBwFupyGx6ZlAMCLpzdOl9UnhttWdQjQ7Nt85DqGBd/F6onea
 tx4K4nYKm9sLBUdL0SV58uokT0PFxa9zLYnqpAgLATXCP3LQ+haIzqgj1DchsS3tBe
 C/+M2l9/GfRGubAtpeVM4XWTyimGrQn3Z+lTOyxc+zg7Ti1xQwwZWQdhaP8xEjc6Ku
 wdykZpnNm9c9kIAYQ7BFrkpzQZw66LCOxM+3xTLio+0vSM6vE470FfH59AbnULXjZH
 gpEobjdGQXndw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.0 4/7] ASoC: SOF: mediatek: initialize panic_info to
 zero
Date: Sat, 31 Dec 2022 15:04:59 -0500
Message-Id: <20221231200502.1748784-4-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221231200502.1748784-1-sashal@kernel.org>
References: <20221231200502.1748784-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, tiwai@suse.com, lgirdwood@gmail.com,
 daniel.baluta@nxp.com, pierre-louis.bossart@linux.intel.com,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 ranjani.sridharan@linux.intel.com, YC Hung <yc.hung@mediatek.com>,
 matthias.bgg@gmail.com, Curtis Malainey <cujomalainey@chromium.org>,
 peter.ujfalusi@linux.intel.com, linux-arm-kernel@lists.infradead.org,
 sound-open-firmware@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: YC Hung <yc.hung@mediatek.com>

[ Upstream commit 7bd220f2ba9014b78f0304178103393554b8c4fe ]

Coverity spotted that panic_info is not initialized to zero in
mtk_adsp_dump. Using uninitialized value panic_info.linenum when
calling snd_sof_get_status. Fix this coverity by initializing
panic_info struct as zero.

Signed-off-by: YC Hung <yc.hung@mediatek.com>
Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
Link: https://lore.kernel.org/r/20221213115617.25086-1-yc.hung@mediatek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/mediatek/mtk-adsp-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/mediatek/mtk-adsp-common.c b/sound/soc/sof/mediatek/mtk-adsp-common.c
index 1e0769c668a7..de8dbe27cd0d 100644
--- a/sound/soc/sof/mediatek/mtk-adsp-common.c
+++ b/sound/soc/sof/mediatek/mtk-adsp-common.c
@@ -60,7 +60,7 @@ void mtk_adsp_dump(struct snd_sof_dev *sdev, u32 flags)
 {
 	char *level = (flags & SOF_DBG_DUMP_OPTIONAL) ? KERN_DEBUG : KERN_ERR;
 	struct sof_ipc_dsp_oops_xtensa xoops;
-	struct sof_ipc_panic_info panic_info;
+	struct sof_ipc_panic_info panic_info = {};
 	u32 stack[MTK_ADSP_STACK_DUMP_SIZE];
 	u32 status;
 
-- 
2.35.1

