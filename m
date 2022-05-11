Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B870C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 11 May 2022 18:27:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 800541A60;
	Wed, 11 May 2022 20:26:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 800541A60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652293630;
	bh=OAFl+ihsmj9j/cuwcDlnF15uJDEMS+2Xkfv6qIxnMiU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ego+9QjNPHvuc8tqoLSXUFJLaAEVG7XqTcsFZeLEThfH0jj2GepBSA37KEvftfNlQ
	 31KG22/cLwPhv2wLXPH1KYFD9esG9D+9g7rwSHsMTEVxoBZjU6b34HmGuqGfNUrgk/
	 OA0L69OSbWXt2dWKjlkOVmzVI7N3EBVPR1TmP0rY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 097BAF80137;
	Wed, 11 May 2022 20:26:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72DC5F8015B; Wed, 11 May 2022 20:26:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E175EF8011C
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2022 20:26:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E175EF8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="sgtP8z1g"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A915961DD0;
 Wed, 11 May 2022 18:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CB0C340EE;
 Wed, 11 May 2022 18:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652293570;
 bh=OAFl+ihsmj9j/cuwcDlnF15uJDEMS+2Xkfv6qIxnMiU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=sgtP8z1gkBvOtPY2NfAM4R5uflqBEAsSJnQ0+IsQMa1zVsr0uVO7uE4xkTjX8u8AW
 xQ3Y181sa4fRBZwtDrG/Cvf/1f+DUi4U1gPJunr2FpaEUgsgqBXisF4X8tNLTJHnKu
 Rf4fcghiFngFeoeHw/vVDMd3UVzQ5lHH8aTWPMygjMzdZWzrTrweL9B93agBqxGjzl
 JMAxEYGQEM2Ubrssr7clAqB1sAV3sqR51babzmv5xqux+y4rNPAST57evKaMh/g/BS
 w+o3sVbvUDwbkA9aZtFwSCl4GmvAE+PU2u152q3f/SFru92kq+cjMwoHGUMRveUree
 knbK0vZslDHhw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
In-Reply-To: <20220509170922.54868-1-pierre-louis.bossart@linux.intel.com>
References: <20220509170922.54868-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/3] ASoC: Intel: boards: Chromebook configuration updates
Message-Id: <165229356912.325367.13121103179347675425.b4-ty@kernel.org>
Date: Wed, 11 May 2022 19:26:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 9 May 2022 12:09:19 -0500, Pierre-Louis Bossart wrote:
> two minor changes to enable DMIC and capture for CS35L41, and one new
> configuration for AlderLake hardware.
> 
> Brent Lu (2):
>   ASoC: Intel: sof_ssp_amp: fix no DMIC BE Link on Chromebooks
>   ASoC: Intel: sof_ssp_amp: enable capture stream from cs35l41
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: Intel: sof_rt5682: Add support for adl_rt1019_rt5682s
      commit: 0b56ed197d7df394fc4918bfea0f77e6192996b0
[2/3] ASoC: Intel: sof_ssp_amp: fix no DMIC BE Link on Chromebooks
      commit: d1c808765deb2bcd35d827402ed4d75d068aae18
[3/3] ASoC: Intel: sof_ssp_amp: enable capture stream from cs35l41
      commit: cebbefbd22d5afd161a4762ced7212c10971d011

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
