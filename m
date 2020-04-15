Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73A5C2BA19
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 23:39:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6472076A
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 23:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gtVzb48A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgkkqn/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6472076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D18A1165D;
	Thu, 16 Apr 2020 01:38:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D18A1165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586993954;
	bh=7JQLMa1r9P+5uVg2RKaO1qFO4AfI5Die3TppthdAnqM=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gtVzb48A4OApD4QDkErQaLjzRZRuDPp0LtpHorPaHJd5ymtwLhDvlOpTzDGfMYQfL
	 EUTNw7BgZ2TPi3y1inC+Z7pJj/lJlRP4YTcejyWgCZB0tQ7uceCU3FjJjhgjppazVI
	 vhGej9bDbjO7LLAilKAT27v4Z5pxYI2Y2242oNcQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FE50F80291;
	Thu, 16 Apr 2020 01:36:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E076F80292; Thu, 16 Apr 2020 01:36:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA078F8026A
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 01:36:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA078F8026A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pgkkqn/A"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 625832076A;
 Wed, 15 Apr 2020 23:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586993802;
 bh=7JQLMa1r9P+5uVg2RKaO1qFO4AfI5Die3TppthdAnqM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=pgkkqn/A60JlXlGe4/ux04qhA+jIQ1y6X+N3KbR+YapQRZWkLg2Zgu2RAQSn88zFq
 ptHt/Fj6SVmkPrjVX31WW4XR1vC+t/bK9SMCVFfgbk6ikAuvU3yfqr6VvIxUT7Aown
 mUNfgwbxw0HChfa4WNUKWoDE+fdVc7vBEqS+qwDk=
Date: Thu, 16 Apr 2020 00:36:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20200409071832.2039-1-daniel.baluta@oss.nxp.com>
References: <20200409071832.2039-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH v2 0/5] Add support for SOF on i.MX8M
Message-Id: <158699320580.11316.13339627985998445155.b4-ty@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, Daniel Baluta <daniel.baluta@nxp.com>,
 shengjiu.wang@nxp.com, ranjani.sridharan@linux.intel.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-imx@nxp.com,
 pierre-louis.bossart@linux.intel.com, festevam@gmail.com
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

On Thu, 9 Apr 2020 10:18:27 +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> This patch series adds support for SOF on i.MX8M family. First board
> from this family that has a DSP is i.MX8MP.
> 
> First 2 patches are trying to fix some compilation issues, the next two
> are adding the imx8m support and the last one adds the devicetree
> binding.
> 
> [...]

Applied, thanks!

[1/5] ASoC: SOF: imx8: Fix randbuild error
      commit: fe17e6cdc0fefca96ba9659be4b2b07487cbf0c5
[2/5] ASoC: SOF: imx: fix undefined reference issue
      commit: cb0312f61c3e95c71ec8955a94d42bf7eb5ba617
[3/5] ASoC: SOF: imx: Add i.MX8M HW support
      commit: afb93d716533ddef20fc70e626f7b43f204cb411
[4/5] ASoC: SOF: Add i.MX8MP device descriptor
      commit: 58825cc2253986ec3a4d0d67b8b4dc30945afb52
[5/5] dt-bindings: dsp: fsl: Add fsl,imx8mp-dsp entry
      commit: 35a0f242520520dfa1e8eaf66f20d297b12e413e

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
