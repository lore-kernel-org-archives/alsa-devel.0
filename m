Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9CAC433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  9 May 2022 17:18:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A85ED18E4;
	Mon,  9 May 2022 19:17:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A85ED18E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652116722;
	bh=/vK4hUOw5XVzRCz9/q9BHaDHH7etX4k7UQOvk8DgWS8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UqxPMQKG7GC0d+qjeH2IyeObMOftsXmRxE/dzeFu/T9D9EoEawDwoNF3CIGFx9oOh
	 u6SZpXg7dlqG2IewYc5AWdUYPHsO0rwTciokYgW7dGSUik2mNTSf9GzSk9qqBtNalT
	 xb2Z+ALK+Eg+0aIoDosfyba8G50EvhZCuzIbAfgQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33A19F80237;
	Mon,  9 May 2022 19:17:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 456CDF8025D; Mon,  9 May 2022 19:17:50 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3818F800D3
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2022 19:17:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3818F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gCsrO0C+"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 675B6B81160;
 Mon,  9 May 2022 17:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4641CC385B2;
 Mon,  9 May 2022 17:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652116665;
 bh=/vK4hUOw5XVzRCz9/q9BHaDHH7etX4k7UQOvk8DgWS8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=gCsrO0C+bYZ/fHs1oJCf4AMGfTrJSzwOMuhCfjt/XmGRTrgzPIR+B6p9NmeMLZLCD
 4LudReQE+eKCtnC9S7sQ3LZ3xJwwh9xwHEUCqWGLixZsWJR/WwX9nfkEjBGwSQ4Cx4
 Wwo3bqP0R3R45UaLPOeLY4um28DSZm8LC7AA2kU3pPnxayOW3zvdRnXQGWLW5Rjrm2
 PwLjzvdU67ApymHm6qL8R0fes/Bhkw73qWkujPLE0gIVrVfxA6XYzo/ZfE02zriWpa
 vMKnO8zadPBp46V5WSXYRGii3ty1lYnyuehqGWxEcWlbY/YAZ1tRRR4RxaSYWHkVUY
 IcChFz6cpW/mw==
From: Mark Brown <broonie@kernel.org>
To: nfraprado@collabora.com
In-Reply-To: <20220429203039.2207848-1-nfraprado@collabora.com>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
Subject: Re: [PATCH 0/3] Add missing dt-binding properties for audio
 components on mt8192-asurada
Message-Id: <165211666198.1065748.1151009730882312510.b4-ty@kernel.org>
Date: Mon, 09 May 2022 18:17:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, tzungbi@google.com,
 linux-kernel@vger.kernel.org, jiaxin.yu@mediatek.com, lgirdwood@gmail.com,
 shane.chien@mediatek.com, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 matthias.bgg@gmail.com, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com
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

On Fri, 29 Apr 2022 16:30:36 -0400, Nícolas F. R. A. Prado wrote:
> These patches add properties that were missing on the dt-bindings of the
> audio components used by mt8192-asurada. Namely the i2s-share
> properties for the sound platform and the #sound-dai-cells on the
> rt1015p and rt5682 codecs when they're referenced by the machine sound
> node.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share properties
      commit: e056cf4341ae3f856f1e38da02b27cb04de4c69b
[2/3] ASoC: dt-bindings: rt1015p: Add #sound-dai-cells
      commit: 2f45536587e53a7a22024e12fbe97ef13598e623
[3/3] ASoC: dt-bindings: rt5682: Add #sound-dai-cells
      commit: 0adccaf1eac91a2c2ee6a54a6de042affe9860f4

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
