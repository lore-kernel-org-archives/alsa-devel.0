Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2469C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 18:20:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5053A222B3
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 18:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5053A222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFD69181A;
	Fri, 15 Jan 2021 19:19:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFD69181A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610734833;
	bh=3rRDT+rU1u3GZvGDwrSbAniCXS09VSj6vZ/alOvP+cQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GnvyOX7R0/YjK4541xcNwhQlvAGse2snKRdrb9dTKZ269B07Ur98F3ysHVVye8MTW
	 px5xZQiHSutwnphhACPkogmNdd+JBVx2+KCv4Wj8CDgDvUXxbg/Wy95pgfn3yeot8Z
	 wZpyj0ZHJ4jghDnPRLrVLcOSE+PMEvEhV2D3N5D0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CA1EF8016D;
	Fri, 15 Jan 2021 19:19:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36621F80113; Fri, 15 Jan 2021 19:19:41 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F9C7F80134
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 19:19:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F9C7F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="luOgCmD3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16925222B3;
 Fri, 15 Jan 2021 18:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610734771;
 bh=3rRDT+rU1u3GZvGDwrSbAniCXS09VSj6vZ/alOvP+cQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=luOgCmD3g2dKfofk01BU11o3YgKeJEe3zxEpjOWvZE6xhZ2FNIp6iDzXBui8Ddpkr
 FTLKNceUkIIn1qaztis+xvtvdPg28RuRE4MNtn4YHszzRMJrJZroQ/ZOS5G8iqAQzk
 e0xICRheUSWsmLwKu6crP6LKCy6InUrnn37H69KQAXpor429zGr5ExC7WdTppkykhI
 X+kGcc3GOzhT1YWzszmzZVJ6vpRt+6T0IiLrKjn1jveDn1gAZ4YgfFJjrbrVGlzuqk
 yae8KH7K8lFIGxY2M46zqR1j7aI/nc8vXDrBRp+nbzcB6Qin0OOLwHEq8JzZVw7UsY
 vrIAZCrtmXJCw==
From: Mark Brown <broonie@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20210115034327.617223-1-swboyd@chromium.org>
References: <20210115034327.617223-1-swboyd@chromium.org>
Subject: Re: [PATCH 0/4] ASoC: qcom: Minor code cleanups for lpass-cpu
Message-Id: <161073473698.12268.9934599691128446500.b4-ty@kernel.org>
Date: Fri, 15 Jan 2021 18:18:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao <srivasam@codeaurora.org>,
 V Sujith Kumar Reddy <vsujithk@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

On Thu, 14 Jan 2021 19:43:23 -0800, Stephen Boyd wrote:
> Here's some minor code cleanups for the lpass-cpu driver. I noticed that
> it casts away const from the driver data from DT. That's not great but
> fixing it is a little more involved. I'll get to it later. There's also
> some questionable clk_get() usage that should probably be
> clk_get_optional(). For now this should help a little.
> 
> Cc: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Cc: Srinivasa Rao <srivasam@codeaurora.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Cheng-Yi Chiang <cychiang@chromium.org>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: qcom: Remove useless debug print
      commit: 16117beb16f01a470d40339960ffae1e287c03be
[2/4] ASoC: qcom: Add some names to regmap configs
      commit: 03b49bf9a92b18bbfcc3b5eb206cca8447e9f2cb
[3/4] ASoC: qcom: Stop casting away __iomem for error pointers
      commit: e697df66876c182927899950971c3b4888df3e6e
[4/4] ASoC: qcom: Remove duplicate error messages on ioremap
      commit: 4e15f5060d34dd28591cf3af43d3086a4b76c965

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
