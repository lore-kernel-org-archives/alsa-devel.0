Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B6FC7EE23
	for <alsa-devel@archiver.kernel.org>; Thu, 18 May 2023 14:06:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3104E3E7;
	Thu, 18 May 2023 16:05:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3104E3E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684418759;
	bh=UuHx04hSE3nvvit+/BJGPN6bovsW2uIqsUMiqWF/WXo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=W23DPnSohNgKKgzv9MDL5H6ehRhxzWl29fGr4CauLW6IaNjOXQsaCNwREIhFraXeY
	 MidnBJY1ElJMTvzhhHa/6FtxZjYA9orVRxzN+HVY7aiO69mZ8Hvc9ouxcyhm/kKPqv
	 HsvKkH2liapaseH12IT5FSHKZb7aDJ8UwjcUYoN0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8CD30F8057F; Thu, 18 May 2023 16:04:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17EE0F8057F;
	Thu, 18 May 2023 16:04:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 564E4F80570; Thu, 18 May 2023 16:03:54 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EA108F80431
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2023 16:03:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA108F80431
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 8009223F20;
	Thu, 18 May 2023 10:03:39 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1pzeEF-cKw-00; Thu, 18 May 2023 16:03:39 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 0/2] ALSA: emu10k1: various improvements to the DSP-based
 mixer code
Date: Thu, 18 May 2023 16:03:37 +0200
Message-Id: <20230518140339.3722279-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3WK6OFZ7DT55X72HIDSO6SGU2UJCRAFP
X-Message-ID-Hash: 3WK6OFZ7DT55X72HIDSO6SGU2UJCRAFP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3WK6OFZ7DT55X72HIDSO6SGU2UJCRAFP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


Oswald Buddenhagen (2):
  ALSA: emu10k1: enable bit-exact playback, part 3: pitch
  ALSA: emu10k1: enable bit-exact playback, part 4: send amounts

 include/sound/emu10k1.h    |  2 ++
 sound/pci/emu10k1/emupcm.c | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

-- 
2.40.0.152.g15d061e6df

