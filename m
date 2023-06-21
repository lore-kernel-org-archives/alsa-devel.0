Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DC4EB64D8
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 11:04:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D65614E;
	Wed, 21 Jun 2023 13:03:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D65614E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687345478;
	bh=qCKs3/paHBtxowj1/1xs6UUzfMLrwZjUXQ/sKH3FAkI=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=irgM8HbtDXZ6Iaa3PCWYv5YD0W/bRHhFDTboWlF+nUphJ1WSIm7j01puPAkAwyC2m
	 Bi6oLSSHhW1b805ZIFJcNFJ4HbUiAmskLaMSfv1Usp2JtOgbVz5cVSd+PGqocs6Kss
	 RsnpDuRpbtgLvyJHA/+6RcSatPcS2HBJ4KmHV3F0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47CC0F80567; Wed, 21 Jun 2023 13:02:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A4CA5F80567;
	Wed, 21 Jun 2023 13:02:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60377F80549; Wed, 21 Jun 2023 13:02:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2001:67c:2178:6::1d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EB509F80093
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 13:02:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB509F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=QdbJARIP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=T4Lvm25f
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73F781FDBB;
	Wed, 21 Jun 2023 11:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1687345363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=2YJ9xx+aOBG1mcbyKIjlUqxzYp7Pz7GYn75jxNsK55g=;
	b=QdbJARIPFJrxCEpuw94jIwaMpuSKubEZ5he9vVHadqqCTgSdlUPylmmwt+camZHfGYyce8
	Fc/kDnAVOUdcfcI2a5rRMzkSAdTuZi9UGkYnYr0JopRvShZ+pd4jzenbP4NmCy8aHSDu5d
	KSNoY4FkW7G4zBTSxApPGVUrH+jfg1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687345363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=2YJ9xx+aOBG1mcbyKIjlUqxzYp7Pz7GYn75jxNsK55g=;
	b=T4Lvm25fTGOZMnC8vtzANnCMrQu68EyCEPiaFbuz/sjXIVsHP3D+otiYZfHwH61u4k60FN
	FuemT4D0I/3+4ODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D5C9134B1;
	Wed, 21 Jun 2023 11:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 1adyFtPYkmTdHgAAMHmgww
	(envelope-from <tiwai@suse.de>); Wed, 21 Jun 2023 11:02:43 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ALSA: ump: Preliminary changes for gadget driver
Date: Wed, 21 Jun 2023 13:02:38 +0200
Message-Id: <20230621110241.4751-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QF5TAJ2YNPO5FFS6ZMWHOVPPDWBKDEB7
X-Message-ID-Hash: QF5TAJ2YNPO5FFS6ZMWHOVPPDWBKDEB7
X-MailFrom: tiwai@suse.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QF5TAJ2YNPO5FFS6ZMWHOVPPDWBKDEB7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

this is a small patch set to change the UMP core for the upcoming
gadget driver support.  Basically exporting a couple of helper
functions and adding a flag to suppress the internal UMP handling.
No functional changes by those alone.


Takashi

===

Takashi Iwai (3):
  ALSA: ump: Add helper to change MIDI protocol
  ALSA: ump: Add no_process_stream flag
  ALSA: ump: Export snd_ump_receive_ump_val()

 include/sound/ump.h |  4 ++++
 sound/core/ump.c    | 46 +++++++++++++++++++++++++++++++++++----------
 2 files changed, 40 insertions(+), 10 deletions(-)

-- 
2.35.3

