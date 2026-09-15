Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F8AC88E75
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:09:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE4ED601EE;
	Tue, 15 Sep 2026 20:09:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE4ED601EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789495758;
	bh=TIIhdHZfImno8IHnpU61Rik0esQpnaspY0ZDNX2lqls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cZmPiSjsVwne1+ErFab/7R3RdGstOutq4EwI9qollqeF8tX9Q9xK9RaP5CT/oS3Yt
	 tjJF1ROhuL+vSrc2UIa1jW7B/hmirwH8+EZvGs+sS4aeGrEr8U/1pxllPxcxiFMSJG
	 Aa/Y2vloICLHNM4BZcCoEgIsM5/nhhGEfsqACWgE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E77B1F80602; Tue, 15 Sep 2026 20:08:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 13485F80600;
	Tue, 15 Sep 2026 20:08:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E240F80588; Tue, 15 Sep 2026 20:08:39 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789495717;
	b=SyEsIg3WGxZsRbSfGqOlS74OCa6yvMuHjrLAByFebKflK8Lm6CP83p3SazvLrskKHkRb
	 dVsG4ifeLcTV+bqJt2DmEsMqUGUWUzmhG9Tqxd3ac9NWlFv5RqNEmqJDQ7gPKRbfyonqY
	 MXMcjN90+9jDtaycxTcE272wCHXwmcUAcu7DQ8auoMCBlkKFd1xbs0JeuDKGvlSK2ng8p
	 yq42zclqmW2Md/th69o4WeqN2W+ZbPEWuJ4uB5ypEMf9qK3ye+e1HNbnR6bCqdTYXZLZY
	 Du4mPZ9PkxttaJ3EgQtWO1dDkSGKOkXF2QUoWZg7b/H8Ij4g21mpttBzZVTNjNP5pqA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789495717;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=TIIhdHZfImno8IHnpU61Rik0esQpnaspY0ZDNX2lqls=;
	b=bGX3pqhV57FxC0+NfhBRu5O1dHAKZe47WLq+lwWC5UJjdzGeoQsWweEmY0wBJ/0DmllI
	 qkKsikqezznzMHBmibotyD3x3l0OO6Exb6MJqP0qWXmqa1up58292hMhmpUX/s7L8ThFX
	 AXrDy+vk8pxC9Mm5d/x5pNcEKOmjr3ho+gBUVkJ4E+RIghHtZ+MSdBlKwratHypgEB1z1
	 wEeSlMiso/02VIubQiG8kTlGE/3N+e2XLSTv2AQh4kPtmnqQ0iOxxytWR4Qm5EXQcEKnq
	 JrSJXZb2FxfgBoOw05HvlWiYuJhZgKRDfA7fqQeJiOOfr7wkBQ4eK7pslXn2nhxSzTw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Vi+w+dk6;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BAC4CF80423
	for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2026 20:08:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BAC4CF80423
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Vi+w+dk6
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F373C600CB;
	Tue, 15 Sep 2026 18:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12691F000FF;
	Tue, 15 Sep 2026 18:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789495712;
	bh=lW0j21suN5eUTRByogg2pNvghzdTs7ZY5AtLSulagVE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Vi+w+dk6FhsXb1qhgp6kkW7LTuQRoM5GGRxAoRBHeV1XBWq7+4y4gzywvDHp0i/rw
	 7xn07dl9twQtv8MwQZZFLT64ztn1IhBKr+AUtIv88q68IU/1K/DosGX9ZTHetUcq3n
	 Gl9AfjPNnsUN1ZIThlLn4Zk0H8Kr/h/1GXXPeGlV6Txpd5v0kAd5IcZcvrtlBq3cx3
	 Au7DNqkucKI0sy2jqoTu+v++996fEClRU54Yxq+uIY3P/LOMVTKhqlkQVfVsCaGcRk
	 lesywgRYZ5z+XCVpD6uxlt8sDZ1LqH7/6GZPPaObgJYulxPzVDp+cTqPKxiurQn+a9
	 iywe2+TTuRZUw==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com,
 ckeepax@opensource.cirrus.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260910161728.1452808-1-Vijendar.Mukunda@amd.com>
References: <20260910161728.1452808-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/4] ASoC: amd: acp: SoundWire machine driver fixes
Message-Id: <178949173671.151760.14042833988826539787.b4-ty@b4>
Date: Tue, 15 Sep 2026 18:02:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2490; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TIIhdHZfImno8IHnpU61Rik0esQpnaspY0ZDNX2lqls=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqqYmbDZjNG5WhckGdMRHAgSIFk8Q3jv+atf2q3
 5zi5G4bxVyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqmJmwAKCRAk1otyXVSH
 0KguB/0Z4NquPK5hN7CChcyCOkGWNr6807j9P0ybILaUow+GNMhAyMipp8tWEHny8+ASsnMfaSX
 ou5Tjr4sDxNbkhO3sfF8ajogpSUvDChz8dtFbGqxq/KrXiBDg+8OFRTHWbXr0CxNpPG6Jy5XlMS
 Z26zdB5hdpKKDW0oSlhiSY81f89/aPgXtt8Wnp3DgwiVu1OQ5fuduDeLInOyV1BAXLVHccqroqX
 exhzBTJgf3e6UPRxkYPEABSBH94WINKrDAxZ2Iz8J57pd9y9W9h52/X72hllaUVRuiUwwZILgZe
 JrO78H8h6hKIQlTzj1qH/ffK4893FlMBJhhkH0Iagqz46TFa
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: S7DFTWBO64UQT4RDKOUFMX5PHKDI3J5A
X-Message-ID-Hash: S7DFTWBO64UQT4RDKOUFMX5PHKDI3J5A
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S7DFTWBO64UQT4RDKOUFMX5PHKDI3J5A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 10 Sep 2026 21:46:45 +0530, Vijendar Mukunda wrote:
> ASoC: amd: acp: SoundWire machine driver fixes
> 
> This series fixes four defects in the AMD ACP SoundWire machine drivers
> (acp-sdw-legacy-mach.c and acp-sdw-sof-mach.c).
> 
> A bounds check is added to validate the SoundWire link ID before it is
> used as an array index in create_sdw_dailink(), preventing out-of-bounds
> access when an unexpected link_mask value is encountered. The codec
> config count in the SOF machine driver is refactored to use a dedicated
> variable rather than reusing the endpoint-count variable for two
> purposes, making the intent clearer and avoiding a stale value being
> passed to the codec config array. An operator-precedence bug in the
> ffs(link_mask - 1) expression is corrected to ffs(link_mask) - 1,
> ensuring the link ID is derived from the correct bit position. Finally,
> the SOF machine driver card name is shortened to fit within the 16-byte
> snd_card driver[] field and eliminate a compile-time warning.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/4] ASoC: amd: acp: bounds-check SoundWire link ID in machine drivers
      https://git.kernel.org/broonie/sound/c/2faa0ae56fa5
[2/4] ASoC: amd: acp: refactor codec config count in SOF SoundWire machine driver
      https://git.kernel.org/broonie/sound/c/efd76c8d6153
[3/4] ASoC: amd: acp: fix ffs() operator precedence for SoundWire link ID
      https://git.kernel.org/broonie/sound/c/5b28d773ed3a
[4/4] ASoC: amd: acp: fix card name length warning in SOF SoundWire machine driver
      https://git.kernel.org/broonie/sound/c/2444f73fe476

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

