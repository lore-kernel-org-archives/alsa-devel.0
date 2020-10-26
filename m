Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF29C2D0A3
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:48:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C8820773
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IYhHs04w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM/xoo0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C8820773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0EA116B2;
	Tue, 27 Oct 2020 00:47:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0EA116B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603756081;
	bh=yizclJtwFHsgpdbAeytsLNpgwGTh0czj9w5bj6puFao=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IYhHs04wmNCGcjtOCPXKJ3o+JQijW5Eyv13kstBeJ4FaLT6Zilf1tYNt/q4Venx8X
	 OPPZlTqZ+YQkSiXmFbT283hnm+xKtRSUEO5Bfb6jSb4mCxKikTo4LZkN6DDs9bQGmQ
	 qBU2LDs+KHS0J2VI0MZyQl8zWXOIosSKFdas9vUc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B7BDF8027C;
	Tue, 27 Oct 2020 00:45:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3FEA2F804BC; Tue, 27 Oct 2020 00:45:47 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBB86F8027C
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 00:45:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBB86F8027C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HM/xoo0i"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E02C420872;
 Mon, 26 Oct 2020 23:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603755943;
 bh=yizclJtwFHsgpdbAeytsLNpgwGTh0czj9w5bj6puFao=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=HM/xoo0iHClbn3JNr7iBUB8MqDDL+S3IgGq4nMlUf5NisfoG+WdcI3CdUZKBkFTLW
 vj+Yue/oLQuqXpd9x3pvqu/Xlhytm1uOixd5CTmdsDFw6H1bnnuFJtIpKSiq918E62
 bpYGx+6MTtYDUlL6yIXNHJcizQe1K0Rx7S7LumfQ=
Date: Mon, 26 Oct 2020 23:45:39 +0000
From: Mark Brown <broonie@kernel.org>
To: mark.rutland@arm.com, lgirdwood@gmail.com, robh@kernel.org, perex@perex.cz,
 tiwai@suse.com, alexandre.torgue@st.com,
 Olivier Moysan <olivier.moysan@st.com>
In-Reply-To: <20201020155709.2621-1-olivier.moysan@st.com>
References: <20201020155709.2621-1-olivier.moysan@st.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: stm32: convert audio dfsdm to
 json-schema
Message-Id: <160375592348.31132.11289357992457782423.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 arnaud.pouliquen@st.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
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

On Tue, 20 Oct 2020 17:57:07 +0200, Olivier Moysan wrote:
> Some audio properties documented in st,stm32-adfsdm.txt are already documented
> in Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml bindings.
> Move remaining properties from st,stm32-adfsdm.txt to st,stm32-dfsdm-adc.yaml,
> and remove st,stm32-adfsdm.txt.
> 
> Changes in v2:
> - Complete st,stm32-dfsdm-adc.yaml rather than converting st,stm32-adfsdm.txt
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: stm32: dfsdm: update audio properties
      commit: f24fd10bea5961629f22e1da0f56e8c918bdb2da
[2/2] ASoC: dt-bindings: stm32: dfsdm: remove stm32-adfsdm.txt binding
      commit: ea8650730332ee3c707883a2de37756ea9122981

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
