Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5DCC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 18:43:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085C964E73
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 18:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085C964E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 717E6169E;
	Mon,  8 Feb 2021 19:42:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 717E6169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612809801;
	bh=CJBhjWAM0Ayfhy6Hcc9oYoGWHxulMFA1via/SRFRbE4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K0/kfqLFBFPknKDbrnd2Sg0jBqJRxZnzoEk4T8xxtCXbfC/8k64wYVYDe0VG8bpTH
	 QILNwx52xV+stcmvNUGMecwKE6d6eLuFa5NdYm27lJFqCJrJu3np9JG07mFoA1V1Kb
	 IPHEcaoJuJpBsxfEJKu+apByeKWdSGFC9UAw8Mnk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91E6DF804CF;
	Mon,  8 Feb 2021 19:39:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95C88F804D1; Mon,  8 Feb 2021 19:39:55 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3C3FF80431
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 19:39:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3C3FF80431
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qTuq43fT"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35CE164E6F;
 Mon,  8 Feb 2021 18:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612809590;
 bh=CJBhjWAM0Ayfhy6Hcc9oYoGWHxulMFA1via/SRFRbE4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=qTuq43fT9JiU6JCVKTXdoqWAHbB+dyWjRcvlsXslgXSmAu3Tg7ROF+T2qmSE9nx6j
 R0sCCxSE6AD8MrYCkwTHz+UgDd+No6YG1Q8TtfZ+xHOB38wKxXQblOFnnFxFKidDpV
 hZ16ydxM5QUhu8hhUMoeIppfZU4GzoGR1SkV15xMI5SeMo0FQGGin15JYlBHzAyINu
 RKISlXFa8xh+DTQ68CPWHr9SX/0S81e+6UHZiuSvmR9TsIGf4yMNI1QRG6Rh1E5QqK
 vhYtSTbxMAN5j6HRgWF4eoEH0ARJNRIzBu9lvPhWcpCzeQ3G1iSgZPeHFH0O31bryP
 QkPgJMnMDv7KA==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20210206142753.536459-1-festevam@gmail.com>
References: <20210206142753.536459-1-festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_esai: Remove unused 'imx' field
Message-Id: <161280948304.10741.16839342556781704787.b4-ty@kernel.org>
Date: Mon, 08 Feb 2021 18:38:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org,
 shengjiu.wang@gmail.com
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

On Sat, 6 Feb 2021 11:27:53 -0300, Fabio Estevam wrote:
> The 'imx' field is not used anywhere, so get rid of it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_esai: Remove unused 'imx' field
      commit: 40bd053bc8e18b68e877bd4cdea1b6938ddf5fdd

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
