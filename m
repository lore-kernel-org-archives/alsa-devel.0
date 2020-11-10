Return-Path: <SRS0=3oRA=EQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FD3C5517A
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 16:05:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E28E2076E
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 16:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OIBwmej9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoUlOLUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E28E2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 095181745;
	Tue, 10 Nov 2020 17:04:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 095181745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605024315;
	bh=arSU7iObv5TKvnOj6naRt5mQLdMTSeyl4JneYSecfts=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OIBwmej9A1xeeuNG1ySCUAXFGJJDRby5l9eqtzJ+rZRj/mENuI/OKqkr/Bu4Mq3fG
	 2SeXsxzPW87kOtglYN9HJb1Pb5zGm8MA5pFWAwl0o7CiM/q7OvMppr+z+pXfeViHDK
	 VBAr9k2cvlwoX7kPT54awQHTiRO8K0T6gI2fdUOE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AD93F804D2;
	Tue, 10 Nov 2020 17:03:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 882CEF804CB; Tue, 10 Nov 2020 17:03:07 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44DC8F804CB
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2020 17:03:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44DC8F804CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="aoUlOLUo"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0DCED20829;
 Tue, 10 Nov 2020 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605024183;
 bh=arSU7iObv5TKvnOj6naRt5mQLdMTSeyl4JneYSecfts=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=aoUlOLUo8fWOL4ebcQd9XF/ZfKTW4mTZ+5YkQb53YE2DJ76QTKZq09jrZtxsyfrtb
 Gne4/wjoyQfVjF7BwPMw+KFcqJr/dcs0xtV/rF8gsIEHK828Vir2rfMTmq4ViQw1pr
 CYm2jTOzaUiPEaOC2rll/wqA2TovOvW+4C3aB9ZY=
Date: Tue, 10 Nov 2020 16:02:49 +0000
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Ajye Huang <ajye.huang@gmail.com>
In-Reply-To: <20200928063744.525700-1-ajye_huang@compal.corp-partner.google.com>
References: <20200928063744.525700-1-ajye_huang@compal.corp-partner.google.com>
Subject: Re: [PATCH v1 0/2] Modify documentation and machine driver for SC7180
 sound card
Message-Id: <160502414078.45830.11309600092998215198.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: dianders@chromium.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <agross@kernel.org>,
 Rohit kumar <rohitkr@codeaurora.org>, tzungbi@chromium.org,
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 linux-arm-kernel@lists.infradead.org, cychiang@chromium.org
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

On Mon, 28 Sep 2020 14:37:42 +0800, Ajye Huang wrote:
> Note:
> - This patch depends on this patch series
>  ASoC: qcom: dt-bindings: Add sc7180 machine bindings
>  https://patchwork.kernel.org/patch/11773221/
>  ASoC: qcom: sc7180: Add machine driver for sound card registration
>  https://patchwork.kernel.org/patch/11773223/
> - The patch is made by the collaboration of
>  Ajye Huang <ajye_huang@compal.corp-partner.google.com>
>  Cheng-Yi Chiang <cychiang@chromium.org>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: dt-bindings: Modify sc7180 machine bindings
      (no commit info)
[2/2] ASoC: qcom: sc7180: Modify machine driver for 2mic
      commit: 3cfbf07c6d2779d24a6f5b999a91f400256b1d4e

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
