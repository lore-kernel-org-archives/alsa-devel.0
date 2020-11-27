Return-Path: <SRS0=aYR+=FB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1EAC3E8C5
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 16:21:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D2D21D7A
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 16:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I3dFv62Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="maormRB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D2D21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B6D21849;
	Fri, 27 Nov 2020 17:20:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B6D21849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606494097;
	bh=zddLxlCzjvQCUIKJPRApQIgwKgr/yV43vpmOZuV1TM8=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I3dFv62Z+tkWvEIbrLoBWGiKUcfkBHJu89TRPc9afk12s+kOypfuqck+tCL9GbPjo
	 bjfgy2S9GAfe4wa4O0h2lcygsTpiw3yMuk2/r9ee3bN11PPMs6EsR4J4R/yV3J8sLx
	 kbzX1Bx0ZAZ2lXWQx+ACDoN1XTVrrJcs7BJbINSI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DA57DF8015F;
	Fri, 27 Nov 2020 17:20:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A348F8019D; Fri, 27 Nov 2020 17:20:44 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C45C1F8015A
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2020 17:20:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C45C1F8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="maormRB/"
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9E2C221534;
 Fri, 27 Nov 2020 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606494037;
 bh=zddLxlCzjvQCUIKJPRApQIgwKgr/yV43vpmOZuV1TM8=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=maormRB/zuu98AI/ktz2A2ccUFQq7PSAMdadNz+5tYYOcWbyJT++1WbTnFmN+V9iU
 VLeDGgE2VspenC0bPNpvnp9ZPmazSKJ/WN3428Dvs0af/OAriFSlEejhQtXB2sGQMs
 3oayn/WXqLNqtQFO/0s1zOImbpeyh/MPj637m2cg=
Date: Fri, 27 Nov 2020 16:20:12 +0000
From: Mark Brown <broonie@kernel.org>
To: xuyuqing <xuyuqing@huaqin.corp-partner.google.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20201118005858.123013-1-xuyuqing@huaqin.corp-partner.google.com>
References: <20201118005858.123013-1-xuyuqing@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v1 0/1] Fix 32 bit format for adau7002
Message-Id: <160649401225.51911.879572172271559224.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Banajit Goswami <bgoswami@codeaurora.org>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, dianders@chromium.org,
 Stephan Gerhold <stephan@gerhold.net>, Taniya Das <tdas@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, tzungbi@chromium.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Andy Gross <agross@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org,
 zhouguohui@huaqin.corp-partner.google.com, judyhsiao@chromium.org,
 linux-arm-kernel@lists.infradead.org, cychiang@chromium.org
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

On Wed, 18 Nov 2020 08:58:57 +0800, xuyuqing wrote:
> the microphone is attached to external codec(adau7002)
> instead of rt5682.We need to always use 32 bit format on sc7180
> to meet the clock requirement of adau7002:
> The ADAU7002 requires a BCLK rate
> that is a minimum of 64× the LRCLK sample rate
> 
> xuyuqing (1):
>   ASoC: qcom: sc7180: fix 32 bit format for adau7002
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: sc7180: fix 32 bit format for adau7002
      commit: 7f2c63d6ae0754e5389c5942cb3bd670ea6cff40

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
