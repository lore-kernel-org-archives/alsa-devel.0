Return-Path: <SRS0=/b47=CC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2C2C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:34:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1214E2063A
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tTY5lCfh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z25Zek48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1214E2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 860CC1671;
	Mon, 24 Aug 2020 15:34:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 860CC1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598276094;
	bh=227dtBv6s+osOfbFZGxhSmc7Pp+0HyhRJcvJKsfk/9g=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tTY5lCfhUK1CCS6zyzmNJ2Eppjj6TjZVEWO5wNklU9pqbKLO1Vc8qAdSmvisTNbES
	 WfQQToMTF58q88IKyIoobACMk5I8s82HrQbDxxH3fppFo8hEarAXRmJ0VblZOwEeI+
	 IyF4no7nUU8bjkrFcCsHBnZGI41lPznpje+HG7J0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E36E1F802BC;
	Mon, 24 Aug 2020 15:32:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96091F8013D; Mon, 24 Aug 2020 15:32:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 604B4F801D9
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2020 15:32:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 604B4F801D9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Z25Zek48"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8482D21741;
 Mon, 24 Aug 2020 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598275936;
 bh=227dtBv6s+osOfbFZGxhSmc7Pp+0HyhRJcvJKsfk/9g=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Z25Zek48M4ObQQW2U6XdS3pJxww3Z1DSNLI8UqjLpwPj7TjLcv9jq/hDBS7TZxXBz
 PwAYzNfPyBe7m3m7hAflDuszz4SPdFZt8uk3/1PvneCwtIgK1oHyPtIOcu5ZXXkRIh
 +gvrqVF80qrTRsXNt3NvpKlh9BukPWX9YazDowiE=
Date: Mon, 24 Aug 2020 14:31:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Xiubo.Lee@gmail.com, tiwai@suse.com, timur@kernel.org,
 alsa-devel@alsa-project.org, festevam@gmail.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, perex@perex.cz,
 nicoleotsuka@gmail.com
In-Reply-To: <1598255887-1391-1-git-send-email-shengjiu.wang@nxp.com>
References: <1598255887-1391-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH RESEND] ASoC: fsl_sai: Add -EPROBE_DEFER check for regmap
 init
Message-Id: <159827589162.47809.7720594849042451325.b4-ty@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Mon, 24 Aug 2020 15:58:07 +0800, Shengjiu Wang wrote:
> Regmap initialization may return -EPROBE_DEFER for clock
> may not be ready, so check -EPROBE_DEFER error type before
> start another Regmap initialization.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Add -EPROBE_DEFER check for regmap init
      commit: c1e47e8919da525c803d1557a30e44441db1e5ee

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
