Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FE4C77B7A
	for <alsa-devel@archiver.kernel.org>; Thu, 18 May 2023 14:12:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3280825;
	Thu, 18 May 2023 16:11:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3280825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684419161;
	bh=ocFe/SELUTKznmFuFG+F9iCrOwehlOL5hVU3PDRsIbg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qduU5bVnpF0MHMzFOOcSAkIGgV1I1iYEZiIvk4P2rKCnHcdKupKYLg9ALODGnPo3W
	 WorqmjG7/iTozPAt5tpdeRZApzFY5qWRBMsWp7o7vNxdn/edNf7iMwJHjiMidj9Qdz
	 Vmnemjv1G+J1dxUYXQzAmBFL8C8jVIlQok/9Of6Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90F9DF805B5; Thu, 18 May 2023 16:10:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B1E7F805BB;
	Thu, 18 May 2023 16:10:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6720AF8053D; Thu, 18 May 2023 16:09:59 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1A0FAF80272
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2023 16:09:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A0FAF80272
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 7850923E25;
	Thu, 18 May 2023 10:09:47 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pzeKB-d9G-00; Thu, 18 May 2023 16:09:47 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 0/7] ALSA: emu10k1: refactoring of the playback voice
 management
Date: Thu, 18 May 2023 16:09:40 +0200
Message-Id: <20230518140947.3725394-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VDCCOFL2Z7LAEINBHRJWXJ7KQL35RJNC
X-Message-ID-Hash: VDCCOFL2Z7LAEINBHRJWXJ7KQL35RJNC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VDCCOFL2Z7LAEINBHRJWXJ7KQL35RJNC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


Oswald Buddenhagen (7):
  ALSA: emu10k1: simplify freeing synth voices
  ALSA: emu10k1: don't forget to reset reclaimed synth voices
  ALSA: emu10k1: improve voice status display in /proc
  ALSA: emu10k1: make freeing untouched playback voices cheap
  ALSA: emu10k1: centralize freeing PCM voices
  ALSA: emu10k1: make snd_emu10k1_voice_alloc() assign voices' epcm
  ALSA: emu10k1: revamp playback voice allocator

 include/sound/emu10k1.h              |  18 ++--
 sound/pci/emu10k1/emu10k1_callback.c |   8 +-
 sound/pci/emu10k1/emumixer.c         |  24 ++---
 sound/pci/emu10k1/emupcm.c           |  88 ++++++++---------
 sound/pci/emu10k1/emuproc.c          |  18 ++--
 sound/pci/emu10k1/voice.c            | 136 +++++++++++++--------------
 6 files changed, 136 insertions(+), 156 deletions(-)

-- 
2.40.0.152.g15d061e6df

