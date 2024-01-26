Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E02C47422
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Jan 2024 21:38:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B309E82C;
	Fri, 26 Jan 2024 22:38:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B309E82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706305136;
	bh=Cyr+ohTCDNTF015J2dl9lIrDXnFHUzCsBweKOJFBkuw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jc0AelLU/AQc3IG4+IjlteBZkLDd+w3lo2fFXSlj4xaE3MTWafnaGRt7S1vF0Kh4T
	 dFSTbCsd3ngtGoz4KC59jI46KPCtbk7s5J4U/v4fvMfXBHms78MhG4GfjmvGVqyQn0
	 LZ/U1hR/jVErvZB9tQxaJ6AfrsX8Q7EQQPsjcolE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DDC07F80589; Fri, 26 Jan 2024 22:38:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EF47F80587;
	Fri, 26 Jan 2024 22:38:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D60C1F802BE; Fri, 26 Jan 2024 22:38:19 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1AB31F800C1
	for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2024 22:38:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1AB31F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=KAPLvw0/
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9F7F462334;
	Fri, 26 Jan 2024 21:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC00C433C7;
	Fri, 26 Jan 2024 21:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706305088;
	bh=Cyr+ohTCDNTF015J2dl9lIrDXnFHUzCsBweKOJFBkuw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KAPLvw0/vaB0QKZx0Mo4DAoXZh5RzceBvBjcNZ7f0T1o5tZIqA+6+qFPlZi3DkuOg
	 wAj3bFB7Q+GG480+li8sMBk70or/p0ziIjQDlO+DTa7OeTVA2ZJLIUjRUATwQp810m
	 BGyLONVlk4pUz5DZarX/yzwG9KA3Z3gxe7b6MKAoplZx1Rzmd/WwmUtRaKUcJqaXrK
	 pup1pk3Sbt9jrIeE9lhgrh6LzP2DZOYtWok4k86diFPH7Co1pimFGiFQCxSo0sNORv
	 h5gff3Ta3vnKFIpA6omH23Nb9IeZRg2Q1YsT6jrCkV0UJvzwu7c1XI+wlL8mH4o7u/
	 a/Jaj13xIbnlw==
From: Mark Brown <broonie@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240124190754.1554899-1-robh@kernel.org>
References: <20240124190754.1554899-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: samsung,tm2: Correct "audio-codec"
 constraints
Message-Id: <170630508611.52716.16893175190780075572.b4-ty@kernel.org>
Date: Fri, 26 Jan 2024 21:38:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c
Message-ID-Hash: XGSTOIIVAZHPANCAR6XZ4HRKZFTU6FH6
X-Message-ID-Hash: XGSTOIIVAZHPANCAR6XZ4HRKZFTU6FH6
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XGSTOIIVAZHPANCAR6XZ4HRKZFTU6FH6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 24 Jan 2024 13:07:53 -0600, Rob Herring wrote:
> The "audio-codec" constraints define how many entries(2), but not the
> size of each entry. Each entry is a single phandle. Define the size with
> an inner 'items' list.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: samsung,tm2: Correct "audio-codec" constraints
      commit: 36553eb7785da18568de2b8ecafb3d80db1a0d6b

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

