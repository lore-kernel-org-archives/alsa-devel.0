Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07370C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 16:31:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30660208D5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 16:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30660208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74EB11732;
	Mon, 11 Jan 2021 17:30:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74EB11732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610382664;
	bh=G5+Z2c5y/qafwv2OenU6ckGI8gYAwBTeTauA6NsOeXw=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jfHaVNCYXQBRpRuYjgyqZYJcB0rDokUR5w7l1Jc0zWkDf4g9yqP86xt3oPLVVdEK1
	 qufofYZsvdRWaQ/IBmlde4KPmKt2RASCFVq3rKGANK1E3rYlfrRu6sY4nt+PznPv0y
	 8IQwdtS1D8zTE17HZ7H3ydMDtxocQFJ7F+ozSvS0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA16BF804D8;
	Mon, 11 Jan 2021 17:28:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C058F804CC; Mon, 11 Jan 2021 17:28:38 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6EFBBF804C2
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 17:28:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EFBBF804C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jlyL/Kar"
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1C9D22AAD;
 Mon, 11 Jan 2021 16:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610382513;
 bh=G5+Z2c5y/qafwv2OenU6ckGI8gYAwBTeTauA6NsOeXw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=jlyL/KarUMCerA5s1GvZDGI+MMvZwE5EMMAwM5K7exR2pspUYSqNioDDZDiXAYT1N
 1uK6KFuQvJsd7Ty8jLa02DcLNDpxijc5jxXGGp6wlba8n1iWlWjxPOv9ZMZhQuNsCs
 xZoqqc2bvEM+FfBJLUhRedfZ7KGVFjkOu0/tlqmKKbNsslFvhhsU9rlR+YhnMf7rPp
 PIW0kSJqm5DHoIY9d57+Y0/+lVaLbuZ7iFbPxz8Obf9JHdiESIYhnPBjMrbQcLvWAT
 Xo4AZUyCjEt/rtjQTu3Un6yqsO3PAbHieop5ftLjYpgmRvIo9QtfjwSag8iWEI6WMR
 NTsjoOaD1qP4A==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, oder_chiou@realtek.com, lgirdwood@gmail.com, tiwai@suse.com,
 Chris Chiu <chiu@endlessos.org>
In-Reply-To: <20210111054141.4668-1-chiu@endlessos.org>
References: <20210111054141.4668-1-chiu@endlessos.org>
Subject: Re: [PATCH v3 0/4] ASoC: rt5645: Enable internal mic and headset on
 ECS EF20
Message-Id: <161038245912.32701.12070464225959721815.b4-ty@kernel.org>
Date: Mon, 11 Jan 2021 16:27:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux@endlessos.org
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

On Mon, 11 Jan 2021 13:41:37 +0800, Chris Chiu wrote:
> These patches are trying to fix the jack detection and internal
> microphone problems on ECS EF20 series laptops which are empowered
> by Intel Atom x5-Z8350 CPU (CherryTrail) with Realtek rt5645 audio
> codec.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
      commit: 21f603482a6bdc4e7481f5a8e0e4b654d8d6e3a3
[2/4] ASoC: rt5645: Add ACPI-defined GPIO for ECS EF20 series
      commit: a4dae468cfdd90cdb08d96161482c23739dd636a
[3/4] ASoC: rt5645: add inv_hp_det flag
      commit: 28c988492cf65626d06ae32d7f20f1596c080667
[4/4] ASoC: rt5645: Enable internal microphone and JD on ECS EF20
      commit: 3ac2bfd52b7de6206b1e694a4e79a39d6106c961

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
