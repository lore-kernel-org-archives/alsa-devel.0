Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7047C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Oct 2022 14:19:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3319A45C;
	Wed, 19 Oct 2022 16:18:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3319A45C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666189190;
	bh=jl9RsLdd8GkrwAEB8TZH479uD0hkS97Gr2BNBbCYung=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZEKKvKJueyxagnBSVN3kjwcfNiVtU9R08OXfo2uWcLUfwuHWmQgLzj9Q2v5Cw3tUh
	 Hh2EE7nI/RWmyUk5EPQO9X5OTJO433W04guY6eH1n2pe/L6CabXH3sn2if9w8ML5bm
	 s3pWV/t98cw4gLLn5RVMX1IARTJUICwO97gB3PnY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB40AF80542;
	Wed, 19 Oct 2022 16:18:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6ED5F80528; Wed, 19 Oct 2022 16:18:25 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2BD9F80137
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2022 16:18:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2BD9F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SW2VfUhL"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BFA41B8249E;
 Wed, 19 Oct 2022 14:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2DDC433D7;
 Wed, 19 Oct 2022 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666189100;
 bh=jl9RsLdd8GkrwAEB8TZH479uD0hkS97Gr2BNBbCYung=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=SW2VfUhL2jokJTi/lfZdK4CWMyS/Fy+9X4jPb8fueuMtaToq095tQhw0NHdQZmv3K
 obWjRvi00cRix7A7O91qWxDoyZonskVi2VVn1Ev9qyAjNPtNg9997qz6oTLa/PnPR8
 fwG5Wtq1RPXXmu1/17/mcmOU42CUb7q0PvsnnEBZlG7tBKWZlteA6K4Pd/CkjuwQKG
 mGoDe78cPCR90TwMXctBoKXzOFjwqwVjU6iFzUdwu30KWEw3Kx5s4Is0voX2mtoum0
 xfi1xnKhWis26VCgbW1UZXc5FoExkF/xBwlCVyMqMC60xADVJPgalu7PfZ63xoVZ3i
 avuBMvDIcxdbg==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bkq8tzu1.wl-kuninori.morimoto.gx@renesas.com>
References: <87bkq8tzu1.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2 00/11] ASoC: soc-dapm.c random cleanups
Message-Id: <166618909923.493922.5185619310945017595.b4-ty@kernel.org>
Date: Wed, 19 Oct 2022 15:18:19 +0100
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

On Wed, 19 Oct 2022 00:35:34 +0000, Kuninori Morimoto wrote:
> These are v2 of random cleanup for soc-dpam.c/h.
> Basically, these are just cleanup, nothing changed.
> 
> v1
> 	https://lore.kernel.org/r/8735bmqazf.wl-kuninori.morimoto.gx@renesas.com
> 
> v1 -> v2
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/11] ASoC: soc-dapm.c: replace snd_soc_dapm_wcache to snd_soc_dapm_widget
        commit: 03e13efbb2113412ae7879258a82bdae86fc72e2
[02/11] ASoC: soc-dapm.c: tidyup error handling on snd_soc_dapm_add_route()
        commit: b913e9f4b313469dac7ae3083356baee3db4454f
[03/11] ASoC: soc-dapm.c: remove no meaning variable from snd_soc_dapm_add_path()
        commit: c1329a0f3bde6a655b9e6ce54b1ce47f46fa49f2
[04/11] ASoC: soc-dapm.c: ignore parameter NULL at snd_soc_dapm_free_widget()
        commit: 1c9096f32ad23f5867e752f238fd25e4fec55ecd
[05/11] ASoC: soc-dapm.c: cleanup dapm_widget_set_power()
        commit: 0135ae74b4f16fd08c9bad3b965234961d377fa7
[06/11] ASoC: soc-dapm.c: merge dapm_power_one_widget() and dapm_widget_set_power()
        (no commit info)
[07/11] ASoC: soc-dapm.c: cleanup snd_soc_dapm_new_dai()
        (no commit info)
[08/11] ASoC: soc-dapm.c: numerical order for dapm_up_seq
        (no commit info)
[09/11] ASoC: soc-dapm.h: cleanup white space
        (no commit info)
[10/11] ASoC: soc-dapm.h: fixup comment for snd_soc_dapm_widget_for_each_path()
        (no commit info)
[11/11] ASoC: soc-dpcm.h: remove snd_soc_dpcm::hw_param
        (no commit info)

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
