Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C187C4345F
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Apr 2024 12:18:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26AFE10BE;
	Tue, 16 Apr 2024 14:18:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26AFE10BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1713269926;
	bh=aY8++HxRFmpGifsfgLUOkhH818thc1en9HPDo3uQgoA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=R6YoYVTDg6Otekskxq8Ffvyu9BA2pHrfDYh+o1l4p5caJDGIfmsWhojhsbcomr7iw
	 RnFJurEUSDX+4ub+0lSOxgihpgYtcLybKYBJzo0sfLvxi/lHuZPLkHPD8nQEMa3QpT
	 lcE8wEzfayRxiVoss5eIEWCrj1LZYvE+Phn7JHn8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C79DF805F2; Tue, 16 Apr 2024 14:17:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CF6FF805FC;
	Tue, 16 Apr 2024 14:17:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B996F80423; Tue, 16 Apr 2024 14:17:38 +0200 (CEST)
Received: from smtp.ivitera.com (smtp.ivitera.com [88.101.85.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4F089F8013D
	for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2024 14:17:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F089F8013D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=ivitera.com header.i=@ivitera.com header.a=rsa-sha256
 header.s=mail header.b=T00z+q5h;
	dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.a=rsa-sha256 header.s=mail header.b=T00z+q5h
Received: from localhost (localhost [127.0.0.1])
	by smtp.ivitera.com (Postfix) with ESMTP id D26D11722D2;
	Tue, 16 Apr 2024 14:17:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
	t=1713269847; bh=aY8++HxRFmpGifsfgLUOkhH818thc1en9HPDo3uQgoA=;
	h=From:To:Cc:Subject:Date:From;
	b=T00z+q5hAxivumMY0mkncWs+0ALZOq/bexUKCkIRF9Sj7Iq/HDJGSbYxOj6gkDLO6
	 4ppuRWPqCe09nWCN17dmJbOpFXW4e4D4YrN0wVa1SnUtrv2tMHFuKV7GmobGkivdk6
	 K5o13MAD4YXqosZ5c3AtcyO66M8W2nT5LkDL3ox8=
Received: from smtp.ivitera.com ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iPrvbPGBIuEm; Tue, 16 Apr 2024 14:17:27 +0200 (CEST)
Received: from precision.insite.cz (dustin.pilsfree.net [81.201.58.138])
	(Authenticated sender: pavel)
	by smtp.ivitera.com (Postfix) with ESMTPSA id 51EA917322E;
	Tue, 16 Apr 2024 14:17:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
	t=1713269847; bh=aY8++HxRFmpGifsfgLUOkhH818thc1en9HPDo3uQgoA=;
	h=From:To:Cc:Subject:Date:From;
	b=T00z+q5hAxivumMY0mkncWs+0ALZOq/bexUKCkIRF9Sj7Iq/HDJGSbYxOj6gkDLO6
	 4ppuRWPqCe09nWCN17dmJbOpFXW4e4D4YrN0wVa1SnUtrv2tMHFuKV7GmobGkivdk6
	 K5o13MAD4YXqosZ5c3AtcyO66M8W2nT5LkDL3ox8=
From: Pavel Hofman <pavel.hofman@ivitera.com>
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>,
	Pavel Hofman <pavel.hofman@ivitera.com>
Subject: [PATCH 0/3] adding 705.6/768kHz rates; DSD and 768kHz in aloop
Date: Tue, 16 Apr 2024 14:17:23 +0200
Message-Id: <20240416121726.628679-1-pavel.hofman@ivitera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JXCWGSTR3T4EUOURTHB5EIU3ZOUMEDXR
X-Message-ID-Hash: JXCWGSTR3T4EUOURTHB5EIU3ZOUMEDXR
X-MailFrom: pavel.hofman@ivitera.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JXCWGSTR3T4EUOURTHB5EIU3ZOUMEDXR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch series allows using the loopback driver in modern chains with
samplerates up to 768kHz and DSD formats.

The patch "ALSA:pcm: add support for 705.6kHz and 768kHz sample rates" is
basically a copy of commit 4cc4531c310e ("ALSA: pcm: add support for 352.8KHz and 384KHz sample rate").

As of loopback performance at 768kHz - in my tests aloop runs OK event at
12MHz samplerate.

Pavel Hofman (3):
  ALSA:aloop: add DSD formats
  ALSA:pcm: add support for 705.6kHz and 768kHz sample rates
  ALSA:aloop: add support for up to 768kHz sample rate

 include/sound/pcm.h     | 5 +++++
 sound/core/pcm_native.c | 2 +-
 sound/drivers/aloop.c   | 9 ++++++---
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.25.1

