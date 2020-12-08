Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C823C4361B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 17:10:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C901223B04
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 17:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C901223B04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C022016D8;
	Tue,  8 Dec 2020 18:10:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C022016D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607447454;
	bh=SZaGLaZCzSboDYmnN31auNTnYRxKgDk78mdAhVFk7yM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tfJ+j4ZhLo6dW3pUg7de3GZhQ3Ic/Ut8gFOiHeNizVNfaoCqZPD0EO/D+Tnpz30a/
	 91bWv4hQLnS6NHWspgkXB9wLAAIs9H/V3O4xBXZew8L6Cg9zLpynLYv5om/YsqlIH1
	 vo4DH7SfEnDPRW2jxUGUVNynDw8apV8QRQuH6T+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10194F80164;
	Tue,  8 Dec 2020 18:10:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C463F8019D; Tue,  8 Dec 2020 18:10:02 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13E96F80130
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 18:09:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13E96F80130
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20201206122436.13553-1-hdegoede@redhat.com>
References: <20201206122436.13553-1-hdegoede@redhat.com>
Subject: Re: [PATCH 0/2] ASoC: Intel: cht_bsw_nau8824: 2 fixes for usage with
 sof-audio-acpi
Message-Id: <160744738921.29839.7753377427445402835.b4-ty@kernel.org>
Date: Tue, 08 Dec 2020 17:09:49 +0000
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

On Sun, 6 Dec 2020 13:24:34 +0100, Hans de Goede wrote:
> Here are 2 simple fixes which are necessary to make the
> cht_bsw_nau8824 machine driver work together with the
> sof-audio-acpi driver.
> 
> Note that atm the sof topology files are missing a .tplg
> file for this setup. Simply copying over the standard
> sof-byte-codec.tplg file does the trick, but then some
> mixer setting changes are necessary to fix the right
> speaker/headphones channel not working; and those mixer
> settings break the right channel when used with the
> sst-acpi driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: Intel: cht_bsw_nau8824: Drop compress-cpu-dai bits
      commit: e60ffc48fac4b6ba8f3ec500bd166909f3db03c3
[2/2] ASoC: Intel: cht_bsw_nau8824: Change SSP2-Codec DAI id to 0
      commit: 748e72e869718db8d735d773040bce95158c98c6

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
