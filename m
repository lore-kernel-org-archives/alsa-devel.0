Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D7AC76195
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Mar 2023 18:34:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2411A7F8;
	Mon, 20 Mar 2023 19:33:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2411A7F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679337249;
	bh=h+iKiZTxlrZriKA3thm4jrdMcAtXKyFnJ24Dz8l78d0=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HSvP+GAqLGa868XuHwCStAKdG8keW2giEsDqG02riHmQcF87tehl0J5KP1cK/SghY
	 YL1XvXaT/lwhR6FTigp/qPhgtch0rDcbM6k8B88tBPxsu0HEOwasaH/XvYmpV41FEb
	 aFv8pM2ru4+cehR5P8g6iE/W79tiF9KnPZU8SCa0=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B96CF80534;
	Mon, 20 Mar 2023 19:32:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41D38F80529; Mon, 20 Mar 2023 19:32:08 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EFFADF8027B
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2023 19:31:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFFADF8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=H9/UnK1y
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 157E06179B;
	Mon, 20 Mar 2023 18:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B21C4339C;
	Mon, 20 Mar 2023 18:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679337117;
	bh=h+iKiZTxlrZriKA3thm4jrdMcAtXKyFnJ24Dz8l78d0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H9/UnK1ymJI55JadZlMZt3CaGTo7zVWc9YDKQD58whi14JvN209bNcfx2cHOwOacq
	 TkhEo5Hyeno5MlLqz8uj/IawP1UYIFRwPRJBljlrqDVWm79Qy9QK4bgVYKVY7ERfCx
	 rtSWhyUs478HsFID8DrTEEHfxNGoS9cBnL11ZLKqAhFYlhTitI9/jTSRA4VFhuqBEA
	 YNQ2vtqGNSavM/jsoi9trYKBb9s6sdxBn12ATX94eXGklnYmTbka8GGlRfnC9MCmjO
	 YymQgcG5gmDBGnws6SG9uXRjtC3B2X1R0orAKTAbuCJZt9+9U5sYjuCH+PCLjCgMkB
	 z2PWQaNcp84SQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Lucas Tanure <tanureal@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Rob Herring <robh@kernel.org>
In-Reply-To: <20230317233612.3967849-1-robh@kernel.org>
References: <20230317233612.3967849-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Drop unneeded quotes
Message-Id: <167933711212.198283.1787020882861078735.b4-ty@kernel.org>
Date: Mon, 20 Mar 2023 18:31:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
Message-ID-Hash: TTDOIB3MJIUHM4UACUHFRBEZNB35EXE6
X-Message-ID-Hash: TTDOIB3MJIUHM4UACUHFRBEZNB35EXE6
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TTDOIB3MJIUHM4UACUHFRBEZNB35EXE6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 17 Mar 2023 18:36:10 -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Drop unneeded quotes
      commit: d9e909e219a843c6bf49f9affe536660f830d6fc

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

