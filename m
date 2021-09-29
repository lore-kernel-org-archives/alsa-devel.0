Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25C2C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 13:18:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC26613A7
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 13:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DC26613A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 620CE1695;
	Wed, 29 Sep 2021 15:17:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 620CE1695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632921515;
	bh=/7ffRfO70FzWtNxTpBsYQ6/zH6FWWTHiDyUtdaVoxNM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YXcBmzeZ04Bwj797T2lYWj6s4qzX5js+vOdGd2JLYj0zcjZbYy+nixz7U0FM+BVCL
	 4BTL4nGIA837dzpdz8INYHmaX7eYFLC04q3jQx5HeoIjrbYlM4zStHT6AVQCXv7eoC
	 dj6OOfSg1Nf9NN+C7CPshChWmcHT6G21ouEeqls0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E29D7F801F7;
	Wed, 29 Sep 2021 15:17:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86ABEF80161; Wed, 29 Sep 2021 15:17:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51C62F80161
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 15:17:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51C62F80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VggxSjaX"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 395E8611C8;
 Wed, 29 Sep 2021 13:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632921455;
 bh=/7ffRfO70FzWtNxTpBsYQ6/zH6FWWTHiDyUtdaVoxNM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VggxSjaXR3LQSOrES/Fvon5cf53q55be9Xwqlb67r6AmQoa/D+PywZcGiGnxyc8/M
 JMnbE/07Vc3r4f+wMc66bIVYFGWzk6jM58KMy204c38ODHx6fM5JKyDNy1B6VqOQbn
 /o/w9/CNRcGRYnNAHcWwPSYSTkh1Lm59FIJQBIu1xABqI09/zJhWs7mDMYdhvQU55E
 32pI3oXGw95sabLY2AJLE0Ztkuv1w/yqSqBcHVcxXy448+G3qbeT3QYu/hQfe3b9me
 KKi8xiBQqEUSXXRDa0/2LmOh88fp5WCogTZhThYk7vxaQDonvwtLopuK1IcfHo21fQ
 nvZ8xbFz0IuLg==
From: Mark Brown <broonie@kernel.org>
To: Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] ASoC: ti: Constify static snd_soc_ops
Date: Wed, 29 Sep 2021 14:16:44 +0100
Message-Id: <163292102842.46827.14999239239747146155.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929093121.21253-1-rikard.falkeborn@gmail.com>
References: <20210929093121.21253-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 linux-omap@vger.kernel.org
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

On Wed, 29 Sep 2021 11:31:21 +0200, Rikard Falkeborn wrote:
> These are only assigned to the ops field in the snd_soc_dai_link struct
> which is a pointer to const struct snd_soc_ops. Make them const to allow
> the compiler to put them in read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: Constify static snd_soc_ops
      commit: 5100436c27aafdbc860de17447862304c5639b60

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
