Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54053C3DA59
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:50:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6356847;
	Tue, 16 Jul 2024 16:50:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6356847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1721141446;
	bh=RjRpkJFPLTVtr7FF7jRiRNR6NNoZv16lBsE1D8s+HyY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KX1lX0JR4IoMLOjqad9xccacBflmXLFYrWvKbF/CvppL+rjVnmUE6isXFpyVNOSKF
	 80mXWfwpIqLvIvB2MNQ0CG51AJeQ2rzk7poOGZY/p1aKtshbUUcdnK4EzfP8lQ5sNM
	 4eheahAWysmw42Ikn7bshrS3h3pQTE5Y45uafIy0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F7A0F805CB; Tue, 16 Jul 2024 16:49:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D28CCF805E5;
	Tue, 16 Jul 2024 16:49:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A91DF8026D; Tue, 16 Jul 2024 16:45:55 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1E59F801C0
	for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2024 16:45:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1E59F801C0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sj+axYiS
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3083ECE12FE;
	Tue, 16 Jul 2024 14:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FEAC116B1;
	Tue, 16 Jul 2024 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721141144;
	bh=RjRpkJFPLTVtr7FF7jRiRNR6NNoZv16lBsE1D8s+HyY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sj+axYiSmlSi+MkvpWpxTS1N8uxL9VMoiU8AcXl4XS7m2ab9LYR1068jHGefOaONN
	 BDhKLU341oD3jKQMrZjYiA/i4tXrewK0dARKfSkdiSVB14kiFN5E5NZ1GmYlS+owvB
	 UGqQ26Yp1LpMscUU32E716f7CsNMhLKUzEiyvu5vnxECh/ztJoYmivaIRih+NrxZnu
	 mZ9WMpi1lWytxJCAlZJ0BaJqNaHxdhJ6KIzXgbU8qVXcZge/SKlpPtW0a8iB9V643y
	 akJlnLVOOImx+IdeJS3bVEOi7OBboG/cRlnXNFqGWlhQoAjmtinnlKEvi/d36GtnBN
	 UtCkiHaY9kCog==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de,
 Curtis Malainey <cujomalainey@chromium.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
In-Reply-To: <20240716084012.299257-1-pierre-louis.bossart@linux.intel.com>
References: <20240716084012.299257-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Fix RT5650 SSP lookup
Message-Id: <172114114300.56252.16479559406586120577.b4-ty@kernel.org>
Date: Tue, 16 Jul 2024 15:45:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: LQ745UVUDRQHNGBH6VUJ4FM2UUIW5WK3
X-Message-ID-Hash: LQ745UVUDRQHNGBH6VUJ4FM2UUIW5WK3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LQ745UVUDRQHNGBH6VUJ4FM2UUIW5WK3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 16 Jul 2024 10:40:12 +0200, Pierre-Louis Bossart wrote:
> Commit 8efcd4864652 ("ASoC: Intel: sof_rt5682: use common module for
> sof_card_private initialization") migrated the pin assignment in the
> context struct up to soc-acpi-intel-ssp-common.c. This uses a lookup
> table to see if a device has a amp/codec before assigning the pin. The
> issue here arises when combination parts that serve both (with 2 ports)
> are used.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Fix RT5650 SSP lookup
      commit: 6f6a23d42bdfbbfe1b41a23e2c78319a0cc65db3

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

