Return-Path: <SRS0=uvJZ=6W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEC8C38A2A
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2020 17:16:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABECE21974
	for <alsa-devel@archiver.kernel.org>; Fri,  8 May 2020 17:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="a6TFZ61o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAgyn1Az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABECE21974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0454A82C;
	Fri,  8 May 2020 19:15:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0454A82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588958169;
	bh=5t7WJiL5EwvoF0nnqVxBZir0wWe3BIQcNbcs1QJffwA=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a6TFZ61oONFTayoWLC/gGLefEeEtaQ82L/xJfLRWaQO1Gw+4w0uYt8l8H/qTPxQjz
	 rm341GizIu+v3ex+1zIlNoKzdjjHTKLbQ9paP5XPE+sOY0uBt10hTrTamTrhW0W5MD
	 UYZFFK2Z4/hlnqMqNcuf2DH3938KozJv8jAc/P8k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01D5AF80299;
	Fri,  8 May 2020 19:13:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 232DBF8029A; Fri,  8 May 2020 19:13:45 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9D82F80290
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2020 19:13:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9D82F80290
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rAgyn1Az"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A46242063A;
 Fri,  8 May 2020 17:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588958017;
 bh=5t7WJiL5EwvoF0nnqVxBZir0wWe3BIQcNbcs1QJffwA=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=rAgyn1AzkpzjDtU1+fwmVGaaW32AsL9fJeQxDyPG+4bENc1L72C8N/5TpqKgFGG9m
 fVSCnRSKUlW1rqiwWnyL1VjbOfKnkKZMqOtQYKcK7yW11nTwDAQx+SjIkWmXvVeTlh
 wIenW1KdCjcuSDpdquykMkHaJ9Bw5hXfIm1zBzdU=
Date: Fri, 08 May 2020 18:13:34 +0100
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, perex@perex.cz, s.hauer@pengutronix.de, lgirdwood@gmail.com,
 shawnguo@kernel.org, Tang Bin <tangbin@cmss.chinamobile.com>
In-Reply-To: <20200429094023.12856-1-tangbin@cmss.chinamobile.com>
References: <20200429094023.12856-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: mxs-saif: Add variable dev to simplify code
Message-Id: <158895800277.30774.18095767521738841967.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, 29 Apr 2020 17:40:23 +0800, Tang Bin wrote:
> Add variable 'dev' to make the code cleaner in the function
> mxs_saif_probe(). And now that the function mxs_saif_mclk_init()
> have defined the variables 'ret' as the error returned value,
> then it should be used instead in this place.
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> 
> [...]

Applied to

   local tree regulator/for-5.7

Thanks!

[1/1] ASoC: mxs-saif: Add variable dev to simplify code
      (no commit info)

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
