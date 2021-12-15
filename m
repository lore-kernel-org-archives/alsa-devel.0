Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB06C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Dec 2021 02:06:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 845DD1FEE;
	Wed, 15 Dec 2021 03:05:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 845DD1FEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639533973;
	bh=TOjtb2aoJCE2pXxO6BztrEzxcbnx3/8gLisrRtT+7d8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LpqLbq/o+c+eeTZo3YVDCiPJkZQNyko9VjGiEcSJ+V0+ti7mYc2JKnKTbA/+xET0h
	 TyxL4bAuKg3/Yfvf9DBykroCNU/GtQ8a9TDyhGOYvK4erwc/ugZeZiCCxgZLFZzLWE
	 kogkRZdKjhIBoIWo6tQQN1SsY68ib4IOIOTCOpwU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F3E4F8051A;
	Wed, 15 Dec 2021 03:04:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DCF9F8051B; Wed, 15 Dec 2021 03:04:14 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F3E8F80516
 for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2021 03:04:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F3E8F80516
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GkqHt4YA"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C869F61798;
 Wed, 15 Dec 2021 02:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C80C34601;
 Wed, 15 Dec 2021 02:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639533847;
 bh=TOjtb2aoJCE2pXxO6BztrEzxcbnx3/8gLisrRtT+7d8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=GkqHt4YAVUbxahzZiuhPY9tPPoQkLsU+EFYlRaMxLDZMRSgD6IG/ZWTXj1Vi8gt0D
 wpj0B3LKcIMAvvFQktHH9bPFNkUjEi8eBsUrFpTb08SSY4bjfsUcSTYVCzVmKsPwHI
 8X07HiBStSQyVu0QeqbmmczJU/RTuKoZNu0PwYPgxIHlP4wsHMh8zlUHlbaFQ8V/rI
 bN2GY8PyqeS6/hzTxAmIWlv0wuzRn+OUgOVCqCnAQM5/p8Duu6ZEuLOaqNC2EIlrCx
 f9/ogrzOxET5oBXGlBSVI26RhZbCpQTDQIb0U0n2KvJZCZgVg7yissxk1xWrh1gZj/
 ZFtYrxkn0TBew==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20211207173745.15850-1-pierre-louis.bossart@linux.intel.com>
References: <20211207173745.15850-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/6] ASoC : soc-pcm: fix trigger race conditions with
 shared BE
Message-Id: <163953384515.1515253.13641477106348913835.b4-ty@kernel.org>
Date: Wed, 15 Dec 2021 02:04:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 Sameer Pujar <spujar@nvidia.com>, linux-kernel@vger.kernel.org,
 vkoul@kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
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

On Tue, 7 Dec 2021 11:37:39 -0600, Pierre-Louis Bossart wrote:
> We've been adding a 'deep buffer' PCM device to several SOF topologies
> in order to reduce power consumption. The typical use-case would be
> music playback over a headset: this additional PCM device provides
> more buffering and longer latencies, leaving the rest of the system
> sleep for longer periods. Notifications and 'regular' low-latency
> audio playback would still use the 'normal' PCM device and be mixed
> with the 'deep buffer' before rendering on the headphone endpoint. The
> tentative direction would be to expose this alternate device to
> PulseAudio/PipeWire/CRAS via the UCM SectionModifier definitions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure
      commit: d8a9c6e1f6766a16cf02b4e99a629f3c5512c183
[2/6] ASoC: soc-pcm: align BE 'atomicity' with that of the FE
      commit: bbf7d3b1c4f40eb02dd1dffb500ba00b0bff0303
[3/6] ASoC: soc-pcm: Fix and cleanup DPCM locking
      commit: b7898396f4bbe160f546d0c5e9fa17cca9a7d153
[4/6] ASoC: soc-pcm: serialize BE triggers
      commit: b2ae80663008a7662febe7d13f14ea1b2eb0cd51
[5/6] ASoC: soc-pcm: test refcount before triggering
      commit: 848aedfdc6ba25ad5652797db9266007773e44dd
[6/6] ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE
      commit: 3aa1e96a2b95e2ece198f8dd01e96818971b84df

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
