Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9407C6FA92
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Sep 2022 10:36:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D79C0F3;
	Tue, 27 Sep 2022 12:35:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D79C0F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664274963;
	bh=0r0L2iUcElk7msgyXX001Y0IZKkcWjtg+9SlV70egg4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2JOzLaM+Yag+MUZ3SZP4Op+8z4gCVAP2mk2arPFOirpJ6i0EHJZqpWEAaEGFdb86
	 0ErLkNIUfhOT48D17NepZJbWC3eUgqKA3adERiFn+fPpzUPsACq3Hp1wJV38dTyWsQ
	 heVvtsfyb5mTayOEKnhseIcQ8kDgi58Ab/hhPkVo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 196A0F80539;
	Tue, 27 Sep 2022 12:34:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9F90F80508; Tue, 27 Sep 2022 12:34:24 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29F0DF80166
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 12:34:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29F0DF80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kr3AUvhD"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4ADD5617B0;
 Tue, 27 Sep 2022 10:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B36C433D6;
 Tue, 27 Sep 2022 10:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664274859;
 bh=0r0L2iUcElk7msgyXX001Y0IZKkcWjtg+9SlV70egg4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=kr3AUvhDPsOXlpDZoHG/I2hJFICJspmZ6X6g8VC0UsjRTEpF9wGD3U/nddsFdDO3b
 pCjSDIdRs0DHKsLwW8frw16jgHMAoqUdcp8EK8YtiYxKzIV0HAhmIlAy2/n44nyMHC
 Z/RW+vY2sHMGS2tHqQEWvtL+2q3fGx2b3SERHVzerc8zr7ycxXs4UkKMirDH9HlaEV
 waqeD+M6R5w4hIYM9D3oyy8eSfqgfnnsP+2yPwvEIdCzn5p/rBNIcnWTwsQzNb6qAy
 K/lmblp6Px0LXR0sQgRmDa7EsHZiedUoQFNZ5OjCyJXxG+gpi0+l65hNim2CCLQDmw
 vv+Kx0Ovv+TaA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20220916140757.681414-1-yangyingliang@huawei.com>
References: <20220916140757.681414-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: Intel: skylake: remove unnecessary
 dev_set_drvdata()
Message-Id: <166427485820.60697.7549055145038298678.b4-ty@kernel.org>
Date: Tue, 27 Sep 2022 11:34:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: tiwai@suse.de, cezary.rojewski@intel.com,
 pierre-louis.bossart@linux.intel.com
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

On Fri, 16 Sep 2022 22:07:57 +0800, Yang Yingliang wrote:
> Remove unnecessary dev_set_drvdata() in skl_remove(), the driver_data
> will be set to NULL in device_unbind_cleanup() after calling ->remove().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: skylake: remove unnecessary dev_set_drvdata()
      commit: d508260e89a7d1889bbb5788fdfc52cc3eb8ddb6

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
