Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE3C606A31C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2026 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=T+LW66gu;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lWijItAh
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 004B760216;
	Fri, 27 Nov 2026 03:43:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 004B760216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795747398;
	bh=c+A5eI4goI5Vr8qphPYMW136cy8hdAfBU1mlDsnX2Pk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=T+LW66guD7fFeRaer76It5a80vVOpeT6eI/Lf3OtJqI3QfQmdb7rgy3MmlfzIOIgw
	 Rfib5yw6x5L4isUnyKVlL5VvSPcwqtyp0H+oPH9htMOMbS+TW2ha733uJZBP/3Nd7q
	 F4fLmWbLaBM/u2WFL0BjnqmMGplOXvaKeNBI2e+Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7CDBDF805FC; Fri, 27 Nov 2026 03:42:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 188D6F805F5;
	Fri, 27 Nov 2026 03:42:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9D66F805A8; Fri, 27 Nov 2026 03:42:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PP_MIME_FAKE_ASCII_TEXT,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795747357;
	b=OnwiGwLVW5BQLxsvU5AxQ/2BqSshEIYd0VYQEfFmN3QZUKpRgoJlkbRHFF0xfX2DkZTD
	 Jx1vJK9Brzso7Z7KnAkwerldNQQLvjRyozAS4E/0hmKNDJh1K8d1JiTET3boIqsIWu+FG
	 Ya6LswdOcG+EFUaJfL1faZkO53h/wSpBAFNlmj8doYLIvpZGVyd1R9AvYlLeBI1e5cYBE
	 TpaH8LkaSzFqBkIVBe0KFIrYA6aSr29IFEfSsvIFScj+jqBbIZT24biKjpE8em+0Ro0v+
	 BV+AoQHmeJRaWY3PeDdT6xD2unQ6x8C2LCgR6iCr+wrW62dr2JwGqU6LLiL53hUeS0g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795747357;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id;
	bh=c+A5eI4goI5Vr8qphPYMW136cy8hdAfBU1mlDsnX2Pk=;
	b=PduYBl0ilRoOZbb/oBkSMGE2zRkdwNCLqm+MdcVYlSWGkg5XxkppBJOfl8mMZ03HEycU
	 I7GnULwnhIeA9EaRFTV2rQGWTbz3BsuVAPllDpjwZi261BRYUqD+n1j+9sLe5TqglctKD
	 t9n8EXW8tq+A3FX1HB8ca44sJZykESfivlnFhhy85r19xI1Sf8Zw7rM1Xct2IvQ5IYdbD
	 pGQ/9hY95mv49CIplW10JithyO9/z7I4TN4zMDDB9A1jgrG9W5tSaVMQyBU5HkjgDmJ+O
	 QyxhRs9s4sK4rKM5FaZToQh82TrKOHSdza2K1RBGTytNOLFWK7ez2QuqIHBulaMkFMg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lWijItAh;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 17AB5F80095
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2026 03:42:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17AB5F80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lWijItAh
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 98ED040AA6;
	Fri, 27 Nov 2026 02:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B75F1F00893;
	Fri, 27 Nov 2026 02:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795747352;
	bh=aWTgNdp3DLlsNb1upmQBOTRJ28t0xb8oDxlhzbKg2gE=;
	h=From:To:Cc:Subject:Date;
	b=lWijItAheEVPG3uQm1B+qfyFQc70q4D3XpyuwhO4KKhchiDYjYZKabIUg7sl/kSov
	 d6QlPMvhYp14x2X35fF6zf9Qg1L25SUUwjtlT4rXpp0j2dTSJxcRHjA/HtDMXqSINs
	 KYwdhbswvgnT6TEOHBBf6OoUnzDC2b+GKAvMkdXsoj17jeAAXv90vFW7Z50LbG+NEh
	 j/74uY8fUebfB/ggenKQba9EkRn1GZHo+d0lkxnmHxy4hs1FCHrGb1EDlNhsc7AdDr
	 j4oD0bBuY8vDAYzCmV8b4FgYG7xQqVXj5GbJq59yFDTeUU9myPgoArhD1hwlpNbR9t
	 ZqqtTPw1jmg8g==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 91DB03470DDE; Fri, 27 Nov 2026 02:42:36 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.4-rc4
Date: Fri, 27 Nov 2026 02:41:45 +0000
Message-Id: <20261127024236.91DB03470DDE@traversing.sirena.org.uk>
Message-ID-Hash: BRIAR3VG5QBPTFW3LAQY4WAAZUG5OA7Z
X-Message-ID-Hash: BRIAR3VG5QBPTFW3LAQY4WAAZUG5OA7Z
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BRIAR3VG5QBPTFW3LAQY4WAAZUG5OA7Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
X-Archived-By: <archiver.kernel.org>

The following changes since commit f66297be665c067d2e96da9ce1c5767b587e17b7:

  ASoC: tas2781: Avoid possible zero-division (2026-11-19 17:34:26 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.4-rc4

for you to fetch changes up to b4378764a58960a016a42506992eac86d4d4eaf9:

  ASoC: amd: yc: Add DMI quirk for HP 255R G10 (board 8D22) (2026-11-26 14:59:44 +0000)

----------------------------------------------------------------
ASoC: Fixes for v7.4

A fairly big but mostly routine pile of driver specific fixes and quirks
for v7.4.  The new Tegra support is the biggest thing here, it's all
data required by the newly added device, there's no real code in there
so while it was on the edge of getting applied for v7.5 it seemed fine
here.

----------------------------------------------------------------
Alen Tišljar (1):
      ASoC: amd: yc: Add DMI quirk for HP 255R G10 (board 8D22)

Anupama Kunkulagunta (2):
      ASoC: dt-bindings: tegra: Add Tegra268 ADMAIF support
      ASoC: tegra: ADMAIF: Add Tegra268 support

Arnav Kapoor (1):
      ASoC: SOF: control: reject out-of-range enum values

JaeHoon Kim (1):
      ASoC: amd: acp: Add ACP70 ACPI flag override for LG gram 15Z95U

James X. Nelson (1):
      ASoC: amd: yc: Enable DMIC on MSI Crosshair A18 HX A8WGKG

Marco Giunta (2):
      ASoC: aw88166: fix backup restoring the RE value instead of saving it
      ASoC: aw88399: fix register used to disable I2S TX

Mark Brown (3):
      ASoC: codecs: ES8326: issue about pop and Configuration
      ASoC: tegra: Add Tegra268 ADMAIF support
      ASoC: fsl_asrc/fsl_easrc: fix memory safety issues

Markus Paltian (1):
      ASoC: amd: acp: Add Lenovo IdeaPad Slim 5 16AKP10 to ACP70 override table

Mikolaj Kucharski (1):
      ASoC: amd: yc: Add DMI quirk for Xiaomi REDMI Book 14 2025 (AMD)

Stefan Ghetu (5):
      ASoC: fsl_asrc_m2m: fix out-of-bounds write when draining the output FIFO
      ASoC: fsl_asrc: fix pair ownership on repeated or failed hw_params
      ASoC: fsl_asrc_dma: release DMA channels on repeated hw_params
      ASoC: fsl_easrc: fix context ownership on repeated hw_params
      ASoC: fsl_asrc_m2m: allow only one task at a time per stream

Zhang Yi (4):
      ASoC: codecs: ES8326: Modify Clock Configuration
      ASoC: codecs: ES8326: issue about capture pop
      ASoC: codecs: ES8326: Modify the Initialization Configuration
      ASoC: codecs: ES8326: Adjust the delay during calibration

 .../bindings/sound/nvidia,tegra210-admaif.yaml     | 22 ++++++++
 sound/soc/amd/acp-config.c                         | 14 +++++
 sound/soc/amd/yc/acp6x-mach.c                      | 22 ++++++++
 sound/soc/codecs/aw88166.c                         |  2 +-
 sound/soc/codecs/aw88399-lib.c                     |  2 +-
 sound/soc/codecs/es8326.c                          |  8 ++-
 sound/soc/fsl/fsl_asrc.c                           | 22 ++++++++
 sound/soc/fsl/fsl_asrc_dma.c                       | 27 ++++++---
 sound/soc/fsl/fsl_asrc_m2m.c                       | 30 ++++++----
 sound/soc/fsl/fsl_easrc.c                          | 10 ++++
 sound/soc/sof/control.c                            |  5 ++
 sound/soc/tegra/tegra210_admaif.c                  | 66 ++++++++++++++++++++++
 sound/soc/tegra/tegra210_admaif.h                  | 18 ++++++
 13 files changed, 223 insertions(+), 25 deletions(-)
