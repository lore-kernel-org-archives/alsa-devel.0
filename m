Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6508C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 18:42:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7294F64E74
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 18:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7294F64E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1601169E;
	Mon,  8 Feb 2021 19:41:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1601169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612809738;
	bh=5IBhQ7c3BzKenFcsQ0x87dAwNhuhz1U+iCIXHPWQyxM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h3ozPbj5Zpjmx3kjX9rZTs3VHaTtVupII53NFrxJQy7T6jeVbHaxRtoQY43oT0+ID
	 92mEoU5zRJ5o0ltq70pWwzxOIffpkN0HmvtkleI0hEGuu4vYGDp1IDVekZicll8WCT
	 pDhY2fIt5Zqn9KMt0Urui7H0ubYnwJSq4oniUJ9w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1CB2F802DF;
	Mon,  8 Feb 2021 19:39:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05E7BF802E0; Mon,  8 Feb 2021 19:39:34 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CEE6F802DB
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 19:39:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CEE6F802DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VU2VcT7T"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C962F64E6C;
 Mon,  8 Feb 2021 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612809569;
 bh=5IBhQ7c3BzKenFcsQ0x87dAwNhuhz1U+iCIXHPWQyxM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=VU2VcT7TaDO3lBZ+GiDsY1XzFCoiEFRHjkWoyS5jY75bIxBkybh+BXvUmZR3aQexr
 i5/tDc4C08lpVQ6qJWPmzIg4cjhfZuowj47xMC1wkaV05c6mSTupTFN+IhSfIq/Fxs
 DTHkE4k3cBun8UqU0mmmDvlDQnYIlVSOO2GOv7tK9/Vm4Rn0BKHp881myK23Y9NMei
 l3AEJUcKYtBlrfOvjaQaiQTiwBDnVk0YqrwCylJf9hABDBIkCsKohzRxg5NrC4XZjH
 AoCt9qt7JjwtYz2JujdAeicrUJLpNmVH2b1xvTDhsrbIsP6duqD3JfJ4xw26EKb6Ct
 BqF7FZYwICdcQ==
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>, Jie Yang <yang.jie@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20210120214957.140232-1-hdegoede@redhat.com>
References: <20210120214957.140232-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail
 boards with WM5102 codec
Message-Id: <161280948306.10741.6212553639750410303.b4-ty@kernel.org>
Date: Mon, 08 Feb 2021 18:38:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, linux-kernel@vger.kernel.org
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

On Wed, 20 Jan 2021 22:49:52 +0100, Hans de Goede wrote:
> Here is v4 of my series to add support for Intel Bay Trail based devices
> which use a WM5102 codec for audio output/input.
> 
> This was developed and tested on a Lenovo Yoga Tablet 1051L.
> 
> The MFD and ASoC parts do not have any build-time dependencies
> on each other. But the follow-up jack-detect series does have
> patches depending on each-other and on this series. So IMHO it
> would be best if this entire series would be merged through the
> MFD tree to make merging the follow-up series easier.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[4/5] ASoC: Intel: Add DMI quirk table to soc_intel_is_byt_cr()
      commit: 8ade6d8b02b1ead741bd4f6c42921035caab6560
[5/5] ASoC: Intel: bytcr_wm5102: Add machine driver for BYT/WM5102
      commit: 9a87fc1e061900e81ab13d823e85012a78849244

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
