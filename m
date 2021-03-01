Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12839C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 23:39:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8276146B
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 23:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8276146B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7AA3167F;
	Tue,  2 Mar 2021 00:38:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7AA3167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614641937;
	bh=vcYL7YMP9HvSzovVECCPSXUlqwqpx9BUE6LKvKNX608=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OzXKFXG4pHFSC86YDp7mBWmXJ1tVfBgxih83X3L9//gpuKrpwVHFdYcr0G1h7cJLC
	 LIExoTIJO9Gjunl/xzkrCGnrISp9th/VgZ/bSMWF+Z1xX7hakMtrXp3qVR0vRTRC9I
	 JG+OOUNi7HwafIThUR73jMLckdptnnCaGH2SxB2I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06621F80482;
	Tue,  2 Mar 2021 00:36:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C5AAF8042F; Tue,  2 Mar 2021 00:36:13 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3E73F8042F
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 00:36:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3E73F8042F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bHfNrhZ3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E584B60249;
 Mon,  1 Mar 2021 23:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614641769;
 bh=vcYL7YMP9HvSzovVECCPSXUlqwqpx9BUE6LKvKNX608=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=bHfNrhZ3xSP2veYUc7s/qZahXstxzOZ4RqeIuxdLEDd+UNBgvK8RgUlabYfKU7Tzp
 TP6ul+gy0freu/tDOEXb/hCWnwyWw2PBDDlsmP6mO+B/MbchlTvIOxySYOmQc8Ok+K
 TgXfoaTtqds3aGOmtnutb0zTcYz7FT0/KuAIRieoyx/9A7KycjUq6k/93v+v8DIo6h
 J0FhZZ9yB5Ry+SkeESG3+vQ5HrLLEWHrGHpvAtk1BzdbRPEyDTQW2YdgkG80n7YJWk
 hvzCnz5l6U9dnviiKcK7flgYndy2mrksl5YjKOnPkDlmZ9nX3poeu3QyV0uWojiXcy
 6qsFMu630++9w==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
References: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/9] ASoC: fsl: remove cppcheck warnings
Message-Id: <161464168098.31144.13269030740591647542.b4-ty@kernel.org>
Date: Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org
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

On Fri, 19 Feb 2021 17:29:28 -0600, Pierre-Louis Bossart wrote:
> Nothing critical and no functional changes.
> 
> The only change that needs attention if the 'fsl_ssi: remove
> unnecessary tests' patch, where variables are to zero, then tested to
> set register fields. Either the tests are indeed redundant or the
> entire programming sequence is incorrect.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: fsl: fsl_asrc: remove useless assignment
      commit: ca289c2c70c131dc2d4a37e5f6f5c71acfc7cb8b
[2/9] ASoC: fsl: fsl_dma: remove unused variable
      commit: faff74679f510b9e469238b8ff610eb2b8ad5602
[3/9] ASoC: fsl: fsl_easrc: remove useless assignments
      commit: e80382fe721f71100cd49e209fbac260042a0106
[4/9] ASoC: fsl: fsl_esai: clarify expression
      commit: e7347520a4323fafea1df84abb29ae979c595931
[5/9] ASoC: fsl: fsl_ssi: remove unnecessary tests
      commit: e06a8f1a7c4ceb9f3f804bbe5e2fd25230bc91b1
[6/9] ASoC: fsl: imx-hdmi: remove unused structure members
      commit: 40e2c4450a34429b6343a7c8f80b4c6715bbd393
[7/9] ASoC: fsl: mpc5200: signed parameter in snprintf format
      commit: 5a6d43108095c2bb94947ccf3f53a7e71ae5774e
[8/9] ASoC: fsl: mpc8610: remove useless assignment
      commit: 3fb0dcec3e60466afd6a3d770c06a8a879160f68
[9/9] ASoC: fsl: p1022_ds: remove useless assignment
      commit: bafe21c9d01b3f39d26ff6271905c5c9ef00dc44

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
