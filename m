Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDC2C00140
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Aug 2022 16:27:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8AD301640;
	Mon, 15 Aug 2022 18:26:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8AD301640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660580848;
	bh=M48z2KqCHhL953p7b1Jg0Gu4m0TjqNK8KDEbgoo0JM8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kf003sU1boAlLyraSdCkHTOrPLymRNQxUNJbx/JjqxWwPatKioF2mSbnQ1w41auhi
	 ndQwIlG81QJWiye5Js4Qwe2WDyczgrtiJx0wnn1pX9QCqSaLolrV0oQ4f8PM7lMEE3
	 LmCs4bdtseRobs27E/KjkCQIASF+OFiXxuavnifs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1063F805C0;
	Mon, 15 Aug 2022 18:23:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2FBDF8057D; Mon, 15 Aug 2022 18:23:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E7F7F805AE
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2022 18:23:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E7F7F805AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FXq9TSSY"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2B111611E8;
 Mon, 15 Aug 2022 16:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94311C4347C;
 Mon, 15 Aug 2022 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660580602;
 bh=M48z2KqCHhL953p7b1Jg0Gu4m0TjqNK8KDEbgoo0JM8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=FXq9TSSYTg7OpDTuH1ZAddk6xdRmPg/M2VqfFMK5gt0bsnL3QVez4AZAZNCyRXiSM
 NOdlOYS6T4qufeYEdhi6y6C35ew+IOkuT7DiaI67iPHNhfMirG0P8wDi1oVqnuAOFV
 CsQvZfeZUnvTwJpHn/dL5hdv8Cjg4vu71h10IfzLbpkY9+xnEf5Rr+W9s42HjW5GHy
 7s4SRipdH7iORl66cbaUSBwqsF2tLqkleK7ni6c5B8P566CA/jpVdFPt6opUcew30n
 +bwWyp+5vHJCHeyIU07yzpU1fPtox03xyA7pCjbz12wlSgs3ar+Rhjprtuy2TXiLK8
 Iop3mp0X+d6/A==
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Argus Lin <argus.lin@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <YvThhr86N3qQM2EO@kili>
References: <YvThhr86N3qQM2EO@kili>
Subject: Re: [PATCH] ASoC: mt6359: fix tests for platform_get_irq() failure
Message-Id: <166058060031.769843.15519074468480649760.b4-ty@kernel.org>
Date: Mon, 15 Aug 2022 17:23:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Liang He <windhl@126.com>
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

On Thu, 11 Aug 2022 14:01:26 +0300, Dan Carpenter wrote:
> The platform_get_irq() returns negative error codes.  It can't actually
> return zero, but if it did that should be treated as success.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mt6359: fix tests for platform_get_irq() failure
      commit: 51eea3a6fb4d39c2cc71824e6eee5949d7ae4d1c

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
