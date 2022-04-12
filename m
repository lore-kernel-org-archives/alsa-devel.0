Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5297AC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 19:52:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89CBF188A;
	Tue, 12 Apr 2022 21:51:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89CBF188A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649793140;
	bh=aBRM9sG0Z1BLiszeFEO4ei/zQqmpiKFPvY0NHwUIN+c=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PBYmztrzjWyqDjpCPjkBs7xUczqVy7H39Ghgy/j+uChh3PaLTDibYN8Hsw6cwOjL7
	 /qn/UxoaXH2yk5v6oSREye7Ok6X5K4iNTDfT86+eafl8rlByuChlU4DEs/kmPUWUfm
	 ySLaeylhJaIX+rfRhHha34HJLvurt84OSuCPiDxg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4449AF8050F;
	Tue, 12 Apr 2022 21:50:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C23CF80511; Tue, 12 Apr 2022 21:50:42 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F36EFF80095
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 21:50:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F36EFF80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="blgB7Bvq"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3038861B96;
 Tue, 12 Apr 2022 19:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FBFC385A6;
 Tue, 12 Apr 2022 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649793030;
 bh=aBRM9sG0Z1BLiszeFEO4ei/zQqmpiKFPvY0NHwUIN+c=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=blgB7BvqvEnC87M+Fs1165CJSFVuZayx+JdjdPn20o5vOfGgfDCF3kmR3Ldr26gVm
 +YfHynIspRgj9LS/t1IsaJIX8E5JB9bgINEjfLE0HFjOgekwCt6DFBCQvJzZyDJUcg
 UAlz6508+yLZpmSAKKLowVjeH5HPCTfko5SbCwfFrItbQdl9Q1W5Pcyu9+nmS717S0
 mNygbCXNHfc02tnYQh9z2TMhLIsU1Tw+Exv6OFci/xD+gpsBmfCUtzSKncxCFcH9Jg
 sjcITaBrMrpRhRa3uBPh37w919hSHO98WA8RgngC6w6GIAjPCdB2PKcV+YZ+f1KmUD
 P/L5fKAXOpeOw==
From: Mark Brown <broonie@kernel.org>
To: cgel.zte@gmail.com, shengjiu.wang@gmail.com
In-Reply-To: <20220412083000.2532711-1-chi.minghao@zte.com.cn>
References: <20220412083000.2532711-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: fsl: using pm_runtime_resume_and_get instead of
 pm_runtime_get_sync
Message-Id: <164979302826.449327.17327555437837608042.b4-ty@kernel.org>
Date: Tue, 12 Apr 2022 20:50:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
 zealci@zte.com.cn, linux-kernel@vger.kernel.org, chi.minghao@zte.com.cn,
 lgirdwood@gmail.com, nicoleotsuka@gmail.com, linuxppc-dev@lists.ozlabs.org
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

On Tue, 12 Apr 2022 08:30:00 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: c721905c54d913db0102973dbcdfb48d91146a2d

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
