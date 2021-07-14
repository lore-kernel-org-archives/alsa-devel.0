Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BF1C07E9A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 15:57:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F19613CB
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 15:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F19613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C84BD167F;
	Wed, 14 Jul 2021 17:56:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C84BD167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626278234;
	bh=zZhbwQi2yOb/sPR3cZ/XLUil00bQ2w92GlnXFgAA72s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lJxGX65EhBaqTobp6+WofPWJT749LSfKQd1rgj8NHo2IreektfzxjKoknYdrS5lEZ
	 fzNF2A177JGISVeO2XnfI7rGw4vW+GF/3Dwq+dGqbtR7GbwNLMsRoI7C8p+GrE9IlZ
	 YeS1vlJ6BPvXhevmhufBTb4vRswYzi9//qxamTlY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C041F80253;
	Wed, 14 Jul 2021 17:56:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74E01F800D3; Wed, 14 Jul 2021 17:56:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C18BF800D3
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 17:56:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C18BF800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pTimcNfg"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD369613CF;
 Wed, 14 Jul 2021 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626278177;
 bh=zZhbwQi2yOb/sPR3cZ/XLUil00bQ2w92GlnXFgAA72s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pTimcNfgWjOR94XdobBqS9ehLqtM3bC9XDHfR5WWlBFsD1AqpoZMroTVQSDLoq14o
 TuiKl5BI7KMIXNb4nDBTHxrjPlD5fyZ/Ns921fudZr1mV7B8caANj10ujewAibgQYm
 FJUaJIE7rcjP8dLYdoF6qhbEU8GAiOeJaDBvOiNhghTXSOYY4fkyHZvhjBImY+4/gq
 UoYoVSUZ3GkBYZe4Idyh0jddDuXhDJ20PFPu4ALf0BfEwWw/gZwKENIj4rXh/M3PHz
 n9G3I7quAdwIDm9vkDBWDSeiKUNOh/25JZTyJGPJ4GnM1JE08yQiPvmxtu1hiTRQKZ
 mDg5mit6AiTqA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: Update ADL descriptor to use ACPI power
 states
Date: Wed, 14 Jul 2021 16:55:20 +0100
Message-Id: <162627737185.54838.4103402581884711146.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210712201620.44311-1-pierre-louis.bossart@linux.intel.com>
References: <20210712201620.44311-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Sathya Prakash M R <sathya.prakash.m.r@intel.com>, tiwai@suse.de,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

On Mon, 12 Jul 2021 15:16:20 -0500, Pierre-Louis Bossart wrote:
> The ADL descriptor was missing an ACPI power setting, causing the DSP
> to enter D3 even with a D0i1-compatible wake-on-voice/hotwording
> capture stream.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: Update ADL descriptor to use ACPI power states
      commit: aa21548e34c19c12e924c736f3fd9e6a4d0f5419

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
