Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94094C54798
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Feb 2024 03:03:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E56D8826;
	Sat, 24 Feb 2024 04:03:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E56D8826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1708743834;
	bh=jEHirSoRsFxzzzcf1js6eRmSK2fDWo49/HdLgHj49Tw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eEG1qw91bTbAuIdguTBeXoOr1mRFTbYa5llleA2AhOAj2vUOQ9dfD9SKcgyZxMkko
	 NFGCpiaRYuFGHc4ho7WRbixrxESoCcmpvVMit4fis31Hq2fDt8RvVdCI/f/JV/1cG0
	 mU3Dy2ABVjcIiychayZ2izAr1f1uSSRyaIgoSe6U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D9C5F8047D; Sat, 24 Feb 2024 04:03:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5A1AF805AB;
	Sat, 24 Feb 2024 04:03:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E34B3F80496; Sat, 24 Feb 2024 03:57:38 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9AAE5F800EE
	for <alsa-devel@alsa-project.org>; Sat, 24 Feb 2024 03:57:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9AAE5F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=O68hcKkd
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4D051CE2F8D;
	Sat, 24 Feb 2024 02:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12420C433F1;
	Sat, 24 Feb 2024 02:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708743444;
	bh=jEHirSoRsFxzzzcf1js6eRmSK2fDWo49/HdLgHj49Tw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O68hcKkdWjRSKTSvsTpgAvZp/MRTn9n5lDL3wnut27hif4oe+QaI66N3qgtrYOVZ6
	 S7kh9NV/W7DT7KWldB9hECnQhpjrINkb9xzczIUbsW8pcOy/YlbR8CzC/QAWerQham
	 9nunOeoi+I3lYH65iTzQoiJQUPeD5MSg74PwjlOy+tLU6LyD9kJ46CcVHt/ndigURp
	 EN7gIcYkf5Zs4pjiqllogkRw4aOtGa470yIDu+Bn4mmrs2SfBO3YxM4roeMYf7ZA1T
	 EbVTkHRGQmqhYfEBBBaUMI8vKzylpepDv2EGuQ3Jkvsmy7I3nuQFmhMMfFDJZWDBJb
	 evWSiIzdqUe3A==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240223153910.2063698-1-rf@opensource.cirrus.com>
References: <20240223153910.2063698-1-rf@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v2 0/6] ALSA: cs35l56: Apply calibration from
 EFI
Message-Id: <170874344273.260432.989060891858906599.b4-ty@kernel.org>
Date: Sat, 24 Feb 2024 02:57:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: DBT3XJ4NNOEZ7BWEA3L7CXBFFHFB4LEL
X-Message-ID-Hash: DBT3XJ4NNOEZ7BWEA3L7CXBFFHFB4LEL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DBT3XJ4NNOEZ7BWEA3L7CXBFFHFB4LEL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 23 Feb 2024 15:39:04 +0000, Richard Fitzgerald wrote:
> Factory calibration of the speakers stores the calibration information
> into an EFI variable.
> 
> This set of patches adds support for applying speaker calibration
> data from that EFI variable.
> 
> The HDA patch (#5) depends on the ASoC patches #2 and #3
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: wm_adsp: Add wm_adsp_start() and wm_adsp_stop()
      commit: 5519ac3a7164d5d1c31879bf5b0d279b58c8e88f
[2/6] ASoC: cs-amp-lib: Add helpers for factory calibration data
      commit: 1cad8725f2b98965ed3658bc917090b30adb14fa
[3/6] ASoC: cs35l56: Add helper functions for amp calibration
      commit: e1830f66f6c62d288d2c27a7ed18ab93caa0b253
[4/6] ASoC: cs35l56: Apply amp calibration from EFI data
      commit: 1326444e93c250ff99eba048f699313ba6acbf2f
[5/6] ALSA: hda: cs35l56: Apply amp calibration from EFI data
      commit: cfa43aaa7948be5a701ad4099588cf49d5a02708

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

