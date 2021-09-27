Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05ADC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:57:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00ECC60F11
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 00ECC60F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88D9B16F0;
	Mon, 27 Sep 2021 19:56:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88D9B16F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632765436;
	bh=6nQbGFp+CK6omPNi2RGUGVBJk31HCjC2u1mN87MtA9U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TMqlJ8csp/3dZ3h2PRNQ7CIV8tRd1Cz0mv6v/GlAEiP5ygZ3DLdoTriJys/2TQ0LH
	 Qri83LGmCR5eP2aFUPXwK2EyXxzAme1DTpjIeWqVCSxpl/ujcvqHTyzOSSMSf1j14G
	 4BYlM245HZqoSd7ACvs+4IsxLxAfb0emdVx0FNvY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1465EF805C2;
	Mon, 27 Sep 2021 19:48:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8D27F805B6; Mon, 27 Sep 2021 19:48:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85C52F805B0
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 19:48:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85C52F805B0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZA5uBFJ0"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1834761058;
 Mon, 27 Sep 2021 17:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632764897;
 bh=6nQbGFp+CK6omPNi2RGUGVBJk31HCjC2u1mN87MtA9U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZA5uBFJ0y7vT2Wgs7lGG1G5od3XhuseVzcDduhB/X5fU6uI4Z4OuU7CeaNr9Q/6PE
 bes0pQREAEN4ifq5+zgXtKSff3BbFXFBqOeXg5y3FJydhp4lbWlGi85RbYXLpcduzm
 BHg1HvRUIMJCpwlSE2ha46ZBkoCHKVE0tvt2UCh0uhCV1guwxJzbrzXdtKNn4yReEW
 5SkNGCxhk6hjnh3Fsaj62nndbEhqnUNqUXS34aDAZ3Y9eXz9Pt9JuMO2P21uvBfsKd
 bqqX0mYVHb/5FZeXKQj6Yhdo4741VeXxS72LwqU2efcO23fpn6VndL3XD1JF3o7YOD
 MLbKcocbHSQ0Q==
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH] ASoC: bcm: Convert to modern clocking terminology
Date: Mon, 27 Sep 2021 18:45:51 +0100
Message-Id: <163276442020.18200.10580818808186373060.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916143423.24025-1-broonie@kernel.org>
References: <20210916143423.24025-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org
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

On Thu, 16 Sep 2021 15:34:23 +0100, Mark Brown wrote:
> As part of the effort to remove our old APIs based on outdated terminology
> update the Broadcom drivers to use modern terminology.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: bcm: Convert to modern clocking terminology
      commit: a91b0e5b0bf6a1284f38997a7a4e116241b16251

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
