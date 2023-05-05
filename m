Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76232C77B7C
	for <alsa-devel@archiver.kernel.org>; Fri,  5 May 2023 07:39:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17A3F2BCF;
	Fri,  5 May 2023 09:39:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17A3F2BCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683272392;
	bh=jezAXpX6BFT3CBlMovT+Mu6BnQGYZj7DJFpRajl9D58=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=cuzamtXwVzqVP23AMNa/fmXKC2yAvRsUajcqezp3d3SxEkfneFwfEqUvMu9UQyq53
	 60OynzIFbN6Pn+f38/KiR7YYA9Vtp/2enpcT1pJ0K+YHBKzOgwgE6fGF3GCiaPd2+i
	 DobXJ/ZweL19PYCk93tjyK1SC9unrVrXciAYrRD8=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F434F8052E;
	Fri,  5 May 2023 09:38:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8EB51F8052D; Fri,  5 May 2023 09:38:33 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6C0CCF80087
	for <alsa-devel@alsa-project.org>; Fri,  5 May 2023 09:38:30 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id EC20D11E2;
	Fri,  5 May 2023 09:38:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz EC20D11E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1683272309; bh=4zAtNdLKO/zSz9lg4vVAz+VML9cLnXn/6YCAcL0xszI=;
	h=From:To:Cc:Subject:Date:From;
	b=QFDTApjroCw3ALDu5U2oQRGw5qO2CqeNvXdBf4ay8AOwki1FXTUxVEEiyq8NAnClL
	 d/HYKbDMdWj91zCWVFnCxEnq919A5uQ2cPL0z/la034CVKmr4kkc6vfV1hFlk27jqX
	 XrJLcxxWVsNxHVSzCD3m/O26LO7uPbv5NOhKJNZY=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Fri,  5 May 2023 09:38:23 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH 0/5] rewrite snd_pcm_playback_silence() again
Date: Fri,  5 May 2023 09:38:08 +0200
Message-Id: <20230505073813.1219175-1-perex@perex.cz>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: HBBL5MCA45GKS6S7KA5IU6PJKX6GXXZY
X-Message-ID-Hash: HBBL5MCA45GKS6S7KA5IU6PJKX6GXXZY
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Takashi Iwai <tiwai@suse.de>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Jeff Chua <jeff.chua.linux@gmail.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HBBL5MCA45GKS6S7KA5IU6PJKX6GXXZY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This is a split of changes for both patches (the first with the missing
top-up mode + later fix with mixups) proposed by Oswald. The aim was to
pick only real code changes.

Only the first two patches after revert fixes the current silencing issues.
The last two are just cleanups with the extra optimization in the last patch
moving the common code to a function.

Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>

Jaroslav Kysela (5):
  ALSA: pcm: Revert "ALSA: pcm: rewrite snd_pcm_playback_silence()"
  ALSA: pcm: fix playback silence - use the actual new_hw_ptr for the
    threshold mode
  ALSA: pcm: fix playback silence - correct the incremental silencing
  ALSA: pcm: playback silence - remove extra code
  ALSA: pcm: playback silence - move silence variables updates to
    separate function

 sound/core/pcm_lib.c    | 91 +++++++++++++++++++++++++----------------
 sound/core/pcm_local.h  |  3 +-
 sound/core/pcm_native.c |  6 +--
 3 files changed, 61 insertions(+), 39 deletions(-)

-- 
2.39.2

