Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C62C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:57:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC1D60F4B
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1FC1D60F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC83216EE;
	Mon, 27 Sep 2021 19:56:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC83216EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632765419;
	bh=Z4NOzrNbBOX/TYyEuQLP+lxyx0e3iGBJu2EUdQ+Y4cM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sl5TMMYC7nND6fgK0Z5bUAFjHpq5cQpDzVuKUthG4TUQ7Mr5Kbh6n9sfFKmpS2d8u
	 4ihTwUhy0BR+c4kanVpdcYTJnlFG+QbWI7Lsrm+kWVuqMYY6tbDvHi+VdL8xAsSEBM
	 BXlx6ZtiThzkrDCspeAih7fE16iRvY4nlg6mkM7g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5F58F805C0;
	Mon, 27 Sep 2021 19:48:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54593F805B6; Mon, 27 Sep 2021 19:48:20 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EBD9F805B0
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 19:48:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EBD9F805B0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hono0Luh"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27ACB60F92;
 Mon, 27 Sep 2021 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632764894;
 bh=Z4NOzrNbBOX/TYyEuQLP+lxyx0e3iGBJu2EUdQ+Y4cM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hono0LuhVf/lPCs9A8ERRHsQOi4bnfSN09yk8T1c6nqPJ+QY3SbtgCKUS39Ma/BfB
 plyxv+PR8F04joIel2taXZqxccaxbn1cHkGYWWKLOFcmhwO5ymj/TO0suVMG92zg9j
 VKZ2gJYOjukVY5A9HvFJESmCGURAsZhJbMFkKCJiV6j/mBfGd90tJKTFK0TpviNw6p
 OgNnCAZNB2BPp8pe5GYG4a/EsuLL6ycG+GIM8zetKiApYPDHIDNMOvGctfo5a8u9dP
 YqglKaspxerloU9xHdffngWLrhUJbmCzL055ylFQ8N6kNgPHVk3paMaL0+IatAjQls
 Ug9Fw0Qloye4g==
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: cpcap: Use modern ASoC DAI format terminology
Date: Mon, 27 Sep 2021 18:45:50 +0100
Message-Id: <163276442022.18200.1201063515695467432.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210920165323.17338-1-broonie@kernel.org>
References: <20210920165323.17338-1-broonie@kernel.org>
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

On Mon, 20 Sep 2021 17:53:23 +0100, Mark Brown wrote:
> As part of moving to remove the old style defines for the bus clocks update
> the cpcap driver to use more modern terminology for clocking.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cpcap: Use modern ASoC DAI format terminology
      commit: 99a26f2416fc1fadcfb4519ae5de5265b109e268

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
