Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD770C4338F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 22:38:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFDED601FD
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 22:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFDED601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EF0B170C;
	Wed,  4 Aug 2021 00:38:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EF0B170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628030336;
	bh=DOyU2sYorvQY4kQgLU4xRaU30VsJypmI5w2Lq/QPj1E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L0Bdknxgjd0BcCcTynKROZGAKCI/hy7yRbpo7+iTZNSG9y1BAviCbPK7BUILsjHO6
	 whBrVKnw8phQ/8MRhHRI00xMntf482KqcrJHp2615KZ5itKKljcwqyJkHIs/8JRuoo
	 Oda0aXkquJQWsWdfoGwc3DPcftsnTHbOm2FQpyAU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0ECE8F804F3;
	Wed,  4 Aug 2021 00:36:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE67AF804FC; Wed,  4 Aug 2021 00:36:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30DB0F804ED
 for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2021 00:36:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30DB0F804ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="mJNgikBq"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52206601FD;
 Tue,  3 Aug 2021 22:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628030188;
 bh=DOyU2sYorvQY4kQgLU4xRaU30VsJypmI5w2Lq/QPj1E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mJNgikBqAHXwSOywcGo5VU4P3Tj/C+pEjPqGfm4bXxcKiHYWMXUavkSi6zA0co2JI
 vduvjGSg09xv766Qi0TyIIhilCX1702yvctSMKWj9s6MKBZgrLhgFFzvGIkkIS/362
 u9YxQXlDK8NdjUdRtMb/+h7K30jWCuhxivhNLHUwIOV2eboUrY2IWTCupksdnJCyxF
 hG1syLWZXJX6lEjndS+S/evcbzlgWVR3lcI2IWp3WArnzq05xf/e4s7rryfRFI0Ihr
 QXkXtyoq3SvI286rw2u0lrzn16dqANM6oAAH759fErreakDGTEhRU2dYIFe493iuw9
 9GqOo0lKJplbA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] ASoC: codecs: ad193x: add support for 96kHz and 192kHz
 playback rates
Date: Tue,  3 Aug 2021 23:35:41 +0100
Message-Id: <162802985539.42099.2701841258072136197.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803104825.2198335-1-codrin.ciubotariu@microchip.com>
References: <20210803104825.2198335-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: lars@metafoo.de, lgirdwood@gmail.com, tiwai@suse.com,
 nicolas.ferre@microchip.com, Mark Brown <broonie@kernel.org>,
 nuno.sa@analog.com
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

On Tue, 3 Aug 2021 13:48:25 +0300, Codrin Ciubotariu wrote:
> ad193x devices support 96KHz and 192KHz sampling rates, when PLL/MCLK is
> referenced to 48kHz.
> Tested on ad1934.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: ad193x: add support for 96kHz and 192kHz playback rates
      commit: 0d73297e483e5b7ce197c0a923424e5dd96eae4d

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
