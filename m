Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A839CD6E5A
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Oct 2023 11:40:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 888A3158B;
	Wed, 11 Oct 2023 13:40:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 888A3158B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697024452;
	bh=T77Zw4Ow+fGootlr3AzajNul/Y31eLQDixkQ42a4Eco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Rf2ySim3Ctq8B+QXcRGtMklkOjl1lAP/qeWJYe0JL3P5i19zxNwRcOBxOuNS3ZwzD
	 I/fmXkyFxZbi7PmxnBnGQ540W9O4PB7ePDtYggIkjtTF0qCyzpBXArZNuUriop9bjQ
	 +rutwv+hpUm3jeNgYGwFpxsOi6eW14wX74oOuzek=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BBC90F80536; Wed, 11 Oct 2023 13:39:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D9BCBF802BE;
	Wed, 11 Oct 2023 13:39:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 50821F802BE; Wed, 11 Oct 2023 13:36:13 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 62CB0F8015B
	for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2023 13:34:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62CB0F8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=W7vdqLtx
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9AB9C6184A;
	Wed, 11 Oct 2023 11:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3F8C433C7;
	Wed, 11 Oct 2023 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697024089;
	bh=T77Zw4Ow+fGootlr3AzajNul/Y31eLQDixkQ42a4Eco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W7vdqLtxGJGwwnSXxh3fxZies3A93UQ3lYTZM+wU7N7228PCEfJGYy2ELwzOLOc2a
	 EDSCKOpzaQ2JU7gQhdxNXqDqTrHP768IGb+VN2n5eTojP87zFqflHI+VnsFQkDKpiC
	 jwgl9+HUi0uBT59x/heygfMxV3+hM/L8FXixl4B+Hk40JNRcwAv0kQjdQM4KEul5YM
	 LKY3icUnaKUsQixaXvS+ldrXHf/M9oY/mq5w2Dn2ZIbIF4WIbS9zChvPv+PddmErve
	 yuwwsT5N9+X2N6pUEf7UOc70fjj7QCj3ADZdBpE+ybZ6iIZJTxjOeQPIT3H6FzZ9EL
	 40KFZpnvC53bA==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
 Kees Cook <keescook@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev,
 alsa-devel@alsa-project.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
In-Reply-To: <20230922175050.work.819-kees@kernel.org>
References: <20230922175050.work.819-kees@kernel.org>
Subject: Re: [PATCH] ASoC: apple: mca: Annotate struct mca_data with
 __counted_by
Message-Id: <169702408624.29318.955313379054643924.b4-ty@kernel.org>
Date: Wed, 11 Oct 2023 12:34:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: 4UV3VPLMKHWWE6ZC6MVGVWFGP4TT2GL6
X-Message-ID-Hash: 4UV3VPLMKHWWE6ZC6MVGVWFGP4TT2GL6
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4UV3VPLMKHWWE6ZC6MVGVWFGP4TT2GL6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 22 Sep 2023 10:50:50 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mca_data.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: apple: mca: Annotate struct mca_data with __counted_by
      commit: 59825951707eccf92782e109c04772d34fc07eb6

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

