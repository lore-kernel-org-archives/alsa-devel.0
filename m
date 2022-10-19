Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B2BC4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Oct 2022 12:33:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2305445AE;
	Wed, 19 Oct 2022 14:32:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2305445AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666182804;
	bh=cY8wZfU94pF+CbYRDBS/AtJZE7KBiyDCZcUKpEcrAaU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eBUoLm+B1o6NpwPncfgWpH2FMZd3bVYXhyqgvqKTTPb4+6YOWOpKq5C0AWxDwZGi7
	 AB5UPSnmu5AT681+PP5uC/nV2SWB2n6U6F07/aJC+aNxlfAneMvv0JAQdSA7t5guJH
	 Gok4u5ILQihL0refocTVCQ1Aah0h3spBWmBoYF6c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 875B8F804F1;
	Wed, 19 Oct 2022 14:32:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79671F804FA; Wed, 19 Oct 2022 14:32:27 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73707F804E0
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2022 14:32:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73707F804E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WB2H5lnj"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 19C2BB822B9;
 Wed, 19 Oct 2022 12:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9599C433C1;
 Wed, 19 Oct 2022 12:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666182742;
 bh=cY8wZfU94pF+CbYRDBS/AtJZE7KBiyDCZcUKpEcrAaU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=WB2H5lnjf/NLOwXcgZsNEEbP10TRgFPndtMDrKQM9HciDpwKNlfrTpVmMlOEqSVWi
 ys0vWTXUqGpem5rxjHUtkp9xEDbWHHncwwrvxo4O/BRFN0LgRSXQ4hHAKV/q59VTbO
 hizjy28ZThMth0KtUmA4/+WvzzZJDDKrf2WP7ebPk6pkcEfDCVQTSZYjEJMWhEuy99
 pqtUfDdhPS6N0h5eUYc+nPTO6gM1r0IZIKwpoLfn1UVXDmV1r1RJFaDhX5gLOIe9Am
 HYP8Vz753BuQk1298duBuUX9UDZ6A4WdZ6x4yRvz4IE3ZBKGFZyiXaDyEW66V7w1ou
 LfQPLu3CPCQFw==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20221017204207.207608-1-pierre-louis.bossart@linux.intel.com>
References: <20221017204207.207608-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: Add quirk for Rex board
Message-Id: <166618274141.118898.18011052269054807686.b4-ty@kernel.org>
Date: Wed, 19 Oct 2022 13:32:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: tiwai@suse.de, Curtis Malainey <cujomalainey@chromium.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Yong Zhi <yong.zhi@intel.com>
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

On Mon, 17 Oct 2022 15:42:07 -0500, Pierre-Louis Bossart wrote:
> From: Yong Zhi <yong.zhi@intel.com>
> 
> Add mtl_mx98357_rt5682 driver data for Chrome Rex board support.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_rt5682: Add quirk for Rex board
      commit: b4dd2e3758709aa8a2abd1ac34c56bd09b980039

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
