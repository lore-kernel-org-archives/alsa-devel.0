Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5674DD2D0E2
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:55:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36919601F2;
	Tue, 13 Jan 2026 12:55:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36919601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1768305356;
	bh=1A1NElpFwRfas98hum57Zz1hhHk4n/ks0M8UBIUrtl0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qjG5/u+7MavKroC0OfCFR/dg+lVxHDB88q1bnGIiMlSwCO6Krlpi77EiWsDTH/UkK
	 Ob0mDnWhTJfWGilinhsKAWTdSS7uR7mkwqAZbLKnfSD29yjQurl4CyOd0yPM8xCkll
	 iCXAsVSaRggPWpjz9v4BRq5gbX2hfoxueUBJt2Uw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56F8BF805E1; Tue, 13 Jan 2026 12:55:20 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C95B3F805E1;
	Tue, 13 Jan 2026 12:55:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F21B4F805CA; Tue, 13 Jan 2026 12:55:05 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7AE70F80016
	for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2026 12:55:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AE70F80016
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=vFi5/BGm
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 786E3600AE;
	Tue, 13 Jan 2026 11:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254B2C16AAE;
	Tue, 13 Jan 2026 11:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768305301;
	bh=1A1NElpFwRfas98hum57Zz1hhHk4n/ks0M8UBIUrtl0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vFi5/BGmiKelO5woyJgR6+wU+G77nUNci4gciKFuCJ9IyMhrv/kZrZhvzLJklBdZx
	 Azqu8hl7oDshqJ4ByWAJbGxOGOnH8Gy3fcrIrti8NYzst3jDI3y8rVlxcUH4rjfKhO
	 pQImv5wGFbry9ztJxIWRT9z4Imupz636YnjyYaPWfdEcmUJGdyQW1Tbd2Oc2txrBYR
	 L0QHyjadRkGNuaHvMZAgdFNC+FKls5BgQht5IG2F3fC9/BT7d10ZQ7gGYBjgCjTuoV
	 RMydmaunPkJaitJRi0s8SnpoyyfYfUHdmkwdoH1bNOErfzVR2aF9zLrU4YIUbyNHiB
	 dGNIwi0IGHZEA==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 simont@opensource.cirrus.com, Sunil-kumar.Dommati@amd.com,
 mario.limonciello@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260110064505.1485927-1-Vijendar.Mukunda@amd.com>
References: <20260110064505.1485927-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: soc-acpi: add is_device_rt712_vb()
 helper
Message-Id: <176830529888.30686.15997534667463868299.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 11:54:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
Message-ID-Hash: 344C45L4ALPY3G5WBXEDBTBPRTH2XU3K
X-Message-ID-Hash: 344C45L4ALPY3G5WBXEDBTBPRTH2XU3K
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/344C45L4ALPY3G5WBXEDBTBPRTH2XU3K/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 10 Jan 2026 12:14:14 +0530, Vijendar Mukunda wrote:
> Add a filter to skip the RT172 VB configuration if a SmartMic Function
> is not found in the SDCA descriptors.
> 
> If the ACPI information is incorrect this can only be quirked further
> with DMI information.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: soc-acpi: add is_device_rt712_vb() helper
      commit: e7c30ac379b429d439eb62ae1bb69720a6701e26

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

