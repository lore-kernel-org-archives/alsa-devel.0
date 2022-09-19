Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0B5C6FA82
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 23:16:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB060163D;
	Tue, 20 Sep 2022 01:15:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB060163D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663629364;
	bh=XhRuma0ZzzkFBY4uz2tHVaVmULGVWuxRBp6uHlCoG+I=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n/qYNuhiejwEOaDCyFyU94jmWnUF7Pi/F2ISu7o/KuiNBg7JH0SuwN9TsqtztzmWE
	 84pcAMuB3ARO/cz21XjGxRVoQQ+JGb2tJrnXe903lcbEMHimLQkeVAIs1Q9V9JLj74
	 etZVKxN784aRb7u8MLCrYeGMYWmtAKiv67X4Dj6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82FC8F805E2;
	Tue, 20 Sep 2022 01:10:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67036F805E2; Tue, 20 Sep 2022 01:10:48 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2663F805C2
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 01:10:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2663F805C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="egC0l2Gi"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id F3872CE1348;
 Mon, 19 Sep 2022 23:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EB3C433D6;
 Mon, 19 Sep 2022 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663629035;
 bh=XhRuma0ZzzkFBY4uz2tHVaVmULGVWuxRBp6uHlCoG+I=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=egC0l2GiHY+Gox0BXJi+HphGEA7fUwa8st2xlPZw7HHoddjE+IztGLCoDr0eSrdEZ
 ZBtgev3c/jNIXTpdB78xzoSY/ByowNBlgHBhCWS5/eMO6NhvoVWGpuJ5fRa/zzj7M6
 AQA1v499yWNB49Jac3ji6Anulgh/+N/Tla2jnlL37N/LPrYsZX+3dooVtN6xi2GKy9
 mPd1+Yddxb9/i5cSqPpB+AXzocrIBeUySqRu1taPHalvrPVlPY6ADS51SvSdkb1FrH
 Fekyua/TLBsRnBf19y8LGd5CJoxjIYQ0c/tvEwfSA8BGn+P1k7CeBAIYFEygLxNbbV
 paC238NG/kXBA==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <875yhxmjjd.wl-kuninori.morimoto.gx@renesas.com>
References: <875yhxmjjd.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: soc-core.c: setup rtd->pmdown_time at
 soc_new_pcm_runtime()
Message-Id: <166362903272.3419825.15616022024634879055.b4-ty@kernel.org>
Date: Tue, 20 Sep 2022 00:10:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, Bard Liao <yung-chuan.liao@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
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

On Fri, 9 Sep 2022 01:19:18 +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Almost all default rtd->xxx are setup at soc_new_pcm_runtime()
> which is sub-function of snd_soc_add_pcm_runtime() (A).
> But "rtd->pmdown_time" is setup at soc_init_pcm_runtime() (B).
> It is very random timing setup. This patch setup it at (A),
> same as other rtd->xxx.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core.c: setup rtd->pmdown_time at soc_new_pcm_runtime()
      commit: c403dcd8b0c4dc01974329e38dc3f82859fd6f99

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
