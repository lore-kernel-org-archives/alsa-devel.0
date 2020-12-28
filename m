Return-Path: <SRS0=H50z=GA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0A1C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 16:08:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9372020731
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 16:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9372020731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1ED9174A;
	Mon, 28 Dec 2020 17:07:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1ED9174A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609171709;
	bh=mqb+V8KwpniY5OTuAQBPlleqKjClqNjI5EX4LEXBC1s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WWgANr4Fi5Z2azK+22W0LPDV2jT06vAZJKioRq9QapwoeHboWCkpeUF6BoU5pJpkC
	 JhVWoviLYEjHs4BSANqRAttVzd/2xcFCEv2wM7r+k1d8ebvZol9S/e7D5sXAhAxEiB
	 Bz88cdq55qjoDDp0sIC+d8F5ljyviLml3EbfF0Ts=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD8FCF80249;
	Mon, 28 Dec 2020 17:06:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FE19F801F9; Mon, 28 Dec 2020 17:06:42 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95A67F801ED
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2020 17:06:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95A67F801ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YG+9hR2a"
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD71720719;
 Mon, 28 Dec 2020 16:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609171593;
 bh=mqb+V8KwpniY5OTuAQBPlleqKjClqNjI5EX4LEXBC1s=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=YG+9hR2a0eQLdmIwqUt5+j9zwe/xDbB+DHADXmxHsKfP9h0EsYODWYptwZ+C3F3EP
 gv4Q0/d4Ko8GFYpte+01WTZjAYGyZAwMdhykFMFxfsctA4yJs6DpF7Cc3GPqTBwSZm
 0L4apwmL72WJ1Tb2M3pzsgb0X1O8KazpGKHBzoK0YryToyxJ1DPCAmzms59TlPRhcu
 5ekaF5r+N0uQHS9bx3g/Y4nB/1OSXuLSnF3wBm7VenOtY5wGfSFzCC7BFCniYtelir
 /iMa161BbjEBNkcl+gQh7SsuLIJtdcnV/L5SBqWxfgfX/yd9/fiy8YLon701DUBXXM
 1XYDVYY/E5dbQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Baolin Wang <baolin.wang7@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20201208111805.6989-1-andriy.shevchenko@linux.intel.com>
References: <20201208111805.6989-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: sprd: Switch to use list_entry_is_head() helper
Message-Id: <160917143257.51553.9711078590395339738.b4-ty@kernel.org>
Date: Mon, 28 Dec 2020 16:03:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 8 Dec 2020 13:18:05 +0200, Andy Shevchenko wrote:
> Since we got list_entry_is_head() helper in the generic header,
> we may switch driver to use it. This eliminates the need
> in additional variable.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sprd: Switch to use list_entry_is_head() helper
      commit: 57fc2bbc62ef9d505e8732acbae0d6b5c59836cd

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
