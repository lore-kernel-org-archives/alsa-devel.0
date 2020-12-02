Return-Path: <SRS0=YmRK=FG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4522C64E7C
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 17:20:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A04321D42
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 17:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A04321D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31EE7178F;
	Wed,  2 Dec 2020 18:20:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31EE7178F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606929652;
	bh=LN8JsVr8xfkCSHAtJt40KEro5mWD1yQq9wDL1JE/psc=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e2ZaZ0EahUj3vURU2bhQyW4AqVcXJRkaL4BtRQAkK7Zfpq0EXyoL1eGvoDOXQ0IiP
	 pm/9Ezjbo8x/Kk48g0bA5lf9QJ7Z4j/I7dSOucwEBpTpTh1iq0b6Fa8mWxxglm9Leb
	 3wG8pxImhs7SOl4pkaWxFCCbjEcLz7Z2msvi9eeM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 973CFF8025F;
	Wed,  2 Dec 2020 18:20:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D559BF8026B; Wed,  2 Dec 2020 18:20:00 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51A8FF80168
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2020 18:19:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51A8FF80168
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20201201211150.433472-1-ranjani.sridharan@linux.intel.com>
References: <20201201211150.433472-1-ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Boards: tgl_max98373: update TDM slot_width
Message-Id: <160692956495.33960.8249694735993878352.b4-ty@kernel.org>
Date: Wed, 02 Dec 2020 17:19:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On Tue, 1 Dec 2020 13:11:50 -0800, Ranjani Sridharan wrote:
> Speaker amp's SSP bclk configuration was changed in the topology file to be
> based on 12.288MHz and dai_ops->hw_params is based on s32le format.
> But, the TDM slot size remained set to 24 bits.
> This inconsistency created audible noises and needs to be corrected.
> This patch updates TDM slot width to 32.
> 
> Fixes: bc7477fc2ab4 ("ASoC: Intel: Boards: tgl_max98373: Update TDM configuration in hw_params")

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Boards: tgl_max98373: update TDM slot_width
      commit: 0d7f2459ae926a964ab211aac413d72074131727

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
