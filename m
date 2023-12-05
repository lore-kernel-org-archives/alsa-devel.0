Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD19FC4167B
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Dec 2023 13:13:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8970FDF2;
	Tue,  5 Dec 2023 14:13:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8970FDF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701781993;
	bh=Z6h5KHVxXcZwqHJ9jYxohUKf3Szok2IEy9KLPl804z4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Y+FpvBV3P1skINDBNyI94CQgiKI4OCljGjBB54eNXr+YEFfexuFVKdrBiBYEP4jxM
	 1IGIDgLZle/gAnXy/mmYWkZTJ2UXD0aMTxT8XUOI4fJbYFoL4bjt2eBBC8Ew9/Zl+k
	 vnt7+C23n7Y4pTq8YmVb3EhbhGZklQUsSwlL0kd0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E9AAF805EA; Tue,  5 Dec 2023 14:12:16 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 61C12F805F2;
	Tue,  5 Dec 2023 14:12:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7BF9CF80589; Tue,  5 Dec 2023 14:12:11 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8B815F800E4
	for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2023 14:11:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B815F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AkvoYi7r
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6981F61741;
	Tue,  5 Dec 2023 13:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AB5C433C7;
	Tue,  5 Dec 2023 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701781916;
	bh=Z6h5KHVxXcZwqHJ9jYxohUKf3Szok2IEy9KLPl804z4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AkvoYi7rwPmXQztcDTJXAx9e+WnZuqjVic1N58LVCOgq96vWWcFKbYSadK7vToQq8
	 cBk6dhtxSu8cU/bWwkzY/pW6NMtENaVWUvIRBHexZdGt10E9PgrADtv6gg0GDP2GzJ
	 k1IwJoamsVLpzQXcbg62lD8UPOKjO1sK/qBRF4sbEyvvFd1vfcSk+AKp6i02rFiSMO
	 2BCuhrreNOL10weBA99XVKa8TD8YWPd9Bs2+CgD2V3WdZrSgj2eJWjolhqJa6MyQwL
	 LSDPMCZ8NqLVfSp9UlxLdJB0M4y7+EywCapfe0KRzN5TQW0QlqUxd0+Adzt5m65XDD
	 vV8W/sdXPywOg==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, peter.ujfalusi@linux.intel.com,
 yung-chuan.liao@linux.intel.com,
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com,
 ranjani.sridharan@linux.intel.com, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com
In-Reply-To: <20231204135614.2169624-1-rf@opensource.cirrus.com>
References: <20231204135614.2169624-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v3] ASoC: Intel: soc-acpi-intel-tgl-match: add cs42l43
 and cs35l56 support
Message-Id: <170178191427.32878.1882562725490078312.b4-ty@kernel.org>
Date: Tue, 05 Dec 2023 13:11:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
Message-ID-Hash: G6NCDMY3EX766UMUNY7LUXN3FLTLAJUI
X-Message-ID-Hash: G6NCDMY3EX766UMUNY7LUXN3FLTLAJUI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G6NCDMY3EX766UMUNY7LUXN3FLTLAJUI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 04 Dec 2023 13:56:14 +0000, Richard Fitzgerald wrote:
> This is a test configuration for UpExtreme with Cirrus Logic
> CS35L56-EIGHT-C board.
> 
> The codec layout is configured as:
>     - Link3: CS42L43 Jack
>     - Link0: 2x CS35L56 Speaker (amps 1 and 2)
>     - Link1: 2x CS35L56 Speaker (amps 7 and 8)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: soc-acpi-intel-tgl-match: add cs42l43 and cs35l56 support
      commit: e17999750649c4bd4ba945419b406d1d1a3e92e2

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

