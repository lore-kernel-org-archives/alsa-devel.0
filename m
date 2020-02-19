Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F72C34056
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:07:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C9A207FD
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 21:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qxWxmTuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C9A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D0A616A3;
	Wed, 19 Feb 2020 22:06:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D0A616A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582146418;
	bh=pqAoZW8WBfQToIzceECX6gnAQtg5gqWr5CxcEogw9Yc=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=qxWxmTuB29D8WFHIcMaJQNAt5M+GM3YtEugSBZtNRwPiu5JsQGGIrqoGx2O1NqQ2Y
	 tKrin5VeL8euRjRIkkqYMPouEs8Ra4RN5vXWfdt/HQXfzDPRmjWdgDepGyWF2+EqIn
	 Hb8iQLBWaP2hp2x7K1Ui0FLBW8F4pUtOhkUUTOjg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95E71F80335;
	Wed, 19 Feb 2020 21:57:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11F57F80336; Wed, 19 Feb 2020 21:57:58 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id AB01DF80323
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 21:57:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB01DF80323
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08BD6FEC;
 Wed, 19 Feb 2020 12:57:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82D633F68F;
 Wed, 19 Feb 2020 12:57:53 -0800 (PST)
Date: Wed, 19 Feb 2020 20:57:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Subject: Applied "ASoC: dapm: select sleep_state when initializing PINCTRL
 widget" to the asoc tree
In-Reply-To: <20200219170951.1.I61f6559a37a6a40a6fde0737cb16100fb17c0480@changeid>
Message-Id: <applied-20200219170951.1.I61f6559a37a6a40a6fde0737cb16100fb17c0480@changeid>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, cychiang@google.com, jiaxin.yu@mediatek.com,
 tzungbi@google.com, Mark Brown <broonie@kernel.org>, dgreid@google.com
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

The patch

   ASoC: dapm: select sleep_state when initializing PINCTRL widget

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

From ec06dc15c358d3f41e9fd05872d772ed0f9fa32a Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Wed, 19 Feb 2020 17:38:38 +0800
Subject: [PATCH] ASoC: dapm: select sleep_state when initializing PINCTRL
 widget

Selects sleep_state when initializing PINCTRL widget.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20200219170951.1.I61f6559a37a6a40a6fde0737cb16100fb17c0480@changeid
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index cc17a3730d3d..69eff234b26f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3628,6 +3628,9 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 			ret = PTR_ERR(w->pinctrl);
 			goto request_failed;
 		}
+
+		/* set to sleep_state when initializing */
+		dapm_pinctrl_event(w, NULL, SND_SOC_DAPM_POST_PMD);
 		break;
 	case snd_soc_dapm_clock_supply:
 		w->clk = devm_clk_get(dapm->dev, w->name);
-- 
2.20.1

