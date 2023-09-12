Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DC0CA0EF1
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Sep 2023 15:00:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 478E3AE8;
	Tue, 12 Sep 2023 16:59:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 478E3AE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694530820;
	bh=PYAQkJrO1WkKP0/tTTlzK5uxjkDb8XCIVszb8hdked4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=oKBKI+baKkGP8wFvObI3TFil+US2PaQ9x/TmtuWDFg337SNQedTyl7CqoAzUD3uEr
	 hVB1uCNKpLz2q52bmVz8YRfVdLOaK9jBcDsXtnXxomPRQdvbQw5Ov4LSo/UJK/1XPF
	 5JcpxLaS5399LIytxoe16KEqy/bkeGO/RXB3cU1Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE133F80141; Tue, 12 Sep 2023 16:59:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 24D4AF80141;
	Tue, 12 Sep 2023 16:59:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD7F1F80431; Tue, 12 Sep 2023 16:58:56 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7CFFBF80141
	for <alsa-devel@alsa-project.org>; Tue, 12 Sep 2023 16:58:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CFFBF80141
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=m5Y+Qcqc
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 0BD37B81DC6;
	Tue, 12 Sep 2023 14:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D200C433C8;
	Tue, 12 Sep 2023 14:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694530724;
	bh=PYAQkJrO1WkKP0/tTTlzK5uxjkDb8XCIVszb8hdked4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m5Y+QcqcgPdS3iZykO1Uxg4O8yhi1LUg8BK+y4kXxp4k/Q5j5dDC7amELHfVuedQ4
	 AD6hEkn4xBqHgv3WLkdpjMBaOc2S1sLVII6njWKYqKjB99hdbMSH5juIZ1OARg3tH3
	 m2UnbUD7ssgOykUxOSYjoYCGTWqiqieal6wvzzvln5fNp5sk1aT9CZ/AglU4sINycK
	 N0VhCev9SatYQfeYAWQQzdHJv9My/h4QKeij7hnyA+U5EKvgwkkD5GMgV7pe4R9Mec
	 pJBFu86elFFp2kPO1SQ44oMr23UTmifTZSorujIQLs6DUR2BePnDXAkp9hvaZ/J1jA
	 oWCz/in2eAaPQ==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Mario Limonciello <mario.limonciello@amd.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Syed.SabaKareem@amd.com, wildjim@kiwinet.org
In-Reply-To: <20230906182257.45736-1-mario.limonciello@amd.com>
References: <20230906182257.45736-1-mario.limonciello@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Fix a non-functional mic on Lenovo 82TL
Message-Id: <169453072328.64014.13305753532018696310.b4-ty@kernel.org>
Date: Tue, 12 Sep 2023 15:58:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: 5D7RZNY665VL73GLTKVGPG32K3QY6XII
X-Message-ID-Hash: 5D7RZNY665VL73GLTKVGPG32K3QY6XII
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5D7RZNY665VL73GLTKVGPG32K3QY6XII/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 06 Sep 2023 13:22:57 -0500, Mario Limonciello wrote:
> Lenovo 82TL has DMIC connected like 82V2 does.  Also match
> 82TL.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Fix a non-functional mic on Lenovo 82TL
      commit: cfff2a7794d23b03a3ddedd318bf1df1876c598f

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

