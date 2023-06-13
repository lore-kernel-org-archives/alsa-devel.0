Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC79AC77B7A
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Jun 2023 07:40:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DB00846;
	Tue, 13 Jun 2023 09:39:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DB00846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686642020;
	bh=Aj6vaq24Ij7dbtgJ4h8y6IiCXQwfg5sF2KVCXO1hvYA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Oc3wJGqelX0tUVknAj8o552BVPwC4lbk90qi7sxdpEMWpgcD1/D0GLcrHHAoKX+5v
	 hRsEeEPSQYp4GdwMWgBtC2JCafSbBActyOVG4DBmHaUB6n+uXKUIjaRQoX2BKUsv9J
	 Q8+MocLeXEtbwyYWoAF95mzSI8gi3ssTzu/7AJRs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16668F8057C; Tue, 13 Jun 2023 09:38:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 288ECF8057C;
	Tue, 13 Jun 2023 09:38:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 012B9F8057E; Tue, 13 Jun 2023 09:38:48 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C78E5F8025E
	for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2023 09:38:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C78E5F8025E
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 779C324154;
	Tue, 13 Jun 2023 03:38:22 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1q8ybe-dRL-00; Tue, 13 Jun 2023 09:38:22 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 0/8] ALSA: emu10k1: add support for high-bitrate modes of E-MU
 cards
Date: Tue, 13 Jun 2023 09:38:14 +0200
Message-Id: <20230613073822.1343234-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WZGNIAGOM2VP6SPPYSIVX7XNMLPTGNHC
X-Message-ID-Hash: WZGNIAGOM2VP6SPPYSIVX7XNMLPTGNHC
X-MailFrom: ossi@kde.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WZGNIAGOM2VP6SPPYSIVX7XNMLPTGNHC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This series is what all the work was about: support the "dual-/quad-pumped"
modes of the E-MU cards.

Oswald Buddenhagen (8):
  ALSA: emu10k1: introduce alternative E-MU D.A.S. mode
  ALSA: emu10k1: improve mixer control naming in E-MU D.A.S. mode
  ALSA: emu10k1: set the "no filtering" bits on PCM voices
  ALSA: emu10k1: make playback in E-MU D.A.S. mode 32-bit
  ALSA: add snd_ctl_add_locked()
  ALSA: emu10k1: add support for 2x/4x word clocks in E-MU D.A.S. mode
  ALSA: emu10k1: add high-rate capture in E-MU D.A.S. mode
  ALSA: emu10k1: add high-rate playback in E-MU D.A.S. mode

 include/sound/control.h          |   1 +
 include/sound/emu10k1.h          |  11 +
 sound/core/control.c             |  31 ++
 sound/pci/emu10k1/emu10k1.c      |  29 +-
 sound/pci/emu10k1/emu10k1_main.c |  19 +-
 sound/pci/emu10k1/emufx.c        | 109 +++-
 sound/pci/emu10k1/emumixer.c     | 901 +++++++++++++++++++++++++++----
 sound/pci/emu10k1/emupcm.c       | 422 +++++++++++++--
 sound/pci/emu10k1/emuproc.c      |   5 +
 sound/pci/emu10k1/io.c           |  30 +-
 sound/pci/emu10k1/voice.c        |   6 +
 11 files changed, 1383 insertions(+), 181 deletions(-)

-- 
2.40.0.152.g15d061e6df

