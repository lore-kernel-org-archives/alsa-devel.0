Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C95C7EE26
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 20:10:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A163847;
	Tue, 23 May 2023 22:09:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A163847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684872642;
	bh=LSeTmt4D4HxqY7on+/B2lGzsdaKF6ymdlrTaLv1WD6k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=gwIuTCEMaBhy/HTMLiBrMMCRIEdPlu4c3ef0T1xa2VPXSO1a+xOCkM5NpZXwMPLlf
	 OBH3d+FG1zkHhrbfrvZF2KKCKRICG6r7LfgGqlDGkKcBCwgwRPVLVh4I+Bx++obEf7
	 /7+uFeC6BdXJWM28tD0jKWgyVR8KE8giW6HUkI60=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 35A55F805E1; Tue, 23 May 2023 22:07:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 61B2EF805C8;
	Tue, 23 May 2023 22:07:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D936EF805B4; Tue, 23 May 2023 22:07:36 +0200 (CEST)
Received: from bluemchen.kde.org (bluemchen.kde.org
 [IPv6:2001:470:142:8::100])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A6E24F80425
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 22:07:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6E24F80425
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 3E20F241F5;
	Tue, 23 May 2023 16:07:10 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
	id 1q1YHl-zPc-00; Tue, 23 May 2023 22:07:09 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 0/4] ALSA: emu10k1: capture-related improvements
Date: Tue, 23 May 2023 22:07:05 +0200
Message-Id: <20230523200709.236059-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6HLJ6QXNV5GSC55EZAGJSGYGTM3JNMFA
X-Message-ID-Hash: 6HLJ6QXNV5GSC55EZAGJSGYGTM3JNMFA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6HLJ6QXNV5GSC55EZAGJSGYGTM3JNMFA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


Oswald Buddenhagen (4):
  ALSA: emu10k1: fix capture buffer size confusion
  ALSA: emu10k1: fix support for 24 kHz capture
  ALSA: emu10k1: don't restrict capture channel count to powers of two
  ALSA: emu10k1: fix multi-channel capture config for E-MU cards

 sound/pci/emu10k1/emupcm.c | 122 +++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 60 deletions(-)

-- 
2.40.0.152.g15d061e6df

