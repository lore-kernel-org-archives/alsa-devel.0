Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12985C83F01
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Aug 2023 17:07:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D173DF2;
	Sun, 27 Aug 2023 19:06:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D173DF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693156041;
	bh=XEn8QKXb/YVHPNTtSbdh3vcx6D5prDug/3qdW3OJ1sE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=SgYbThKhyE2iCVIcrv0jZxKKjc5INQmYuKhFRmk9tKVkC+vF5EytbChZppTTRspTj
	 BbWFoeeDr4nOd2KIVVsMOtNguajZNT3KwE15Dk4BSGAomXIuRz4+5P1YeYioWuPddL
	 lwJX2K6kDpu8YLXGDtOWLr7s8Ch/pCDCofLLC6PQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6DDBF80615; Sun, 27 Aug 2023 19:03:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 32A09F80611;
	Sun, 27 Aug 2023 19:03:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3AD35F80158; Sat, 26 Aug 2023 00:22:20 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1294DF8022B
	for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2023 00:22:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1294DF8022B
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id B3995242C3;
	Fri, 25 Aug 2023 18:21:58 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qZfBm-iUT-00; Sat, 26 Aug 2023 00:21:58 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v5 0/8] ALSA: emu10k1: add support for high-bitrate modes of
 E-MU cards
Date: Sat, 26 Aug 2023 00:21:50 +0200
Message-Id: <20230825222158.171007-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: ossi@kde.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: CPIKKELPAH4O452W2V2YUVZURWLLKMEB
X-Message-ID-Hash: CPIKKELPAH4O452W2V2YUVZURWLLKMEB
X-Mailman-Approved-At: Sun, 27 Aug 2023 17:03:09 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CPIKKELPAH4O452W2V2YUVZURWLLKMEB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This series is what all the work was about: support the "dual-/quad-pumped"
modes of the E-MU cards.
---

i don't suppose you had an epiphany, so as before i'm posting this for
posterity, without expectation of it being applied.

---
v5:
- rebased onto new buffer copy callback
- added end-user documentation
v4:
- rebased onto locking changes
v3:
- rebased onto pulled ahead series
---
This patch series needs to be applied on top of the patch titled "ALSA:
emu10k1: add separate documentation for E-MU cards".

Oswald Buddenhagen (8):
  ALSA: add snd_ctl_add_locked() & export snd_ctl_remove_locked()
  ALSA: emu10k1: introduce alternative E-MU D.A.S. mode
  ALSA: emu10k1: improve mixer control naming in E-MU D.A.S. mode
  ALSA: emu10k1: make playback in E-MU D.A.S. mode 32-bit
  ALSA: emu10k1: add support for 2x/4x word clocks in E-MU D.A.S. mode
  ALSA: emu10k1: add high-rate capture in E-MU D.A.S. mode
  ALSA: emu10k1: add high-rate playback in E-MU D.A.S. mode
  ALSA: emu10k1: document E-MU D.A.S. mode

 Documentation/sound/cards/emu-mixer.rst |  59 +-
 include/sound/control.h                 |   2 +
 include/sound/emu10k1.h                 |  11 +
 sound/core/control.c                    |  43 +-
 sound/pci/emu10k1/emu10k1.c             |  29 +-
 sound/pci/emu10k1/emu10k1_main.c        |  30 +-
 sound/pci/emu10k1/emufx.c               | 109 ++-
 sound/pci/emu10k1/emumixer.c            | 902 +++++++++++++++++++++---
 sound/pci/emu10k1/emupcm.c              | 400 +++++++++--
 sound/pci/emu10k1/emuproc.c             |   5 +
 sound/pci/emu10k1/io.c                  |  30 +-
 sound/pci/emu10k1/voice.c               |   6 +
 12 files changed, 1423 insertions(+), 203 deletions(-)


base-commit: c5baafafd8411c19e27c6a2c7237538a34b8ca31
prerequisite-patch-id: 6b89fb2dc075fcf9e5b8d8ae36bed09ecf063344
prerequisite-patch-id: 44c4ce123c9838904e4fb3ce285ade080f09f306
prerequisite-patch-id: 40620a68c4ad5945a920ff05ba3c7f73e58ad45c
-- 
2.40.0.152.g15d061e6df

