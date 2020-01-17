Return-Path: <SRS0=jvLf=3G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11590C3F68F
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:48:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B772072E
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SeobibOY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Iaesy9aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B772072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FA1617E3;
	Fri, 17 Jan 2020 16:48:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FA1617E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579276130;
	bh=cprpzYlFxVAVbbsaYfoEkNKW703CaWgsQZ8mmjeXLKg=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=SeobibOYrjPu2Kv8xQ4a4IKij95Gxeec/UIu3v8Q5rfauBgRpMb+lKDfOYuCG1klR
	 FgA2LytJtVBGXdJBnd9PMWNZkMJHV3kAzbinlYRNS8sYgH/jfZ620w+0BeMXK9Pm9U
	 aLHI5+FiS5DKnwhXFRcDXYiXmRIm1jtRjR332Ao8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CDD14F80274;
	Fri, 17 Jan 2020 16:45:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3DD3DF80276; Fri, 17 Jan 2020 16:44:18 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 876FBF801EB
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2020 16:44:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 876FBF801EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="Iaesy9aU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=Y4i+ypY7iyDxaYo+Tar2NamJmn/oGTJMXx3UeAwgJZc=; b=Iaesy9aUdgGp
 Wp6ZVcolAcaoew6XUe1utex33FjYUxYJslIo2Fstsw1ATCd1qxbXPf4qzUX3NR3ZdHGHnAPDlLI1s
 OK/HsS9AwOgpXGlDP1cv5YN+IhZw/EzIlOM5wj7Af29t2TGE9OTd7iWIMrh5IyV0HBB6VOjC7hvoh
 en+gs=;
Received: from fw-tnat-cam4.arm.com ([217.140.106.52]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1isTn9-0006rr-Fp; Fri, 17 Jan 2020 15:44:11 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 30793D02BD9; Fri, 17 Jan 2020 15:44:11 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
In-Reply-To: <20200114181229.42302-2-stephan@gerhold.net>
Message-Id: <applied-20200114181229.42302-2-stephan@gerhold.net>
X-Patchwork-Hint: ignore
Date: Fri, 17 Jan 2020 15:44:11 +0000 (GMT)
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht, Nikita Travkin <nikitos.tr@gmail.com>
Subject: [alsa-devel] Applied "ASoC: msm8916-wcd-analog: Add MIC BIAS
	Internal3" to the asoc tree
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

   ASoC: msm8916-wcd-analog: Add MIC BIAS Internal3

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

From 00d852326e524214f046a5e1301eee84535a6863 Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan@gerhold.net>
Date: Tue, 14 Jan 2020 19:12:29 +0100
Subject: [PATCH] ASoC: msm8916-wcd-analog: Add MIC BIAS Internal3

PM8916 has three TX inputs that each have an (optional) internal
RBIAS resistor. MIC BIAS Internal1/2 (for TX1/2) are already supported.
TX3 does not have its own MIC BIAS supply, instead it is also supplied
from MIC_BIAS1.

Now that we have simplified the MIC BIAS Internal* implementation
we can easily add support for it:

Add a MIC BIAS Internal3 supply that enables the internal RBIAS
resistor on TX3, and make sure to also enable the MIC_BIAS1 supply.

Tested-by: Nikita Travkin <nikitos.tr@gmail.com> # longcheer-l8150
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200114181229.42302-2-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index d6d727f5bae5..85bc7ae4d267 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -856,6 +856,7 @@ static const struct snd_soc_dapm_route pm8916_wcd_analog_audio_map[] = {
 	{"MIC BIAS Internal1", NULL, "MIC_BIAS1"},
 	{"MIC BIAS External2", NULL, "MIC_BIAS2"},
 	{"MIC BIAS Internal2", NULL, "MIC_BIAS2"},
+	{"MIC BIAS Internal3", NULL, "MIC_BIAS1"},
 };
 
 static const struct snd_soc_dapm_widget pm8916_wcd_analog_dapm_widgets[] = {
@@ -924,6 +925,9 @@ static const struct snd_soc_dapm_widget pm8916_wcd_analog_dapm_widgets[] = {
 			    pm8916_wcd_analog_enable_micbias_int2,
 			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
 			    SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal3", CDC_A_MICB_1_INT_RBIAS, 1, 0,
+			    pm8916_wcd_analog_enable_micbias_int,
+			    SND_SOC_DAPM_PRE_PMU),
 
 	SND_SOC_DAPM_ADC_E("ADC1", NULL, CDC_A_TX_1_EN, 7, 0,
 			   pm8916_wcd_analog_enable_adc,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
