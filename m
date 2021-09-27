Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0492C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:51:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B7860FBF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66B7860FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A05016C3;
	Mon, 27 Sep 2021 19:50:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A05016C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632765063;
	bh=i6C1j/rVSaKCT6VZs7hNmd9rfXiX+ZOqCInscH6GliU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cR3M2ARKtJ8AbcgHm9YyhNqfOku1wNM/iOcGXODcyONmZqzB++GZ0R9+juTEwc83x
	 bm+LYMKEVDbiIYKkWlkfDGEWAF+hctH8NbUL5LG8szNO6GV3Lszrfi33i6RfW7V5w1
	 02KxqZ1YOT4aSey1YQvdae2+PGgAJW0sGuNOQlzY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52569F8051A;
	Mon, 27 Sep 2021 19:47:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7B7C5F8050F; Mon, 27 Sep 2021 19:47:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31ABAF804E3
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 19:47:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31ABAF804E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="r8Yw6Drk"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E648460FBF;
 Mon, 27 Sep 2021 17:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632764841;
 bh=i6C1j/rVSaKCT6VZs7hNmd9rfXiX+ZOqCInscH6GliU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r8Yw6DrkQMNMNhrFVCWdQ65qa1RCnrKgcfptX/h+Im3mqomdgenGb0QWw+wzQ3yhY
 pQKKEEC0rFogz1yPHog1X2HYowB6w+xEBSD06zRuUN/xKv9/XiIozNZNcNr85sHC6n
 nuIGrLGYvmXYsXaWNcCE3tSreT7ivGQtfQr93jS9jz1WhnmSveFF8cAZclqTvAmXzd
 f5MhYvk/4BrAiz10yL68i9+DQ9BMAW1TT7Q6xPA/YE7wHvydDoQICSdsPo/SG8QDz5
 xYKu363L1BzMHFHeuVG0G0TDpXuTKbUpp0bu6Cs+Cgfx7vCD/PwicJbrdxmpFlmeaS
 rzfN4o7Iroo3A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Oder Chiou <oder_chiou@realtek.com>,
 Colin King <colin.king@canonical.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: codecs: Fix spelling mistake "Unsupport" ->
 "Unsupported"
Date: Mon, 27 Sep 2021 18:45:30 +0100
Message-Id: <163276442024.18200.2988591432282232659.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210924231003.144502-1-colin.king@canonical.com>
References: <20210924231003.144502-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

On Sat, 25 Sep 2021 00:10:03 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are spelling mistakes in dev_err error messages. Fix them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Fix spelling mistake "Unsupport" -> "Unsupported"
      commit: a4db95b2824157bdf0394da429ea49280bfad6b9

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
