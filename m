Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA44DC77B7D
	for <alsa-devel@archiver.kernel.org>; Sun, 14 May 2023 17:05:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 766A4DF3;
	Sun, 14 May 2023 19:04:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 766A4DF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684083926;
	bh=UvU/vCC7h14/rhMi/CokChNfvwsPzHEYZm94p1hftHk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=bEHq/dI1BeDQsOkbMZ3vSAyk1jNIJUAA9/9pLM0vRnxRmZlf4Q30L3LEGuIIoazLC
	 st/EEgpid2K9wu7MwYydMCWCQite/+XyplEFxV2QTcPG6Ce9GfHTrZcg0DqTRrTmnx
	 E1JIGxoPeLQ0J8/oFT5pOR9DkoLnY7TK2QEMFME4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E7C8F8057C; Sun, 14 May 2023 19:03:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AB6D3F80567;
	Sun, 14 May 2023 19:03:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A882F8025A; Sun, 14 May 2023 19:03:35 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C2E53F80272
	for <alsa-devel@alsa-project.org>; Sun, 14 May 2023 19:03:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2E53F80272
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 980FC2425A;
	Sun, 14 May 2023 13:03:23 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pyF7z-InS-00; Sun, 14 May 2023 19:03:23 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v2 0/7] ALSA: emu10k1: various improvements to the DSP-based
 mixer code
Date: Sun, 14 May 2023 19:03:16 +0200
Message-Id: <20230514170323.3408834-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MQFHTPEDNFLRSQH3CKPF75HDZCW2AGWE
X-Message-ID-Hash: MQFHTPEDNFLRSQH3CKPF75HDZCW2AGWE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MQFHTPEDNFLRSQH3CKPF75HDZCW2AGWE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


Oswald Buddenhagen (7):
  ALSA: emu10k1: polish audigy GPR allocation
  ALSA: emu10k1: fix non-zero mixer control defaults in highres mode
  ALSA: emu10k1: validate min/max values of translated controls
  ALSA: emu10k1: omit non-applicable mixer controls for E-MU cards
  ALSA: emu10k1: skip mic capture PCM for cards without AC97 codec
  ALSA: emu10k1: enable bit-exact playback, part 1: DSP attenuation
  ALSA: emu10k1: enable bit-exact playback, part 2: voice attenuation

 Documentation/sound/cards/audigy-mixer.rst  |   2 +-
 Documentation/sound/cards/sb-live-mixer.rst |   2 +-
 include/sound/emu10k1.h                     |   9 +-
 include/uapi/sound/emu10k1.h                |   8 +-
 sound/pci/emu10k1/emu10k1.c                 |   8 +-
 sound/pci/emu10k1/emufx.c                   | 491 +++++++++++---------
 sound/pci/emu10k1/emumixer.c                |  15 +-
 sound/pci/emu10k1/emupcm.c                  |   4 +-
 8 files changed, 291 insertions(+), 248 deletions(-)

-- 
2.40.0.152.g15d061e6df

