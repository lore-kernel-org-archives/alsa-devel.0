Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A01C352A1
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Dec 2022 17:39:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1DED17E7;
	Wed,  7 Dec 2022 18:38:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1DED17E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670434779;
	bh=qSza4H82mdMpbCFfcyf6/rY8vJ/rlTzfwv8qc4wJ898=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YuQ/VGRoDQ4A1ePLz8kRKk6P5/CQI+aJfPshN8P4k+lGWpgeAqGr23OzkOEqVC6WZ
	 i8GQrNnv1DOF8bfQL0VFcPpMYS+r2sCclvgW8A8mVf3A8dn+PVioSe+NILD+iiR78J
	 AP8tkaVFfWVxnO1FCAIH5JVdwsDH0DpyAn8MN6Mg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9A32F8056F;
	Wed,  7 Dec 2022 18:37:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C5FEF80567; Wed,  7 Dec 2022 18:37:54 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 603CCF80567
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2022 18:37:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 603CCF80567
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VMNINyvg"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id F2981B81FE9;
 Wed,  7 Dec 2022 17:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E89FC433D6;
 Wed,  7 Dec 2022 17:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670434669;
 bh=qSza4H82mdMpbCFfcyf6/rY8vJ/rlTzfwv8qc4wJ898=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=VMNINyvgSLOgWcwHRpomCG5dTh6aVNzHk0GL8UolqwWzW0Eilb/1IKwDhPlsFLJcH
 E3sAb2RDsCRKg5QKU0nP6Doiw8JPBRgwAUA/7+VDJfCHq2RHzyVzGTFYk+NI6zSAaA
 0tgSu/Ts6qbKQOi8/gpN/5mE6O97+MkEpQ8AJCf4xilpmYALC4Gom+RXDn5sLZ/I9A
 faxx+rio4a9aLoac+o1bW2DIsoxBV2tJQczyzv1eHfLjbxcxe4uXa1plKihXnBFCwd
 71wpsWCZookvWCZemhhRxvcbACc5MX+vtIOiS+lWrUSrQwqPf1IWjxAQh5OTc0UnED
 aVObzXKTvh4DQ==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20221205085330.857665-1-cezary.rojewski@intel.com>
References: <20221205085330.857665-1-cezary.rojewski@intel.com>
Subject: Re: [PATCH v2 0/6] ASoC: Intel: Skylake: Topology and shutdown fixes
Message-Id: <167043466737.393374.2015082133648997354.b4-ty@kernel.org>
Date: Wed, 07 Dec 2022 17:37:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-b77ec
Cc: upstream@semihalf.com, rad@semihalf.com,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com, cujomalainey@chromium.org,
 lma@semihalf.com
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

On Mon, 05 Dec 2022 09:53:24 +0100, Cezary Rojewski wrote:
> Even though skylake-driver is going to be replaced by the avs-driver,
> the goal is to keep it functional on all the configurations it supports
> until its EOL. When comparing chrome trees against upstream
> skylake-driver, couple fixes pop up that are not part of upstream
> repository. These fixes are backed up by real bugs (issue trackers),
> address real problems. There is no reason for them to stay in the
> internal tree.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: Intel: Skylake: Update pipe_config_idx before filling BE params
      commit: 72d9a541d7f186f0ec97c71ba7e477dd9bf4155f
[2/6] ASoC: Intel: Skylake: Remove skl_tplg_is_multi_fmt()
      commit: b0d16e54e7559f2055123ea7b1d9ff1bb808ebad
[3/6] ASoC: Intel: Skylake: Drop pipe_config_idx
      commit: 75ab3c00769009e32e5cf51c8b503de4f73114e4
[4/6] ASoC: Intel: Skylake: Introduce single place for pipe-config selection
      commit: 4ac587f3578c5ca490e4df55af6403f5474eb2f0
[5/6] ASoC: Intel: Skylake: Fix driver hang during shutdown
      commit: 171107237246d66bce04f3769d33648f896b4ce3
[6/6] ASoC: Intel: Skylake: Use SG allocation for SKL-based firmware load
      commit: 451d85c46cf719a09a052510d4d4cd920103163a

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
