Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89D0CD8CAD
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 23:06:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EE79601CA;
	Wed, 10 Jun 2026 01:06:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EE79601CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781046389;
	bh=o6n1uuPCEB/Ka068lEYyZMmLYee+quQGII4plLS5wIc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UAkZsd6ORuuLGwNHLyV/oLRVTVh8A602CH/70s/CPZovS57S+KrOq34unrVg2OHX3
	 nPoFnraOyyOIuSKz5uwko5d3LeXVe0ByBLG6ohBsJVZJW/ZgwBII1Skv+mYwH57BP5
	 tGlEKsXlLOamBKPRjIVVRxTcJsqoBS45/mFo4gyM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8798AF805EE; Wed, 10 Jun 2026 01:05:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 27269F805FF;
	Wed, 10 Jun 2026 01:05:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11676F8058C; Wed, 10 Jun 2026 01:05:51 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781046350;
	b=NO5X2aAFPs9AIjnHK1P6k5NKwqGPe9pP/E6MsB03D1d/YcZyfoXGKardENJqdaMcUMQv
	 cYhByS81OenFNIEPK6tFlmWQdRkMUB9HflDOO6+3JLpFGvY/X9htDEfDcLzbSoESKrxb9
	 EzpnQdAs0GZ1QNg9OBoMOr2B0Q2fIH/ecJhO8iPHRLC4z5DYNc0if1scVT/sC4RZx/Jld
	 qHCtlYAN1HBVxzKcnQNkiiAGjp+VYwc/6CCVUFSrflWXsB94i0/IaWQeJVR1OSJv1bPJy
	 jpFPZ3eGbRhZBzY+6qeyvhtJ+t5Jqt0cm782geCuSRS/PyW9K+lbeOJF0Q0nBUhyYGg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781046350;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=o6n1uuPCEB/Ka068lEYyZMmLYee+quQGII4plLS5wIc=;
	b=Z955L0YDENuZlQqNwtlJvugJjF5bH4uBLxnLta0zwExvNe4l5TDAL5p27LaION9OsebJ
	 A5EWBM42xvgB8/aYJonSKM7vkd+7n//RFwfHQf70TFaLdyrcc1LmfYG0nxEn1uO3e8rCI
	 xd8djBH5OCzbcoCqxEhuCBpXaixh4bMrEAyYAdAFV1Y8rOmGf+8vGZBASx2e8ndDnJTyp
	 Y23KlRnWw9KDhjwsmS+UvLqSzEyM8Ss5QP1r1Oj8iDhoGlKOz8Ase5R57VTuEGEAEmKlx
	 aMV5rUEVDf5iGM1i+u+pFZoRNoYbkNrEUPkZAVNi7V5/ErnQlZ6VDUz8lBZMgcH//uw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MAVbbo8U;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6A13CF801F5
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 01:05:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A13CF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MAVbbo8U
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 44F67602C4;
	Tue,  9 Jun 2026 23:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A761F00893;
	Tue,  9 Jun 2026 23:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781046347;
	bh=o9zlsQ8CpFOx7IotxwW6wamDr1emdTYdo/aeMCB1F6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MAVbbo8UiKc/+V5LwknxNszBu/EiR4Bp5hNolCNbatNfRtP4/J90BmPbiVQ8B6wkT
	 KNtLVuvJ8+r6egapbfC5CZakBr7otrDfna0ozc34/vArQDFjjcvcepYdFXHdkaQC5U
	 FBNtiU01sY8cYs2A+/0wB+FQsVj7CGwW3452HgdEIDrvKTW7voXqFqPoBwsb6MehJZ
	 SjOmFvGJC+vE7Lf8vRuvW/+IICNX7MX75Goelqbo8DBYYc1W8PRtSnI3Fx39v/0xhN
	 YnXwcoXkloz/z7tJyAqpBcWNox4Courmn8Gjs0ZzcVJnt/YG/MoYnf6ndGd6nQLwlw
	 vXBqeUCHC11Aw==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 mario.limonciello@amd.com, Basavaraj.Hiregoudar@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260609143230.3310356-1-Vijendar.Mukunda@amd.com>
References: <20260609143230.3310356-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: ps: honor machine_check in SoundWire
 machine select
Message-Id: <178102694997.34323.5492926624097882645.b4-ty@b4>
Date: Tue, 09 Jun 2026 18:42:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=broonie@kernel.org;
 h=from:subject:message-id; bh=o6n1uuPCEB/Ka068lEYyZMmLYee+quQGII4plLS5wIc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqKJxHMSDMkDDe7Pk1tgKc8ZVPwZitxx/8UPEXK
 vrxh9+wrZSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiicRwAKCRAk1otyXVSH
 0HYYB/4p7lDTg+LiovSu/s2PbfxWFwLsW3/qVzy8aDeXbygc1vRhIapfrVgtCYEW/4zwETXxmsZ
 NmimOm6xc9611r1lA9PQIIqk6zrTq9f3uUpzv3hHh3a9TMlHUhNGvJxvy4wueLgO+nqViK7pqfi
 6iMeYsUpxMT2Ea5tPqFs96nVzq8IO+pyEn/nsgUCX4yaCtnFaM/hgewNGNl2FFxN5NSnZf98dpw
 d2Ww57Cfd+ZtyXiy6qWqnXyw8TK0gzWYd1q2gUDTKTbXXBaqwU7j+0ovhBhg/Ly9vY8SW9HRQqZ
 KZVnptP+i6OLkLGICe3GZmqb5/lWy/AMDiu5wEUBmPpAGLsN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: NM7G2FBEWZ23DFTIDK4N244ZNK5BZHNP
X-Message-ID-Hash: NM7G2FBEWZ23DFTIDK4N244ZNK5BZHNP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NM7G2FBEWZ23DFTIDK4N244ZNK5BZHNP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 09 Jun 2026 20:02:12 +0530, Vijendar Mukunda wrote:
> ASoC: amd: ps: honor machine_check in SoundWire machine select

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: amd: ps: honor machine_check in SoundWire machine select
      https://git.kernel.org/broonie/sound/c/a980535929de

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

