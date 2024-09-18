Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA712CCD19A
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2024 11:21:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE4F4AE8;
	Wed, 18 Sep 2024 13:21:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE4F4AE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1726658504;
	bh=Yj8yguq6fHMKpfy6cIyL/hq3Tishf6iAF3akjLIRzAg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jXG12hWttpUYwPtYM+cqalzj7BBXqmYSjMgmdSmXEBcjZq3eKx+EpZuPSVAGTz3gj
	 b61FXpO4ttb73L871jOBOFuh48k6r+UcydqjkKnS6hPPumZb0omx0yttO6LkW6Mzfv
	 oKzJb3Ua29n0mQiS0ZJGusvvHM+S3fl66q4K6ouM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3B9EF805B3; Wed, 18 Sep 2024 13:21:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AC57F80518;
	Wed, 18 Sep 2024 13:21:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88C9AF8020D; Wed, 18 Sep 2024 13:21:06 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AD2D6F80074
	for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2024 13:21:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD2D6F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RPXWnrZU
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CAD54A43816;
	Wed, 18 Sep 2024 11:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAE1C4CEC3;
	Wed, 18 Sep 2024 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726658461;
	bh=Yj8yguq6fHMKpfy6cIyL/hq3Tishf6iAF3akjLIRzAg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RPXWnrZUdCoH7kRrmZTLDcNq69Us/SfDSGuGYdpss6MCaDCz+FWMbG4pYdnV40pIU
	 kvMFA6NlCbwqGgkAjZDX93glz69CIYYmuU4MIhh+x1RHDmpL6x5bkWEwqwD6wY9NeT
	 LsFu/HPjU+knmG6EaaFb8WPnlt4na4hlUNe1ssPZ6hA8W0zN403g3vQb7t7uVoHwXs
	 6Q3T9pLxzn6qpM40Va23Q+hjdM1D2CaMeYRAuSlLccvvKkeoVfln24NcbitzBvn7/O
	 3AzKWoI/BSP/nvMEzUDbf1dddoi37NfgqxMEjxg/wns9yEggEMhKndxo5fhvjdAXJc
	 DJaqZK2lLbNLg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240916061318.3147988-1-Vijendar.Mukunda@amd.com>
References: <20240916061318.3147988-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: don't set card long_name
Message-Id: <172665845809.1795214.7985418215228293070.b4-ty@kernel.org>
Date: Wed, 18 Sep 2024 13:20:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12
Message-ID-Hash: GTQHPXJSC2B7FHHLQCG7COVQC5PKSBMT
X-Message-ID-Hash: GTQHPXJSC2B7FHHLQCG7COVQC5PKSBMT
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GTQHPXJSC2B7FHHLQCG7COVQC5PKSBMT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 16 Sep 2024 11:43:18 +0530, Vijendar Mukunda wrote:
> UCM can load a board-specific file based on the card long_name. Remove
> the constant "AMD Soundwire SOF" long_name so that the ASoC core can
> set the long_name based on DMI information.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: don't set card long_name
      commit: 8451a3c7879d8883fd3fbd9dd7cbe7ecc31e89ce

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

