Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E316EE6447
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Sep 2023 09:15:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74BA3A4B;
	Fri, 15 Sep 2023 11:14:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74BA3A4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694769336;
	bh=aAKvD7hx0uO1tCyx5nAqyjMI+Tn7dzMKgIT3uoYNjBM=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=hjrXfGc7ogCbVBQVAc+5FETjTuz9ZTr+KNjENJv6j+gPnmOB9zhIK5B0NmSC4MFj6
	 5su83TOscI8x7yqSP1tfnEbX2QRlNe0YTxUvNKtbcRDKnmqqD6u31g/eCMZpfDjgu6
	 MCMmy4HzMPnFUmhMfnjPu5VTaCBkpm3/NPcrZ0ZU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90ABAF80588; Fri, 15 Sep 2023 11:13:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 23F16F80589;
	Fri, 15 Sep 2023 11:13:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40D7BF80567; Fri, 15 Sep 2023 11:13:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5C22AF8007C
	for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2023 11:13:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C22AF8007C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=FJxYDTqF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=A+MEdM6E
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0B412185F;
	Fri, 15 Sep 2023 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1694769195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=pjdoECbel2xKDElSQcL17UTGhNlQa8zIxiftJXqnpA0=;
	b=FJxYDTqFIkp29WEEKoQ0RYbvg/xRtUrZv88twMhDVqxPerDMhvmM3HGo9RK/MLuOMX81iO
	SmDHVMB3J3vNohEC03JRa4dYP96res3quNLX26RGTqCSEBfMvqmWvDqmHPwlcyEcUFe8vw
	1t58eWXCaYf/HSBg8qppl/mI8mKLmkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694769195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=pjdoECbel2xKDElSQcL17UTGhNlQa8zIxiftJXqnpA0=;
	b=A+MEdM6ELpVD5q/5ZWrumMdy5tlstOgL6IOElMYrKFjp29aqL0jnuPsk5RscfIl5K4UPdI
	ZQOaQkTaoIhn6MAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A2671358A;
	Fri, 15 Sep 2023 09:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +3+/HCsgBGWcWQAAMHmgww
	(envelope-from <tiwai@suse.de>); Fri, 15 Sep 2023 09:13:15 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ALSA: Yer more fix -Wformat-truncation warnings
Date: Fri, 15 Sep 2023 11:13:10 +0200
Message-Id: <20230915091313.5988-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NJZ76PREXTHL6WAH6TDP67UQ5RL4OGOU
X-Message-ID-Hash: NJZ76PREXTHL6WAH6TDP67UQ5RL4OGOU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NJZ76PREXTHL6WAH6TDP67UQ5RL4OGOU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This is a few more similar patches covering the recent warnings by
the -Wformat-truncation option.


Takashi

===

Takashi Iwai (3):
  ALSA: ad1848: Fix -Wformat-truncation warning for longname string
  ALSA: cs4231: Fix -Wformat-truncation warning for longname string
  ALSA: riptide: Fix -Wformat-truncation warning for longname string

 sound/isa/ad1848/ad1848.c   | 12 ++++++------
 sound/isa/cs423x/cs4231.c   | 12 ++++++------
 sound/pci/riptide/riptide.c | 16 ++++++++--------
 3 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.35.3

