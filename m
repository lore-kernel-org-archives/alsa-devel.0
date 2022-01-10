Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F35C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Jan 2022 15:52:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7C5017A2;
	Mon, 10 Jan 2022 16:51:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7C5017A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641829953;
	bh=pcFkAXpvGkEyW988hbvcTj7EBSns64+wf0God1b2oqY=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W2Mygy9tb6ONIGKxSYaOlB56or5wFukyECqpATwZK5TaD3nzZ5F925SRdFGep+0nz
	 JFgQ7mvPz3GsnReRjQayWdRb9VvBVgvDcoOYEi2kQRM1uA7QNVKVBF27+wShXzcrZs
	 nTqjo+UMX5Yvt+DZeGDRMxaF3eMXnS17wO8EW6no=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B65CF80125;
	Mon, 10 Jan 2022 16:51:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14F89F8012E; Mon, 10 Jan 2022 16:51:41 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA1DFF80054
 for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2022 16:51:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA1DFF80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KVEto6x1"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A1CA961325;
 Mon, 10 Jan 2022 15:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE65CC36AE5;
 Mon, 10 Jan 2022 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641829894;
 bh=pcFkAXpvGkEyW988hbvcTj7EBSns64+wf0God1b2oqY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=KVEto6x1WwRnlXVsPTz3ehpAUmjrQFQZj1Q0u9bvEasuQ4vRt4xGik/86lAbT0mbu
 P3gOZG41xI5zCaJbJxhGGmdWDuxv6Sz6ppWN7iDyNDDRbFtXVSQHG1i0srAYuayWj5
 Dv3KW3c7jVNGPJNMVuKNz3mETqutACqlbiipKl+Xw/LQmt0EiPbYM2A1BJzWe/G5z2
 ywfxj5LzASeADzX6VND5nK00KsE0L/cLjRM+BmVnonlrdOYoUhr0xuR7+5sGsq2JSR
 ltlXt8jfZ9By3LRWTQPc0Ja1dd2746vQdOvOPT7tc3drlWH9WdE+ug62l6k3ofXmG9
 Fqmsu88OtFMzQ==
From: Mark Brown <broonie@kernel.org>
To: Robert Hancock <robert.hancock@calian.com>, alsa-devel@alsa-project.org
In-Reply-To: <20220107214711.1100162-1-robert.hancock@calian.com>
References: <20220107214711.1100162-1-robert.hancock@calian.com>
Subject: Re: (subset) [PATCH v2 0/6] ASoC: Xilinx fixes
Message-Id: <164182989247.964880.12365145408644039388.b4-ty@kernel.org>
Date: Mon, 10 Jan 2022 15:51:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: michal.simek@xilinx.com, maruthi.srinivas.bayyavarapu@xilinx.com,
 kuninori.morimoto.gx@renesas.com, tiwai@suse.com
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

On Fri, 7 Jan 2022 15:47:05 -0600, Robert Hancock wrote:
> There are drivers in mainline for the Xilinx Audio Formatter and Xilinx
> I2S IP cores. However, because of a few issues, these were only really
> usable with Xilinx's xlnx_pl_snd_card top-level driver, which is not in
> mainline (and not suitable for mainline).
> 
> The fixes in this patchset, for the simple-card layer as well as the
> Xilinx drivers, now allow these drivers to be properly used with
> simple-card without any out-of-tree support code.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/6] ASoC: xilinx: xlnx_formatter_pcm: Make buffer bytes multiple of period bytes
      commit: e958b5884725dac86d36c1e7afe5a55f31feb0b2

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
