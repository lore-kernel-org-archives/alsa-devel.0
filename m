Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19D3C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 16:45:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9A764DB1
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 16:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9A764DB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CB6B1616;
	Fri,  5 Feb 2021 17:45:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CB6B1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612543552;
	bh=PXiONkiHLFyycY0uLa3iLGkOkJkNgYGXd95uCU3KPkw=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o/uurdKlhXiaKMOds/p2ot/boFgJgK9lHE+9dHQX7tZngpSbu6n11yII+9DBAH0G1
	 qwRSMUcnczlfLPDMzZbrxFBW5G+uUq5+4YC/+/ZQN60JbTHqVzf3aWWaeRAVSt+8LL
	 VtDwlCXZZi3rXB9JT6k2V/5hXMgvH5xwnF1JcaRc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05F00F80156;
	Fri,  5 Feb 2021 17:45:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9796F8015A; Fri,  5 Feb 2021 17:44:59 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41FC5F80152
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 17:44:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41FC5F80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="d/emirZY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33D8064E41;
 Fri,  5 Feb 2021 16:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612543490;
 bh=PXiONkiHLFyycY0uLa3iLGkOkJkNgYGXd95uCU3KPkw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=d/emirZYV79/LFZ3gcUyV5l56jL3WETg3Tl0W4quAHJh6baGjqwHdUigr3RvkssZH
 7rRo6FTU+6yosPVjiSmbpm8FL8oBmgElYdmGmuZFRgnPXm6i8//rWwVhypXA3JKmcO
 O7ZS5z7EfOOO0QGYylkGCv4xQDyvsz1hylOMW1XSc1sf2r6Q8+NAMLGKWrOiAoEt/Z
 En8YP9+vOpYDBoye/bsuuNPQHN/wGrGCM3JfqhN7+SSXu9Wn5BVTBwyt2h20lJ+YMw
 fwRyeHwERI/4RHORm7R4JYB5loFa+XrnhHiOv7/2chbT1vJm9SmJSaDVLc292zgxH9
 V72ed8/lbTvpA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Olivier Moysan <olivier.moysan@st.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, Jaroslav Kysela <perex@perex.cz>,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20210205104404.18786-1-olivier.moysan@foss.st.com>
References: <20210205104404.18786-1-olivier.moysan@foss.st.com>
Subject: Re: [RESEND PATCH 0/2] ASoC: stm32: i2s: add master clock provider
Message-Id: <161254344059.9495.3602816971823494322.b4-ty@kernel.org>
Date: Fri, 05 Feb 2021 16:44:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
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

On Fri, 5 Feb 2021 11:44:02 +0100, Olivier Moysan wrote:
> Add master clock generation support in STM32 I2S driver.
> Resend of patch https://lkml.org/lkml/2020/9/11/264
> 
> Olivier Moysan (2):
>   ASoC: dt-bindings: add mclk provider support to stm32 i2s
>   ASoC: stm32: i2s: add master clock provider
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: add mclk provider support to stm32 i2s
      commit: df91785a22e2505d2ac668f1d3e6b6e6d8ba627a
[2/2] ASoC: stm32: i2s: add master clock provider
      commit: 8a262e614ef8675cfde924c6ddf873a95db0be6a

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
