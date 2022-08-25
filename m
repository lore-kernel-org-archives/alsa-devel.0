Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6447EC28D13
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Aug 2022 15:30:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84BF31658;
	Thu, 25 Aug 2022 17:29:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84BF31658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661441407;
	bh=yKyrbvscUxBwrXmqG5oLczuAvPaScnAReCHkvRnGolI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LhBklfApCA1E+Q6ULv32AVVFs7hMKgry8bqWaMVX6GQSYifs6I7SA1+JRu+BUeJQ/
	 KX35PF1ADTgH6Hvhyjju23mR9acd24ZdGicdPW5JuOn5G/JxyyLdbw9R+szjbKXkHL
	 zzePt/dVCLvoXqoAmB6qZW5ofktN/bo/fE8lW3ug=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF58AF80537;
	Thu, 25 Aug 2022 17:28:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD717F80506; Thu, 25 Aug 2022 17:28:30 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48885F8014B
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2022 17:28:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48885F8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Cd1w5Anz"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B4DBD61A9C;
 Thu, 25 Aug 2022 15:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1217C43470;
 Thu, 25 Aug 2022 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661441302;
 bh=yKyrbvscUxBwrXmqG5oLczuAvPaScnAReCHkvRnGolI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Cd1w5Anzs8A92wu9QLzQRLi2mmaTdtLxtA0SiMVUgcDjfqgy/OW1BTq629FuYNPWB
 AHwLSRCL3JIsaqE1USVAwSlQVho6W1tvURq098/xRi0XRLtc5/JKmsBRsh5tU1yuwj
 WoKDmxwOf3zes0JL14l1SVdA7XzM81jc2su/zEwzH3Nk1Iq+dYBiaRvNiLml0xM0+S
 DtwvO1ags0IrXU4vyfQBUsWpqn+NhiExewo62RLqXCSgj3s5YZyEaoEC9Y4Jo4CB+T
 +1U9VabK9CaRmOmZahgTfdBTv3GuDLehcLiv32HGP+QkWWPPX3tyjFsCszcv7gPYMB
 qLhvsO63w40Hw==
From: Mark Brown <broonie@kernel.org>
To: chunxu.li@mediatek.com, nfraprado@collabora.com,
 krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
In-Reply-To: <20220824122319.23918-1-chunxu.li@mediatek.com>
References: <20220824122319.23918-1-chunxu.li@mediatek.com>
Subject: Re: [PATCH v2 0/2] ASoC: mediatek: dt-bindings: modify machine
Message-Id: <166144129763.526663.3235477335040031977.b4-ty@kernel.org>
Date: Thu, 25 Aug 2022 16:28:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, jiaxin.yu@mediatek.com, linux-kernel@vger.kernel.org,
 project_global_chrome_upstream_group@mediatek.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
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

On Wed, 24 Aug 2022 20:23:17 +0800, Chunxu Li wrote:
> From: "chunxu.li" <chunxu.li@mediatek.com>
> 
> Changes since V1:
>   - remove unnecessary quotes
> 
> Add SOF related field.
> 1. Add a property "mediatek,adsp", Only when adsp phandle could be retrieved,
>  from DTS, the SOF related part of machine driver is executed.
> 2. Add a property "mediatek,dai-link" to support dai-links could be specified
>  from DTS
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: dt-bindings: modify machine bindings for SOF
      commit: 1173107d7c129ff87224814fd38fce5db023aaa0
[2/2] ASoC: mediatek: dt-bindings: modify machine bindings for SOF
      commit: 1173107d7c129ff87224814fd38fce5db023aaa0

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
