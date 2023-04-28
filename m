Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C61CC77B60
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Apr 2023 10:02:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E46B12AE;
	Fri, 28 Apr 2023 12:01:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E46B12AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682676144;
	bh=ks7xfQ9rRIqXMbRTqYsFyv30O1v8XGxdCI9VNaJ4Yjk=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=E+rOqC80z68YDVN0YsqA6QIkl4wXiILpH77PdBNzxbQPAK0rNle2fLztFKyjrfeuB
	 nIbU2tS5ozLq9d+JJPzjvwl++5oFWaXx6wJRHeUHUcgg1VjoCGaZ+y7WZTdh1Vb95y
	 TRl4Dm5s35siVts8UvOZuqSZni4BJXxozky3mccA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 37688F80558;
	Fri, 28 Apr 2023 12:00:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BBE3F80548; Fri, 28 Apr 2023 12:00:14 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 92543F8052D
	for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2023 11:59:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92543F8052D
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id C10E62420A;
	Fri, 28 Apr 2023 05:59:41 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1psKtB-9sr-00; Fri, 28 Apr 2023 11:59:41 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/6] ALSA: emu10k1: Various improvements related to locking
Date: Fri, 28 Apr 2023 11:59:35 +0200
Message-Id: <20230428095941.1706278-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: G3NEETTBJURVFKK4P25DZVHJJ57PPFJX
X-Message-ID-Hash: G3NEETTBJURVFKK4P25DZVHJJ57PPFJX
X-MailFrom: ossi@kde.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Takashi Iwai <tiwai@suse.de>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G3NEETTBJURVFKK4P25DZVHJJ57PPFJX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

---

This patch series needs to be applied on top of the patch titled "ALSA:
emu10k1: use more existing defines instead of open-coded numbers".

Oswald Buddenhagen (6):
  ALSA: emu10k1: remove pointless locks from timer code
  ALSA: emu10k1: remove pointless locks from /proc code
  ALSA: emu10k1: use the right lock in snd_emu10k1_shared_spdif_put()
  ALSA: emu10k1: fix locking in snd_emu1010_fpga_link_dst_src_write()
  ALSA: core: update comment on snd_card.controls_rwsem
  ALSA: emu10k1: remove now superfluous mixer locking

 include/sound/core.h         |  2 +-
 sound/pci/emu10k1/emufx.c    |  7 -------
 sound/pci/emu10k1/emumixer.c | 32 ++------------------------------
 sound/pci/emu10k1/emupcm.c   |  2 --
 sound/pci/emu10k1/emuproc.c  |  6 ------
 sound/pci/emu10k1/io.c       | 25 +++++++++++++++++--------
 sound/pci/emu10k1/timer.c    |  6 ------
 7 files changed, 20 insertions(+), 60 deletions(-)

-- 
2.40.0.152.g15d061e6df

