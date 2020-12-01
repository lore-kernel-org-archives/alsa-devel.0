Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E69C83014
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 14:00:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70C92087C
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 14:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PUM+kJLj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xwp65o2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70C92087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2733217CB;
	Tue,  1 Dec 2020 14:59:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2733217CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606831228;
	bh=YhgQZao5VbGau9cfjrXj/A+steCHHY0BXqeRNdlaEPM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PUM+kJLjoY+/Re7Ze8Dbhsw5qHIEcFhUBFoRjmkBTzS3W5iGlIcoQ9cQT1InMxbzo
	 9NDr9LYXjCo8WOcESLc+r6tOER2eJvuCJjQp2Wws0fc58Z1YkEuWpxDNaLepdV/sbR
	 cZF7w9mtDI4Hn1fBVC+pXfLBPO8KrTE0zRkkNlrE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB4E7F80277;
	Tue,  1 Dec 2020 14:59:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD9C1F804BD; Tue,  1 Dec 2020 14:59:00 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62591F80277
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 14:58:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62591F80277
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xwp65o2z"
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EBD8320C56;
 Tue,  1 Dec 2020 13:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606831136;
 bh=YhgQZao5VbGau9cfjrXj/A+steCHHY0BXqeRNdlaEPM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=xwp65o2zPjvzSxZdvnbocqTSWXL97Ef+e5Dz9gG/KHBJ1DXTr+r8AY5lJstL7l1vy
 0F6cKC30O3n15lGHuhcR8Y/TP78RTvfqNcvgLMuyZ/pRocnFfHm9ZtdUSI5+/Qcz+c
 plxXlcEkbAXP125QXkT/vN6MWenpn9NsSklRerX4=
From: Mark Brown <broonie@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
In-Reply-To: <20201130215626.2400999-1-alexandre.belloni@bootlin.com>
References: <20201130215626.2400999-1-alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] ASoC: adau1372: add missing dependencies
Message-Id: <160683107678.35139.14007436475647314012.b4-ty@kernel.org>
Date: Tue, 01 Dec 2020 13:57:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
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

On Mon, 30 Nov 2020 22:56:26 +0100, Alexandre Belloni wrote:
> SND_SOC_ADAU1372_I2C and SND_SOC_ADAU1372_SPI prpoerly select the REGMAP
> config they need but forget to depend on the underlying bus.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: adau1372: add missing dependencies
      (no commit info)

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
