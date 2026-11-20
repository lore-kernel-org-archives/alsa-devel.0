Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3D606A320
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Xb5lTyYq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2yehk+z
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B07F760199;
	Fri, 20 Nov 2026 18:44:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B07F760199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795196688;
	bh=w+ngpUDZBZVs+uIe3ql7UJZ0fyaMW6XlFX9OldcDsmc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Xb5lTyYq3KRlw12zVs4Lmzw5xVdo8/BNAi1pBg7W6IyXNy2r9LvNeqd/bziXHmGrz
	 uNYgTgs1GAyD7MGNSBHF3cdGwobLyaHGD+XZSTY7xo4J251O8TIXPPkCTeRPSruuBZ
	 2qiHKPXrjKVGsQxLejgcBK67I0rZz/Yo9YmYydys=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7D122F805FE; Fri, 20 Nov 2026 18:44:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BD661F805FE;
	Fri, 20 Nov 2026 18:44:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A719F8025F; Fri, 20 Nov 2026 18:44:07 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795196643;
	b=VOkMLOiCzdcwOtcm1BFAVZ2AvAnjER+1U5HDM8qOt8vmGOijfkEtMkPXWQhWnB98s6H7
	 4ZMcVTxjQc7FmCHK4DGqmeQfFdW6SZxfAANvvgqDsawheyETkUlqT9VdrkV26v5TJgOgu
	 KFihjF6+Vv4TL3ALASisdCGZj7x5SX+vIwGkG+DkFbbhxP5wcpsJpfE64wulDoUOQSoo7
	 lpw97XmQZ7qjKCDVhgypHoe1bDfgzg3T1eLlZ7N0HKOGLkVBvwxv4lZhfoyzbial4QYvY
	 RWlG1Zl85GDmHTBry7rSkFIpCCkibA4XWB2wklqJxPiHW98uzWGhcaH9rHdpW0dkBXA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795196643;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=w+ngpUDZBZVs+uIe3ql7UJZ0fyaMW6XlFX9OldcDsmc=;
	b=VaAsl+fNRlECfB2iVMMOVrNc/yYS02ELfXdupjPPgGu5KqhtDTmBO07BDY8XeOdj8U9b
	 PJ5uUUCGqqCFlTz5cubu9MbUPoyFaJk/MSKcTUkNe2y2d5pjveKbaAj2OyzMHxGp6hUqa
	 H70OCD3ZTanpEQMOJTHqVrPNuklVLqHjZDp7zayxbtJwGIsEoxciOWVQVaPfweyz6RR3L
	 Vvv2H3HedtRh178f+X6uOgCErmJ30HW/i3jZzMq1vZGLzaGDM/ZD4C96BMtMh7cgdy7OM
	 WrbN6x/EZFeNhtd1ZkJSH4HdrHpwkBfJ0I6OC/1nbNN5pv0En09rB2bk9ZgWMD1Mm9A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=K2yehk+z;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7BAE3F80152
	for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2026 18:44:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BAE3F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=K2yehk+z
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A4522408EF;
	Fri, 20 Nov 2026 17:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806E71F00AD3;
	Fri, 20 Nov 2026 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196638;
	bh=xat0mH4UMjxmPRzKNd3e0XnLZwP4P1uMlabaEm86BqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=K2yehk+zF0NETZVxwSIsQIUmU95o7SfgWlZuZx7RFV21aApbwDR3LprOwvVVf3Pkc
	 +oUtPFq71jL5CZdYZI8QEoL7XXZJHMfFqNf5VdSm65y8rgN487yybM2bzetZkD2FAQ
	 AIpl9VXFhsRbx1UGcawdzzcLhINCFO6vFS0mGk/CwlX+ib3zmmvaxrE95/TttiFzbi
	 V125oXol8cGLMJTWdfAGajESnfQDvhPWwEdfFOpa+M66seY/BSBXZQl/vcfy+CuoWO
	 rfbVkqd31w23owUQdQp7migxQacU8KCqS9LCyG/GiulcNaEpL2l4xN4CLl833UgcHr
	 2khwVcPMVJwjw==
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
 krzk+dt@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, neo.chang70@gmail.com, kchsu0@nuvoton.com,
 sjlin0@nuvoton.com
In-Reply-To: <20261118084214.527804-1-YLCHANG2@nuvoton.com>
References: <20261118084214.527804-1-YLCHANG2@nuvoton.com>
Subject: Re: [PATCH v3 0/2] ASoC: codecs: nau8310: Add NAU83G10 amplifier
Message-Id: <179519003077.6016.13854568103739443276.b4-ty@b4>
Date: Fri, 20 Nov 2026 15:53:50 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579; i=broonie@kernel.org;
 h=from:subject:message-id; bh=w+ngpUDZBZVs+uIe3ql7UJZ0fyaMW6XlFX9OldcDsmc=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIZ2m7Fv8qdsWW93YkZE45tf3+3bons9qZNtUkhXA9C/
 gmY8Hw06ihlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBEltUxMpyoXLis96yHjuv5
 H++3x578fvPKJeXyV3Z7vymyh91+cy2D4b9L1aWJR19Pce59U8P5dv0fRpWmwq+uK00sIxlePp9
 1mY0TAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: ATSWGYKSMCJILIHLYGPSZFQUP5D7LBIK
X-Message-ID-Hash: ATSWGYKSMCJILIHLYGPSZFQUP5D7LBIK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ATSWGYKSMCJILIHLYGPSZFQUP5D7LBIK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Wed, 18 Nov 2026 16:42:12 +0800, Neo Chang wrote:
> ASoC: codecs: nau8310: Add NAU83G10 amplifier
> 
> This patch series adds support for the Nuvoton NAU83G10 audio amplifier.
> 
> The NAU83G10 is a mono boost Class-D audio amplifier with
> an integrated DSP and I/V-sense support. The driver supports
> I2C register access through regmap.
> DAPM widgets and routes, TDM interface configuration, and DSP firmware
> loading.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/2] ASoC: dt-bindings: nuvoton,nau8310: Add NAU83G10
      https://git.kernel.org/broonie/sound/c/27d854b5e925
[2/2] ASoC: codecs: nau8310: Add support for NAU83G10 amplifier
      https://git.kernel.org/broonie/sound/c/8aaede9ea8ac

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

