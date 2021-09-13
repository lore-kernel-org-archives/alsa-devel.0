Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AFEC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:57:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B1F60EE5
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 68B1F60EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E71DA823;
	Mon, 13 Sep 2021 12:56:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E71DA823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631530661;
	bh=dKyuENB8A3Ycf/zD5d0D3HH7xLt8SksRb/tephXNBSs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cCc+o+tfIlszRa6g+bLsEp2GxqoU3FFD3BjKnYNb2VnFVpxX372lJocA3TJFcV/dZ
	 XW1/V6nxZR2UjDoeMzPqSCSL70bUroeZiPoMF2z9Xu4v1ebj8Xt4gAxadkbne5RmCm
	 VcPt4hHyCJx8lIIg4FL4W8v8vcDIq0onSmHP/Pbo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2922BF804FF;
	Mon, 13 Sep 2021 12:55:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25475F804F3; Mon, 13 Sep 2021 12:54:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4F1EF804AB
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 12:54:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4F1EF804AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OSSTZV2d"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0D8661056;
 Mon, 13 Sep 2021 10:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631530490;
 bh=dKyuENB8A3Ycf/zD5d0D3HH7xLt8SksRb/tephXNBSs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OSSTZV2dF3mTQ/9Vm/GyVqbj/uN5ZzRAByxJwPuQ1Qlogd6HU400NExj6BAUnomeE
 MQI7vY5Xxz0CsIg4IVapo2oCmNuRGHVe86hHkDmfGNJ+qfNhe0uS22fh93cpfNNVp0
 /k6gtkLk5ssAhXs+MHNO6qV/V4w/DfaxbTEM/UsxzYLi//Zl6AAzzAHVCRfXMHaxsK
 TWb3GANp5RYzjAN0nupkjbJU+VFbyPhhDMfO31i1ElaV939uyOl64bDY5Yg6TKSsxc
 GVeF9upXt6EUEU3idSN6+8jdOWuv7RGeAq/p/EvsKkATQ5F1oc2Ar40RSXsXDTm344
 mgwU2BhNR5thA==
From: Mark Brown <broonie@kernel.org>
To: derek.fang@realtek.com,
	lgirdwood@gmail.com
Subject: Re: [PATCH v2 1/2] ASoC: rt5682s: Add driver for ALC5682I-VS codec
Date: Mon, 13 Sep 2021 11:53:19 +0100
Message-Id: <163152996584.45703.10295940257693172145.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210831130258.19286-1-derek.fang@realtek.com>
References: <20210831130258.19286-1-derek.fang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, albertchen@realtek.com, Mark Brown <broonie@kernel.org>,
 shumingf@realtek.com, albertwang@realtek.com, flove@realtek.com
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

On Tue, 31 Aug 2021 21:02:57 +0800, derek.fang@realtek.com wrote:
> From: Derek Fang <derek.fang@realtek.com>
> 
> This is an initial codec driver for Realtek ALC5682I-VS codec.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: rt5682s: Add driver for ALC5682I-VS codec
      commit: bdd229ab26be9aa3306d01787e1467db92df6603
[2/2] ASoC: dt-bindings: rt5682s: add bindings for rt5682s
      commit: 50159fdb144b73984873bf2eeb9ff45d10a67f3a

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
