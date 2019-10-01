Return-Path: <SRS0=w4sP=X2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50694C352AA
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:10:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBBB20B7C
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VzYJ+qRj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="r4srQ7W1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBBB20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 164A51672;
	Tue,  1 Oct 2019 20:09:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 164A51672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569953438;
	bh=5rqHFSE0p4JOX7DW/jiJFqaIwb3GsBb+OG5aD8iN0AQ=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=VzYJ+qRjCHn/Xr6E4VhtnII+b9F4xX8RAS0MgAhi6p1GBkSJJU31nnPWyHbVwtDQ7
	 Xg+gM1oNa8dICC2SF2cNSc2tNxLHmMGQaJCoHWI4n5MB9uHCNdechvAy7ExOI/Dxm+
	 HKUcV0V6HxbQoNKgXvUjQ8vf2jvHy3lPGLXjr/Ng=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35811F8077D;
	Tue,  1 Oct 2019 19:57:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D216DF8065B; Tue,  1 Oct 2019 19:57:08 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD73CF8065E
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2019 19:56:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD73CF8065E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="r4srQ7W1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=3lTBC70xBUm0DlRY8qXemHwdtDbpBmIkgi7M14d54Wc=; b=r4srQ7W1eFA2
 nwFb/RNaOkJgBg1Qu8BsLrM0mL4bPmiuwhhmhrHfT6ZLqOTf2foqAzwORe7AzCvIPnrkl2mIF6CGI
 8/Msq85CM0E7+0upMo0z+++b+Iefy266hZiVczFFCMCkbrs33nJscrJWqiJ9IBp2qAlnL1t/Qi2wL
 8ADds=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iFMOI-0005u0-Hv; Tue, 01 Oct 2019 17:56:50 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 058BD27429C0; Tue,  1 Oct 2019 18:56:49 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Li Xu <li.xu@cirrus.com>
In-Reply-To: <20191001130911.19238-1-ckeepax@opensource.cirrus.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001175650.058BD27429C0@ypsilon.sirena.org.uk>
Date: Tue,  1 Oct 2019 18:56:49 +0100 (BST)
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 patches@opensource.cirrus.com, lgirdwood@gmail.com,
 Mark Brown <broonie@kernel.org>, li.xu@cirrus.com
Subject: [alsa-devel] Applied "ASoC: wm_adsp: Fix theoretical NULL pointer
	for alg_region" to the asoc tree
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

   ASoC: wm_adsp: Fix theoretical NULL pointer for alg_region

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 9daf4fd0302b2559223cf90dae7dc510c6679047 Mon Sep 17 00:00:00 2001
From: Li Xu <li.xu@cirrus.com>
Date: Tue, 1 Oct 2019 14:09:11 +0100
Subject: [PATCH] ASoC: wm_adsp: Fix theoretical NULL pointer for alg_region

Fix potential NULL pointer dereference for alg_region in
wm_adsp_buffer_parse_legacy. In practice this can never happen as
loading the firmware should have failed at the wm_adsp2_setup_algs
stage, however probably better for the code to be robust against
future changes and this is more helpful for static analysis.

Signed-off-by: Li Xu <li.xu@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20191001130911.19238-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ae28d9907c30..85396d920e0a 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3697,11 +3697,16 @@ static int wm_adsp_buffer_parse_legacy(struct wm_adsp *dsp)
 	u32 xmalg, addr, magic;
 	int i, ret;
 
+	alg_region = wm_adsp_find_alg_region(dsp, WMFW_ADSP2_XM, dsp->fw_id);
+	if (!alg_region) {
+		adsp_err(dsp, "No algorithm region found\n");
+		return -EINVAL;
+	}
+
 	buf = wm_adsp_buffer_alloc(dsp);
 	if (!buf)
 		return -ENOMEM;
 
-	alg_region = wm_adsp_find_alg_region(dsp, WMFW_ADSP2_XM, dsp->fw_id);
 	xmalg = dsp->ops->sys_config_size / sizeof(__be32);
 
 	addr = alg_region->base + xmalg + ALG_XM_FIELD(magic);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
