Return-Path: <SRS0=EWQz=PB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E4CC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 20:02:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE3A60D07
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 20:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BE3A60D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 988BB168E;
	Wed, 13 Oct 2021 22:01:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 988BB168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634155319;
	bh=ywp+O16zxyBQI01Bzx+Q5zw0Ksa0nuT8E8DGdvjOEAI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dnImQWfAA0q6ksyrNF8DDkGc8OIskPp6JMEGvISGMVPlFEHet8HNokBfDVjcu1lsR
	 M5hPdr5kDPhU90fedvwlvVZjqEIhsXAzEe8fxuPmui8cqgYwRK8ot8GO70uvLjPYp5
	 T1lQAnKxij8eFlSkskwwqUjEsmT4HHGixrAmwdic=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42044F804E4;
	Wed, 13 Oct 2021 22:00:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E0C5F804B4; Wed, 13 Oct 2021 22:00:20 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B87C1F800C0
 for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2021 22:00:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B87C1F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AGJhvT4i"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D99D611CB;
 Wed, 13 Oct 2021 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634155214;
 bh=ywp+O16zxyBQI01Bzx+Q5zw0Ksa0nuT8E8DGdvjOEAI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AGJhvT4i7Rkz1UcTvHCsGIsOR2YiqEeZsZjPQI0SIKeDQP7Xu/iO4Atz4ifrhkX+a
 34TZpzZB6cSHSHdR4k/O+js8XKeuljy+v7dmkpzsX3t6t2lfRD50eENQ0ZDlhWShU+
 THNhMSHFlcb6+NOc/I+BN6qaSok8VAuZDFu3Fp/ovrAQJY4Zq9o7jNpXZwxxZFqx4A
 pppASbbtzeq7UswC0ZIiDDlMVPBqHrO7WC212f/0GzHsXKSJ/x3oTPhNEScBovO3SJ
 /7JlN9vfUTh+SCVh2BwcIjjpwfhLDmSqfOndKZgX1jG7QWvJuuUc830VAyt64GNd+J
 VfXFPuKl8XyAA==
From: Mark Brown <broonie@kernel.org>
To: kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
 tiwai@suse.com, lgirdwood@gmail.com, patches@opensource.cirrus.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, ckeepax@opensource.cirrus.com,
 perex@perex.cz, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] ASoC: wm8960: Fix clock configuration on slave mode
Date: Wed, 13 Oct 2021 20:59:50 +0100
Message-Id: <163415517074.1358186.2537803193300280145.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1634102224-3922-1-git-send-email-shengjiu.wang@nxp.com>
References: <1634102224-3922-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

On Wed, 13 Oct 2021 13:17:04 +0800, Shengjiu Wang wrote:
> There is a noise issue for 8kHz sample rate on slave mode.
> Compared with master mode, the difference is the DACDIV
> setting, after correcting the DACDIV, the noise is gone.
> 
> There is no noise issue for 48kHz sample rate, because
> the default value of DACDIV is correct for 48kHz.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8960: Fix clock configuration on slave mode
      commit: 6b9b546dc00797c74bef491668ce5431ff54e1e2

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
