Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2B3C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 23:40:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF8E61481
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 23:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF8E61481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3343E166D;
	Tue,  2 Mar 2021 00:39:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3343E166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614642010;
	bh=nrIQj+PF6xl0Ng8IlfsVHRNF45bzLAB5oRssCxEx3LI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hdaywe75rRixxuyd/4cfYy6OZz9cAeVCUHZ7hsBY5Fw4mqgmljBYWvB2173ZVhUjv
	 oRs0q6AyDQnluJSPn8Z4C9tpwmXamkkfMFZHOCc4ZXWzuZHhMNEUlJfMxEsNQ6jhuz
	 Yu7QawTzaumSb2dogAnq1PtFwJadP9jkcXpZ3pZo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CB66F804B4;
	Tue,  2 Mar 2021 00:36:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5ED45F804D8; Tue,  2 Mar 2021 00:36:34 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F416F804B4
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 00:36:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F416F804B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QFJZgQAR"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23F94600CD;
 Mon,  1 Mar 2021 23:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614641790;
 bh=nrIQj+PF6xl0Ng8IlfsVHRNF45bzLAB5oRssCxEx3LI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=QFJZgQARvXFK8J+2oAFqDC000HBhw2EThvON11Q1b7pTQHLSlVqy/ErvxjO5rrdqo
 c26YP5TSaD6WHogyBG6FVNT9wqFRVOwJc/UghCcMUrvnp2qoCVVaHbx2s/BJOQl8/c
 xhpoJOiaaYuh2MpENMlPx0qetTaGMIwk41adsyNGxKUgxdgGOJvrRZ9ASkYYjXbcK0
 rPLli8qiJhGacalRXuO5VhV9TqhM1/pK7s+0W0fgAD1ZLet4fLgPjTRweepxUzQKzx
 nWOGLbkeLvbjj/VzRzbTn5dMNUw87WQlzcSCE5YY8czDFJOVsemTgjEpCTYEGehw2d
 yxdg/8OftwmZw==
From: Mark Brown <broonie@kernel.org>
To: Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20210226143817.84287-1-hdegoede@redhat.com>
References: <20210226143817.84287-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH 0/5] AsoC: rt5640/rt5651: Volume control fixes
Message-Id: <161464168097.31144.7188432033841191426.b4-ty@kernel.org>
Date: Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org
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

On Fri, 26 Feb 2021 15:38:12 +0100, Hans de Goede wrote:
> Here is a series of rt5640/rt5651 volume-control fixes which I wrote
> while working on a bytcr-rt5640 UCM profile patch-series adding
> hardware-volume control to devices using this UCM profile.
> 
> The UCM series will also work on older kernels, but it works best on
> kernels with this series applied, giving e.g. finer grained volume
> control and support for hardware muting the outputs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: rt5640: Fix dac- and adc- vol-tlv values being off by a factor of 10
      commit: 24a7b77daed8f973bf8a5ed2f83344f44f9f6396
[2/5] ASoC: rt5651: Fix dac- and adc- vol-tlv values being off by a factor of 10
      commit: e4ffab875d32bf4ffa37b5cd725ace9e15d1707d

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
