Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB71AC77B7A
	for <alsa-devel@archiver.kernel.org>; Tue, 16 May 2023 14:27:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 344F491;
	Tue, 16 May 2023 16:26:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 344F491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684247246;
	bh=Gd1J584vmP39A3tV/FU9gv4hQNH+NXQWlWPp70Q5c6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Y5WQee7esEi9CbAg7p9VR1U1U6Hkg7gYBbeqAE1I3NaXDm/KVunEcR7qLcq3An278
	 ZehxOcAIUQ9zqll6SoFjdGQGrZS89t0qMQROFac20HepBH/lVO5icAo3m2/qZh4tmu
	 kg46KUtgZWfeG3Ccu1Eh9QjIm2zbIZH40mxRdEPk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDCB6F802E8; Tue, 16 May 2023 16:26:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C42EF80272;
	Tue, 16 May 2023 16:26:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9AB79F802E8; Tue, 16 May 2023 16:26:08 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26723F80087
	for <alsa-devel@alsa-project.org>; Tue, 16 May 2023 16:26:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26723F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WAgoEKhg
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2892663AC5;
	Tue, 16 May 2023 14:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3267BC433A4;
	Tue, 16 May 2023 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684247158;
	bh=Gd1J584vmP39A3tV/FU9gv4hQNH+NXQWlWPp70Q5c6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WAgoEKhgI+kFK9TpvfCF/MtW15iIbx7X38x93AFMQkh1dmfeAQaAzJDBQZxHGyj98
	 zxdyKk+rxrDAuQ45wC+If3DpEY38UXAp4MqEqRclWJPIqH9YFyYRHgeQK6dvj3TBP3
	 Q6YDBPzhLULS+KUy4xOV3dO9GsoIRxMHxZnkpiBCKMVzoqz56OA5KYYgKCY9b9IL15
	 +1XgyvSeqxyIrcWU6dGSi9ryhYwv2YgwJXsKXbx52XNp8tTIfPWRgpnZeWl+X8ePhf
	 CdS2SlxmdjEfD+2BoXWBnj6pEOvwW2idox4yiPRDBjtYRADcz2KZREwlD3OIIFYM2A
	 nQomTo+lIqGUQ==
From: Mark Brown <broonie@kernel.org>
To: devicetree@vger.kernel.org, Marek Vasut <marex@denx.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org
In-Reply-To: <20230514225243.777504-1-marex@denx.de>
References: <20230514225243.777504-1-marex@denx.de>
Subject: Re: [PATCH] ASoC: dt-bindings: ssm2518: Convert to dtschema
Message-Id: <168424715490.430742.6586457844648461597.b4-ty@kernel.org>
Date: Tue, 16 May 2023 23:25:54 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: ZEV2XYO3WTG2PX6Y7EKQUSOXAJCLUPWR
X-Message-ID-Hash: ZEV2XYO3WTG2PX6Y7EKQUSOXAJCLUPWR
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZEV2XYO3WTG2PX6Y7EKQUSOXAJCLUPWR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 15 May 2023 00:52:43 +0200, Marek Vasut wrote:
> Convert the ADI SSM2518 audio CODEC bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: ssm2518: Convert to dtschema
      commit: 20ef7f2139ab81c9163addb2da08f2630fdc34db

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

