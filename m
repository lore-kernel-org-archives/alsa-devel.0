Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C014BC982C1
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2026 21:25:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E413601F3;
	Wed, 16 Sep 2026 23:24:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E413601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789593901;
	bh=htx96s3nLyB/IdXMC0KeubgVBF4kIhKYXv4UDVVgVTk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=T8yRuUka6obOimkb6Qegu0lnAxFI/dCyfGJMi9hm5U1T9WlBYU9vpIjtrkf3cMJcT
	 83yTAgwdhRPpL2RKeh++9X9GQ9vtJPrPFXlpjBr8j95dKyCjQsBLKN6BMfs2upfsum
	 /14+n+VQ02zRefvCCV4bA1GYo50kCCgivVzasI+Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6634F805F6; Wed, 16 Sep 2026 23:24:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 21449F805FB;
	Wed, 16 Sep 2026 23:24:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B4EFF802DB; Wed, 16 Sep 2026 23:24:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789593858;
	b=EY7aRYhht8JgYiSjvETJ1y7rwfWZmmGV8Dyh4JWnYGU0cDrskiVZCRNXsSb9HjTnE+dz
	 ScjGiVnCpc/mOK60vpHoUcqnEc4sAWgLVQzwOP5ylp5z3dgcWtb5oFwx0oUal8hLPHR+3
	 hhStII9nmL0eRlEZP3nUOkspNO9yNcksoNosg/VBbiX49ENvMsjoJMR9drJuBQLJam+N+
	 tF0+AK1OsVQIDcxIIoCDyRLc3PvEEwEQPuzE8mnEAzgWvqwfrmiELnFKE7veGBkgx/yfi
	 pk6anbtPgflW5UxyTY9FkyvGFahCYssdKzHVCZ/ygnotqE8rmWWyfCh+zGXIw0i9zvA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789593858;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=htx96s3nLyB/IdXMC0KeubgVBF4kIhKYXv4UDVVgVTk=;
	b=TaQUdXJBcKEOtomdmYHed4KHkAkzO082VNe/4i9yqHvGa3tJuBY+0LEZ7Y/oX142pRpK
	 ll3UZd98aE7YUDqU8Q0jFRrzXm3AIpj8Uq7aD+VbTEedPojmN80abGFUH3Dj36tN912KF
	 cqG17a9vH2fEMs7SyR5e/QaH/r+MVskS40aUBnnHcQy1nbZvVkx5FNfhtSIOhITpOfB0u
	 ncFldz/66CaTxg31xIY5MlWZ8BE5UGHMumuOEW9s61NUMrfHP2Q3hcKR5QkKWLXUxaGEi
	 dJDRnZ0y/oBqTwfBA3bL99EwA/XptAeALK7D1G/b9wb7P3eVszszf95jidjXIhKIzFQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Z8j8AbUe;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 07B87F8007E
	for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2026 23:24:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07B87F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Z8j8AbUe
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 3F034601EF;
	Wed, 16 Sep 2026 21:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 697351F00893;
	Wed, 16 Sep 2026 21:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789593854;
	bh=X/uf3IfOCUVuisGWX1+AT50pztZc6s9aO5SNjGWGG3c=;
	h=From:To:Cc:Subject:Date;
	b=Z8j8AbUeKAmXSFXGOCCl/jGOvhM62uq+cdT5e/jboBAb3OxH7zRhMmtNSpp7OsZCG
	 I2i0yVB93y9GEwhRGVWc7FanovXwzasYYy5m/yLc+fwgjNU9wUV7WFe1xYif1Oow8S
	 yUhQfk2xiu1+U8Qx+qH1Ajgu+BixIR7zlgdJwE35xNk4gJC1HpI4HPLELCb+5nyGtn
	 JzzqmXt+M/rZFendQYNB52zVAiCrtTGhx3zc6PluUQtwlfRvcJOBOMt4qJnyLXLkWp
	 sKx6OHjpYlzAPOMuRTmiRlo4IglK7O3Kle392MsMg2UIZP+Eyq1fx38yztQEOulsKo
	 t0B1kjKOsBDlg==
Message-ID: <3413f10580c07752cd34ce5a1557e8c3@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.3-rc3
Date: Wed, 16 Sep 2026 22:23:52 +0100
Message-ID-Hash: H4AKWMSEOTWCINVOD5Q3Q26IU2YMUISP
X-Message-ID-Hash: H4AKWMSEOTWCINVOD5Q3Q26IU2YMUISP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/H4AKWMSEOTWCINVOD5Q3Q26IU2YMUISP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.3-rc3

for you to fetch changes up to 940e8fe8535d22ce67dd2fb9588e6c55a31d7d03:

  ASoC: adau1977: small fixes to make the driver more usable (2026-09-16 20:09:57 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.3

A relatively large pile of fixes here, a lot of driver specific stuff
that's broadly unremarkable plus a few core fixes from Richard that fix
issues where SoundWire systems with multiple CODECs on the same link
would configure the CODECs to use the same bus slots leading to broken
audio.

----------------------------------------------------------------
Ai Chao (1):
      ASoC: Intel: sof_es8336: Add a quirk for Huawei Matebook B3-420

Alvin Šipraga (3):
      ASoC: adau1977: make the Kconfig symbols user selectable
      ASoC: adau1977-spi: drop __maybe_unused and of_match_ptr()
      ASoC: adau1977-i2c: add OF match table for I2C

HyeongJun An (1):
      ASoC: hdmi-codec: Report a change when the channel status moves

Jack Yu (1):
      ASoC: rt712-sdca: reconfigure PLL2 to fix calibration time-out

Jiangshan Yi (1):
      ASoC: codecs: rt712-sdca-dmic: fix uninitialized stream_config->type

Mark Brown (3):
      ASoC: Fix missing channel fixup for codec end of ch_map
      ASoC: amd: acp: SoundWire machine driver fixes
      ASoC: adau1977: small fixes to make the driver more usable

Oder Chiou (1):
      ASoC: rt721: Reset codec to fix abnormal sound

Richard Fitzgerald (7):
      ASoC: wm_adsp: Firmware search progress log should not look like an error
      ASoC: Rename snd_soc_dai_link_ch_map.ch_mask to cpu_ch_mask
      ASoC: Add codec_ch_mask to snd_soc_dai_link_ch_map
      ASoC: soc-pcm: Apply snd_soc_dai_link_ch_map.codec_ch_mask to codec params
      ASoC: sdw_utils: Set snd_soc_dai_link_ch_map.codec_ch_mask for capture
      ASoC: sdw_utils: cs_amp: Delete bogus and incorrect capture channel fixup
      ASoC: cs-amp-lib: Prevent NULL pointer if efi variable is zero length

Sasha Levin (1):
      ASoC: ux500: Parenthesize MSP_{RX,TX}_CLKPOL_BIT() arguments

Vijendar Mukunda (4):
      ASoC: amd: acp: bounds-check SoundWire link ID in machine drivers
      ASoC: amd: acp: refactor codec config count in SOF SoundWire machine driver
      ASoC: amd: acp: fix ffs() operator precedence for SoundWire link ID
      ASoC: amd: acp: fix card name length warning in SOF SoundWire machine driver

 include/sound/soc.h                     |  3 +-
 include/sound/soc_sdw_utils.h           |  2 -
 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 14 +++++-
 sound/soc/amd/acp/acp-sdw-sof-mach.c    | 23 ++++++---
 sound/soc/codecs/Kconfig                |  4 +-
 sound/soc/codecs/adau1977-i2c.c         |  9 ++++
 sound/soc/codecs/adau1977-spi.c         | 12 ++---
 sound/soc/codecs/cs-amp-lib.c           |  2 +
 sound/soc/codecs/hdmi-codec.c           |  6 ++-
 sound/soc/codecs/rt712-sdca-dmic.c      | 14 ++----
 sound/soc/codecs/rt712-sdca-sdw.c       |  8 +++
 sound/soc/codecs/rt712-sdca.c           | 86 +++++++++++++++++++++++++++++++--
 sound/soc/codecs/rt712-sdca.h           | 18 +++++++
 sound/soc/codecs/rt721-sdca-sdw.c       |  3 ++
 sound/soc/codecs/rt721-sdca.c           | 17 +++++++
 sound/soc/codecs/wm_adsp.c              |  5 +-
 sound/soc/intel/boards/sof_es8336.c     |  9 ++++
 sound/soc/sdw_utils/soc_sdw_cs_amp.c    | 46 ------------------
 sound/soc/sdw_utils/soc_sdw_utils.c     | 24 +++++----
 sound/soc/soc-pcm.c                     | 18 +++++--
 sound/soc/ux500/ux500_msp_i2s.h         |  4 +-
 21 files changed, 231 insertions(+), 96 deletions(-)
