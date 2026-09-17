Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1342DC982D7
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2026 09:49:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2C4160203;
	Fri, 18 Sep 2026 11:49:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2C4160203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789724957;
	bh=0xJlfhEtS7rP+cIQGSbdXqP0rAyv7gYirXsnZ/0eJCA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mcH8b4xkaourEgpP8P8U9B2KavKB8YaHSfFVnZiXMdYOBrEhzFtzW6BUvY0LSqjAA
	 j9XqdLQTAMqhML21g8qNnYxDcHViPA33t3twgcSxFQapQi/PXXdTT16C72w0aDRIKv
	 gGhmUgioMTc/4OhbbAOBLO5bnTghCU0h0+8WiqsA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 39CB4F805EF; Fri, 18 Sep 2026 11:48:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B2B1F80600;
	Fri, 18 Sep 2026 11:48:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 374EFF80518; Fri, 18 Sep 2026 11:48:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789724911;
	b=dJrV676yGpJf6Jzor0I8N5xLipbiNmlKU3f7UWmrnUi3Sq/GUzxhEqSaC43Idrs1w3Dt
	 YpsIw3QxJBwHLYE+l9WCTfAVQMZFt6Q/2KPHkJX+zSZ9Swj1vwERWC0gXr+QbrVX0GVNE
	 /pSW+8IVuzIQQ6sTVHM9y+eSHNyr5QSMiYT4CLgldaBJxHwOZetUGveAEOhw0LIh6idtE
	 tYhidSHAyi4YqV4UKeOsSfDpExzvM/3xro2tSxioyOqFV6kOrjL9bvUzqOl53pB1aI0ec
	 UIV1ufc5Fgiqp8nSnrWWkKfTW4BkFO7WdK3+upr/GKnAHLPW1bffArEtaZld9dHz3kA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789724911;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=0xJlfhEtS7rP+cIQGSbdXqP0rAyv7gYirXsnZ/0eJCA=;
	b=OzPW8q9T/nqWVlg/FASLmBXjP4IJ68Bsqy2KdPbV54ZYMqsIYKlFp6iZLUOK7lwpg17X
	 VvTW+LuthacT8Ft6GswnyFYBgBZA3OnDjeZJeEQKW2MixfjOfsv7o927zdiz9HluT9Vbg
	 Qk4YqihFsU7g79Qd+Bo1QRrW21X7iimhR8hs41T8FK4+epctvMiUvk83FHjlOoyyCrEuD
	 4SRU6V1GKnHWgpQKPNHX+C78YoJAwSrgvlhH9FgNW3KPyDtk64RDk4HFA1iMq9ci+sWBU
	 9zDS7yYPblTQPIochATyiE1P4m4jDSWX1NPWUHDgBy2Tf0mg8oO29ZZXkKST7dviGgQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TUrcbOLi;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 14104F8001E
	for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2026 11:48:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14104F8001E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TUrcbOLi
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8B01760A5E;
	Fri, 18 Sep 2026 09:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359AE1F000FF;
	Fri, 18 Sep 2026 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789724907;
	bh=hubMP+qeA9OQW4X4+cRxFhZ+FwJ/0Bm3jEI+zxjXKlg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TUrcbOLiC+Lc06p71uqurDkZ5oPWHF/+Lsaaz67l24jE+hjzkuGBm5+uZCOTqBitb
	 qAqcagJf+GEEOVGJxQR8F7gE91RShKIUaE7k1Qo28T70yG1i1h5uqB8sOlxHlfAYOF
	 NsAiWbfX4+HRdQm4vAjuvBCu4Xpst2rMqCETrYIpsuiIBPSt0kflc+7cOT8YgSvq+P
	 oTELMOsn/l2gyJsM5ddWL6xYL2crfXsVAmTgDJw4gpDoHpmhR2qpps+dZhHsQ3uQ0M
	 hq9WO7OZcmTl00j9oY1DlG4BNIv38WNsnGU8cgSGtiLERfyHH5AJtTg7heq+7pDv9R
	 sGSEHmasD9ASg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: Vijendar.Mukunda@amd.com, anson.tsao@amd.com,
 Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Randy Dunlap <rdunlap@infradead.org>,
 Simon Trimmer <simont@opensource.cirrus.com>, Baojun Xu <baojun.xu@ti.com>,
 Ville Saarinen <wiza@saarinenkoti.fi>, Hasun Park <hasunpark@gmail.com>,
 "open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20260917165314.1880855-1-syed.sabakareem@amd.com>
References: <20260917165314.1880855-1-syed.sabakareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: enable TAS2783 and add RT712-VB
 SoundWire machine
Message-Id: <178968348634.285745.3236296235637083568.b4-ty@b4>
Date: Thu, 17 Sep 2026 23:18:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0xJlfhEtS7rP+cIQGSbdXqP0rAyv7gYirXsnZ/0eJCA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqrQjlqj6fyAmTQRpiBgkaiMjMVz5x/506/qNxu
 oFo0hBtNq2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq0I5QAKCRAk1otyXVSH
 0Hg2B/9X5dBztILpHb18qDJx2sn0koMp+TDojKWRMQBG6EhNlw/PKcoa+3fi/ZzCwaQL1x1+Chd
 7e/Hxa/jFKsX3m+IADYGuNsUxm5c6Uh3mcZ/yh5ZLYeGNRoZ0ayvoO3ylRI5g5zRVgiJ+JNUNwJ
 DR+VsqVAg9JwgVOFZEVqdD/tslutfwudjn22UbklmEmFHsfbYKbuG3jMVHXZLz16Q+d5u4/04C9
 22gnGsiq+Gybx0wP2Ab4RMfFA06Nf7bjT4gaiOMctNC1zzJuZ6QEsQqjrghvVQHstdlo7DmfuQh
 nSvCUXj5DSVYGkMU7vANIUHFYynJKVciW/tKEqREm6ERlNHf
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: JF32KX3LTOXDP353FQGFFJLH2Y2NJXJ3
X-Message-ID-Hash: JF32KX3LTOXDP353FQGFFJLH2Y2NJXJ3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JF32KX3LTOXDP353FQGFFJLH2Y2NJXJ3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 17 Sep 2026 22:21:49 +0530, Syed Saba Kareem wrote:
> ASoC: amd: acp: enable TAS2783 and add RT712-VB SoundWire machine

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: amd: acp: enable TAS2783 and add RT712-VB SoundWire machine
      https://git.kernel.org/broonie/sound/c/28114992dd2f

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

