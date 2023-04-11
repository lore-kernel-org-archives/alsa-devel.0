Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8643C76196
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Apr 2023 17:35:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD37CEFF;
	Tue, 11 Apr 2023 19:34:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD37CEFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681234516;
	bh=iEXSKNbC985Lxi/M/SXjfyiLy2lPpRmyV98zFwJJvns=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=A4OCsiIqU/ou2oBJuo9/sngYvyMTeL9IaB4C/ugd+O7Uod6aBSnsYTjPpHmNamX7/
	 1aoJObBItM3BvIhpmXoF4KsNRInPft7dQtPNCWBfjB62l9jjxveAazN6vZmD1uzy6l
	 0SesB9AHHqNu3oH3QHLd30tYGz5WnCo3g4QkLpKU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 52279F8049C;
	Tue, 11 Apr 2023 19:34:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA99DF8049C; Tue, 11 Apr 2023 19:33:58 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 15F13F80149
	for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2023 19:33:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15F13F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Chdu1Wds
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A605D6200A;
	Tue, 11 Apr 2023 17:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F3AC433EF;
	Tue, 11 Apr 2023 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681234428;
	bh=iEXSKNbC985Lxi/M/SXjfyiLy2lPpRmyV98zFwJJvns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Chdu1WdsYBzm0fuPoVmMtmRbTkF31qUiFmwToGqm+gcugHSCAFxN5i5RNlAfWCcSC
	 6v5FB9FI/FcevYOgCwIXD421Py/dfmfqIJoIvrvLtrSYiAJBGvmeyXFgCPI8pKpFQg
	 +H2vgpsN2ysiRN5t/SGThP9gm6LVgTX0/4OZGbaPA3K0+Tkga73gV7T9AQd7x3pfE/
	 wixhcnuI9K2EgurJ+PzMoxsTUICzDnDHbRK9af3JO68zmuVpE9M2hoyd+rGcmAC3A0
	 /FZfpiz/EEDjsOzwgituEcuLltlzzxkdJ2vpI4E6rErH/i3WDuFIdSbBBbkg670eyy
	 vXdFOCjKgYzYQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com,
 Saalim Quadri <danascape@gmail.com>
In-Reply-To: <20230405203419.5621-1-danascape@gmail.com>
References: <20230405203419.5621-1-danascape@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: wm8523: Convert to dtschema
Message-Id: <168123442597.491748.3278236721968610950.b4-ty@kernel.org>
Date: Tue, 11 Apr 2023 18:33:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Message-ID-Hash: 45EWUY6MVX6NMVIRJ6SHGLBNN5PYJCVB
X-Message-ID-Hash: 45EWUY6MVX6NMVIRJ6SHGLBNN5PYJCVB
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/45EWUY6MVX6NMVIRJ6SHGLBNN5PYJCVB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 06 Apr 2023 02:04:19 +0530, Saalim Quadri wrote:
> Convert the WM8523 audio CODEC bindings to DT schema
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: wm8523: Convert to dtschema
      commit: 3e5f79723dc3f22fed30ba5a559db11b53b632ae

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

