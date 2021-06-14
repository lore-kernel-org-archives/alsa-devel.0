Return-Path: <SRS0=68EG=LI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63FCC2B9F4
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:58:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CAF61246
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CAF61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A572A16A0;
	Mon, 14 Jun 2021 21:57:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A572A16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623700720;
	bh=UaMAdaGCIFZTe9Lid8hlx9FlqRqLHjiFO76ePbDjrE0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dJfkv4+TK4Dzazss6iwayZ+jQ/M3I8lCGcakN8ztio0BJ0QQnLU55IARb+INJx3tg
	 59y7QXn9opq6JERmsPiKJ60mrVCfzgIuiBXajRT2zmUX4bbMa40/4eCKvl7NCnoSk1
	 ChQCFVPD7127lo08KG5+eRw3yl9+n2YE0sShmF2I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BB52F804FC;
	Mon, 14 Jun 2021 21:55:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6CCA2F804FD; Mon, 14 Jun 2021 21:55:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C25BF804FA
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 21:55:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C25BF804FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XKfnJWBW"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AA3A6128A;
 Mon, 14 Jun 2021 19:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623700503;
 bh=UaMAdaGCIFZTe9Lid8hlx9FlqRqLHjiFO76ePbDjrE0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XKfnJWBW4djyyeyu+bnBwYV3kA0AMw1zcNBMq6AoparWdnwL6o6Ze65nCZUigY81f
 S970hJT5ru0jnee4ijuWhFUX5tcMP0nxgmo9nF4IHvqXMVGgKpxmtHMadoZzETvPHs
 Rcjj/by5SMn7+AHhyz7J0KlkmUr2vFwn1T0ySzJa5oqvP1oUzu5nw8CqdZfqHe/ZYm
 Mj5JXw0BAh8bKgTfa+EXPyx9afERF6ds5sdsShqr/CPJW3Yj+gZbuy8OHf0bA2PAFX
 NvDt32juFXFEkAIrIBnMloIn+8dB6qb+5verJlJax0bnLTAm0EV9TOIj3xmi+RM9MF
 fNNk2vur8lIhw==
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: rt5645: Avoid upgrading static warnings to errors
Date: Mon, 14 Jun 2021 20:53:46 +0100
Message-Id: <162369994008.34524.1712121519306200413.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608160713.21040-1-broonie@kernel.org>
References: <20210608160713.21040-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, Phillip Potter <phil@philpotter.co.uk>
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

On Tue, 8 Jun 2021 17:07:13 +0100, Mark Brown wrote:
> One of the fixes reverted as part of the UMN fallout was actually fine,
> however rather than undoing the revert the process that handled all this
> stuff resulted in a patch which attempted to add extra error checks
> instead.  Unfortunately this new change wasn't really based on a good
> understanding of the subsystem APIs and bypassed the usual patch flow
> without ensuring it was reviewed by people with subsystem knowledge and
> was merged as a fix rather than during the merge window.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5645: Avoid upgrading static warnings to errors
      commit: 916cccb5078eee57fce131c5fe18e417545083e2

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
