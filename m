Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C67FC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 21:26:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1600660F9C
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 21:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1600660F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1F45171B;
	Mon,  2 Aug 2021 23:25:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1F45171B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627939578;
	bh=2Wbr8lKOxYcEnRVsPKJDVHQFpQA4L8T0K/kB3c4SpcE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rw3JLIz/XOmnSNg521fOK0ym7+WUSWIehG0Zhy/+jhRGX4bgLlWuxrZn1np2sHK3o
	 yLYohUSEG3h9m8JbnB4xPnNu+LvWXMEC30yI//ry6FLp31wwFor5Fn8b59vpAPxVZZ
	 vYYA6vv8RsLMPWqlCHmkO7gLWDiJwcSfn3Tas9xQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A4A9F801F7;
	Mon,  2 Aug 2021 23:25:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0292F8025F; Mon,  2 Aug 2021 23:25:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCF0DF8014D
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 23:25:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCF0DF8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qJFNt/e7"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 279E560EEA;
 Mon,  2 Aug 2021 21:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627939517;
 bh=2Wbr8lKOxYcEnRVsPKJDVHQFpQA4L8T0K/kB3c4SpcE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qJFNt/e7Fj5ohb/1a8trJgNdnCgnAfyelKS/AVdOd3EvjK4cLpLdH9kKkNjxqTKEo
 5D7lJ6uX/aVbToZRma6r3aUBZVoENvU6X5uxjjFJXycdtSBdjn72+HB7tlWOB5r7qh
 EMgmYglJGJ/Fy9DRPtIoVp19QDmw8WeYmQSZlYtDhNg2SXucwSf7j24rYgYqf+AXXZ
 3wcznbXA+b5ZpPS7DUFcoJpITPPooFdLVeqHsWoP46iBCqGVfnLLOaO3CortKp7UZa
 fSTTZBKGgwS31xYy2lYM/GW60xRFkWAdwZJY0nvbIWlzgXcUPirUu3/xppwWf813Cs
 oD/QkC7CDyXFg==
From: Nathan Chancellor <nathan@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] ASoC: Intel: boards: Fix CONFIG_SND_SOC_SDW_MOCKUP select
Date: Mon,  2 Aug 2021 14:24:10 -0700
Message-Id: <20210802212409.3207648-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.264.g75ae10bc75
In-Reply-To: <20210802190351.3201677-1-nathan@kernel.org>
References: <20210802190351.3201677-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
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

When CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH is enabled without
CONFIG_EXPERT, there is a Kconfig warning about unmet dependencies:

WARNING: unmet direct dependencies detected for SND_SOC_SDW_MOCKUP
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
EXPERT [=n] && SOUNDWIRE [=y]
  Selected by [y]:
  - SND_SOC_INTEL_SOUNDWIRE_SOF_MACH [=y] && ...

Selecting a symbol does not account for dependencies. There are three
ways to resolve this:

1. Make CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH select
   CONFIG_SND_SOC_SDW_MOCKUP only if CONFIG_EXPERT is set.

2. Make CONFIG_SND_SOC_SDW_MOCKUP's prompt depend on CONFIG_EXPERT so
   that it can be selected by options that only depend on
   CONFIG_SOUNDWIRE but still appear as a prompt to the user when
   CONFIG_EXPERT is set.

3. Make CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH imply
   CONFIG_SND_SOC_SDW_MOCKUP, which will select
   CONFIG_SND_SOC_SDW_MOCKUP when its dependencies are enabled but still
   allow the user to disable it.

Go with the third option as it gives the most flexibility while
retaining the original intent of the select.

Fixes: 0ccac3bcf356 ("ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests")
Suggested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v1 -> v2:

* Switch to imply rather than select ... if ... (Pierre-Louis).

* Reword commit message to explain different solutions rather than
  explain the problem in depth.

 sound/soc/intel/boards/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 046955bf717c..61b71d6c44cf 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -602,7 +602,7 @@ config SND_SOC_INTEL_SOUNDWIRE_SOF_MACH
 	select SND_SOC_DMIC
 	select SND_SOC_INTEL_HDA_DSP_COMMON
 	select SND_SOC_INTEL_SOF_MAXIM_COMMON
-	select SND_SOC_SDW_MOCKUP
+	imply SND_SOC_SDW_MOCKUP
 	help
 	  Add support for Intel SoundWire-based platforms connected to
 	  MAX98373, RT700, RT711, RT1308 and RT715

base-commit: 170c0d7460fc4aa522995ae4096b5a442f50a1fc
-- 
2.32.0.264.g75ae10bc75

