Return-Path: <SRS0=/2j+=HM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A824C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 20:15:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EA064EE5
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 20:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EA064EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3ED5816F6;
	Wed, 10 Feb 2021 21:14:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3ED5816F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612988115;
	bh=iEOYZn8L7AitQnyhexhoCYUTH/xeBqcqQseFMRYwaTs=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u7GiTd0Erw0NtKQ83QkvpPUqQKXKRMV1wNTC96rCV36qmodY9B8m0J3GGsytbIoUe
	 raX0IuZkxD6Y0M/cjvfmIk+jvgW5oSSWF6rz5482omhWF1oayxnyhhnjXOfzeazX8D
	 cE10lM5dbWMFgPspGnY5cVq8KFmfYkfw9Pkn4LL8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E6A2F802D2;
	Wed, 10 Feb 2021 21:12:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20C61F802DB; Wed, 10 Feb 2021 21:12:52 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA250F8028B
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 21:12:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA250F8028B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ER7n+ENK"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CADCB64EDA;
 Wed, 10 Feb 2021 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612987967;
 bh=iEOYZn8L7AitQnyhexhoCYUTH/xeBqcqQseFMRYwaTs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ER7n+ENKccw1A+XwpgOdzgTccKmKT0gQF0JP12ztrSNsnMBglnTyw6BkowB/u9r6C
 jswUNlZrI2Y7BFlu4+9yzT38ImbomobBBe9lOANLFoDtWUmq5JlZv4I40WyLovykEJ
 mmEW66a8Erl4kB4bI6W0KS2hnt7h0yu/9W2iW50nmgnPfdyLKxet/6SdLlGK7IcQg/
 W3DEImXnX/b14UWV4LUCzcwuY/N5pduBrShqr5OkQ7QaH60tP6po1gUwWWJyda40sT
 KlY+J9ZUOJAh3UxXxMmeL/l3TRWRIZdUBrL8OuJwuCKtEEN5XpikRQ8rrnEUVvHzYo
 9VHgkrkKBYCPA==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20210204203312.27112-1-pierre-louis.bossart@linux.intel.com>
References: <20210204203312.27112-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: (subset) [PATCH 00/14] ASoC: SOF/Intel/SoundWire: add missing
 quirks and DMIC support
Message-Id: <161298789617.5497.4460102753147616155.b4-ty@kernel.org>
Date: Wed, 10 Feb 2021 20:11:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

On Thu, 4 Feb 2021 14:32:58 -0600, Pierre-Louis Bossart wrote:
> HP Spectre x360 convertible devices rely on a mixed SoundWire+DMIC
> configuration which wasn't well supported. This lead to the discovery
> that we missed the TGL_HDMI quirk on a number of Dell devices, the
> addition of DMIC autodetection (based on NHLT tables), the addition of
> new component strings needed by UCM, and work-arounds due to
> problematic DSDT tables.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[04/14] ASoC: Intel: sof_sdw: reorganize quirks by generation
        commit: 3d09cf8d0d791a41a75123e135f604d59f4aa870
[05/14] ASoC: Intel: sof-sdw: indent and add quirks consistently
        commit: 8caf37e2be761688c396c609880936a807af490f
[06/14] ASoC: Intel: sof_sdw: add quirk for HP Spectre x360 convertible
        commit: d92e279dee56b4b65c1af21f972413f172a9734a
[07/14] ASoC: Intel: sof_sdw: add mic:dmic and cfg-mics component strings
        commit: 209b0b0d8d5a469a2892ad51cb448811d00b4ff4
[08/14] ASoC: Intel: sof_sdw: detect DMIC number based on mach params
        commit: f88dcb9b98d3f86ead04d2453475267910448bb8
[09/14] ASoC: Intel: sof_sdw: add trace for dai links
        commit: 3827b7ca399245e609b3ca717550b0638d1f69cd
[10/14] ASoC: Intel: soc-acpi: add ACPI matching table for HP Spectre x360
        commit: 717a8fdd150c495cc202880cf6955294c7acae4f
[11/14] ASoC: SOF: Intel: SoundWire: refine ACPI match
        commit: 6f5d506d7ff1d9b1ffac0130f2958b9da41175f4
[12/14] ASoC: SOF: Intel: detect DMIC number in SoundWire mixed config
        commit: 7aecf59770920cce5ff6e94b3809574364178126
[13/14] ASoC: SOF: Intel: HDA: don't keep a temporary variable
        commit: b9088535e1021f11500f8417598b6af1f381f7dc
[14/14] ASoC: SOF: Intel: hda: add dev_dbg() when DMIC number is overridden
        commit: 026370cb5bd7ef7999bc4379ab89ffd7a73874f2

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
