Return-Path: <SRS0=lFLu=3S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E48C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:57:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4860F20716
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="d0jo30Ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4860F20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A220E168E;
	Wed, 29 Jan 2020 18:56:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A220E168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580320629;
	bh=/hqSU7VYDc7aYnl67jTM/L0sargkny8zKMOTN7Crmhs=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=d0jo30Haw1B0kOT0X3j1/EisL7VMARvLow1SJDr3AdHryAy/XNo8u3YhB/xSsVT0+
	 Bj7TTYDhVNlLTfWhzgGZrscI8TquLau3h8VxpmwcNypTFVGZRWuj7Rgp6ykyk1RYoo
	 UG5ooKvXGSaGYTBU1pkdvOiB7dAT7BA61ByYEG78=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E6CBF8027B;
	Wed, 29 Jan 2020 18:54:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D251FF80277; Wed, 29 Jan 2020 18:54:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 2DE3DF80273
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 18:54:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DE3DF80273
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74C111045;
 Wed, 29 Jan 2020 09:54:26 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E69153F67D;
 Wed, 29 Jan 2020 09:54:25 -0800 (PST)
Date: Wed, 29 Jan 2020 17:54:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Akshu Agrawal <akshu.agrawal@amd.com>
In-Reply-To: <20200128103029.128841-1-akshu.agrawal@amd.com>
Message-Id: <applied-20200128103029.128841-1-akshu.agrawal@amd.com>
X-Patchwork-Hint: ignore
Cc: "SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 list@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Wei Yongjun <weiyongjun1@huawei.com>, moderated@alsa-project.org,
 vishnuvardhanrao.ravulapati@amd.com, akshu.agrawal@amd.com,
 "Cc:"@alsa-project.org
Subject: [alsa-devel] Applied "ASoC: amd: Fix simultaneous playback and
	capture" to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: amd: Fix simultaneous playback and capture

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 67e69e1d46becd934a03489c38fc42bb2510c1c6 Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Tue, 28 Jan 2020 16:00:22 +0530
Subject: [PATCH] ASoC: amd: Fix simultaneous playback and capture

Stopping of one stream is killing the other stream when they
are running simultaneously. This is because, IER register is
cleared which disables I2S and overrides any other block enables.

Clearing IER register only when all streams on a channel are disabled,
fixes the issue.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Link: https://lore.kernel.org/r/20200128103029.128841-1-akshu.agrawal@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-i2s.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index bf51cadf8682..31cd4008e33f 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -234,30 +234,32 @@ static int acp3x_i2s_trigger(struct snd_pcm_substream *substream,
 			switch (rtd->i2s_instance) {
 			case I2S_BT_INSTANCE:
 				reg_val = mmACP_BTTDM_ITER;
-				ier_val = mmACP_BTTDM_IER;
 				break;
 			case I2S_SP_INSTANCE:
 			default:
 				reg_val = mmACP_I2STDM_ITER;
-				ier_val = mmACP_I2STDM_IER;
 			}
 
 		} else {
 			switch (rtd->i2s_instance) {
 			case I2S_BT_INSTANCE:
 				reg_val = mmACP_BTTDM_IRER;
-				ier_val = mmACP_BTTDM_IER;
 				break;
 			case I2S_SP_INSTANCE:
 			default:
 				reg_val = mmACP_I2STDM_IRER;
-				ier_val = mmACP_I2STDM_IER;
 			}
 		}
 		val = rv_readl(rtd->acp3x_base + reg_val);
 		val = val & ~BIT(0);
 		rv_writel(val, rtd->acp3x_base + reg_val);
-		rv_writel(0, rtd->acp3x_base + ier_val);
+
+		if (!(rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER) & BIT(0)) &&
+		     !(rv_readl(rtd->acp3x_base + mmACP_BTTDM_IRER) & BIT(0)))
+			rv_writel(0, rtd->acp3x_base + mmACP_BTTDM_IER);
+		if (!(rv_readl(rtd->acp3x_base + mmACP_I2STDM_ITER) & BIT(0)) &&
+		     !(rv_readl(rtd->acp3x_base + mmACP_I2STDM_IRER) & BIT(0)))
+			rv_writel(0, rtd->acp3x_base + mmACP_I2STDM_IER);
 		ret = 0;
 		break;
 	default:
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
