Return-Path: <SRS0=Op9s=6N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64340C83000
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:30:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38332073E
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cwXsJfdC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNtwpDlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38332073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47C821666;
	Wed, 29 Apr 2020 18:29:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47C821666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588177835;
	bh=+ZFmSTfRlzLSqIImDH7J+JHuq7zyyWHC0ptJUMmXft0=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cwXsJfdCgof0nK4N9h1nUqvaAxyK+YHmRb/NytmI1LEtD+Wwgmkyh4MV9jS2g17Ls
	 3XBPrDBL0O8f2nA4WXMWEQDXwNT/y2raQrscmCiSieyaZwnYktNn84LofGn6RxsQIW
	 JUlw94XHKgoUtl4EpAYQ6aWwnAe68nW3S2ZfN8Tk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61B3AF802BE;
	Wed, 29 Apr 2020 18:26:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D041F802BE; Wed, 29 Apr 2020 18:26:42 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17AD1F802A1
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2020 18:26:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17AD1F802A1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jNtwpDlN"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 10CFF2076B;
 Wed, 29 Apr 2020 16:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588177598;
 bh=+ZFmSTfRlzLSqIImDH7J+JHuq7zyyWHC0ptJUMmXft0=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=jNtwpDlN2/yGU87aQZnyuN1IH98wv1CpRVpBC4Uwt/70lA0qwy5OTnoe2aHRSBp1D
 h8Ozoh62f6XvG7IfwUZLY8MseaEy1tb57+jJf+GZoEy6PcVaUQdJlvbxcCr3Rrl35A
 vXmxiQ+oXRTxE74U6ugksHMR6+IwBMln6lqNHRR8=
Date: Wed, 29 Apr 2020 17:26:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200428214642.3925004-1-arnd@arndb.de>
References: <20200428214642.3925004-1-arnd@arndb.de>
Subject: Re: [PATCH] ASoC: rt5682: fix I2C/Soundwire dependencies
Message-Id: <158817756638.27768.13590393174406922978.b4-ty@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 kbuild test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
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

On Tue, 28 Apr 2020 23:46:14 +0200, Arnd Bergmann wrote:
> If one of the two is a loadable module, the combined driver must
> not be built-in:
> 
> aarch64-linux-ld: sound/soc/codecs/rt5682.o: in function `rt5682_sdw_hw_free':
> rt5682.c:(.text+0xb34): undefined reference to `sdw_stream_remove_slave'
> aarch64-linux-ld: sound/soc/codecs/rt5682.o: in function `rt5682_sdw_hw_params':
> rt5682.c:(.text+0xe78): undefined reference to `sdw_stream_add_slave'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: rt5682: fix I2C/Soundwire dependencies
      commit: fd443a20c2f0950f3c31765a08f7dd49b3bc69cb

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
