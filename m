Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6032CCDE001
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2026 17:02:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23042600E9;
	Thu, 25 Jun 2026 19:02:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23042600E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782406936;
	bh=V3t0lYJfVLfi6ASNtlsskXfQdiP7sp/9Kyfp7JhIjdQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=N7SE9bnvL2zIlZUd1dLZ0/bk1EuBbnlw648Dd8lqx4sebq1cq7+heXN+hyhpBAWAZ
	 of95Ln2Eh2yrSQlhiHGpGgr10hPyrzSOrhT5nFpwWr+binOP+wsaunCTUdb9gkfKyZ
	 j5ZL8gCBsVueKKi0sd5laMZEsddc/N0xoGoisu3o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83FE3F805FD; Thu, 25 Jun 2026 19:01:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EF30AF805F9;
	Thu, 25 Jun 2026 19:01:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 321E9F80510; Thu, 25 Jun 2026 19:01:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782406892;
	b=eC1Caad6XwSGWMKCGd+wkmcdv89oTeGMBrfrw2/tReq3ykW8SntVqClyPV47H2ILqoqq
	 tgpt0Yscu5NeKGYw/c19mlhQkGeEbQbKJ4fan0nspC4HzG8KhbrXHraYvDlYiHp2Vrpx5
	 14VwVyuWErJVyz26lj8Oju3NIGZQUbhkau2RbFcWVicetLlOG8elCqPy8z9B8BpvXmNyV
	 IfDcc7NmA/mqAEGryw09Ek5mou8mvsvSHcws79cvPf5qGQ6tX2sOWUYj9e8AFxtyLHhXo
	 adVvX8NQ3h3iYupRGw9YXgnumcVb7S/PVpbqYJF1Ts7OplcBgUHTgSbrCxgNZFv0zYw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782406892;
	h=DKIM-Signature:Message-ID:From:To:Subject:Date;
	bh=V3t0lYJfVLfi6ASNtlsskXfQdiP7sp/9Kyfp7JhIjdQ=;
	b=kr1KkwYFMg3tyNOOlx5OIUg1wlE0T/vgxHuu7p8D5U2Ng31BmKKTEHI1xzrE2jRnAAHj
	 jv1IlZrBcmSFF1UqoG/asrAPflMWKfd+p3HAv9VoI18crHD2lgcZbVABf3gDhvpRYFVps
	 GMirO4qChYVKGaiU6hn3S1Tsi0iyJlkQa5thyWagFU0Vp/25ukslFgjcb2pYuxvc1Ao6X
	 8wZLaxHXx7p6FxRAturF2uMKV4t6eCSrWsVea8a51TkTsvFGE+7gGIYzleTGf8PoGEeX3
	 OmG6MTrI0BlkyvuSUNxN15ajQjqoonrXVKGj8BSTMEhSUTCE4C9DTG600YTXNYL0Srg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=T5yhb5Sb;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 8F2F0F80217
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2026 19:01:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F2F0F80217
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=T5yhb5Sb
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 0258340E14;
	Thu, 25 Jun 2026 17:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 62F4D1F000E9;
	Thu, 25 Jun 2026 17:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782406887;
	bh=TqWxG8nR5Xf9Ymfer2/6ARrr2Ipm/881jg9J2i1RkYU=;
	h=From:To:Cc:Subject:Date;
	b=T5yhb5SbbKVeXsiFBrrenpKIIyO9l0wfy+eRVKbJ+9BExVD0jM6JZW1Q3fhNNyH49
	 LFW8il9EmAd91IQGW9CWt8cpeSCzdFhE7ZdtLcGi+AW4kXXHgRsXPEr6vymkZ2J2l+
	 M3akEl1GcCKEUsiD7VFzJs7sLIC2Md98RP/Q0QmlDz5mO/qHnO0nDndRUoe6d4jO0S
	 6xzmFpv60bxGnCTlB2wgc7br5G9dKBl2ZP6OMq5GfNaEs+tnXMrre/gMFzKute8nyw
	 wm6+nLnr1KXL+1mzBNtz3BcItQZCk1QdqJe5fDnUlPtEs8RMvNeMeK5k0VpsI/2nMt
	 uskTbAApxxvKQ==
Message-ID: <8d888870bec370f9abaad606055cdb75@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v7.2-merge-window
Date: Thu, 25 Jun 2026 18:01:19 +0100
Message-ID-Hash: 4CYTOKZ4JGLDLEUHCGB4SU43WS6UQTU7
X-Message-ID-Hash: 4CYTOKZ4JGLDLEUHCGB4SU43WS6UQTU7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4CYTOKZ4JGLDLEUHCGB4SU43WS6UQTU7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The following changes since commit 4346d91cfa47b0d9303533edde8acd33e4b9ca40:

  ASoC: dt-bindings: Fix RT5677 "realtek,gpio-config" type (2026-06-14 01:03:38 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.2-merge-window

for you to fetch changes up to cf6f56990ea21172e085f0588e5bbf2089ce8f58:

  ASoC: fsl_asrc_dma: fix eDMA maxburst misalignment with channel count (2026-06-25 14:56:27 +0100)

----------------------------------------------------------------
ASoC: Fixes for v7.2

We've got a good collection of device specific fix here, plus a couple
of stand out things:

 - Richard fixed some special cases with the new device_link creation
   by more gracefully handling any errors during creation.
 - Charles did some light refactoring of the SoundWire interfaces to
   fix some persistent randconfig issues that people kept running into.

----------------------------------------------------------------
Ahmad Fatoum (1):
      ASoC: cs530x: Fix expected MCLK rates for CS5302/4/8

Alvin Šipraga (1):
      ASoC: audio-graph-card2: Drop warning for manually selected DAI formats

Baojun Xu (1):
      ASoC: tas2781: Update default register address to TAS2563

Bartosz Juraszewski (1):
      ASoC: tas2783: Update loaded firmware names to linux-firmware 20260519

Charles Keepax (5):
      soundwire: Move wait for initialisation helper to header
      ASoC: es9356: Add back local call to sdw_show_ping_status()
      ASoC: max98373: Add back local call to sdw_show_ping_status()
      ASoC: ti: Add back local call to sdw_show_ping_status()
      ASoC: realtek: Add back local call to sdw_show_ping_status()

Christian Hewitt (1):
      ASoC: codecs: pcm512x: only print info once on no sclk

HyeongJun An (1):
      ASoC: SDCA: Validate written enum value in ge_put_enum_double()

Mark Brown (1):
      ASoC: Fix SoundWire randconfig issues

Nicolas Frattaroli (1):
      ASoC: rockchip: Drop problematic guard() changes

Oder Chiou (1):
      ASoC: rt5575: Use __le32 for SPI burst write address

Richard Fitzgerald (1):
      ASoC: soc-core: Don't fail if device_link could not be created

Sen Wang (1):
      ASoC: tlv320aic3x: restrict CLKDIV bypass Q values in dual-rate mode

Shengjiu Wang (1):
      ASoC: fsl_asrc_dma: fix eDMA maxburst misalignment with channel count

Shuming Fan (1):
      ASoC: rt5650: enhance spk protection function

Srinivas Kandagatla (1):
      ASoC: qcom: q6apm: fix NULL pointer dereference in graph_callback

Uwe Kleine-König (The Capable Hub) (1):
      ASoC: rockchip: rockchip_sai: #include <linux/platform_device.h> explicitly

 drivers/soundwire/bus.c               |  28 ----
 include/linux/soundwire/sdw.h         |  38 +++--
 include/sound/soc-component.h         |   4 +
 include/sound/tas2781.h               |   4 +-
 sound/soc/codecs/cs530x.c             |  29 +++-
 sound/soc/codecs/cs530x.h             |   6 -
 sound/soc/codecs/es9356.c             |   4 +-
 sound/soc/codecs/max98373-sdw.c       |   4 +-
 sound/soc/codecs/pcm512x.c            |   2 +-
 sound/soc/codecs/rt1017-sdca-sdw.c    |   4 +-
 sound/soc/codecs/rt1308-sdw.c         |   4 +-
 sound/soc/codecs/rt1316-sdw.c         |   4 +-
 sound/soc/codecs/rt5575-spi.c         |   2 +-
 sound/soc/codecs/rt5645.c             |   6 +-
 sound/soc/codecs/rt5645.h             |   1 +
 sound/soc/codecs/rt5682-sdw.c         |   4 +-
 sound/soc/codecs/rt700-sdw.c          |   4 +-
 sound/soc/codecs/rt711-sdca-sdw.c     |   4 +-
 sound/soc/codecs/rt712-sdca-dmic.c    |   4 +-
 sound/soc/codecs/rt712-sdca-sdw.c     |   4 +-
 sound/soc/codecs/rt715-sdca-sdw.c     |   4 +-
 sound/soc/codecs/rt715-sdw.c          |   4 +-
 sound/soc/codecs/rt721-sdca-sdw.c     |   4 +-
 sound/soc/codecs/rt722-sdca-sdw.c     |   4 +-
 sound/soc/codecs/tac5xx2-sdw.c        |   4 +-
 sound/soc/codecs/tas2783-sdw.c        |  77 ++++++----
 sound/soc/codecs/tlv320aic3x.c        |  25 +++-
 sound/soc/fsl/fsl_asrc_dma.c          |  20 +++
 sound/soc/generic/audio-graph-card2.c |  12 --
 sound/soc/qcom/qdsp6/q6apm.c          |   8 ++
 sound/soc/rockchip/rockchip_sai.c     | 263 +++++++++++++++++-----------------
 sound/soc/sdca/sdca_asoc.c            |   3 +
 sound/soc/soc-core.c                  |  35 ++---
 33 files changed, 362 insertions(+), 261 deletions(-)
