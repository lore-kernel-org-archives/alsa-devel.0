Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D918C4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Nov 2022 17:56:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3A54164E;
	Thu, 10 Nov 2022 18:55:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3A54164E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668102983;
	bh=EEoloO2utirGLLQf4HVfbZvQAidHPzJqkD9TODgJHwI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W8JO6F+4QS8FCsYUKJraCE3kTsfBBi58RKA+vgIXmRCxCasudELibS6U4odrgqdRS
	 LWZJza1iy+Ar0DDKjyPyNBV0jQQCe4Uq0voy1rH2LwthGMFryCiRnRK831A4EfY3a2
	 PcbrPLILydBpRLAQfgwbsmajKKPJUD9DPJGR2hWE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 892D5F802E8;
	Thu, 10 Nov 2022 18:55:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C45FF802E8; Thu, 10 Nov 2022 18:55:31 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3A98F80114
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2022 18:55:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3A98F80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="mGyuUfkp"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5F4CE61DCA;
 Thu, 10 Nov 2022 17:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D65DC433B5;
 Thu, 10 Nov 2022 17:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668102925;
 bh=EEoloO2utirGLLQf4HVfbZvQAidHPzJqkD9TODgJHwI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=mGyuUfkpfVTOY3Waige6Mv77F2BBRYYtTgvfsTOi9TqYaG3Obi7DA6CyKbCUn9xPJ
 Eky0sdGLlEWVsymxRhv7URqNDomAD/LLIEl0tPlTPj4PJrrZ4fNa5yqxDJxljqoZZG
 AyjS8Kgo1gQCIqLkGK5hl4DBmT1P7hjvYci2hAWWI21Z1ZwANUgw3IeuwiYBnq4POs
 Y/QmxkfbfZdFja7ax6/T/GYZpgK8OSsaz0at2IvBbpgGxhaGY2Kbc70I7w5biS1tUV
 YhIUpxkQE2TGAKVgXJ0qLoEXhLlecsqbtcEe1CENR58X45uXC4VtoER/PnAtHIcDAK
 U7Dn2D7ISDuFw==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <875yfz8fuq.wl-kuninori.morimoto.gx@renesas.com>
References: <875yfz8fuq.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/3] ASoC: simpe-card/audio-graph fixups
Message-Id: <166810292475.959181.3430536250650328696.b4-ty@kernel.org>
Date: Thu, 10 Nov 2022 17:55:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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

On Tue, 1 Nov 2022 04:21:18 +0000, Kuninori Morimoto wrote:
> These are simpe-card/audio-graph fixup patches.
> 
> Kuninori Morimoto (3):
>   ASoC: simple-card-utils: remove asoc_simple_convert_fixup()
>   ASoC: audio-graph-card2-custom-sample.dtsi: add convert-rate for DPCM (MIXer)
>   ASoC: audio-graph-card2: check also dpcm node for convert-xxx
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: simple-card-utils: remove asoc_simple_convert_fixup()
      commit: 5c065eaf445d14e70cbdb1da75e12567c7ae9b91
[2/3] ASoC: audio-graph-card2-custom-sample.dtsi: add convert-rate for DPCM (MIXer)
      commit: 2dc025aba7fbebd6c6f3a05bc3530af31776a6fa
[3/3] ASoC: audio-graph-card2: check also dpcm node for convert-xxx
      commit: 8f5979833b45b318d0971f384de3fb17924042f0

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
