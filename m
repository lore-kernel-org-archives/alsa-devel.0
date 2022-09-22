Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE70C54EE9
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Sep 2022 15:39:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76A261EC;
	Thu, 22 Sep 2022 17:38:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76A261EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663861141;
	bh=ufTHqER2911AjYAjMI2Z0KIjReSirktao0U7lSgkAFg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vEpELTCrqR9POs1vopwrLLSKX/FEClH0QxVnJ17IcNIqhiHQfIrw/PDzzNBh0HE/P
	 gz+1f13knqI/HELtBH4nbRvRml1LAypK/yqU2GCxYgT6u5uSs4sktPxSMooi/gBBsW
	 8vNwnuMa9hQJupIElDvYHx6gkreVBKOhAsSN7VDk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B6C3F80256;
	Thu, 22 Sep 2022 17:38:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA7ABF8027B; Thu, 22 Sep 2022 17:38:09 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78C25F8012A
 for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2022 17:38:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78C25F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KO4xsI2K"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 7B25FB821A3;
 Thu, 22 Sep 2022 15:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8550AC433C1;
 Thu, 22 Sep 2022 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663861085;
 bh=ufTHqER2911AjYAjMI2Z0KIjReSirktao0U7lSgkAFg=;
 h=From:To:Cc:Subject:Date:From;
 b=KO4xsI2KK5bFenWW+4r39VBMr1Bx5tD3DORVZPNTiKCRfMRI6M9jYitKlvFUepFsl
 M6IvNWersrjSY07tAN5fgeUTzoLy2WAikvtTL1PZFNrV25tIXMzreVk+MMZOL6XbfK
 4NZSp0VmJhZqfaENWZA4arD/aqSpcNeUUAZH/rhp1MvQXytQz8+dad0jXhUd8OQMbM
 5yWnSlPQOGI3oazB+75J3ujWyFgmBIUsJ7GBlwuTI9k4vcy6QIHTPJLURqjAWHcb7C
 +6Y6jWLDRq2mPwsKTunYf+W2AWzu8KmMZW4M/2b1PPUtcyi6NXkcC2nEnGcU5dRWBq
 fB7++30FBkxAA==
From: Nathan Chancellor <nathan@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH -next] ASoC: Intel: sof_da7219_mx98360a: Access num_codecs
 through dai_link
Date: Thu, 22 Sep 2022 08:37:52 -0700
Message-Id: <20220922153752.336193-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Nathan Chancellor <nathan@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patches@lists.linux.dev
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

After commit 3989ade2d1e7 ("ASoC: soc.h: remove num_cpus/codecs"), the
following build error occurs:

  sound/soc/intel/boards/sof_da7219_max98373.c:198:27: error: no member named 'num_codecs' in 'struct snd_soc_pcm_runtime'
          for (j = 0; j < runtime->num_codecs; j++) {
                          ~~~~~~~  ^
  1 error generated.

This conversion was missed by the aforementioned change. Do it now to
fix the build error.

Fixes: 3989ade2d1e7 ("ASoC: soc.h: remove num_cpus/codecs")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/soc/intel/boards/sof_da7219_max98373.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_da7219_max98373.c b/sound/soc/intel/boards/sof_da7219_max98373.c
index 34cf849a8344..e048e789e633 100644
--- a/sound/soc/intel/boards/sof_da7219_max98373.c
+++ b/sound/soc/intel/boards/sof_da7219_max98373.c
@@ -195,7 +195,7 @@ static int ssp1_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *runtime = asoc_substream_to_rtd(substream);
 	int ret, j;
 
-	for (j = 0; j < runtime->num_codecs; j++) {
+	for (j = 0; j < runtime->dai_link->num_codecs; j++) {
 		struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(runtime, j);
 
 		if (!strcmp(codec_dai->component->name, MAXIM_DEV0_NAME)) {

base-commit: a921986f445ad611b441c8ee7749dc6dfc770481
-- 
2.37.3

