Return-Path: <SRS0=UTIM=IR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAD0C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 16:38:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E77A6148E
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 16:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E77A6148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88523167B;
	Fri, 19 Mar 2021 17:37:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88523167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616171897;
	bh=JLGIeO+SU/aoxkCiO7w4upoM0h99vTvP5Hp9y3LEn+4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UiiXWaCCKYWWj/NShTRob+KcQ6N2XgZ8ZmITgwmPd9BDERmXHxu35ZiTDghxB+uL6
	 D7Hv/KwdU+nRduIGkuhH3cSYoquDWVsQ0UCwp3XI6HgagotdizuAirZd2oNPT7IC10
	 ySfgPF+yGkgGzkaGfyt1e2RA+uipsOLGuvEwukg4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5E13F8021C;
	Fri, 19 Mar 2021 17:37:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B52AF8021C; Fri, 19 Mar 2021 17:37:20 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75175F80124
 for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2021 17:37:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75175F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SpIQgVG8"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9250A61981;
 Fri, 19 Mar 2021 16:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616171832;
 bh=JLGIeO+SU/aoxkCiO7w4upoM0h99vTvP5Hp9y3LEn+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SpIQgVG8PNRgzJWuXuTDMs1eE9tipH0v4SXgNc7ronYHL5njq/Gl73AmiGPLr2R90
 3Y2mE9OICn1M4UeUJZLe/750svgvY5/pTM15tEz58X/kPsz2MpBGPtNDpHTWLRHzbi
 cEWcsTLv9m0BxKFPRt7hBqWamJQ5cRxppHTbAwNGp/LtYoYd6MmJ1Ji80S2A24E44r
 swr5vYKrm4HoIjg6AQ5JA9KbQ7KPnexadVtXIKRgm4XgMnMmYkfHsKLbYEFXy8bIbD
 ctE6au2hBMXCf+pPkKu9KsSJjESHv4PHEEqk3VH6PJ8AwdUzGYU9AG04k+oVJ3zSic
 LI6vNfYumiXkg==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 00/14] ASoC: tidyup error message timing
Date: Fri, 19 Mar 2021 16:37:04 +0000
Message-Id: <161617160659.9613.12605092485402535952.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87sg4xutcl.wl-kuninori.morimoto.gx@renesas.com>
References: <87sg4xutcl.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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

On 15 Mar 2021 09:57:14 +0900, Kuninori Morimoto wrote:
> Indicating error message when failed case is very useful for debuging.
> In many case, it uses below style.
> 
> 	int function(...)
> 	{
> 		...
> 		return ret;
> 	}
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/14] ASoC: soc-pcm: indicate error message at soc_pcm_open()
        commit: e4b044f4582366de10b8b28614c24ac4ff22b299
[02/14] ASoC: soc-pcm: indicate error message at soc_pcm_hw_params()
        commit: cb11f79b4af65005584880eb408f9748c32661d0
[03/14] ASoC: soc-pcm: indicate error message at soc_pcm_prepare()
        commit: dab7eeb4045cce074e083be1f3092d7390d6cfb2
[04/14] ASoC: soc-pcm: indicate error message at dpcm_path_get()
        commit: d479f00b795ac62b24ef90f4ec421e65c3178ca7
[05/14] ASoC: soc-pcm: indicate error message at dpcm_be_dai_trigger()
        commit: db3aa39c91068424407f71d23b028493eac994a1
[06/14] ASoC: soc-pcm: indicate error message at dpcm_apply_symmetry()
        commit: bbd2bac8d6ca00ee0b032d3c03100328131425ac
[07/14] ASoC: soc-pcm: indicate error message at dpcm_run_update_startup/shutdown()
        commit: 81c82a9edbddc4cd97e4d974dfd7f2689ee63474
[08/14] ASoC: soc-pcm: indicate error message at dpcm_fe/be_dai_startup()
        commit: 06aaeb874256a10fe5b84f511da3c65f548a43b9
[09/14] ASoC: soc-pcm: indicate error message at dpcm_fe/be_dai_hw_params()
        commit: 33b6b94f55ec60517ce71ca2bc9c03a6d337c805
[10/14] ASoC: soc-pcm: indicate error message at dpcm_fe/be_dai_prepare()
        commit: 273db971cf833d62c9e2d9381d190e14b1cd3641
[11/14] ASoC: soc-pcm: don't indicate error message for soc_pcm_hw_free()
        commit: e20c9c4f96d79aa48eb3649c57f1f2784f92b838
[12/14] ASoC: soc-pcm: don't indicate error message for dpcm_be_dai_hw_free()
        commit: f52366e6831ecb2da133b6ecfc7c69266086660c
[13/14] ASoC: don't indicate error message for snd_soc_[pcm_]dai_xxx()
        commit: 62462e018220895267450155b188f5804f54c202
[14/14] ASoC: don't indicate error message for snd_soc_[pcm_]component_xxx()
        commit: 60adbd8fbf486214f4ae1946e61df69c3867e20b

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
