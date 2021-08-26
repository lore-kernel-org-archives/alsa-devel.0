Return-Path: <SRS0=0cRQ=NR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2BAC432BE
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 14:17:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6220460F25
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 14:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6220460F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D31D816B0;
	Thu, 26 Aug 2021 16:16:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D31D816B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629987437;
	bh=19+SFriioNrfn3fwOrICbeSKe/bS5e7OWPAEUGfvvhY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t7yHHGuK6mBfNc8V2iugcDSEm0S94bs9irWcD8DF9VbC6od4FxATt8HrqZ0hGPeUR
	 b04IZyAmu9HE0usLz3RRm/O+3XxWdLj4jMzGHlIMxFOf2x7Epo4y+y87HossgB6WV+
	 neZTNxRVig/bFYDK09qG7BQEzNQ0QDaWSxQaTZos=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63E48F801D8;
	Thu, 26 Aug 2021 16:16:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AFE8DF80224; Thu, 26 Aug 2021 16:16:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55492F80054
 for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2021 16:16:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55492F80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MiooJBf9"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9776660698;
 Thu, 26 Aug 2021 14:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629987377;
 bh=19+SFriioNrfn3fwOrICbeSKe/bS5e7OWPAEUGfvvhY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MiooJBf9vLHfA09AxSvssoyn5b3Bc2xmYjYaAxykMO2iKnb2iN9ekqCwAlZxQHzEK
 uLLysvFtjaJz84LAO+B2tysgq/eWeVtlYPJQWV5FmVRl2hcavEa2U9T8t+r3DD20BY
 mGbPAbnc2UoF6ISLRcF5HDPi4g8AYCPTOyQgUjDG0vULCorsXNgbJsMoNBliliFYPg
 gkREbGYP1VB/nBgfTH3RRipsuUJ/+qM72Ar8Nu2v0LV97tN/2u/6vtTsAsDtg+GgVI
 m5VSOy9qqqn8E42UYKYiXKQ7QqozvBfuN6QmgNHqc47ozhekbZwfIXUN8CUTyNMCbN
 iKagMWY1z60Jw==
From: Mark Brown <broonie@kernel.org>
To: heiko@sntech.de,
	Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v1 0/4] Patches to update for rockchip spdif
Date: Thu, 26 Aug 2021 15:15:43 +0100
Message-Id: <162998707937.5647.10936208575135633257.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1629800162-12824-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1629800162-12824-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 24 Aug 2021 18:15:58 +0800, Sugar Zhang wrote:
> These patches fixup or update for rockchip spdif.
> 
> 
> Sugar Zhang (4):
>   ASoC: rockchip: spdif: Mark SPDIF_SMPDR as volatile
>   ASoC: rockchip: spdif: Fix some coding style
>   ASoC: rockchip: spdif: Add support for rk3568 spdif
>   ASoC: dt-bindings: rockchip: Add compatible for rk3568 spdif
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: rockchip: spdif: Mark SPDIF_SMPDR as volatile
      commit: 023a3f3a1c4f9be9cc1ae92579ba816120fb5807
[2/4] ASoC: rockchip: spdif: Fix some coding style
      commit: acc8b9d117912c2d5952868fba0d4fca49cde3c8
[3/4] ASoC: rockchip: spdif: Add support for rk3568 spdif
      commit: c5d4f09feb9f74e704d87a304f0c20001488fe10
[4/4] ASoC: dt-bindings: rockchip: Add compatible for rk3568 spdif
      commit: e79ef3c2cfe0b39878496eac87450698a2e84e3f

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
