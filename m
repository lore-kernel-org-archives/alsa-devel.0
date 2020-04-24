Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAF2C54FD0
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:20:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6849A20700
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c43Lt4E5";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uT/kEZTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6849A20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B409416A9;
	Fri, 24 Apr 2020 14:19:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B409416A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587730828;
	bh=v4Wkb61I3GAFJWdNX/2z2spkJ9EdzvizSv/i0EDffmE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c43Lt4E5MQbci10rcrrOOaBfAL8WC9f/Xbx/9ah1q0VyoaUXSfuHwQyhcE2zQ7TZ+
	 5bOZz041863kEd95fSYp5th2z9cFYRihXYCVBmNIj6nT6S0qekuO/ByyfWnj1hdR1Y
	 qgFcS3/+N/JnipoopMUM7yTqr4VMFuy6dVKlXYs8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C5BDF80121;
	Fri, 24 Apr 2020 14:19:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F6D3F80142; Fri, 24 Apr 2020 14:19:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 064EEF800BE
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 14:19:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 064EEF800BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uT/kEZTD"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3600620700;
 Fri, 24 Apr 2020 12:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587730770;
 bh=v4Wkb61I3GAFJWdNX/2z2spkJ9EdzvizSv/i0EDffmE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=uT/kEZTDgmc9s1QnZZQABvTRIpFhViBjaq7eAlt+cACmVWabqxkbRHVp3Ssx0SWTX
 Rw7r9KFyJIeIGFvBYE6SH+k91wkSwyzwD7BTqSjCIdxdk7lJWjMSXkx/M5Pd+TE+d1
 QGnmCBnN1PMZXcijEX8kotpqAZaxsX+Me8BsJU34=
Date: Fri, 24 Apr 2020 13:19:28 +0100
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Rong Chen <rong.a.chen@intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20200422073543.1671-1-rong.a.chen@intel.com>
References: <202004201540.vYPhhYMs%lkp@intel.com>
 <20200422073543.1671-1-rong.a.chen@intel.com>
Subject: Re: [PATCH] ASoC: soc-compress: avoid false-positive Wuninitialized
 warning
Message-Id: <158773076811.21878.6316435664619684333.b4-ty@kernel.org>
Cc: kbuild test robot <lkp@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

On Wed, 22 Apr 2020 15:35:43 +0800, Rong Chen wrote:
> gcc-6.5 and earlier show a new warning:
> 
> sound/soc/soc-compress.c: In function ‘soc_compr_open’:
> sound/soc/soc-compress.c:75:28: warning: ‘component’ is used uninitialized in this function [-Wuninitialized]
>   struct snd_soc_component *component, *save = NULL;
>                               ^~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: soc-compress: avoid false-positive Wuninitialized warning
      commit: 3e645a4add53eec22f3818c9da01c19191525096

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
