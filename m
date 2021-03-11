Return-Path: <SRS0=8+EQ=IJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C84C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 16:20:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A2464F98
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 16:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A2464F98
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C05ED1687;
	Thu, 11 Mar 2021 17:19:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C05ED1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615479624;
	bh=SWYpNyGsJBVwjeNayV+tYTWzaYAdSbGpSQnZ9rHFa7E=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QSPNs3Hv3aZECQUJFmKnrNqzUUDT2dByn1fWz6saud2OjYHq8B2rRipJuoAB7z1Ol
	 2wNtVmlcnQI5UTpV93yZfhWuLkXhgXS6L9qjLM2f8HYFHX3ZE9x65CihsnW2m+6+sT
	 Jsa8uJlfUWOrwXIAWmOmbu/6Hr015yDFKmxe/QDg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 508B0F8019B;
	Thu, 11 Mar 2021 17:19:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 955DEF80227; Thu, 11 Mar 2021 17:19:33 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F753F8010D
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 17:19:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F753F8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="U3Ol8wPS"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F70964F98;
 Thu, 11 Mar 2021 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615479564;
 bh=SWYpNyGsJBVwjeNayV+tYTWzaYAdSbGpSQnZ9rHFa7E=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=U3Ol8wPSPto9WiutluaNsmLJsXBDJhOs9UIHhe7LZPUe5MLuTcWC7VFlVsDmyKU4Q
 AkHUydlszHK9S13SpXl9b26Nko16V6bCtFS9zGqYSsZYsegjR9A5cfZQU68p8c3etI
 NE65DAfOEwdI0USxGoTQHFKQYpQ6ce1IYMeTSMw+JT5oprrOgiAj38M7xvgTXWiUl8
 N3Rezdrna3ZK3v9G7cT+pypI2j/37XfN3f8wE3A+HYlOkzBsUiLYujoB5wELL898y3
 jnqsMkfOcKfQiI4hX0JE2et7dxkelUzFRTHhIipFmZ9zfN5eFoc8xYlqihUveCv0rY
 SDrijjQkf+3LQ==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20210311004332.120901-1-pierre-louis.bossart@linux.intel.com>
References: <20210311004332.120901-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/10] ASoC: codecs: wolfson: remove cppcheck warnings
Message-Id: <161547949199.51229.10737068937572799677.b4-ty@kernel.org>
Date: Thu, 11 Mar 2021 16:18:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, patches@opensource.cirrus.com,
 Charles Keepax <ckeepax@opensource.cirrus.com>
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

On Wed, 10 Mar 2021 18:43:22 -0600, Pierre-Louis Bossart wrote:
> There should be no functionality change, just minor fixes to make
> warnings go away.
> 
> Pierre-Louis Bossart (10):
>   ASoC: arizona: fix function argument
>   ASoC: madera: align function prototype
>   ASoC: wm2200: remove unused structure
>   ASoC: wm8903: remove useless assignments
>   ASoC: wm8958-dsp2: rename local 'control' arrays
>   ASoC: wm8978: clarify expression
>   ASoC: wm8994: align function prototype
>   ASoC: wm8996: clarify expression
>   ASoC: wm_adsp: simplify return value
>   ASoC: wm_hubs: align function prototype
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/10] ASoC: arizona: fix function argument
        commit: 4988f0cc254a1955d5c3244298055f5f7b538e6b
[02/10] ASoC: madera: align function prototype
        commit: b6021b5623b93da05375ae8060f8e8d5dcae0ba9
[03/10] ASoC: wm2200: remove unused structure
        commit: 43fe3fe8b31685ccb2e248799ce3e9f9a15938fb
[04/10] ASoC: wm8903: remove useless assignments
        commit: 13119a311aeb5a91ea751f10e4158a86361c2f08
[05/10] ASoC: wm8958-dsp2: rename local 'control' arrays
        commit: d28a9dfeb8071b9ac0e79c8b8b4a0111c3b54c70
[06/10] ASoC: wm8978: clarify expression
        commit: 729d42a4ab1a7bc9f4b5c37c57a3a4270333351f
[07/10] ASoC: wm8994: align function prototype
        commit: b564fdb756918557fb4ca5086e67929bd2eafdd6
[08/10] ASoC: wm8996: clarify expression
        commit: ea80d4991b76dc101b87228b74515d818ff03bcd
[09/10] ASoC: wm_adsp: simplify return value
        commit: 492df5b0748ada592119dc19dd713e4a60c4e69f
[10/10] ASoC: wm_hubs: align function prototype
        commit: 8ea9e29cc7fc966885018628e123f4113f1ce4b2

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
