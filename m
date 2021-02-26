Return-Path: <SRS0=9dS2=H4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82A0C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Feb 2021 18:58:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9346164F24
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Feb 2021 18:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9346164F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BA2E1686;
	Fri, 26 Feb 2021 19:57:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BA2E1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614365887;
	bh=cfsk/Abj16Y8q/ZiAM1bvVZnWKLUSBXro8r5SkdZjOk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X5PLYLOf2x1wJgxthnL8cZmWtbe/eXOIvRKU0+E6IJfbF70yFp30zVrf3MIBAqCW1
	 4zlUhe3mfqt2Ktn/it+Wu88YELT6IZ2heuBfSF3FzEP768el3UToYpZ6pnymBNa6zk
	 Apdqd+flp+HV4pMYtEJ8Py4uylhX6y3h8VHZALJY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B00AEF80161;
	Fri, 26 Feb 2021 19:57:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A42F0F8016C; Fri, 26 Feb 2021 19:57:14 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AACEEF80154
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2021 19:57:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AACEEF80154
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1lFiII-0000Mk-4s; Fri, 26 Feb 2021 18:56:54 +0000
From: Colin King <colin.king@canonical.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: boards: sof-wm8804: add check for PLL setting
Date: Fri, 26 Feb 2021 18:56:53 +0000
Message-Id: <20210226185653.1071321-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

Currently the return from snd_soc_dai_set_pll is not checking for
failure, this is the only driver in the kernel that ignores this,
so it probably should be added for sake of completeness.  Fix this
by adding an error return check.

Addresses-Coverity: ("Unchecked return value")
Fixes: f139546fb7d4 ("ASoC: Intel: boards: sof-wm8804: support for Hifiberry Digiplus boards")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/boards/sof_wm8804.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_wm8804.c b/sound/soc/intel/boards/sof_wm8804.c
index a46ba13e8eb0..6a181e45143d 100644
--- a/sound/soc/intel/boards/sof_wm8804.c
+++ b/sound/soc/intel/boards/sof_wm8804.c
@@ -124,7 +124,11 @@ static int sof_wm8804_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	snd_soc_dai_set_clkdiv(codec_dai, WM8804_MCLK_DIV, mclk_div);
-	snd_soc_dai_set_pll(codec_dai, 0, 0, sysclk, mclk_freq);
+	ret = snd_soc_dai_set_pll(codec_dai, 0, 0, sysclk, mclk_freq);
+	if (ret < 0) {
+		dev_err(rtd->card->dev, "Failed to set WM8804 PLL\n");
+		return ret;
+	}
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8804_TX_CLKSRC_PLL,
 				     sysclk, SND_SOC_CLOCK_OUT);
-- 
2.30.0

