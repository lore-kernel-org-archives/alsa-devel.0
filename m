Return-Path: <SRS0=evnw=K6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B62C47425
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 16:34:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6358E610E7
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 16:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6358E610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 696A6173A;
	Fri,  4 Jun 2021 18:33:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 696A6173A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622824479;
	bh=9yhUSzn3yYDa5TaKiRajPiCZuGQ4F9eE3poqB/Isyu0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sZCWiVyT/tEM4WCXvp/C3dsXV4ebWHZBhWH2DDHBwCebXvHXT1HB25KWENvmRI33i
	 VJIdaCy01xDj1Xw0fQ/k5sKg4enD1YdRrSAO8gvWw+CpmkRdUD8DH4Oi5ZD1ai+laj
	 0q4urBolZngn3bzZZjHdhUXPZQtUe2SjDq4eRIK0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23E9CF802A9;
	Fri,  4 Jun 2021 18:33:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6050F80103; Fri,  4 Jun 2021 18:32:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50B9CF80103
 for <alsa-devel@alsa-project.org>; Fri,  4 Jun 2021 18:32:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50B9CF80103
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kcZnBfg6"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13A5E610E7;
 Fri,  4 Jun 2021 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622824372;
 bh=9yhUSzn3yYDa5TaKiRajPiCZuGQ4F9eE3poqB/Isyu0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kcZnBfg6g5iLCndwauVfPagd4enk4nBl6ra1I7SCuggUVsSJN1s1kX/Spo2t9bgib
 d5Gy3VmAYmZwZM2mO2m2r+ZVvk2kgmDVwz7dX9guaSe5RcvNJWfgXLoNq1bAv9KPvI
 J8q8ZmqEt/Uf02JaBCY3Wq/2isASiVq2LM+DMBmJKR2y2gWWqEkmdZEVuIVfW0Df9P
 tgP4giBNrPI8YuzQG77qMrHpTqvkBmV7Wr696auQB2N0BIPdti4y3nng/sVK9pmtst
 32wTDETwHy76ByAyAxr2YDJJkkdw76EcuXZdOhqEQlencOENWi7BvU/W/Z6ba/uqlY
 p/QfkGmN9iOrQ==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2][next] ASoC: ti: davinci-mcasp: Fix fall-through
 warning for Clang
Date: Fri,  4 Jun 2021 17:32:28 +0100
Message-Id: <162282419357.38836.16514328061509733520.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210604072714.GA244640@embeddedor>
References: <20210604072714.GA244640@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Fri, 4 Jun 2021 02:27:14 -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a fallthrough; statement.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: davinci-mcasp: Fix fall-through warning for Clang
      commit: 50d790012a48f0f2f1dc8e4c214054283e529ae9

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
