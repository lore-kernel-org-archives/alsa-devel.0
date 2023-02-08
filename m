Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15659C636D3
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Feb 2023 18:22:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5BE883E;
	Wed,  8 Feb 2023 19:21:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5BE883E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675880547;
	bh=A3n0nGZLvj39U/jVCAMmkf50AXmyykK4cBXFyjRUEI8=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NnUcLqFuFnTjydhUkG7gVY5gUTV4YLSKumt8YwuaaDQaPIrO2QHEvshxWeWhPBql0
	 Fcvbo8Pmt8koQU90PlgYvpNBb/HejlKWP7ztuLP4t8sNxbvef2pehd1d+FJVgHGgku
	 gBFSqa5tKaKAfhwJCtj38Xay0bH+3tq2vxG0zuZg=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A313F8012B;
	Wed,  8 Feb 2023 19:21:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 271F2F8012B; Wed,  8 Feb 2023 19:21:10 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 37463F800E2
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2023 19:21:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37463F800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=vM8zBdZm
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6D335616DB;
	Wed,  8 Feb 2023 18:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7E7C433D2;
	Wed,  8 Feb 2023 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675880465;
	bh=A3n0nGZLvj39U/jVCAMmkf50AXmyykK4cBXFyjRUEI8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vM8zBdZmnGDwhC9d+aA/tyJIiVWIPa8XO+fRKKyYaZWm2mAJaM4bvsGqkucEsaqdO
	 XT1ZIWwMriMTr3+0dUHTTeKdRatMQ6cZiAach0QgAwCEERGyNfNA7dtv6WT1v+ONBY
	 1HqQTRNuYEFyucD8geWd+ttsu5Rq7/7k9XpbwQyREbKuv+aIhHp0y4Hv1iVdoWavL3
	 JkG+8qbkzEFFQGRE1/5r6HGB316meziv579/isaEvb6Q7Ei8DhwXhSLQ/vJl1rVeIC
	 BIy7RV7f/8yuOFWwu68BQm2t0U1yrhVeC840RTmMZPXlNB/TlAGlxAFUVJ78XHb1Va
	 lgaCnSivSpoFA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20230208093520.52843-1-jbrunet@baylibre.com>
References: <20230208093520.52843-1-jbrunet@baylibre.com>
Subject: Re: [PATCH v3 0/1] ASoC: dt-bindings: meson: covert axg audio to
 schema
Message-Id: <167588046319.297485.6961864943902317327.b4-ty@kernel.org>
Date: Wed, 08 Feb 2023 18:21:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Message-ID-Hash: 7VPFR3ZG3IVWEF7F45BIM2GFCNOCDZO4
X-Message-ID-Hash: 7VPFR3ZG3IVWEF7F45BIM2GFCNOCDZO4
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: linux-amlogic@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 08 Feb 2023 10:35:18 +0100, Jerome Brunet wrote:
> Continue conversion of AXG audio dt-binding documentation to schema
> 
> Changes since v2:
>  * Drop 6 patches applied with v2
>  * Drop Yaml block style indicator for multiline description
> 
> Changes since v1:
> * Drop 2 patches applied with v1
> * Drop node name patterns
> * Fix examples indentation
> * Yaml fixups requested by Krzysztof
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: meson: convert axg sound card control to schema
      commit: 65f0a8ea90d2fc2e79a616143f844047e25057c8

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

