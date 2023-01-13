Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D3DC54EBE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Jan 2023 15:16:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DDF46D76;
	Fri, 13 Jan 2023 16:15:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DDF46D76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673622964;
	bh=D9GkIGSMBFxxdMCoDmGPDwQh4bCe5JTrqRSdiBrayjM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=kU+w8F50cS6LJwXUnaj2fbJMVjW0YUCf2nepmOJhFTWVw95z2+A+RWKmXhN7hCyEC
	 60HPbV4zxwfv0qIoGCMLM+8ZE3LEWA4Y+mTAQDwluAuaWxBY0DlYyy0Kc4Z99awDTv
	 ++hLKpfccdiKAY2S7Xw2SdtXA61bRRm6QrU/Faa0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C008F803DC;
	Fri, 13 Jan 2023 16:14:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9A58F8016D; Fri, 13 Jan 2023 16:14:47 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DCDBDF8016D
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2023 16:14:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCDBDF8016D
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tA9kvYxr
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5C6C4B82168;
 Fri, 13 Jan 2023 15:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75218C433F0;
 Fri, 13 Jan 2023 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673622881;
 bh=D9GkIGSMBFxxdMCoDmGPDwQh4bCe5JTrqRSdiBrayjM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=tA9kvYxr5sb0mkuvHUWiKGt/OE3o0HVHqvJfxtzql8bSXXx1wnrlIJkcCHSovHAHe
 0AqBHhPblqjjH3tG62lidLUT4r40wReIgHehqe0DKpORwk/ALlgJUZOzxf7WGjiY4a
 s9N2ltIjl3/QeRXySFj+zzW2jJV23IPlpeSdtQy+UQL8BQ0fQtmNgj+Fmn63CgHJaN
 nGSmrGmO/0iZLEYPXMYxLY+vzB9A7Uu/QR3LnSvYjWXUmehULhEB5qWLxYOU3VOIVQ
 OpioPn60kzoDZMwXMuMLlMakE3Z+8vedJMDKeMyHfE6zTaJ+yq7rO3G7TNqhICXlfe
 NxNXTNHiFEkvQ==
From: Mark Brown <broonie@kernel.org>
To: Amadeusz =?utf-8?q?S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230113191410.1454566-1-amadeuszx.slawinski@linux.intel.com>
References: <20230113191410.1454566-1-amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: avs: Use asoc_substream_to_rtd() to
 obtain rtd
Message-Id: <167362288019.139004.13546767194834121090.b4-ty@kernel.org>
Date: Fri, 13 Jan 2023 15:14:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12-dev-8b3d1
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, 13 Jan 2023 20:14:09 +0100, Amadeusz Sławiński wrote:
> Utilize the helper function instead of casting from ->private_data
> or snd_pcm_substream_chip() directly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: Intel: avs: Use asoc_substream_to_rtd() to obtain rtd
      commit: 8f28299f5cdcc6e7b6ed664364d1c76821896d07
[2/2] soundwire: Use asoc_substream_to_rtd() to obtain rtd
      (no commit info)

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
