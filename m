Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE1AC6FD1D
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Mar 2023 16:41:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4770BEF4;
	Fri, 17 Mar 2023 17:40:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4770BEF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679071309;
	bh=SP37QSQ22tFUndVvB7qLuAqWvKKJ/HHqicul5W/eoBw=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eRGAzBqpoYBjzkoseqARl9Dke09HJik9vu5RXS+97+RglWlEVIU2IOi3BKeS4Rzax
	 H4Adx6157yzJ70cIGIyysweHizcWZND2YdCn6AwCygsQckVuRAn61oEFA9DrEgZRIi
	 fB/YaPASkbR/zCRAOxrR4gCVdrzDL5ZxuiX7fKVA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C9CAF80520;
	Fri, 17 Mar 2023 17:40:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4E13F80534; Fri, 17 Mar 2023 17:40:50 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 399D4F80093
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2023 17:40:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 399D4F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PY3GarHe
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 91EFEB824F7;
	Fri, 17 Mar 2023 16:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7AAC433D2;
	Fri, 17 Mar 2023 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679071242;
	bh=SP37QSQ22tFUndVvB7qLuAqWvKKJ/HHqicul5W/eoBw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PY3GarHeJCdld/Xc2eoytQNoKXG4piaO8m+b2XH7eUe3HCZxUQXHF6w9nKtxiE2l6
	 A/VjRoVDFYEovFrB75RaeFSxqe6uhZyoqAg5Xne7vb59+Swx4rU5ncenNp34L5rQIp
	 NYEE5N4Jpkuxdg6gRK0mXuYP/xcQHeg4PfeWkvstxdDcpYtO7G42f0FMRYGniToKdk
	 /exi1lW/dU9s7eZPzVNrgLsImxuWiGPzJqkr3xnSROqOgQ813Ya3G9Cxg1LqJPAb1a
	 243bjLbIsFijyFIGKkeYq89CMuigJ7BEbbi6d5FjzBwP4/VQY3Bp9Lal+lRlx76nM2
	 NbNnMUpJLyDxQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230316141458.13940-1-peter.ujfalusi@linux.intel.com>
References: <20230316141458.13940-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: ipc4: upport multiple configs for BE
 DAIs
Message-Id: <167907124083.46507.10954755361747629514.b4-ty@kernel.org>
Date: Fri, 17 Mar 2023 16:40:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
Message-ID-Hash: UMXMQ73GNFUKQZYSWNZVEF4A55LCQGP3
X-Message-ID-Hash: UMXMQ73GNFUKQZYSWNZVEF4A55LCQGP3
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.com, kai.vehmanen@linux.intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UMXMQ73GNFUKQZYSWNZVEF4A55LCQGP3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 16 Mar 2023 16:14:56 +0200, Peter Ujfalusi wrote:
> Backend DAIs may support multiple audio formats. Modify pipeline setup to select
> a suitable configuration based on topology and frontend DAI runtime configuration.
> 
> The prime use case is BT offload support where we need the abality to select
> different configuration on the BE side.
> 
> Regards,
> Peter
> --
> Kai Vehmanen (2):
>   ASoC: SOF: ipc4-pcm: support multiple configs for BE DAIs
>   ASoC: SOF: ipc4-topology: use common helper function in copier prepare
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: ipc4-pcm: support multiple configs for BE DAIs
      commit: 279e52d6b9f366f9930a0f90ee84e7d0a6a27b26
[2/2] ASoC: SOF: ipc4-topology: use common helper function in copier prepare
      commit: 37ec7ab49f951ef8c38102328b84d3dc7155dc68

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

