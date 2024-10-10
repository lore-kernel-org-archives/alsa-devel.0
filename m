Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6FACF11CD
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2024 11:14:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 096D3AE8;
	Thu, 10 Oct 2024 13:14:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 096D3AE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1728558887;
	bh=N1J0c00xF4NMJoFCUT3x71AcINhMHZp3TIW89fwCbqM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JDBurXTYO3/NWN/Fc89G4XNrGZ587MDbkdgWaJVirp/KiEXcBLuuJgn4FDfWboe68
	 43iw6z0vYEdub4gTCb3cP1/o81LAAPJcVW0qnigjMBnEWxsnLo88hpq1jhpUng5JUs
	 ZKNX6B1ISzS5qgXD7Ez+Owd3bp4ufFvITviPFIco=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E28FF805BD; Thu, 10 Oct 2024 13:14:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B52E6F805B5;
	Thu, 10 Oct 2024 13:14:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EBA85F80528; Thu, 10 Oct 2024 13:14:05 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B759AF80104
	for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2024 13:14:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B759AF80104
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ax4oO6M4
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1212D5C6042;
	Thu, 10 Oct 2024 11:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6070C4CEC6;
	Thu, 10 Oct 2024 11:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728558840;
	bh=N1J0c00xF4NMJoFCUT3x71AcINhMHZp3TIW89fwCbqM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ax4oO6M4qd9U487iiOIRCIcauvbCW9EeIvZNsE+/FIbpoD6wZRR2PsuFwCYaqLw0G
	 ajqAifFrlHoa/rGddMU3Z5yXi4aRPhhRefBUzg3LJbPh0aG7kpayn7K9Tvm9BlZW3C
	 jJGnBHo4yPs+nFK0hUAmkFe8/+zsuSFqsptJghWQRY6uOYUYewwwwURlsv4F6GXRA6
	 arU21rm7kjR+VnYwqEwOz/SJgoqkMRVPj92Buk2wNjRF8O7XUiqRphB8AgYnO9crZ8
	 fS/GDMIMtBoPWqIpsMCWP/9U4ooDxgGaqrHGRJ1FDAVJMfnECgEG+kadL+JYSj7kte
	 gJNxpVcAYOWXQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Jack Yu <jack.yu@realtek.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, bard.liao@intel.com,
 naveen.m@intel.com, "Flove(HsinFu)" <flove@realtek.com>,
 Oder Chiou <oder_chiou@realtek.com>,
 =?utf-8?q?Shuming_=5B=E8=8C=83=E6=9B=B8=E9=8A=98=5D?= <shumingf@realtek.com>,
 =?utf-8?q?Derek_=5B=E6=96=B9=E5=BE=B7=E7=BE=A9=5D?= <derek.fang@realtek.com>
In-Reply-To: <065c0b7d84cf47d3a9186235447521c5@realtek.com>
References: <065c0b7d84cf47d3a9186235447521c5@realtek.com>
Subject: Re: [PATCH 2/2] ASoC: rt721-sdca: Fix issue of warning message
Message-Id: <172855883840.3258793.6214182255139112393.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 12:13:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12
Message-ID-Hash: JUSWPKBVXHIJRYNIN5XT33CRUXGO6H35
X-Message-ID-Hash: JUSWPKBVXHIJRYNIN5XT33CRUXGO6H35
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JUSWPKBVXHIJRYNIN5XT33CRUXGO6H35/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 08 Oct 2024 08:57:36 +0000, Jack Yu wrote:
> Fix issue of warning messages caused by some variables.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASoC: rt721-sdca: Fix issue of warning message
      commit: e5553cb6612989d18229c2b03948d6b4ba5d45f2

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

