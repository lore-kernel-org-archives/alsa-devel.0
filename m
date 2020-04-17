Return-Path: <SRS0=YLi8=6B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07638C2D0EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:17:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7790D2072D
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y+1LwzHw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2puiKB/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7790D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B01301607;
	Fri, 17 Apr 2020 18:16:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B01301607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587140219;
	bh=dMnwJXovzpQ6YBUUVCY4KPofcSqzELKGUYZ13cOxUdI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y+1LwzHwReXMFU/bALpfcrL+VgEG5HKiBeU0MjbyB4RidQZcK6gxPt1Un/jWJYmj4
	 uPXhQsCWajg7916L7xXHBMj780QIO8EZJ0xCx3xBeU5C1C/XytsijFBq3jC5kJyvye
	 Pt1s1+IH+lXRAVCxa5FQgajTkrwOBpApVla60Dik=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 423E8F80229;
	Fri, 17 Apr 2020 18:16:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FAB6F80245; Fri, 17 Apr 2020 18:16:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B86EF800DE
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2020 18:16:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B86EF800DE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="2puiKB/0"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1680120857;
 Fri, 17 Apr 2020 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587140161;
 bh=dMnwJXovzpQ6YBUUVCY4KPofcSqzELKGUYZ13cOxUdI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=2puiKB/0hiVpk1D9MJlEu9jeNCctSYUHooAr1pZSC9C4mMMjiYt2xjJMHYza+dh9P
 9oGoYR4/8Z6FSOcRGaxAc49WewRgBYQ6S8UyVyNK0Fcd5Te3/KnkaMQDMiwSJ6MV9X
 cKTvjq1ss1t31ZKGl8MG7fVht9JIrM3x+xh4qjvk=
Date: Fri, 17 Apr 2020 17:15:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Matthias Blankertz <matthias.blankertz@cetitec.com>
In-Reply-To: <20200415141017.384017-1-matthias.blankertz@cetitec.com>
References: <20200415141017.384017-1-matthias.blankertz@cetitec.com>
Subject: Re: [PATCH 0/2] ASoC: rsnd: Fixes for multichannel HDMI audio output
Message-Id: <158714007098.22963.15064526974433346524.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
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

On Wed, 15 Apr 2020 16:10:15 +0200, Matthias Blankertz wrote:
> This fixes two issues in the snd-soc-rcar driver blocking multichannel
> HDMI audio out: The parent SSI in a multi-SSI configuration is not
> correctly set up and started, and the SSI->HDMI channel mapping is
> wrong.
> 
> With these patches, the following device tree snippet can be used on an
> r8a7795-based platform (Salvator-X) to enable multichannel HDMI audio on
> HDMI0:
> 
> [...]

Applied, thanks!

[1/2] ASoC: rsnd: Fix parent SSI start/stop in multi-SSI mode
      commit: a09fb3f28a60ba3e928a1fa94b0456780800299d
[2/2] ASoC: rsnd: Fix HDMI channel mapping for multi-SSI mode
      commit: b94e164759b82d0c1c80d4b1c8f12c9bee83f11d

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
