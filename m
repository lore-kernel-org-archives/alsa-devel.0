Return-Path: <SRS0=YmRK=FG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB0C64E7B
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 17:22:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E49321D42
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 17:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E49321D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A5B417F1;
	Wed,  2 Dec 2020 18:21:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A5B417F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606929756;
	bh=bVY3sAk1njpoiqn0R6N9BqRzm96U3Hsx0C9NvMMzwtk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RYdvNihqgUv3v9627pbZvOqBaUEipB5ccqOvIGTtusHEPwzxbTlXPeIWeKPrwrLEo
	 bmluYLZStkgVMoV4UC20CWtVMpbdvcdv6pBOa+aKsC7GKjjRf8oAMupp92VRAf7kxl
	 HUwAtMIDoAd0A1xw4NOpL1m7Y6o03CqEbvkLrdgU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69FC6F804D2;
	Wed,  2 Dec 2020 18:20:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86D81F804D6; Wed,  2 Dec 2020 18:20:21 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25F24F804CB
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2020 18:20:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25F24F804CB
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Bard Liao <yung-chuan.liao@linux.intel.com>, alsa-devel@alsa-project.org,
 vkoul@kernel.org
In-Reply-To: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
References: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
Subject: Re: (subset) [PATCH v2 0/5] regmap/SoundWire/ASoC: Add SoundWire SDCA
 support
Message-Id: <160692956495.33960.17128508922677938348.b4-ty@kernel.org>
Date: Wed, 02 Dec 2020 17:19:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, ranjani.sridharan@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, hui.wang@canonical.com,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

On Mon, 30 Nov 2020 22:40:15 +0800, Bard Liao wrote:
> The MIPI SoundWire Device Class standard will define audio functionality
> beyond the scope of the existing SoundWire 1.2 standard, which is limited
> to the bus and interface.
> 
> The description is inspired by the USB Audio Class, with "functions",
> "entities", "control selectors", "audio clusters". The main difference
> with the USB Audio class is that the devices are typically on a motherboard
> and descriptors stored in platform firmware instead of being retrieved
> from the device.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[3/5] ASoC/SoundWire: rt715-sdca: First version of rt715 sdw sdca codec driver
      commit: 6f4a038b99677f4db737841b81b9d45ed4b54966
[4/5] ASoC/SoundWire: rt1316: Add RT1316 SDCA vendor-specific driver
      (no commit info)
[5/5] ASoC/SoundWire: rt711-sdca: Add RT711 SDCA vendor-specific driver
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
