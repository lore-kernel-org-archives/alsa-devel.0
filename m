Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D426EC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Dec 2021 18:37:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6DD426F1;
	Wed,  1 Dec 2021 19:36:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6DD426F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638383823;
	bh=8QeTRR6fzbW3YoUdz05s4uoxupr6A3ZHABdEKS5V9Dg=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XEGBV6Tbpw0tSLz04WXJ1EZ/E+IEtjAJhGDqyRyl9qgwykhYlwbuQlkEap9IBCVi1
	 7PD1R9rn/zIhe6pvuKE6pmUXaPrakEr0AHvaaHS0s79wl5GtGWSvtsgEyEbqbHaUhl
	 7HzLF5Ds+1IXRENovlGfXZV1O+atBbWfFN/zaO8k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50594F8053D;
	Wed,  1 Dec 2021 19:32:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 692B7F80542; Wed,  1 Dec 2021 19:32:30 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06859F80538
 for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2021 19:32:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06859F80538
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uBi1dA24"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E7DDCB820D0;
 Wed,  1 Dec 2021 18:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46D9C53FD0;
 Wed,  1 Dec 2021 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638383546;
 bh=8QeTRR6fzbW3YoUdz05s4uoxupr6A3ZHABdEKS5V9Dg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=uBi1dA24wNF5B9tBTaVUh5fYvwRi+pViAkAyYfZDTypTtrzxTLi+QBODQ1l+gYRJT
 BrXMz/ToKakeZRJWOqeZB3cjN6vZv46nQY/mqTNVeTaOzHudv29qHLmsu1Tx/kOrPP
 8g7XRSsrMc3M4BzC1WhMKAPcinmMOjIp04NJny4SfP0P1go34n+LaQpUHSGwRcX7uX
 c/lPzuiFPUMQH1ixZEKOEcN83AYl6fYPAndecKangqzXq37skBXQ7Wbt+UydUXTkVT
 rvwcw7TC56hv+GmV3oUV7xui9/k/jTPImocbkJ/NiLGcGBZjgYDNxyWyd77EjMLE4k
 0d5XZ5dfuclVQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, Sameer Pujar <spujar@nvidia.com>,
 tiwai@suse.com
In-Reply-To: <1638278605-28225-1-git-send-email-spujar@nvidia.com>
References: <1638278605-28225-1-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH v2] ASoC: tegra: Add master volume/mute control support
Message-Id: <163838354459.2179787.6061621614012995607.b4-ty@kernel.org>
Date: Wed, 01 Dec 2021 18:32:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 thierry.reding@gmail.com, linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

On Tue, 30 Nov 2021 18:53:25 +0530, Sameer Pujar wrote:
> The MVC module has a per channel control bit, based on which it decides
> to apply channel specific volume/mute settings. When per channel control
> bit is enabled (which is the default HW configuration), all MVC channel
> volume/mute can be independently controlled. If the control is disabled,
> channel-0 volume/mute setting is applied by HW to all remaining channels.
> Thus add support to leverage this HW feature by exposing master controls
> for volume/mute.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: Add master volume/mute control support
      commit: 0d242698fa693ab8cb98c11ba7cf7fc8f7242c0b

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
