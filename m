Return-Path: <SRS0=04K1=DQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCBEC43467
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:02:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26BA222BA
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nQqq4pdT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYnaStWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26BA222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A2FA86E;
	Fri,  9 Oct 2020 17:01:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A2FA86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602255752;
	bh=T11muwXB2QxG8iDVQds+7//swDIvA2rVCBdLpoxNIn8=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nQqq4pdTU7ARQQ3BHh891QSfO23hAQ5T02XLzwMejaGBZqsD68EdG9ESkM6FPpxQY
	 Z7DCS/z+n17+3SoiuFH4wll1K+fN7n2A37MYs/QmcPcKRNqkv8sNHz8HCboFIFo7+1
	 qD0aI6KOVe+zWN76SWp5wcEjJC/b4PYbp/EJo3Sg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9786F800BF;
	Fri,  9 Oct 2020 17:01:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82E73F8016A; Fri,  9 Oct 2020 17:01:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 324E4F800BF
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2020 17:01:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 324E4F800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AYnaStWd"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DA811222C4;
 Fri,  9 Oct 2020 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602255695;
 bh=T11muwXB2QxG8iDVQds+7//swDIvA2rVCBdLpoxNIn8=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=AYnaStWdxLfHwpszLEefwQ1igCqXzU60ES9X3xiPYt41ah2ptiup16z0/yhnIWyDP
 OkwegOqis5CrD13Pm7E2+lw/77eeZQOYEAwby7tj7qEhtyqBezs/OdtnyNAiVyJt/l
 1fwndb7GUASqjx5wHXwYFv+XTcYfchR07aEgPIhw=
Date: Fri, 09 Oct 2020 16:01:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org
In-Reply-To: <20201009123527.2770629-1-codrin.ciubotariu@microchip.com>
References: <20201009123527.2770629-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] ASoC: mchp-spdiftx: remove 'TX' from playback stream name
Message-Id: <160225569297.8995.15961322461162264832.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: ludovic.desroches@microchip.com, lgirdwood@gmail.com,
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com
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

On Fri, 9 Oct 2020 15:35:27 +0300, Codrin Ciubotariu wrote:
> Do not include the 'TX' in the stream name since it's obvious for
> playback.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mchp-spdiftx: remove 'TX' from playback stream name
      commit: b899e4fd7a331065d01ca14809c9e55f113f7d05

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
