Return-Path: <SRS0=bkJA=HT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C96C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Feb 2021 18:55:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB88E64E5F
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Feb 2021 18:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB88E64E5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7253E826;
	Wed, 17 Feb 2021 19:54:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7253E826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613588097;
	bh=16jsBlFGjXw5XNNFvcGpZIK1Imlkf1yuw1XtlOLs6ZI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XjvlqiT3jLNO6v0gSVVZK7eKG8dYw51w7jQI7ZO74hjM5fTwTLDgc/hCYKfXjlqJ0
	 O8RyGoiPkb6JmgiYQHqgXX1c5xrEJfV5Zw6MD+Uye3DGCVl3rQgdLFtZbsKD08f3Oz
	 0L79RpzGPZ6LLDJ3zM9rTSYR+HqMeOzvAXQh5vek=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C547CF80258;
	Wed, 17 Feb 2021 19:54:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D03FF80258; Wed, 17 Feb 2021 19:54:05 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54592F800AE
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2021 19:53:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54592F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XYLgI0JD"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C292600CF;
 Wed, 17 Feb 2021 18:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613588036;
 bh=16jsBlFGjXw5XNNFvcGpZIK1Imlkf1yuw1XtlOLs6ZI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=XYLgI0JDyhVqjWJPIne43CfiWJ7kKVNSBXAvV4oRmKWl2gHz7vdJFW1pzH1n1gLDc
 q21lJtzOD+IpOCuEnGfB60F+HVahqN5w+xOXPo4xOWzY5gbr4qVl5lC95zYKhFBRw8
 Lhgdq0CIAEzVN9ocWbc97oHIXaLgO2i7//zz0j27tzfiAPdIdyZFn9KK2bgdquaGIt
 7rfj4KwGRL1vu/wlrtEnDyBeOWOMAVYHe6XF7lYwFzhwxhT1Yiiu5GGpFa/HV3/xOQ
 CcXspN+seaQkMJnY+VhEWJ8ZK4Kyceb51agmqbMB1WQN2Noi5h4xe1xMXGHaS7545O
 fgjF1dYDg6N9g==
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20210216213555.36555-1-hdegoede@redhat.com>
References: <20210216213555.36555-1-hdegoede@redhat.com>
Subject: Re: [PATCH 0/4] ASoC: Intel: bytcr_rt5640: Add quirks for 4 more
 tablet / 2-in-1 models
Message-Id: <161358797885.15305.3196257758161215191.b4-ty@kernel.org>
Date: Wed, 17 Feb 2021 18:52:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 Bard Liao <bard.liao@intel.com>
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

On Tue, 16 Feb 2021 22:35:51 +0100, Hans de Goede wrote:
> Here is a patch series adding quirks with device-specific settings for
> 4 more tablet / 2-in-1 models.
> 
> Regards,
> 
> Hans
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: Intel: bytcr_rt5640: Add quirk for the Estar Beauty HD MID 7316R tablet
      commit: bdea43fc0436c9e98fdfe151c2ed8a3fc7277404
[2/4] ASoC: Intel: bytcr_rt5640: Add quirk for the Voyo Winpad A15 tablet
      commit: e1317cc9ca4ac20262895fddb065ffda4fc29cfb
[3/4] ASoC: Intel: bytcr_rt5651: Add quirk for the Jumper EZpad 7 tablet
      commit: df8359c512fa770ffa6b0b0309807d9b9825a47f
[4/4] ASoC: Intel: bytcr_rt5640: Add quirk for the Acer One S1002 tablet
      commit: c58947af08aedbdee0fce5ea6e6bf3e488ae0e2c

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
