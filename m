Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E10C624D0
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:21:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B26F601D7;
	Tue,  1 Sep 2026 20:21:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B26F601D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788286910;
	bh=dsSrzlawcTjVN2geYOpqAWRil+tOQyfB58l5vWcfDaA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FfNdiSA2bFus5MI90YRxB5812HBbiytEzJc1+MPRds2QbKhxf33KzuuqHz8BxVBae
	 KStlV2I3CLIjnW9RNa/3fCF0HmzyggMUNL47ZazArjQ2wju9qw0X1p/dWN3NBi0cB8
	 FDpsTN5sw+Way+ijwoK5p7AgaaMBt7KZOXVyUG/0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87A16F805FF; Tue,  1 Sep 2026 20:21:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EDDA3F80602;
	Tue,  1 Sep 2026 20:21:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73DF4F804CC; Tue,  1 Sep 2026 20:21:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788286864;
	b=gr7nZtevRVIEMC4hi+yaecMVRzUptUM+Twek6VMmSP7kWt2IlRQghC7QbUTVamS/hPYU
	 TRKH2nddqIqzi1gZqTXYrvaSYKnKQZEn9QKLIAKGarj+mHS6uHydsURIpJ64LzU9ifTiJ
	 Wio414djmHVI9T7+J1T+Clz8IsfKBPuB8N5+uw2eyXqjlIMKimmPU4O+IG48zmcGlgFPC
	 ia4eHdAzUyXTHOS0Jn1/WTmkV3sARTJuv8DoVE94j3N2jZkFBgLKbthSwtZ1wdw0ftj0u
	 H31Y13WuOF37+dsFZs4c7nRQYCok7uLyiTD978R6iFiiW2ctGwgctU7fI0hqX18s4Mw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788286864;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=dsSrzlawcTjVN2geYOpqAWRil+tOQyfB58l5vWcfDaA=;
	b=YPkGWGXn2T6LqTYaYm4YQnYnV+awarOuCvtFxbabZios2wBv9miK+D4vCrMyQBoOsAZr
	 bfIx9Il+uJ3ahp22bGkeoIougdasrKaa+HBqcNOMivvuIgWBz8gv0nS18HyRFuZvbyDiA
	 MVkOWHpNXwSE/VrCAlmMm7a7+FMpKD3Ut3vB6IfXhlo43rtI/WIKrUy8lyvTC/VsoNAjQ
	 qBuyykT5zm74JFx9MgZOK33y+PX/2mZye/lwDHibGW/fekqijyg9uQVbTKZLytvlucoJ1
	 UHYX1+/HX68KKbYIlYaRE8Jg41RxpvgxVuW8orlWmxjybVfT0ZN0FKeWLH3Mj6ZCxcA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="F2Kee/je";
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 806FCF80246
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 20:21:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 806FCF80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=F2Kee/je
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2B993600D2;
	Tue,  1 Sep 2026 18:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3BD1F000E9;
	Tue,  1 Sep 2026 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788286860;
	bh=0aquq+0zmJJq1Jw5/6+wicqtQs66ywHtJeJMa69OFkM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=F2Kee/jeLUNuQFnfBmN2R14jZ5PGwRibMLtzwAFU2hauiBuE4KvoO9aClpFDA29PZ
	 3zsdfWyeVqHLH0h9iAseMBTvllkBu1DTKmAeW2O4EX9BtNm/4dI1NIsW8rHjAtYKXP
	 s0eHDWZqx+/PUaasxXLXJWQWjit0YMZPoab6PBYkumpbEMVwppYeQCvIEFAM4ofbF1
	 7mPMgkaJ6XorZoUsF1UWuLHQUXaFz3PEoCt9wL5X+El/gPpvb0Uqg29RF4PB0+/37i
	 2U+4sRF+suW8fNJ/qJj5AAaog54ULGvOAEv4N96sycGiTLlp4HjwW4dtg0A0jHQE9G
	 mgRDWPIvpjdSQ==
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
 krzk+dt@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, neo.chang70@gmail.com, kchsu0@nuvoton.com,
 sjlin0@nuvoton.com
In-Reply-To: <20260825021644.1203076-1-YLCHANG2@nuvoton.com>
References: <20260825021644.1203076-1-YLCHANG2@nuvoton.com>
Subject: Re: [PATCH v10 0/2] ASoC: codecs: Add Nuvoton NAU83G60 audio codec
 driver
Message-Id: <178813028184.13461.14517335323075054558.b4-ty@b4>
Date: Sun, 30 Aug 2026 23:51:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dsSrzlawcTjVN2geYOpqAWRil+tOQyfB58l5vWcfDaA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqlxeI0QbnnuzssYZuy2YP/z2l0mos9U0eQfhHH
 seOHw3DRtKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapcXiAAKCRAk1otyXVSH
 0Bj0B/96v4pK3IaBuoH2rTWrK1i/wCW4nCkHpONulByjXFv9Rf6HACa9whmCDfm8zB0UEcHjVqr
 i5liq7wNqcRJdY2sPz93vxPjKqDi8B9CfqxEbAcyEz9YYdcsQRlXi5wc1cNtPn/2tGYlDqwpP/a
 aSyegolAA0TLa80YJGTCIBlrpwAB4B3ccBbajOwVAIy40FXwt6bdndZM+7xEdNCT9vvCE0MkMQ5
 6uOxBHSpSrS3iibBhNlSBaA2srZ0dU7drM5O9LCYdn1I3s0fs2I+ZCzefqaPqWG+nIgRF95iUKa
 IDVEgdhUDBt3JYxqvC7yDa6WKwlMqX/rHwwAyAhiMZU/mFjk
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 27EGF62EGS65UG6PXBJ7TNJU6HJH4EEP
X-Message-ID-Hash: 27EGF62EGS65UG6PXBJ7TNJU6HJH4EEP
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/27EGF62EGS65UG6PXBJ7TNJU6HJH4EEP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 25 Aug 2026 10:16:42 +0800, Neo Chang wrote:
> ASoC: codecs: Add Nuvoton NAU83G60 audio codec driver
> 
> This patch series adds support for the Nuvoton NAU83G60 audio codec.
> 
> The NAU83G60 is a stereo Class-D amplifier with an integrated DSP and
> I/V-sense capabilities. The driver supports I2C register access through
> regmap, DAPM widgets and routes, TDM interface configuration, and DSP
> firmware loading.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
      https://git.kernel.org/broonie/sound/c/384a0f7b5adb
[2/2] ASoC: codecs: nau8360: Add support for NAU83G60 amplifier
      https://git.kernel.org/broonie/sound/c/be88847a8bb1

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

