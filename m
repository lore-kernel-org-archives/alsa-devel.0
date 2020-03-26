Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4113FC2D0E8
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:27:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97FC20409
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oLVtiC+l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRTZ7lKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97FC20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2145E1678;
	Fri, 27 Mar 2020 00:26:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2145E1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585265262;
	bh=Nk6KRHSuSV+vV3uuL0Fbyt7lBGmFCrHu/aiRdLfbfJw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oLVtiC+lzgMeA93AzO+ZqHC2pD5LwPPT7YOcHyzyiiVhMVXAaoEuFsiO8oyZhT4NY
	 /on6e47CmLSgqIB4blGk3tMG+vfCfotKcRl0bLMy4bikenZ+ImfSXieP5ixagWGabE
	 Gp56d5Gv/y6fZ4BG+wpzH7NNRrOBVBlK2YhysFOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFA77F802A2;
	Fri, 27 Mar 2020 00:24:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D82C9F802A7; Fri, 27 Mar 2020 00:24:39 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F1F4F802A0
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 00:24:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F1F4F802A0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WRTZ7lKp"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 16DE32082D;
 Thu, 26 Mar 2020 23:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585265075;
 bh=Nk6KRHSuSV+vV3uuL0Fbyt7lBGmFCrHu/aiRdLfbfJw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WRTZ7lKpu0inxg3I9vc5AjPs6v0vMNMQZ2tadk2DggfIPnRiTLXxkAkZCRspMQvum
 MHn20/pSqbFfq+l7fVMBbsTk+hLOzku7gmaqj26kBSudNiKJ1C2EUMp2SOYzPdH525
 TdNGadjeacKMbboITareCm7yIvzGhxhBFa7zJbZU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 03/19] ALSA: hda/realtek: Fix pop noise on ALC225
Date: Thu, 26 Mar 2020 19:24:15 -0400
Message-Id: <20200326232431.7816-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232431.7816-1-sashal@kernel.org>
References: <20200326232431.7816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 3b36b13d5e69d6f51ff1c55d1b404a74646c9757 ]

Commit 317d9313925c ("ALSA: hda/realtek - Set default power save node to
0") makes the ALC225 have pop noise on S3 resume and cold boot.

So partially revert this commit for ALC225 to fix the regression.

Fixes: 317d9313925c ("ALSA: hda/realtek - Set default power save node to 0")
BugLink: https://bugs.launchpad.net/bugs/1866357
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20200311061328.17614-1-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 12858d95c2c85..73b182db7ef3b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8080,6 +8080,8 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->gen.mixer_nid = 0;
 		break;
 	case 0x10ec0225:
+		codec->power_save_node = 1;
+		/* fall through */
 	case 0x10ec0295:
 	case 0x10ec0299:
 		spec->codec_variant = ALC269_TYPE_ALC225;
-- 
2.20.1

