Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA33CC4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Apr 2022 17:25:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A63F17A2;
	Mon, 25 Apr 2022 19:24:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A63F17A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650907510;
	bh=igC0ln6z4ICo6ruvrsN2YbYFK79LIxKWX9Rvb44n6u8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OwleOe3ms0ieDeHwzXq+beU7Nf697gqvb8ajkwK3IOuR07cCZhlUKJv+VMjC8c6Sa
	 vub90/8CDml5hO+Kgp9bJIhEbWZuUFlvkvOQmYVJeHXa7UFoLYf5gQDyHnWEWnnc+v
	 uJtz7A3LfO+ykiuIKWRfDodHWqEDOzvgPebvDYpE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CEB55F8016A;
	Mon, 25 Apr 2022 19:24:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A666F8016B; Mon, 25 Apr 2022 19:24:18 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00AE4F800CB
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2022 19:24:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00AE4F800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KViDhhEV"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 073E0B8191A;
 Mon, 25 Apr 2022 17:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1491EC385A7;
 Mon, 25 Apr 2022 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650907449;
 bh=igC0ln6z4ICo6ruvrsN2YbYFK79LIxKWX9Rvb44n6u8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=KViDhhEVNj1ZMJuVPkbgL6JTA7Y1qc5POj9NALGnayCO0s7fKQL4glnXOovcs0KN0
 0Hj/GramaJewFU0IOqKsIhkXU1sMHpe9LW55Qe5R4+VxAosw2uU0lH+2FK9g7AZ3v+
 etbUTLjcbaH0rwO+lYpt9X0kmYNx1qpGyhEU1yDB2NMSd3AfMYBOQbeoEcy2PAJX+W
 Tr27uWkBvrKxGtU48QU9+11jRGcqzZa8GecRNdJBFMNVVgtjl/7RmyGlHnCs9UZsfr
 YoDsuWHkXGwiCsemLxpjIQ7vcdqLt854THYdm0xpIAJ2ErE8Z2BcbFnkRYenfcigP3
 glA8kuQIjNDjg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, cgel.zte@gmail.com
In-Reply-To: <20220414085310.2541546-1-chi.minghao@zte.com.cn>
References: <20220414085310.2541546-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: img-i2s-in: using pm_runtime_resume_and_get instead
 of pm_runtime_get_sync
Message-Id: <165090744779.583823.15729249408440513217.b4-ty@kernel.org>
Date: Mon, 25 Apr 2022 18:24:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, zealci@zte.com.cn, chi.minghao@zte.com.cn,
 linux-kernel@vger.kernel.org
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

On Thu, 14 Apr 2022 08:53:10 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: img-i2s-in: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: e5737cceeee5c085f6f4ea76ae99e67e4ca1bdd5

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
