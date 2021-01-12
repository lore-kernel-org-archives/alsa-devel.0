Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F352C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 16:45:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B986B23110
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 16:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B986B23110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A54F3171B;
	Tue, 12 Jan 2021 17:44:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A54F3171B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610469909;
	bh=EwG4zdP6v9kxeFX/uSEtjiM/hbzq8E2/KBvL45Tc2Qg=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PrihyMnmGpEc+LceK4R6OJF9SKU+EFtV2Ko7x8HiWLlELHqT+xJbQADlfN99tBETX
	 KMR1PjR/Gk5eh23ECfJTI24uD2WheVMV+zGkoZjpz2xGENQ08/tPz0KY4jWr/HeXvK
	 SDtVxNmuitFbIJV5YAM4rNWMv9l2WXXQ/1x1/2XI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7212F804E1;
	Tue, 12 Jan 2021 17:43:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5514F804E4; Tue, 12 Jan 2021 17:43:01 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 953F3F804E2
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 17:42:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 953F3F804E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ol/SRiGn"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 658B523109;
 Tue, 12 Jan 2021 16:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610469777;
 bh=EwG4zdP6v9kxeFX/uSEtjiM/hbzq8E2/KBvL45Tc2Qg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Ol/SRiGnt5Tc1iUTi0kdQJUmc0rRHvpd4Avl8XyPSQf2P1zm3ksfqHjxiWOGZnkQL
 1ia2tF/Ms5b5qYAH3xZQ3yxSenuKWw97aOkoKtfDb8SjF7pAvFVavWuRn4CF0tEoAI
 zyrNaqLSVNYXIHAzlZmJ+CFFReB7IhnWVS54nntmRG5BQJhQiT3oiFoOZQpHB32dnH
 rkH0BWbYaXPGEro4S/82cZcmKukHB2XvKYVGDWonKmzITJQvAgDKREvCtWEzRdmHu+
 0R+nMm3PHI5ilf7NKHytzEbO976RNh2U0zMTYvsCVTNQw3MfSqwO2UeX3kTYIf5Ho0
 dZLmg86lUfO8A==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20210107115324.11602-1-hdegoede@redhat.com>
References: <20210107115324.11602-1-hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: Intel: cht_bsw_nau8824: Move
 snd_soc_dai_set_tdm_slot call to cht_codec_fixup
Message-Id: <161046972101.805.17846356800767481729.b4-ty@kernel.org>
Date: Tue, 12 Jan 2021 16:42:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Thu, 7 Jan 2021 12:53:24 +0100, Hans de Goede wrote:
> Move the snd_soc_dai_set_tdm_slot() call from cht_codec_init() to
> cht_codec_fixup(). There are 2 reasons for doing this:
> 
> 1. This aligns the cht_bsw_nau8824 with all the other BYT/CHT machine
> drivers which also do this from their codec_fixup function.
> 
> 2. When using the SOF driver, things like the TDM info is set from the
> topology file. Moving the call to the codec_fixup function, which gets
> skipped when using the SOF driver avoids the call interfering with the
> settings when using the SOF driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: cht_bsw_nau8824: Move snd_soc_dai_set_tdm_slot call to cht_codec_fixup
      commit: 780b1a02c1795b58f217aabfd0688d616408bb89

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
