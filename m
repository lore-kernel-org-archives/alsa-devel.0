Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2319ECD6E6D
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:00:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9056C60261;
	Thu,  4 Jun 2026 17:00:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9056C60261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780585217;
	bh=MsTAYqGRduV0qR/MF5eO+Yf4JcSL9qKrxiNRcZxXqEU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rpwBnVIksspT3n7Q459SHHOKV/KE/L1pn4jm9bQ6eR621jUef4P5CvoSxhIB25jrk
	 BtzEb3bJlZo7AIsJqSXSVZjvsgb+YkRTFsDwXtt6WY/bl/EfZjbxk2PK8U/w7mNvvH
	 2hdqEosDrvlF/fgPzScqY1JcPmy5OLmouBY50E1s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7286BF8047D; Thu,  4 Jun 2026 16:59:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CF5E1F805FF;
	Thu,  4 Jun 2026 16:59:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B070F804CC; Thu,  4 Jun 2026 16:59:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780585176;
	b=GH+2IImO2k9KwlLXhnsHj+z1XBa4s8UMRKfkgMwErzHNrfLTCv34myv+Grcoj1MYBzmK
	 r48Kp3bLS4eJ6TWKpwbPbXiaeP7nOBtu+HptBFvCVxyatzn2WcL1oONifi7+jgQdbV43/
	 g4SLnZgXWnrZai7KTNVpRpjy4fMFlj1qiPeYImlSiOrDrHAh8sgVC5inJ4CukGG6Qu1le
	 HWoO9XVbhCZAbWyrSK3notC2z6+eQg26lETNVIJR6Ki68GSoH+ei3X2sfJhtXniROIJDf
	 /pHoxh0vYfXRnUtGairBR0JLKLV161BhcUfRkMR+aIrM0NWkX4Pa5+18cnhO0cmOAFw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780585176;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=MsTAYqGRduV0qR/MF5eO+Yf4JcSL9qKrxiNRcZxXqEU=;
	b=LQxf6IpDymZP9FKx72UW517Do+WmHItl3mxzjJPfTc7WsYnhj0HJggut42xqxoetnzB5
	 KyZkqSm4sPhI1YiOuNoeadRJpvdlXPNAgEA2a3KyoG4tCtfqxlUJwbE9QUM32B0vIcfDw
	 Rmyj1BD865EAWHlkQcqVgzQnkkGKte1kRRvE/aKYViPJZoc+J2qN29fDGqmvajS8K/qj1
	 89IgzIC54m4cs5+PKF+JXmmGvJuOegbBXF9S6fo8utYDFxls4iTc7SSqwJYGqGenRuP63
	 pR/qLkrEcDBzZcM/OXrqLImne7JHIYbYpgz+pKo5GN/K3D809JzhC3VbnEdgWVdTb9A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RelonrKG;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id A8B55F8047D
	for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2026 16:59:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8B55F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RelonrKG
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 6B6A6432BA;
	Thu,  4 Jun 2026 14:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C1F1B1F00893;
	Thu,  4 Jun 2026 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780585172;
	bh=PhrhDHP1FdjIu6eaq4hR73jfDA0sRMs89f3GPR4e9s8=;
	h=From:To:Cc:Subject:Date;
	b=RelonrKG5PKXuxHWzpviGWPpJf0Dx3i5EooZ7YnZapcNydSeKGguwsMz3A3Iu1dtK
	 B/GZX42GDjK+pQ5O8qshQY4vskgYSJAk9VqSvWvk7ondc9WUpl7dxTN7ifLj9+lUBZ
	 6tTRR7jC+ALkLxtxw1PHZgejEJjYgqvPHm+Ams9qg3lq8UDFPsheTb2BHYUiwu4WFh
	 aG5nSre3/7E9PP+VSSKNQqiFCl1EAfWqC7AWbAahmJeCl7RkkGSi7tZTmu7oEYXdlg
	 NR0yzBBfcRuYJc7bjAVXmxj+0eAoCKfZj4ixgOMXh5cI7+8NopkqejYjjdnJhOUEs+
	 TxvaeHMhHO6Pg==
Message-ID: <b99a86ce19505d0016af56bcfe4ad81f@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.1-rc6
Date: Thu, 04 Jun 2026 15:59:17 +0100
Message-ID-Hash: QY4FMXHDJI5ZTIBXKO4JNA7CZYMODYHG
X-Message-ID-Hash: QY4FMXHDJI5ZTIBXKO4JNA7CZYMODYHG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QY4FMXHDJI5ZTIBXKO4JNA7CZYMODYHG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.1-rc6

for you to fetch changes up to d2dcd85f9e09fe3566d4cdcd357856a42ac73f93:

  ASoC: amd: acp70: add standalone RT721 SoundWire machine (2026-06-04 11:35:06 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.1

There's only one actual fix here, for the TDM configuration on the
Freescale SAI controller, everytihng else is DMI quirks for AMD systems.
One of those is relatively large as it adds a bunch of different structs
but it's all data.

----------------------------------------------------------------
Aleksander Pshenitsyn (1):
      ASoC: amd: acp70: add standalone RT721 SoundWire machine

Chancel Liu (1):
      ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift UB in xMR write

David Glushkov (1):
      ASoC: amd: yc: Add MSI Raider A18 HX A9WJG to quirk table

Jackie Dong (1):
      ASoC: amd: acp: Add DMI quirk for Lenovo Yoga Pro 7 15ASH11

João Miguel (1):
      ASoC: amd: yc: Enable internal mic on MSI Bravo 17 C7VF

 sound/soc/amd/acp-config.c               |  7 +++++
 sound/soc/amd/acp/amd-acp70-acpi-match.c | 44 ++++++++++++++++++++++++++++++++
 sound/soc/amd/yc/acp6x-mach.c            | 14 ++++++++++
 sound/soc/fsl/fsl_sai.c                  |  2 +-
 4 files changed, 66 insertions(+), 1 deletion(-)
