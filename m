Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90915C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:03:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1903A2067C
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="J2XiEsDX";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2UqYezM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1903A2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98D1917B9;
	Tue, 18 Aug 2020 19:03:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98D1917B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597770233;
	bh=c6gTr3KzJfv/fFxXcecxzQN77FTkZtezl4q3okO4iPA=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J2XiEsDXM+MUwarGDeoYJ69v0RQH0Yakggw6KTQSzFQXAVtnAKZkukOZogVRseAd1
	 /vMigB2oU9swUi+6wiZTEyqpTeMRpdWPCGQdazftXKLLHzqj8vGzUZ3ubM97lAlj8Z
	 5imVyHMpGd96RBnEFpbrKJGvXdeHC4vuEWTIGKh0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8553BF80342;
	Tue, 18 Aug 2020 18:55:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C900F80343; Tue, 18 Aug 2020 18:55:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3F81F80341
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 18:55:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3F81F80341
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="T2UqYezM"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5B3542080C;
 Tue, 18 Aug 2020 16:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597769725;
 bh=c6gTr3KzJfv/fFxXcecxzQN77FTkZtezl4q3okO4iPA=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=T2UqYezMUFrXWDhCtn2cp+ILVVCWBpYGxF7zPdvO1F1aYxQuV++XKxfK1VUPvtH+J
 Zb1sxppYNIodWeQW5+u4xNkPXMvFJcWe4Xp2nSK1rItEX6BaWf6bM9BtDE89UL1eY0
 Qnn7X7nzD2SKu5i39doS6KusX/mRJznD6vFg4Tb8=
Date: Tue, 18 Aug 2020 17:54:55 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200813175839.59422-1-pierre-louis.bossart@linux.intel.com>
References: <20200813175839.59422-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/5] ASoC: SOF/Intel: fix cppcheck warnings
Message-Id: <159776961932.56094.13912004080779932324.b4-ty@kernel.org>
Cc: tiwai@suse.de
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

On Thu, 13 Aug 2020 12:58:34 -0500, Pierre-Louis Bossart wrote:
> A small set of fixes to reduce the number of warnings.
> 
> Pierre-Louis Bossart (5):
>   ASOC: SOF: Intel: hda-codec: move unused label to correct position
>   ASoC: SOF: Intel: hda-codec: move variable used conditionally
>   ASoC: Intel: rename shadowed variable for all broadwell boards
>   ASoC: Intel: bytcht_cx2072x: simplify return handling
>   ASoC: Intel: sof_sdw: clarify operator precedence
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASOC: SOF: Intel: hda-codec: move unused label to correct position
      commit: 11ec0edc6408a739dffca34ebbbe921817c3b10e
[2/5] ASoC: SOF: Intel: hda-codec: move variable used conditionally
      commit: 2e3e0bc378f205370fc4c6dbd9374d66e803ce53
[3/5] ASoC: Intel: rename shadowed variable for all broadwell boards
      commit: 1e6444271c667d56f3a793cfc295b72a1f8007da
[4/5] ASoC: Intel: bytcht_cx2072x: simplify return handling
      commit: 9c7deb0576d7fe4370a23f4e127b2a69325f7ce9
[5/5] ASoC: Intel: sof_sdw: clarify operator precedence
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
