Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30354C77B7F
	for <alsa-devel@archiver.kernel.org>; Tue, 16 May 2023 09:37:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFE6D10E;
	Tue, 16 May 2023 11:36:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFE6D10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684229868;
	bh=l0f/9X8AKxJS0d7Uy0iX6lVRCOXZwq6IXYe0EKM+aTw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=eSt+X4LveSmLEXP0JioXQkDsyUNtHEWiQEqhE76qWPRMC4nKVcyd1o6r6AtuUTzlv
	 HSkl0M6K5XOtMBFOQvxbF9etBiXwqR7R9lbJMhe1e5BDrZg+F9v1VADT4AOUuxEvZB
	 z6dVJ6EIwZgrICUeZpWYGSgKjvRaP42vYKG896yw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06D09F80578; Tue, 16 May 2023 11:36:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5EE24F8055B;
	Tue, 16 May 2023 11:36:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 99C88F8055B; Tue, 16 May 2023 11:36:19 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B4BAAF8016D
	for <alsa-devel@alsa-project.org>; Tue, 16 May 2023 11:36:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4BAAF8016D
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id BB9B223F78;
	Tue, 16 May 2023 05:36:12 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pyr6K-pzm-00; Tue, 16 May 2023 11:36:12 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 0/6] ALSA: emu10k1: assorted playback-related cleanups
Date: Tue, 16 May 2023 11:36:06 +0200
Message-Id: <20230516093612.3536451-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SL7QVZOC2ELUWTEOBGFFHWKQGEI65TNZ
X-Message-ID-Hash: SL7QVZOC2ELUWTEOBGFFHWKQGEI65TNZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SL7QVZOC2ELUWTEOBGFFHWKQGEI65TNZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


Oswald Buddenhagen (6):
  ALSA: emu10k1: straighten out FX send init
  ALSA: emu10k1: cleanup envelope register init
  ALSA: emu10k1: remove useless resets of stop-on-loop-end bits
  ALSA: emu10k1: rewire {en,dis}abling interrupts for PCM playback
  ALSA: emu10k1: skip needless setting of some voice registers
  ALSA: emu10k1: factor out snd_emu10k1_compose_audigy_sendamounts()

 Documentation/sound/cards/audigy-mixer.rst |  36 ++---
 include/sound/emu10k1.h                    |  14 +-
 sound/pci/emu10k1/emu10k1_main.c           |  12 +-
 sound/pci/emu10k1/emumixer.c               |  51 +------
 sound/pci/emu10k1/emupcm.c                 | 168 ++++++++++-----------
 sound/pci/emu10k1/io.c                     |  63 +-------
 6 files changed, 121 insertions(+), 223 deletions(-)

-- 
2.40.0.152.g15d061e6df

