Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79D4C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:56:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBB060FD7
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2EBB060FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A882216DF;
	Mon, 27 Sep 2021 19:55:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A882216DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632765375;
	bh=GJmf5tv8okvhUb2Nj2NBVWg3C+fz6pux9fl8uwlxm2I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r7DFZYcaxx+LWEMqHfql2WSRUAQ8A+ZHAlgTh3oKgK3G+SY5jEwPDutCRhwRB5Eu3
	 TN0rsXwpZ/CVJ2tQPSiMv0bl1aDdjOhn63TSZiEqKSc+XefTv3zQDZxdSrVAPGWfYF
	 1tVTRl7nT2RKRXfkeh1eo5OBQkI3VKviZXOJzNTE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72185F805A8;
	Mon, 27 Sep 2021 19:48:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2831F80587; Mon, 27 Sep 2021 19:48:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6109F8057C
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 19:48:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6109F8057C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hvmyTcNq"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 729CB60F92;
 Mon, 27 Sep 2021 17:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632764889;
 bh=GJmf5tv8okvhUb2Nj2NBVWg3C+fz6pux9fl8uwlxm2I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hvmyTcNq2/Z7rGRCG4F9GsSRzqI80PgMP94ZpJJlIA3nVF3x+c/QfhMHwFondttB9
 0DvkJY+OnEPVQQW4wdNJhZM/E699Xkj1qXCUjgDj5KOq3Bj/UsxJ5VphloAO9POJsk
 luiUIUKHy4FL33MGPzPgHDH6TK6pGaG9FraTTo3jS0j1AomS97EiHwAXHbP5rDX5tW
 AoInMMt+Qfnb1cczVEsjNZSe3zVEBuev5ogjD5dcoVsRJKoCVWSe7XiOTR7iWThWCk
 f3sSavlsq8QfJ5Msi20d7XNzVG4x8Ms+ihCRl7CzEgxglyWdjPdGIyi99xjNzx8bb7
 SfrDK6ul2wBGA==
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: ak4104: Update to modern clocking terminology
Date: Mon, 27 Sep 2021 18:45:48 +0100
Message-Id: <163276442021.18200.13376871216481647630.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916150922.20183-1-broonie@kernel.org>
References: <20210916150922.20183-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Thu, 16 Sep 2021 16:09:22 +0100, Mark Brown wrote:
> As part of moving to remove the old style defines for the bus clocks update
> the ak4104 driver to use more modern terminology for clocking.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak4104: Update to modern clocking terminology
      commit: 8515f828c5659337d6dd4e1d5beb2e6708bb9c28

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
