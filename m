Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEF3C6FA82
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Sep 2022 16:09:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47CC81914;
	Wed, 14 Sep 2022 18:08:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47CC81914
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663171745;
	bh=oP9/GLCs2nBCUxJkmgY0Lqz3DR7H/lsYCpM7Yftlw5o=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YdtCO9DWGaQ1BoAp5db5pZOJCkjahL+TZq0a7izA+RGD2cNCqptilEMmiSmfJf7CX
	 iQl0v/EE9BOGucFKpCWxmQYC6pf/5k/OD3kF5TGvVybG/XKag5Ultjlwvk/jVqvZSH
	 varoAqvi9XQa3KFbXDgOicg/Wgl2NotvLm3bgrNk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76029F801D8;
	Wed, 14 Sep 2022 18:07:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ADBF8F8014E; Wed, 14 Sep 2022 18:07:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E17A9F800FE
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2022 18:07:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E17A9F800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qxJCmyKc"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 509E4616B6;
 Wed, 14 Sep 2022 16:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC38FC433B5;
 Wed, 14 Sep 2022 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663171649;
 bh=oP9/GLCs2nBCUxJkmgY0Lqz3DR7H/lsYCpM7Yftlw5o=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=qxJCmyKcOEujO+XVlRtDOK8BMxKJ29aMNAQLfeBiHdAzsouh2tdNnJt/dYNCUr6Q8
 jAxAQPktWMHA3dhBLdXnMzIV/xpyZzgi/vYT709KPaXe2i+CzdrTdNHZ+NrhPeb7BG
 xEF6ymITI+hGqjMuEu+FXVl9bvh9KRvmlG8wQ9GBuS/KCOdgGw48pFQu7QOz2S9kji
 gEpcBFgMyOXOXH+ct/Ot26QbULIEqxrNW+R02Kt2JGxIkSz/pybfL3yNDSn5dKrn2Q
 Ya85GHV/PWC0KvQRkZ3RS5eZ1mfbGjGt6l4FvLkZSc7j3cM78YpHPd8pi/N52DfsbW
 iVJB6c0GtW55Q==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Yang Yingliang <yangyingliang@huawei.com>
In-Reply-To: <20220914133355.3779364-1-yangyingliang@huawei.com>
References: <20220914133355.3779364-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next 1/3] ASoC: bcm2835-i2s: Switch to use
 dev_err_probe() helper
Message-Id: <166317164713.1330978.2912707755846248637.b4-ty@kernel.org>
Date: Wed, 14 Sep 2022 17:07:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7dade
Cc: lgirdwood@gmail.com
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

On Wed, 14 Sep 2022 21:33:53 +0800, Yang Yingliang wrote:
> dev_err/dev_dbg() can be replace with dev_err_probe() which will check if error
> code is -EPROBE_DEFER.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/3] ASoC: bcm2835-i2s: Switch to use dev_err_probe() helper
      commit: b407589583da08405a19f4b0139d128e1ae41658
[2/3] ASoC: cs42l42: Switch to use dev_err_probe() helper
      commit: 28a3fb26e83e013c929a2e1185743ece7e8173ff
[3/3] ASoC: soc-dapm: Switch to use dev_err_probe() helper
      commit: a6b0be65123e1dfbcce6653a82394f989d3372ff

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
