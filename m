Return-Path: <SRS0=6DhY=7I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4AEC433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 16:48:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEBF20723
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 16:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mQsZITUZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcmQUE3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEBF20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1EA9177D;
	Tue, 26 May 2020 18:47:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1EA9177D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590511702;
	bh=XOChMk8gnrUoD6TmiuzV6PPv/YGwIxQm8tqk/nDusow=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mQsZITUZWMge/lba49W5Ki9gEggbwm80tvBpdkynCCZBFBStJPvvSlhqIpBx185dX
	 cCA6KVb6gXDcjc8+XIbJImLaVL+ZoXR+8B7+O84WVVw/Rf/s1tpo9XwHqQ8Oaxn9fx
	 +YVVfVI8S7zT6xCnlhwbw7XfRq/not33DW0GSaxY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D824F8026A;
	Tue, 26 May 2020 18:47:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4580F8028F; Tue, 26 May 2020 18:46:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D23CF80278
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2020 18:45:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D23CF80278
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tcmQUE3r"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2771120787;
 Tue, 26 May 2020 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590511555;
 bh=XOChMk8gnrUoD6TmiuzV6PPv/YGwIxQm8tqk/nDusow=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=tcmQUE3ryk37EbisWbA+aKPXcV4hwxJtkoKRvBtFxt++O2PQuAsURLEhcbL4Bt0gI
 C0fgmYv4qEZZsxMjzGojjwnSQTFd0Y0oIlV122g2vfxKGh4cuS3rBz3N/Ww1pmL2HG
 Qw/EZd+JkCoMY6PEKJpj/kgfaVCV/j70gCAelFlY=
Date: Tue, 26 May 2020 17:45:53 +0100
From: Mark Brown <broonie@kernel.org>
To: kjlu@umn.edu, Dinghao Liu <dinghao.liu@zju.edu.cn>
In-Reply-To: <20200525085848.4227-1-dinghao.liu@zju.edu.cn>
References: <20200525085848.4227-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] [v2] ASoC: ti: Fix runtime PM imbalance in
 omap2_mcbsp_set_clks_src
Message-Id: <159051153752.36309.9642221556598180618.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
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

On Mon, 25 May 2020 16:58:48 +0800, Dinghao Liu wrote:
> When clk_set_parent() returns an error code, a pairing
> runtime PM usage counter increment is needed to keep the
> counter balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: Fix runtime PM imbalance in omap2_mcbsp_set_clks_src
      commit: c553d290577093553098a56c954e516950c35c59

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
