Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8711DC3F6B0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Aug 2022 11:32:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C77F83E7;
	Thu, 25 Aug 2022 13:31:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C77F83E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661427123;
	bh=H+veo+Dao6bkJ0QMyFov+hU73WKqs+8y5v0OSddUH8Y=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j4iD2qWGAc2M3cYu2tSDBmTU7r9ebZ4khQmMpgbsnOIFX3Rup6UUSZkuukbQKn2Wu
	 VVFOJGmvT80yu55ev3xWDtvaiKtZSthU035Ycr9KlIqEsXvdLYMXdiZ/2vHL9oU559
	 V4+Bg0I48QPwQ/OI51cS85g8pjAW+6kloQeoHc1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F59FF800C8;
	Thu, 25 Aug 2022 13:31:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DD4BF80528; Wed, 24 Aug 2022 13:12:33 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C55F3F80525
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2022 13:12:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C55F3F80525
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kBHMSKXn"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4D1B4618EC;
 Wed, 24 Aug 2022 11:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95404C433B5;
 Wed, 24 Aug 2022 11:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661339544;
 bh=H+veo+Dao6bkJ0QMyFov+hU73WKqs+8y5v0OSddUH8Y=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=kBHMSKXnm0q0/ig5wiPntO3Jl5ZlIKYg+9lyllxyXo7josUAAKfnl1BGY3qq5uhyO
 Z39yjwD4/NFhx2B6Wc/+r0hxaXJ3UbARfcsvcwDHtrvsdD9i4JhAPciVl3T+CrM3hE
 /EfTraglUjPsMItvnKtQPOtWdoDhkRmhY/G/3keG1xGxXbDlJUrW1CZutdptQFqyPk
 xmLku2O2USngmtzYaRvm9/aAWs6ObNDWc20kLO8WBsH/+ochtgPB/WbGdw8JMgyDNG
 LzO0IgWc0DDMNlWKK3zbXjCzwriQw4vMTPFYeOP0n1m836BgYwak6uCgFGY1uhlIZY
 l8v5dwKXirf2Q==
From: Mark Brown <broonie@kernel.org>
To: Cheng-Yi Chiang <cychiang@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 NXP Linux Team <linux-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, 
 Rob Herring <robh@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Liam Girdwood <lgirdwood@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Andy Gross <agross@kernel.org>, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Jerome Brunet <jbrunet@baylibre.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Jonathan Bakker <xc-racer2@live.ca>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Shane Chien <shane.chien@mediatek.com>
In-Reply-To: <20220823145649.3118479-8-robh@kernel.org>
References: <20220823145649.3118479-8-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Add missing
 (unevaluated|additional)Properties on child nodes
Message-Id: <166133953831.17904.2785802329558247784.b4-ty@kernel.org>
Date: Wed, 24 Aug 2022 12:12:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Mailman-Approved-At: Thu, 25 Aug 2022 13:31:12 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
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

On Tue, 23 Aug 2022 09:56:39 -0500, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Add missing (unevaluated|additional)Properties on child nodes
      commit: 9e10a1ded6a1b7ffacbb2d9c75fe6aa91623051b

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
