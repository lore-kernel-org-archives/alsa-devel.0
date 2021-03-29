Return-Path: <SRS0=ZkCr=I3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF770C433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 19:59:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A87B61606
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 19:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A87B61606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D70501660;
	Mon, 29 Mar 2021 21:58:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D70501660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617047966;
	bh=VMff+Qv6NeIX9a1HoADYuLB7R+Md++1sW41s5i4v3l0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M069X0B3Ar16dae2n2pvJmnP0RjEzbcn8NiBUBYk88Ugc5DoC96tnb96zfNw0wnTF
	 uudUE0UOlMeZog6LCAfWg2XbbMnXC0Zy650R/h9S+E2O1EBr/8XYmYg7wiyhzC2Bv7
	 0287GPHl2q3SswwzmqT3FMotSa2sgBnERWEFiH/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22D7BF8015A;
	Mon, 29 Mar 2021 21:58:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46A20F8016E; Mon, 29 Mar 2021 21:58:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03354F80157
 for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2021 21:58:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03354F80157
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LO1Okk5E"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D7C361494;
 Mon, 29 Mar 2021 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617047906;
 bh=VMff+Qv6NeIX9a1HoADYuLB7R+Md++1sW41s5i4v3l0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LO1Okk5EyAoTa+OR2sEzi7g/DU4llvPF4CAXEDM8pXNgXUXlY70DGfmmd23gLflnh
 0Dx8S9/6YqUmDOLwhjWBd0Gs91cD8N2x1K/jVzeKes8G9lZTURmooMKyBeB3sVMPe1
 dj6nJbUQUzDSpKP9MBaUfCFz/wnU1vEfCUtCIRP/1XGxEyaiymoScdmonhx7zNrujq
 KwYZXhqnIcGsVB90RLb+Q/iIS/7UMQsLFTjZaLzOyHKbLPzGhaoiEQUwvu4Xba67S1
 afamk2iHurB04AXA57AGj8CJ5Iv1dUXvhdynRyOSbZ/vXNO2V9CEfMIy+kr6L3KrQ3
 hiB2p299e14Sg==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, perex@perex.cz, YueHaibing <yuehaibing@huawei.com>,
 lgirdwood@gmail.com
Subject: Re: [PATCH -next] ASoC: dwc: Fix -Wmissing-prototypes warnings
Date: Mon, 29 Mar 2021 20:58:07 +0100
Message-Id: <161704724765.10039.16753813852849832832.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210329150524.18184-1-yuehaibing@huawei.com>
References: <20210329150524.18184-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
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

On Mon, 29 Mar 2021 23:05:24 +0800, YueHaibing wrote:
> while CONFIG_SND_DESIGNWARE_PCM is not set, building with W=1 shows this:
> 
> sound/soc/dwc/local.h:127:6: warning: no previous prototype for ‘dw_pcm_push_tx’ [-Wmissing-prototypes]
>  void dw_pcm_push_tx(struct dw_i2s_dev *dev) { }
>       ^~~~~~~~~~~~~~
> sound/soc/dwc/local.h:128:6: warning: no previous prototype for ‘dw_pcm_pop_rx’ [-Wmissing-prototypes]
>  void dw_pcm_pop_rx(struct dw_i2s_dev *dev) { }
>       ^~~~~~~~~~~~~
> sound/soc/dwc/local.h:129:5: warning: no previous prototype for ‘dw_pcm_register’ [-Wmissing-prototypes]
>  int dw_pcm_register(struct platform_device *pdev)
>      ^~~~~~~~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dwc: Fix -Wmissing-prototypes warnings
      commit: 0803a5cb5b7cf369c3e2af4108ee44d0b6e1c197

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
