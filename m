Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE17EB64DD
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Jul 2023 10:56:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8394A886;
	Fri, 21 Jul 2023 12:55:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8394A886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689937001;
	bh=GqMqpNt1ykUMAT67xmcy7JW79ykixqQxUJAP3ZLHy7Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ctByBmd6vv2b5XZWl5cuMHNhPBaTRnQmiNgtQYmK06x3iPHaSRqQm5nGIDKW8gSL8
	 1SHG/JZl19rcq50G2B8W7c1U2pHCsQWFIP9qCp7O4jK/aa82rj+JL9AvdgS5g4w7cz
	 Ntiw5R0qFZFT5n8Qzc1QvYHTi3CB/JFNMKzqOIR8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDF64F80568; Fri, 21 Jul 2023 12:54:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 75CF6F80549;
	Fri, 21 Jul 2023 12:54:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0BB9F80549; Fri, 21 Jul 2023 12:54:54 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 391E2F8032D
	for <alsa-devel@alsa-project.org>; Fri, 21 Jul 2023 12:54:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 391E2F8032D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=H6oKC7Rn
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DD336619E6;
	Fri, 21 Jul 2023 10:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137D2C433CA;
	Fri, 21 Jul 2023 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689936887;
	bh=GqMqpNt1ykUMAT67xmcy7JW79ykixqQxUJAP3ZLHy7Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H6oKC7RnJUObIQkeWee7W1FwQF/unFVJ6PUyFra3PektbsEnuWJpN3aIT9DWNHkAT
	 HE61fRsuAA1DFbxHzjKcjJ/h78pRhYedwbtyGa76cBciYQ2n6ha6+D6cLzHwxnUaBM
	 ZRZyjXTaOE5a6XwmVuIH6118nrz8wHNPz8Z4eFXwv9ezB4rZ6/IZWeR+MYfU6p6CDU
	 SI88R/eecOlzLiyiFlMiFIGTUMJ9vB9PNDSMyzwwHHgtaOxOldFtQ270YXykzba6XA
	 wNKxzYr8KKPPG0SyUzrzEyxL4M2+Qwg7hdhpNGKaKICjDQAQ8bJ74tiTG9zD46Ykcy
	 DM/Wg0FHwNwtg==
From: Mark Brown <broonie@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
In-Reply-To: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
References: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
Subject: Re: (subset) [PATCH 0/6] ASoC: codecs: msm8916-wcd-analog: Cleanup
 DT bindings
Message-Id: <168993688478.20527.15549284339710004321.b4-ty@kernel.org>
Date: Fri, 21 Jul 2023 11:54:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: ZSUKAUGY5BQDDSFNS43FZ3DSCZJEU3V4
X-Message-ID-Hash: ZSUKAUGY5BQDDSFNS43FZ3DSCZJEU3V4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZSUKAUGY5BQDDSFNS43FZ3DSCZJEU3V4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 18 Jul 2023 13:40:12 +0200, Stephan Gerhold wrote:
> Drop the redundant reg-names and mclk from the PM8916 analog codec.
> Having the mclk on the analog codec is incorrect because only the
> digital codec consumes it directly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: dt-bindings: pm8916-analog-codec: Fix misleading example
      commit: 944b5c7146fbd0a68f501d9a8a87c3fc5767a3de
[2/6] ASoC: dt-bindings: pm8916-analog-codec: Drop pointless reg-names
      commit: dfc491e55255a96b2d43cdb74db10d4222890769
[3/6] ASoC: dt-bindings: pm8916-analog-codec: Drop invalid mclk
      commit: 469c6d9cd1cfb468f01a15f940272504a6b5d083
[4/6] ASoC: codecs: msm8916-wcd-analog: Drop invalid mclk
      commit: 97f29c1a6143762626f4f9bd9fc2f8a2282b9dcd
[5/6] ASoC: codecs: msm8916-wcd-analog: Properly handle probe errors
      commit: 5c0f9652da47061ed3f7815c1dfeb205c545ce54

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

