Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DF4C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jun 2022 20:21:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F6E616B1;
	Mon, 27 Jun 2022 22:20:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F6E616B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656361304;
	bh=WuhLwVReyPIuFiHnuKnYYLH+rlvl1fOWMReZYjq2KMA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T89U/m12yc82FI/fhWZqUkFJ21FqMEsAdzhtMjMK4e0jBaHSMeospnuN5LBzGfM1m
	 s8BFlIePE+xg+20YEa7D+YTRCsFbxLLIuM9cFxVz5UDhlwyQAaVc0FDC4ezntn76Oq
	 0MyD84IoaHB9CpTgpb3zBiUdXcAGEf13WFKzSTFE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 49A68F80552;
	Mon, 27 Jun 2022 22:19:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A0A8F80553; Mon, 27 Jun 2022 22:19:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24C2BF804FC
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2022 22:19:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24C2BF804FC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="EzvLipb/"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 710256174E;
 Mon, 27 Jun 2022 20:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACA9C385A2;
 Mon, 27 Jun 2022 20:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656361153;
 bh=WuhLwVReyPIuFiHnuKnYYLH+rlvl1fOWMReZYjq2KMA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=EzvLipb/md2jDxG97HKhkbVnANDIcXdB9kf1WhKt5pJMqo31/DRMReHEF/yPd0NHq
 lAokPdTX87zAbGK1wokDszHYzYkOgO234P616ZZPoLk+6AfycMhWmdhNC2fauIeoNL
 HLAocQYD/+epH+VC2NbaqYnAkgE+x/rwTVCvMOIqETvkDvPf1ZYSI7p2ASxeLY7wYy
 fPVJUMtPkVpAKYmw8OlVjjSE9PoH9uBYEdH6FLTkPbM9V3AxfUrAEgxRKceaTV2V6y
 7NVCI4a+raTe9wQ0/6dgRWWghZXfAr2//NBeffs6+g9XXMmwzXS7vPiP+l0LC2F56D
 zGX3ZvEa3nNmQ==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, srinivas.kandagatla@linaro.org, perex@perex.cz,
 bgoswami@quicinc.com, lgirdwood@gmail.com, yassine.oudjana@gmail.com
In-Reply-To: <20220622061745.35399-1-y.oudjana@protonmail.com>
References: <20220622061745.35399-1-y.oudjana@protonmail.com>
Subject: Re: [PATCH] ASoC: wcd9335: Use int array instead of bitmask for TX
 mixers
Message-Id: <165636115088.3997797.3429241707337810347.b4-ty@kernel.org>
Date: Mon, 27 Jun 2022 21:19:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, y.oudjana@protonmail.com
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

On Wed, 22 Jun 2022 10:17:45 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Currently slim_tx_mixer_get reports all TX mixers as enabled when
> at least one is, due to it reading the entire tx_port_value bitmask
> without testing the specific bit corresponding to a TX port.
> Furthermore, using the same bitmask for all capture DAIs makes
> setting one mixer affect them all. To prevent this, and since
> the SLIM TX muxes effectively only connect to one of the mixers
> at a time, turn tx_port_value into an int array storing the DAI
> index each of the ports is connected to.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wcd9335: Use int array instead of bitmask for TX mixers
      commit: 4b07ef55d1d4178dbec584195be148685ea25c59

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
