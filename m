Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4AFC4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Dec 2022 17:31:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8E1F1890;
	Mon,  5 Dec 2022 18:30:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8E1F1890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670261458;
	bh=9Bv5VAebQCBrUk+ze61/ojBiqIgNhZa2+JQ5Gajt0wY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lOsQ7XOn+hBlRh8e5zByM+KWZVVTQ27E7Raa+tzSjfQFMQXkQqaNe5vKmvaDChtk7
	 4LB65bLk4VYJUYyx45vFUClaceFeVZDqaSKXYhxFdxwdpeR2vcJ2m107rt2FKP+Uvh
	 ytzVlccL9M+OHnWDt0c+YV1S/FX7DWQ2IqnWqf5Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EFCFF80571;
	Mon,  5 Dec 2022 18:29:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B928FF80578; Mon,  5 Dec 2022 18:29:29 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 912CBF80567
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2022 18:29:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 912CBF80567
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="P7mSE3ar"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 74504611E8;
 Mon,  5 Dec 2022 17:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66111C43470;
 Mon,  5 Dec 2022 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670261363;
 bh=9Bv5VAebQCBrUk+ze61/ojBiqIgNhZa2+JQ5Gajt0wY=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=P7mSE3arucma5t0M0p6afPox4bqYjk/9lMR/+AFc3hMkwfv+9p/pBufC9gQxcEOOY
 P5B8sjTHRE7MinEWglzwsPwU0Mm0rv1srFss1Qd0H7d90Sd5cXjTKmFOu9ASodoREl
 bzEPRRMkps5Q+4XbB/Ze7yXSh72x94v0INK5KKFHDMBJDROs3Z1/Y+HUclqxHkHLOL
 usTipOaJhVd3LT3q7yukczO75+P1HoT4qt2OK05K19WVA+4ud1yiN0OhThsBhe8u0U
 8xsQ43SNuWF1fhTReWDC7umuRBhYjWZJ7hn+D1XraWjTgcSoEiUQSrYZr6dUuvanwb
 XDljV16IB/g9A==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, 
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 "Paul J. Murphy" <paul.j.murphy@intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Daniele Alessandrelli <daniele.alessandrelli@intel.com>
In-Reply-To: <20221203162144.99225-1-krzysztof.kozlowski@linaro.org>
References: <20221203162144.99225-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: Drop Jee Heng Sia
Message-Id: <167026136113.536379.13410215961783875750.b4-ty@kernel.org>
Date: Mon, 05 Dec 2022 17:29:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
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

On Sat, 3 Dec 2022 17:21:43 +0100, Krzysztof Kozlowski wrote:
> Emails to Jee Heng Sia bounce ("550 #5.1.0 Address rejected.").  Add
> Keembay platform maintainers as Keembay I2S maintainers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASoC: dt-bindings: Correct Alexandre Belloni email
      commit: 1cd7de447cbbc49876f4df3f269b0562b8fe5b2f

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
