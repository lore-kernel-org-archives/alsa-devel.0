Return-Path: <SRS0=lo3o=NO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652F4C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 17:40:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CDD61374
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 17:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38CDD61374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 259AB1658;
	Mon, 23 Aug 2021 19:39:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 259AB1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629740422;
	bh=ZNw9GHf8Xb9k6PQIfmJTZrNrqMnGGK2uPHf1PTpMid0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aMqHxHmlEaEIRdYHQqEdWTb6dHJFs/FFRtezf/0myoez/J10UtTUOUIzGK1mjuxOP
	 2r3RbSA8rmBLNR+sQhO1SDRkb4teDrom0WGdMiq7PHGNWVYydxgfhquh+mONCto5gI
	 RYyhRlbgOzbdjMuA+XP2d2Roz0RsZh9EZfRAIyto=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EEF5CF80240;
	Mon, 23 Aug 2021 19:38:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5AAA9F800AE; Mon, 23 Aug 2021 19:38:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AA13F8020C
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 19:38:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AA13F8020C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fAnQ601z"
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1C6F6138B;
 Mon, 23 Aug 2021 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629740310;
 bh=ZNw9GHf8Xb9k6PQIfmJTZrNrqMnGGK2uPHf1PTpMid0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fAnQ601z/WgkxQCbGfeTFU6p6ZLgReV4pqyupjRqm/3RK8KmzOjHMB5qJL1bdRKUK
 KMYXPCQkgG79SCrptMRtN0rj3RHuqEcaGf+GNU0/YFmjFvw4MWWajGPiuM+5HZxwDq
 YCLwur5+TQo5PwxQTJha0CYbvJoFN+4ocpvTlyEKFrQuhdE5fZsbC5rcSoOT80u2VH
 9o3Rm4UUcfVQt2QbTgkQAP7TUtgxO/aokj7hfsENQhfiaD405GF3afI9T7IPLqmBJZ
 /+ugrKLg87j++mtmcfdmYiquZBtpbXDAAf/2ZqjFKK7rPYtBydRx56g5xtu+sv6FSH
 CiZpq3UZSCjOQ==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Mark
 hp_elitepad_1000g2_jack?_check functions static
Date: Mon, 23 Aug 2021 18:37:53 +0100
Message-Id: <162973996481.3102.18076403439747731862.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210823110432.64860-1-hdegoede@redhat.com>
References: <20210823110432.64860-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 kernel test robot <lkp@intel.com>
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

On Mon, 23 Aug 2021 13:04:32 +0200, Hans de Goede wrote:
> The byt_rt5640_hp_elitepad_1000g2_jack?_check functions are only
> used inside bytcr_rt5640.c, mark them as static.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: bytcr_rt5640: Mark hp_elitepad_1000g2_jack?_check functions static
      commit: a5ec377133674a0318bfb9342488d5d0ad0e1327

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
