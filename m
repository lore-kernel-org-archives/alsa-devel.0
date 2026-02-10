Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A820EB26E9
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Feb 2026 17:03:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E79B60218;
	Tue, 10 Feb 2026 18:03:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E79B60218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770742995;
	bh=GKxMsvF8513dldSNQ4piHGgHfcbGjskmI0BUIrYWREA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WVe+y2R0mOCLZ2i1+YEUsDrmcN0elJQEbjPbGxiqtkknKK5qYnrCAYIQDjgL2fHca
	 77gWHbpNK2F82fKq//2tf1415zC69hiTl67dAbY+l2kmOjeoawhuK+bbyxcLycaFC9
	 eORCx1y6NfNM+hiNB6vg40VFCjNIfqFt6ahNOPbI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA1F5F805F3; Tue, 10 Feb 2026 18:02:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CDC2FF805F0;
	Tue, 10 Feb 2026 18:02:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6327F801F7; Tue, 10 Feb 2026 18:01:27 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 142C2F800BD
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2026 18:01:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 142C2F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YyiwPKiQ
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2EB3B443D7;
	Tue, 10 Feb 2026 17:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFF6C116C6;
	Tue, 10 Feb 2026 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770742870;
	bh=GKxMsvF8513dldSNQ4piHGgHfcbGjskmI0BUIrYWREA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YyiwPKiQ0qKyweuyY9xgnBf1hKbeDkIau4SqiZsjSXoLRpuVS3XmIwKutR3JVpPG4
	 6IF1iQOLh+eBf/Iu7zMMTIsUGyrT4ibiBZrCDwn8zXtLSDuu8HDt3qcZZDLffO4I0G
	 7QZ0WFt3dKec1XYKPP9ygWE1ILfnssQsGYXYkBRA4zT5EgHMCSUGL5/qdffD/EuWVK
	 0vMY5nFqjoZMUEmPhJ5Pp4CRdfH0eerZKolqEYM/Lmvti2wQdN4eEtonEFIKZiJ+O4
	 2RBLC9EyKT0S0MUPYT/3135oU+DLr2IQQcUo6MiOAhznePs97+gM3GLD/HMmz7f+U7
	 RfvoB6SWUMEiA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, shumingf@realtek.com, derek.fang@realtek.com
In-Reply-To: <20260210074335.2337830-1-jack.yu@realtek.com>
References: <20260210074335.2337830-1-jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt721-sdca: Fix issue of fail to detect OMTP
 jack type
Message-Id: <177074286825.290644.270301711122471622.b4-ty@kernel.org>
Date: Tue, 10 Feb 2026 17:01:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
Message-ID-Hash: 2FR7SAENVONTGUEC3EW4OWSYYWWWMPFF
X-Message-ID-Hash: 2FR7SAENVONTGUEC3EW4OWSYYWWWMPFF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2FR7SAENVONTGUEC3EW4OWSYYWWWMPFF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 10 Feb 2026 15:43:35 +0800, jack.yu@realtek.com wrote:
> Add related HP-JD settings to fix issue of fail to detect
> OMTP jack type.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt721-sdca: Fix issue of fail to detect OMTP jack type
      commit: 5578da7d957fbaf91f6c39ba2363c2d2e4273183

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

