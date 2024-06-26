Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B005C27C4F
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Jun 2024 17:20:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CD7C1919;
	Wed, 26 Jun 2024 19:20:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CD7C1919
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719422444;
	bh=6bDz9wWMrdHE4fDttMscdwNgAToHlOtFCniRubOfIV4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qKSKIdjsAE2K1E9aziAg5P0yKfqG30Rde1G9i8JdbLgi7hTIDM2LLRXSmEu2u+Xo2
	 k/Ui2kPyf3SgFVMVFQ1IFHNbTRj/A9tfeMyK7QdofxJkiEtU9KJDWFwalXb6CSkCIe
	 ruAufOSguQgwoCLBWJ1i2V/SIvbcDNkE5+HAJMxo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B93AAF805AC; Wed, 26 Jun 2024 19:20:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C670F805A8;
	Wed, 26 Jun 2024 19:20:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F3FCF80423; Wed, 26 Jun 2024 19:20:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B9295F8013D
	for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2024 19:19:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9295F8013D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DnDOnlxx
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5450F61BA6;
	Wed, 26 Jun 2024 17:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69ADBC4AF09;
	Wed, 26 Jun 2024 17:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719422382;
	bh=6bDz9wWMrdHE4fDttMscdwNgAToHlOtFCniRubOfIV4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DnDOnlxxJbQfESrCv+CGB+a6A0vVsAEuCZBl7KKmkd5OgT2Tr+0pQKRvswxlJjuOp
	 KEwbavfWtTR7YHo0IpSF6HLpPDjuhiilysDUoh594XZVofaKcToEIqdJTN+ic7U9B9
	 BuAlMigf32r1cRsnUH3VWiqh6bpglLq/gCvUKp6qZji9K3VC/UO3B9nLIqS2z4VhRp
	 z6j+vB0NazsYjgjCXIUz+lIEHOlQForoVSoz54Jo92Md9Hy7zGuuF/aVWCWTpKrhM3
	 mcVRWUc8T10DUDh3UKOo3os7oAyoxWU+K/0O+y607teR0Hrt46buiybdfaUMAYIBWm
	 JTfcHD0lKEbQQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Jack Yu <jack.yu@realtek.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de,
 "Flove(HsinFu)" <flove@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
 =?utf-8?q?Shuming_=5B=E8=8C=83=E6=9B=B8=E9=8A=98=5D?= <shumingf@realtek.com>,
 =?utf-8?q?Derek_=5B=E6=96=B9=E5=BE=B7=E7=BE=A9=5D?= <derek.fang@realtek.com>,
 flowind_wang@compal.com
In-Reply-To: <9a7a3a66cbcb426487ca6f558f45e922@realtek.com>
References: <9a7a3a66cbcb426487ca6f558f45e922@realtek.com>
Subject: Re: [PATCH] ASoC: rt5645: fix issue of random interrupt from
 push-button
Message-Id: <171942238016.1646283.11581560562533189901.b4-ty@kernel.org>
Date: Wed, 26 Jun 2024 18:19:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: SABUVVNE5O5SBYEST6UIXNGDP2F7PXUL
X-Message-ID-Hash: SABUVVNE5O5SBYEST6UIXNGDP2F7PXUL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SABUVVNE5O5SBYEST6UIXNGDP2F7PXUL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 26 Jun 2024 08:25:34 +0000, Jack Yu wrote:
> Modify register setting sequence of enabling inline command
> to fix issue of random interrupt from push-button.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5645: fix issue of random interrupt from push-button
      commit: 68f97fe330e01450ace63da0ce5cab676fc97f9a

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

