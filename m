Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE24C25B77
	for <alsa-devel@archiver.kernel.org>; Mon, 20 May 2024 19:27:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB121829;
	Mon, 20 May 2024 21:27:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB121829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1716233274;
	bh=lIC7HB0swIWVdimTjG+bzLOFs5vA+ZcNp4GFhv6O2ss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Z55bEsDBUedybyBGXLiUDD9G3xxZ8fy4Vb9tocizJ5u7kcm1oOQZnQZP2/nvN9rUT
	 lzSN+fWNN1hmoIEDrlmGoPAzweVih2VlraaoMe1r6FOFeXXmHfRDcIhcmuJClBe9Fs
	 RRrbzvz3rmMffJMeEbaHbjboA1+b0SGZJ1YE7yzI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E10D4F805AF; Mon, 20 May 2024 21:27:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 38515F805AD;
	Mon, 20 May 2024 21:27:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A274F8028B; Mon, 20 May 2024 21:27:17 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 814F8F801F5
	for <alsa-devel@alsa-project.org>; Mon, 20 May 2024 21:27:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 814F8F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uKFXoRYU
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4FF2ACE09FA;
	Mon, 20 May 2024 19:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A018AC2BD10;
	Mon, 20 May 2024 19:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716233223;
	bh=lIC7HB0swIWVdimTjG+bzLOFs5vA+ZcNp4GFhv6O2ss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uKFXoRYU7uRmLdcEGZK7vJwRRGE7eUjD8yu+aR2xrY2aLnq02mES2IoZKT+WXVMFP
	 J1DjYVZrDFSHtK4NVhoKd1pZ4YCqyHqw6h1AlgOkrG0mYWc+v+7MW4YvoKs5z2ZBC7
	 do4nt5kChBPcE3/CUV3hBaONcstkHa+fPaE1iclH3mcBMPll2pjxxDq0SdpdJxwp7s
	 QTtBh6omdYiAaeifTEL/fIVBdKlKzSAjqeRS2YseQFxLdqgH+MHPfs37aTqbkuV6AN
	 9eIZcFnsErvG+Uykv4HFGxUd+FtWr4LUJNQPJ4LkgyWRXho1GYJuo45uXz+NbM9iKf
	 OlDVjtniSR8NQ==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, i-salazar@ti.com,
 pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 liam.r.girdwood@intel.com, kevin-lu@ti.com, tiwai@suse.de, baojun.xu@ti.com,
 soyer@irl.hu, Baojun.Xu@fpt.com
In-Reply-To: <20240518033515.866-1-shenghao-ding@ti.com>
References: <20240518033515.866-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2552: Add TX path for capturing AUDIO-OUT
 data
Message-Id: <171623322016.94469.11401583139822139429.b4-ty@kernel.org>
Date: Mon, 20 May 2024 20:27:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-621fa
Message-ID-Hash: T2GEZG6GFQJONO3UAESCA7IVPZDBCUPK
X-Message-ID-Hash: T2GEZG6GFQJONO3UAESCA7IVPZDBCUPK
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T2GEZG6GFQJONO3UAESCA7IVPZDBCUPK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 18 May 2024 11:35:15 +0800, Shenghao Ding wrote:
> TAS2552 is a Smartamp with I/V sense data, add TX path
> to support capturing I/V data.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2552: Add TX path for capturing AUDIO-OUT data
      commit: 7078ac4fd179a68d0bab448004fcd357e7a45f8d

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

