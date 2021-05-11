Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1387FC43460
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:35:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B25F61396
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B25F61396
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6D6F179F;
	Tue, 11 May 2021 10:34:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6D6F179F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620722145;
	bh=4cFqGgBdAbBe0GybCv/aBA0bJnpRTZe4yHbphP7wiXE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z1PEO3wVSDhLcvCWjmFrGEVl4TgX2eQOQ8oTESNwwGP/V0zZsGPPmW6Y5IHbf0Wim
	 Qx4CJ7wWhzfZYAzwFeO3iE9RWXW5lKkAqPCwIk5Lv7eizffYoZil2uL6UBCbCDJzzC
	 H+gpa3qLMgx8oVImgtRT7Z4XjYdYmOjuShjw7aug=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1258F80536;
	Tue, 11 May 2021 10:28:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C7EEF804DF; Tue, 11 May 2021 10:28:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8BC36F804D8
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 10:28:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BC36F804D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jynQ+wBd"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D68361943;
 Tue, 11 May 2021 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620721700;
 bh=4cFqGgBdAbBe0GybCv/aBA0bJnpRTZe4yHbphP7wiXE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jynQ+wBdyHTV4wColpT3K+33k7SQI3CioTON0DCXJwQJEViOyc3uRkuJJJDqAWREz
 fg4ZP7cLfys3Ae0ECK6wNl1odn36jCmHpiMw6HXFfreWLli2uzQgJgR7y1KIjgzAD6
 +BEIFhfv3rSAAV2d3vW05YqHK406NVllKk1lY7qh+il6+07D+dcnRdsjLno5mmMQ0x
 O58cDdY303fXyULGaX+b3IZn5GMYtmJ+2vkkbSQPbu0QvkFY8J3P+m4gIgnpDEA+Io
 Ys76PY5EDXTJ2nwRImeke+iug2nQcDtJeYhRchHqOTuv+qPmlTw0XRxeELQFkGhYw2
 ceWbH3NKRodZg==
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Jernej Skrabec <jernej.skrabec@siol.net>, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <mripard@kernel.org>
Subject: Re: (subset) [PATCH v3 0/7] PinePhone BT audio bringup
Date: Tue, 11 May 2021 09:26:02 +0100
Message-Id: <162072058168.33157.16217732000222184745.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430035859.3487-1-samuel@sholland.org>
References: <20210430035859.3487-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

On Thu, 29 Apr 2021 22:58:52 -0500, Samuel Holland wrote:
> This series uses the additional DAIs added to the sun8i-codec driver to
> add hardware routing for BT SCO (headset) audio on the PinePhone.
> 
> The BT audio connection is represented by the "dummy" bt-sco codec. The
> connection to the Quectel EG-25G modem via AIF2 works as well, but I do
> not include it here because there is no appropriate codec driver in
> tree. We have been using an out-of-tree "dummy" codec driver for the
> modem similar to bt-sco, and I'm not sure if such a driver would be
> desired upstream.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: dt-bindings: sun8i-codec: Increase #sound-dai-cells
      commit: 880e007f15a31f446b9e1713720c6ae5a539f3f4

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
