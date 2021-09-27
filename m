Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0113BC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:52:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3F260F44
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E3F260F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FB6B16C5;
	Mon, 27 Sep 2021 19:51:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FB6B16C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632765120;
	bh=S9lPj7S6AtX8lgkNXK2TH/P606+dWXlaJ6v6Z9fSAFY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oR8UoBCvRrPYrq8bBiwU93cUSAl2se87fho8DU9sw/LA7gJGtCHdLoHwQ0PMCkf11
	 b+8Kix6CZn2IxXbjbC0GYVGmvPs3GiRn2ac4HU1CoOWFUH+rKf/zWeD0+Xtx2wjScd
	 +KK99dVbxMCcny6XUPcfwwHSIGyg9IGzb0kAlS1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27C07F80529;
	Mon, 27 Sep 2021 19:47:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A4C0F80525; Mon, 27 Sep 2021 19:47:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9931DF8051B
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 19:47:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9931DF8051B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kYIzxkh3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C3A260FF2;
 Mon, 27 Sep 2021 17:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632764851;
 bh=S9lPj7S6AtX8lgkNXK2TH/P606+dWXlaJ6v6Z9fSAFY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kYIzxkh3O1AON1PzqSy8BJwjZnoSXGhgyw8GrBDEmRvWBDMc8xx20gGFKic0wswfF
 K60u/4taBh4ZXRWKkUdOBWZsrDctzoXXB/ba6ra3N/NvifCxxqnGVN686hXvo1puId
 hwVMrV8vqUChDExnBkep9C8L8X0+Tqob1KDwPEZi759xHZduHQGVPBSf+EzKVhZXUv
 ACV5KUdzNfpzxZtY1NEy37N0PGQQO4SFqHhPMzNIaOHRp0f1AqIkadSsiuRs36Zrqk
 UfwQyVKDqhkjoCqQkl6AX+JWRgHYRgytWpQWUvTdoM83+aSWRD7LVcu5Q4/uCJFTqJ
 pT/kNYGhhuljg==
From: Mark Brown <broonie@kernel.org>
To: Sugar Zhang <sugar.zhang@rock-chips.com>,
	heiko@sntech.de
Subject: Re: [PATCH] ASoC: dmaengine: Introduce module option
 prealloc_buffer_size_kbytes
Date: Mon, 27 Sep 2021 18:45:34 +0100
Message-Id: <163276442023.18200.4927438084255861267.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1632394246-59341-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1632394246-59341-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-doc@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org,
 Mark Brown <broonie@kernel.org>
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

On Thu, 23 Sep 2021 18:50:46 +0800, Sugar Zhang wrote:
> Currently, The fixed 512KB prealloc buffer size is too larger for
> tiny memory kernel (such as 16MB memory). This patch adds the module
> option "prealloc_buffer_size_kbytes" to specify prealloc buffer size.
> 
> It's suitable for cards which use the generic dmaengine pcm driver
> with no config.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dmaengine: Introduce module option prealloc_buffer_size_kbytes
      commit: b0e3b0a7078d71455747025e7deee766d4d43432

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
