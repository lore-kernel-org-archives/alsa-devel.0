Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FBFC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 20:20:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2A663236
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 20:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B2A663236
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67CF016B6;
	Mon, 15 Nov 2021 21:19:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67CF016B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637007616;
	bh=K3pfS4NVMA2CpFVPUUWV/jwChtsYnKjFN0rX/alvMW4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YSWwfR7R/henN4HNQv+4FjVs5TVi29Epup6kqsfcYO2kXHQ0gfuMGY0Co3PmZlvt1
	 7iSkZlacVgLBc8ITFGBps0QQsa3t32Kdktu5WefSDHCGTEzZ6SIugPLxwMOKmlmxUu
	 EE9e35QW8rKJguvCBVN6fonIMxOiUaEbjKULQxLw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19C47F804CF;
	Mon, 15 Nov 2021 21:18:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 497B7F802A0; Mon, 15 Nov 2021 21:18:35 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5D5EF8028B
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 21:18:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5D5EF8028B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GnaAa3OM"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67C8961BFE;
 Mon, 15 Nov 2021 20:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637007508;
 bh=K3pfS4NVMA2CpFVPUUWV/jwChtsYnKjFN0rX/alvMW4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=GnaAa3OMfZjo0cdkgZJPQdMWdKnJe2oF94QBvMIgKUL2AeeNHfpj6tgH7KjefnNWS
 xa16sWmbNMynWx89TRjz0BV529TEsM/JAOYDBAP03ub/AzuBqwt5YSM2Nt5jIXIsg/
 8USGrkghwCn4f3Qqz9z5aSOaTOxz2S4wdIEqHWDYIsXL9+o8AO3xgY2VFol0RmoHj1
 NVD8XVrVN+uCfW32VTTc/STp0+ltHjeFVNMGluPHBwXIPFptNqvNHfgHlar1kJXaIJ
 WRXz4gz/O4sr1flZYelXgBj//rplzrzJ7i+Gxu+rOeQh42qXubmopWE2RP3y4/Wcou
 7bVZhgjZPANDg==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, robh+dt@kernel.org, tiwai@suse.com,
 Vincent Knecht <vincent.knecht@mailoo.org>, stephan@gerhold.net,
 lgirdwood@gmail.com
In-Reply-To: <20211031210956.812101-1-vincent.knecht@mailoo.org>
References: <20211031210956.812101-1-vincent.knecht@mailoo.org>
Subject: Re: [PATCH 0/2] Add tfa9897 rcv-gpios support
Message-Id: <163700750616.2049880.11874024359672809309.b4-ty@kernel.org>
Date: Mon, 15 Nov 2021 20:18:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
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

On Sun, 31 Oct 2021 22:09:54 +0100, Vincent Knecht wrote:
> This is the continuation of a previous series [1] where
> - patch 1/4 is removed in favor of using pin switch
>   This will be posted independently of tfa989x support,
>   since it mainly require changes to sound/soc/qcom/common.c
>   and device DTS.
> - patch 2/4 is already merged
> so here are reworked patch 3/4 (bindings fixed and example added)
> and patch 4/4 unchanged.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: nxp, tfa989x: Add rcv-gpios property for tfa9897
      commit: 77fffb83933ad9e514ea0c7fd93b28cabcdea311
[2/2] ASoC: codecs: tfa989x: Add support for tfa9897 optional rcv-gpios
      commit: 9da52c39b33e7bd9c1f56175c0466fa468d7f145

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
