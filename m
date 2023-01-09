Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80D9C5479D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Jan 2023 16:50:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BA15BB35;
	Mon,  9 Jan 2023 17:50:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BA15BB35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673283052;
	bh=vfToooFvqG7PPIh4+IgqDfsebCiWzTMy8pkLwP+eTLE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=O8MbCKQCdCaWfzUNte7oqcMJBPxeD9O+lYeT9WTYnhQCmyvm3WgfNyiv4kJ09g/Z2
	 oq31kF47+Hmdrm0ngtlIfirps/h3RUKD3kglKU4otKf8MWuItKSztIKDLO7rsVlRvT
	 tDFpf46lEpQw4/hRZ6AstZEhDFY4fBH3Fj4DCxAc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90268F80539;
	Mon,  9 Jan 2023 17:49:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9EB8AF8051B; Mon,  9 Jan 2023 17:49:13 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C296F80425
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2023 17:49:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C296F80425
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dTZ4S4m0
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1D08B611E9;
 Mon,  9 Jan 2023 16:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241C3C433F2;
 Mon,  9 Jan 2023 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673282949;
 bh=vfToooFvqG7PPIh4+IgqDfsebCiWzTMy8pkLwP+eTLE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=dTZ4S4m0Kixw+/ADbnK/a9lxMmzQ94LmS1Z0eEq/i7EruP1hlAt81aajr5fwcRNL5
 pOe/qFU5fQrbC3YDNIrtf8kwCZ2gRziMWn/OJXEed2A8OQOSFNcQ2ees5Li5P207ee
 K/OpgSs6fJRl/z5g7grnlJDAoCwaNoSPN9ngl+DIeGdT6RUWHbcWA8wpufWGHVf/TH
 +d7hDCYszE6gHjpqBwAPwHzMeyi9Gmv1H0gxd8GztsrKkI2/+rjCgDjOy0bV/mrpVA
 z03ZwJ58N6JEuKglO24N5iDEZPXIOvhDD/sqliSpfEjtxoV12W8/ATmgS3Y9AXsPA0
 CU2OT9vfCG6LQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Nathan Chancellor <nathan@kernel.org>
In-Reply-To: <20230105-wsometimes-uninitialized-pci-ps-c-v1-1-4022fd077959@kernel.org>
References: <20230105-wsometimes-uninitialized-pci-ps-c-v1-1-4022fd077959@kernel.org>
Subject: Re: [PATCH] ASoC: amd: ps: Fix uninitialized ret in
 create_acp64_platform_devs()
Message-Id: <167328294786.323147.5948330744390772644.b4-ty@kernel.org>
Date: Mon, 09 Jan 2023 16:49:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 llvm@lists.linux.dev, Syed.SabaKareem@amd.com, Vijendar.Mukunda@amd.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 05 Jan 2023 08:53:32 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>   sound/soc/amd/ps/pci-ps.c:218:2: error: variable 'ret' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>           default:
>           ^~~~~~~
>   sound/soc/amd/ps/pci-ps.c:239:9: note: uninitialized use occurs here
>           return ret;
>                  ^~~
>   sound/soc/amd/ps/pci-ps.c:190:9: note: initialize the variable 'ret' to silence this warning
>           int ret;
>                  ^
>                   = 0
>   1 error generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: ps: Fix uninitialized ret in create_acp64_platform_devs()
      commit: de1cae22898cf10aacc735a21d799b5bbce4496c

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
