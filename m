Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9B8C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Jan 2022 20:30:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58C2D1AB8;
	Thu,  6 Jan 2022 21:29:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58C2D1AB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641501042;
	bh=21uqmI0sF0iqFXzWvfwSr8yWzQwcFoXEvQOSpJlA73Q=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qkGPzZL8WvOKwM72gvYbmFKrj0k9C0cfkeMvrdpVMqdAr8HgEWvkD5PwJ66IZYSLO
	 U9NYNCIpeSia7t5mG5AQSetjmT7xkToIk9FyOtf9JUZpfrXd+vpFXEpCYrOAW3s5LF
	 38ulKl4FOoFDrswTBUv9UoB/SPg5B0K2L2LqkXKs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5E08F80516;
	Thu,  6 Jan 2022 21:28:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7D92F80518; Thu,  6 Jan 2022 21:28:27 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61CF7F80155
 for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2022 21:28:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61CF7F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="F+qwbyGH"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 7D836B823F8;
 Thu,  6 Jan 2022 20:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B656C36AE3;
 Thu,  6 Jan 2022 20:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641500897;
 bh=21uqmI0sF0iqFXzWvfwSr8yWzQwcFoXEvQOSpJlA73Q=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=F+qwbyGHuzSd59HvZAdcWL05m/1dwoHw0g/OWlN9NjtsNLYA9CjiZ2ElVAOi8ifoU
 nwjK6pBaLzl9SFkc64aiFm9xXA/60dEPD5gfqwFNH9Ja1YK+GMSCdk5QV54Gm3K5Lq
 x9wN2hC7VsVxD8mKZpexdSqzLaCZoixn7AOiYc1YrO1/PSpONTvYJtNOCNe76RdbWL
 00LAaDGFeYt1WoPPpAmE0J8p5+xuLVnLB7jyIwYoJydwywAweOIBdZ5DmzezjNWGTV
 6/WHdrxYrWqndNnjrbAlWzgPj4yMz7CWcbQyHCiYvRGKunDcR+7p3bQmPPBO9u/ZM2
 SBTXbdFyaBxBg==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, tiwai@suse.com, Xiubo.Lee@gmail.com,
 alsa-devel@alsa-project.org, festevam@gmail.com, nicoleotsuka@gmail.com,
 timur@kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1641292835-19085-1-git-send-email-shengjiu.wang@nxp.com>
References: <1641292835-19085-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/3] ASoC: imx-card: several improvement and fixes
Message-Id: <164150089509.2243486.810361187856950551.b4-ty@kernel.org>
Date: Thu, 06 Jan 2022 20:28:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Tue, 4 Jan 2022 18:40:32 +0800, Shengjiu Wang wrote:
> Several improvement and fixes for AK codecs supported on i.MX platfroms
> 
> Shengjiu Wang (3):
>   ASoC: imx-card: Need special setting for ak4497 on i.MX8MQ
>   ASoC: imx-card: Fix mclk calculation issue for akcodec
>   ASoC: imx-card: improve the sound quality for low rate
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: imx-card: Need special setting for ak4497 on i.MX8MQ
      commit: 3349b3d0c63b8b6fcca58156d72407f0b2e101ac
[2/3] ASoC: imx-card: Fix mclk calculation issue for akcodec
      commit: f331ae5fa59fbfb748317b290648fc3f1a50d932
[3/3] ASoC: imx-card: improve the sound quality for low rate
      commit: 3969341813eb56d2dfc39bb64229359a6ae3c195

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
