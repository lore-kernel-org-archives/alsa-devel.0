Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F300C30658
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jul 2024 11:32:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D93B211C;
	Tue,  2 Jul 2024 13:32:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D93B211C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719919970;
	bh=ZEBaVU6KtOqS65U4pWx3ZRaX/O4ExxXq3npKnwdQAtE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DVMQ6a2jpNGtFNeU8POleEZwzVpz0xuRkvfubpcmQuXMvFMysnnB0wmx+kmx+TNUy
	 m1DOLy614xyu6qUZo6iVEm7mHahvUa4l+DWr1S4uJxuCG4AJF6TUEiz7w9Jj1b8dVA
	 P2i1Bvl9Gkxkrn7mPDoJBKlyseqXXq96F6qg54Us=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73FD3F805D8; Tue,  2 Jul 2024 13:32:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F3438F805E1;
	Tue,  2 Jul 2024 13:31:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B796F8025E; Tue,  2 Jul 2024 13:30:18 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BECEEF800FA
	for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2024 13:30:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BECEEF800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DTtgxuOa
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 48E66CE1DD2;
	Tue,  2 Jul 2024 11:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA95C2BD10;
	Tue,  2 Jul 2024 11:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719919806;
	bh=ZEBaVU6KtOqS65U4pWx3ZRaX/O4ExxXq3npKnwdQAtE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DTtgxuOanW2fBW/ZV+zeYbRpGLfSG6m7KVdHV788+OXLEZIkpODkqa1H/yKDiEpUW
	 MLExm6b1b2PESzTM3udHlJ1STxLrYN+LNYaZFhwlnOJoWilrsRWCJ7/KBnzOqgPWls
	 k5FPANYDqv5dp8aTEKrJxiPew2Z7k5vtzL1Q/yc8K6wxOjAaEZK6X0vZzoRf2vwdC2
	 vdgNyZkb/OEATiz3JJqRWcXXR9bfTgv+qpfrqUuinBkFktrRrgR194IGxw5z5MdN20
	 58cINbsQuDUv3XDuNUPrA1+/YumETbMmbCf8EH6BXjbVsnlQ289OF+6+8GDy1/InRC
	 mHexAq0PmuUjg==
From: Mark Brown <broonie@kernel.org>
To: "J.M.B. Downing" <jonathan.downing@nautel.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org,
 patches@lists.linux.dev
In-Reply-To: 
 <20240701-lpc32xx-asoc-fix-include-for-field_prep-v1-1-0c5d7f71921b@kernel.org>
References: 
 <20240701-lpc32xx-asoc-fix-include-for-field_prep-v1-1-0c5d7f71921b@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: lpc3xxx-i2s: Include bitfield.h for
 FIELD_PREP
Message-Id: <171991980440.18111.17479068162057597635.b4-ty@kernel.org>
Date: Tue, 02 Jul 2024 12:30:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: SLN4YKE2ZCRQYW7PEAUZ2WHLRV7Y4KFU
X-Message-ID-Hash: SLN4YKE2ZCRQYW7PEAUZ2WHLRV7Y4KFU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SLN4YKE2ZCRQYW7PEAUZ2WHLRV7Y4KFU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 01 Jul 2024 11:26:38 -0700, Nathan Chancellor wrote:
> bitfield.h is not explicitly included but it is required for FIELD_PREP
> to be expanded by the preprocessor. If it is not implicitly included,
> there will be a compiler error (as seen with ARCH=hexagon allmodconfig):
> 
>   sound/soc/fsl/lpc3xxx-i2s.c:169:10: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     169 |                 tmp |= LPC3XXX_I2S_WW8 | LPC3XXX_I2S_WS_HP(LPC3XXX_I2S_WW8_HP);
>         |                        ^
>   sound/soc/fsl/lpc3xxx-i2s.h:42:30: note: expanded from macro 'LPC3XXX_I2S_WW8'
>      42 | #define LPC3XXX_I2S_WW8      FIELD_PREP(0x3, 0) /* Word width is 8bit */
>         |                              ^
>   sound/soc/fsl/lpc3xxx-i2s.c:205:34: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     205 |                              LPC3XXX_I2S_DMA1_TX_EN | LPC3XXX_I2S_DMA0_TX_DEPTH(4));
>         |                                                       ^
>   sound/soc/fsl/lpc3xxx-i2s.h:65:38: note: expanded from macro 'LPC3XXX_I2S_DMA0_TX_DEPTH'
>      65 | #define LPC3XXX_I2S_DMA0_TX_DEPTH(s) FIELD_PREP(0xF0000, s) /* Set the DMA1 TX Request level */
>         |                                      ^
>   sound/soc/fsl/lpc3xxx-i2s.c:210:34: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     210 |                              LPC3XXX_I2S_DMA0_RX_EN | LPC3XXX_I2S_DMA1_RX_DEPTH(4));
>         |                                                       ^
>   sound/soc/fsl/lpc3xxx-i2s.h:70:38: note: expanded from macro 'LPC3XXX_I2S_DMA1_RX_DEPTH'
>      70 | #define LPC3XXX_I2S_DMA1_RX_DEPTH(s) FIELD_PREP(0x700, s) /* Set the DMA1 RX Request level */
>         |                                      ^
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: lpc3xxx-i2s: Include bitfield.h for FIELD_PREP
      commit: f1afb360b6f1f49e943ac85b26d4224ec67d22d3

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

