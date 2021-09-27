Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7ADC433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:53:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7712860F9B
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7712860F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 057EF16B8;
	Mon, 27 Sep 2021 19:53:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 057EF16B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632765238;
	bh=uVl5ACrfcIN4ooLozQqnr+TxY/foOGM8sxO3/2FeKmA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XmhyHcenfcEx8+raDFnMT7HHUew6lsSS/Xlqrabdnru7E4DJC9SFTAxNvZ8cdr+aS
	 3yMMYUyCEq/Iee9k+E2fpWPWA+9EWodP9Uwk87+uKsCy/nsUTGwGCQY0CXXjv++hwp
	 jLSt+F1m8kOwJoYbqG0sNlKg05f65X4KzJEahbe0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EEE0AF8055B;
	Mon, 27 Sep 2021 19:48:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 743F5F80544; Mon, 27 Sep 2021 19:47:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EEA09F80543
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 19:47:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEA09F80543
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QNQMvYyr"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B27960F4F;
 Mon, 27 Sep 2021 17:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632764869;
 bh=uVl5ACrfcIN4ooLozQqnr+TxY/foOGM8sxO3/2FeKmA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QNQMvYyrlucLrAj/mojcJ6teenH0XIbkgaKGCP5hU+C/SM/xyIahSoUV5YTjZJrby
 fhC5CpftHyxMt63kjp9F90FdWcMgCdlrZQ7bMqqOfATdTTumlnaDqxdAAuPJl6tXEq
 FCQLaljGKLGz70ozWu3avec/jSJqTeY+VXr+MUCkT63wr1bUaTSBNlUQ0S2jHn46Fg
 5KG+hDTfhIKS8ZuBLI/Pgx8mgeA+q+i96ZHJm/ituutWJUQz6Ch9kjDSMEpUp255IP
 ZTOz4gMAY1McPbRH33GNldBwXkW4Mm3ztaoPAU2LpwnMQQfsK4mNecoW8NeiXO81In
 fs8yUL1jH4QTQ==
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: wlf,
 wm8978: Fix I2C address in example
Date: Mon, 27 Sep 2021 18:45:41 +0100
Message-Id: <163276442023.18200.16335825617425254658.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <c99fc865e3fca6ea623661c52de7dc6a3c36c8b4.1632487554.git.geert+renesas@glider.be>
References: <c99fc865e3fca6ea623661c52de7dc6a3c36c8b4.1632487554.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com,
 Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime@cerno.tech>
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

On Fri, 24 Sep 2021 14:47:32 +0200, Geert Uytterhoeven wrote:
> According to the WM8978 datasheet, the address of the device is fixed as
> 0011010 in 2-wire mode.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: wlf,wm8978: Fix I2C address in example
      commit: 9208d3ca8cb65748e436c224ed63dbba4a60a3d5

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
