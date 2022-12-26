Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF8EC4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Dec 2022 23:35:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2CD0565A8;
	Tue, 27 Dec 2022 00:34:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2CD0565A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672097722;
	bh=U8xN5fqN2RpLO0+0uf2AAte4B5MTp6owYgnVxY3XP9g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=M6Y7ifo7TIJdgyDFBguTPSA8z1MApz3JpIhWNjDIvVzvwAKb0B1+ZqCDipOk47788
	 h5UEhIBRGzzts3uP0rCy7PqOyrpcQjHmroEV4jh4RTeU+rcvqr1qGaD5Nkoiv1qsVK
	 VTwyPx845gFf/zVw1fxghDgn/TPvY42ttTSzZqXQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88784F804CF;
	Tue, 27 Dec 2022 00:34:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 623ADF804CF; Tue, 27 Dec 2022 00:34:10 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B45A2F804CF
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2022 00:34:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B45A2F804CF
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Dz7mQxD0
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7BA2860F58;
 Mon, 26 Dec 2022 23:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2235BC433EF;
 Mon, 26 Dec 2022 23:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672097644;
 bh=U8xN5fqN2RpLO0+0uf2AAte4B5MTp6owYgnVxY3XP9g=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Dz7mQxD08oUWwRqgseibhWjRzBHJWwOSTl1xIGj4Gs3hOeW5GOpqKB7AvpR9l7ui5
 cJRqxucj+FQucllQVISjYq+TdykyKwmDpKGOzerZw2X/73v3rvwFJ7v1R0F5NfOZTN
 y+3szaN7bhpPwau8BI9Y7znhfWnFYBGMbO7hzyLfu1V6Sl+7H1o41ZrUO4NHHTmO3y
 0wZ9soWrSaL08cVgckBgPlQvTGy9gJ+wG8rjOqlEE03Fp3V7vXd0SsE+lWHppdFJjD
 nqE9op8jP46vczOSBsqDMewy2Bd/LdsIdfOwHtCU8hIAfLRKgKUmmuq+wJEHcCwhLc
 nu5qpLQyheU0g==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Arnd Bergmann <arnd@kernel.org>
In-Reply-To: <20221221132515.2363276-1-arnd@kernel.org>
References: <20221221132515.2363276-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: sof-nau8825: fix module alias overflow
Message-Id: <167209763984.330820.8290497539067890342.b4-ty@kernel.org>
Date: Mon, 26 Dec 2022 23:33:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org,
 Arnd Bergmann <arnd@arndb.de>, ye xingchen <ye.xingchen@zte.com.cn>,
 Takashi Iwai <tiwai@suse.com>, Mac Chiang <mac.chiang@intel.com>,
 Muralidhar Reddy <muralidhar.reddy@intel.com>,
 Akihiko Odaki <akihiko.odaki@gmail.com>, David Lin <CTLIN0@nuvoton.com>,
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org,
 Yong Zhi <yong.zhi@intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 21 Dec 2022 14:24:56 +0100, Arnd Bergmann wrote:
> The maximum name length for a platform_device_id entry is 20 characters
> including the trailing NUL byte. The sof_nau8825.c file exceeds that,
> which causes an obscure error message:
> 
> sound/soc/intel/boards/snd-soc-sof_nau8825.mod.c:35:45: error: illegal character encoding in string literal [-Werror,-Winvalid-source-encoding]
> MODULE_ALIAS("platform:adl_max98373_nau8825<U+0018><AA>");
>                                                    ^~~~
> include/linux/module.h:168:49: note: expanded from macro 'MODULE_ALIAS'
>                                                 ^~~~~~
> include/linux/module.h:165:56: note: expanded from macro 'MODULE_INFO'
>                                                        ^~~~
> include/linux/moduleparam.h:26:47: note: expanded from macro '__MODULE_INFO'
>                 = __MODULE_INFO_PREFIX __stringify(tag) "=" info
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof-nau8825: fix module alias overflow
      commit: 3e78986a840d59dd27e636eae3f52dc11125c835

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
