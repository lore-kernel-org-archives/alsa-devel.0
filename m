Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3AAC35242
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:57:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF5D22314
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NDDpfVH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF5D22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 875A01661;
	Fri, 14 Feb 2020 21:56:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 875A01661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581713836;
	bh=awCUty7IM9n/mtkoVGhR3bmAi5QZ7Yug1GPqh9NUKfk=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=NDDpfVH3q3GlH1A1lfuZCUZpYNiD6nGVHv4vWV8SS9INDV++jppXOrzjTB7+MAH2j
	 +vxOgej26wXwMKDYidtmav8NNRt3DnHn1nvdS2MowWN9A0LVM7f8Nz+Zey6x4IMMLX
	 n2eXCgjHMkg/pwf+m9RsYZWfTtUInYGK8zQmsfU8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C63BEF800F0;
	Fri, 14 Feb 2020 21:56:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DA26F8014F; Fri, 14 Feb 2020 21:56:23 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 4600DF800F0
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 21:56:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4600DF800F0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6467E30E;
 Fri, 14 Feb 2020 12:56:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D73A53F68F;
 Fri, 14 Feb 2020 12:56:17 -0800 (PST)
Date: Fri, 14 Feb 2020 20:56:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20200214131350.337968-6-jbrunet@baylibre.com>
Message-Id: <applied-20200214131350.337968-6-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kbuild test robot <lkp@intel.com>, Kevin Hilman <khilman@baylibre.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org
Subject: [alsa-devel] Applied "ASoC: meson: codec-glue: fix pcm format cast
	warning" to the asoc tree
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

   ASoC: meson: codec-glue: fix pcm format cast warning

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 3cd23f021e2e5f3350125abcb39f12430df87d06 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 14 Feb 2020 14:13:50 +0100
Subject: [PATCH] ASoC: meson: codec-glue: fix pcm format cast warning

Clarify the cast of snd_pcm_format_t and fix the sparse warning:
restricted snd_pcm_format_t degrades to integer

Fixes: 9c29fd9bdf92 ("ASoC: meson: g12a: extract codec-to-codec utils")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200214131350.337968-6-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/meson-codec-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/meson-codec-glue.c b/sound/soc/meson/meson-codec-glue.c
index 97bbc967e176..524a33472337 100644
--- a/sound/soc/meson/meson-codec-glue.c
+++ b/sound/soc/meson/meson-codec-glue.c
@@ -74,7 +74,7 @@ int meson_codec_glue_input_hw_params(struct snd_pcm_substream *substream,
 	data->params.rates = snd_pcm_rate_to_rate_bit(params_rate(params));
 	data->params.rate_min = params_rate(params);
 	data->params.rate_max = params_rate(params);
-	data->params.formats = 1 << params_format(params);
+	data->params.formats = 1ULL << (__force int) params_format(params);
 	data->params.channels_min = params_channels(params);
 	data->params.channels_max = params_channels(params);
 	data->params.sig_bits = dai->driver->playback.sig_bits;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
