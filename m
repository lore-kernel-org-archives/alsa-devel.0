Return-Path: <SRS0=Rjjp=GQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A323C433E6
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 15:29:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC881233ED
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 15:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC881233ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 084131706;
	Wed, 13 Jan 2021 16:28:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 084131706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610551768;
	bh=vxd/kqSo8bN8c/zk/ku4UDlXJMGZVRAHdZAV8MksMrE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A5ggAGBGrWdOB3z9n1zp6i5E51ErOUnbfOAEOtkV4Zwa8SmGuTsLj1lOBNKDH91l/
	 09knbIv850+LFUchfbo4qTXeHFmKoQNkR4KHcjoL5Jb/xBdZ1S20R1aVoePk7q8lkb
	 pNZtc+c1sgil5xY+kYfeDcPXPf4Dio3VLrunU9OE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC4DEF804CB;
	Wed, 13 Jan 2021 16:27:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A923F8026B; Wed, 13 Jan 2021 16:27:33 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9A43F80254;
 Wed, 13 Jan 2021 16:27:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9A43F80254
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RNF09ngm"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 360F9233EA;
 Wed, 13 Jan 2021 15:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610551642;
 bh=vxd/kqSo8bN8c/zk/ku4UDlXJMGZVRAHdZAV8MksMrE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=RNF09ngmseI9UabNoK5Vo4YTXrl8bOw2HXJhQ4ZYMb5ecL6c8XfI88+cB96dahPOq
 cH7MNioULHXyycATFBQzr/Y9PMNna4r1+OEq9uiyQN1KleHubpBAKgqj9plbRDC6C5
 lcMI1SDA67xZvCEqsxB0BWVLG693n/tqDMsL9igXqTeP0vkMFCVfDoY8GfIZ7zOzdy
 zxPpmDRkE7HMHbg426eQp9IUSsH7oK6zT13QXTnULG7hN2T9V1E2vkgNf1oYsk77Tl
 CNAOVgEW1dZxvX5qvJCiLVR0/xPF8co0R+nae5+9KtgRzF2+2Qn7q16sj2STyAPziR
 hEXS4ngRJ0qDg==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, kai.vehmanen@linux.intel.com,
 daniel.baluta@nxp.com, tiwai@suse.com, ranjani.sridharan@linux.intel.com,
 lgirdwood@gmail.com
In-Reply-To: <20210112181128.1229827-1-kai.heng.feng@canonical.com>
References: <20210112181128.1229827-1-kai.heng.feng@canonical.com>
Subject: Re: [PATCH v4 1/3] ASoC: SOF: Intel: hda: Resume codec to do jack
 detection
Message-Id: <161055160366.21623.4212588433578007556.b4-ty@kernel.org>
Date: Wed, 13 Jan 2021 15:26:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>,
 Rander Wang <rander.wang@intel.com>,
 Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE SOF DRIVERS"
 <sound-open-firmware@alsa-project.org>
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

On Wed, 13 Jan 2021 02:11:23 +0800, Kai-Heng Feng wrote:
> Instead of queueing jackpoll_work, runtime resume the codec to let it
> use different jack detection methods based on jackpoll_interval.
> 
> This partially matches SOF driver's behavior with commit a6e7d0a4bdb0
> ("ALSA: hda: fix jack detection with Realtek codecs when in D3"), the
> difference is SOF unconditionally resumes the codec.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: SOF: Intel: hda: Resume codec to do jack detection
      commit: bcd7059abc19e6ec5b2260dff6a008fb99c4eef9
[2/3] ASoC: SOF: Intel: hda: Modify existing helper to disable WAKEEN
      commit: 31ba0c0776027896553bd8477baff7c8b5d95699
[3/3] ASoC: SOF: Intel: hda: Avoid checking jack on system suspend
      commit: ef4d764c99f792b725d4754a3628830f094f5c58

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
