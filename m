Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2F6C3DA59
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jul 2024 17:55:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 154507F8;
	Mon, 22 Jul 2024 19:55:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 154507F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1721670941;
	bh=u+x3Kngce7wmulgXotV/FtEkCDNjHILFl18rzsmB0B8=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=SFS/6/Mo2LeYTFBwJPNdwSCOg3uBiWT4Nrqeq3pujzluInrTxlG6JBDofl3E7HOLA
	 99rI3Uk9r/fq/bO2xOla/CIQ+L/HY0kFuo3+HHJJMEQ3A9zpvDWWm7VO4WdoWkCm9c
	 fv4BZhFrCz0mwbqNf7PjtTRwDCjztppQzqyazVuM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D7BAF805BA; Mon, 22 Jul 2024 19:54:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BE132F80580;
	Mon, 22 Jul 2024 19:54:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8DBA5F805A0; Mon, 22 Jul 2024 19:51:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A80DCF8013D
	for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2024 19:51:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A80DCF8013D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=0157Socu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tgB0H9/w;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=0157Socu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tgB0H9/w
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF88A21B6A;
	Mon, 22 Jul 2024 17:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1721670704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=j+CzKytqIYVeZ4VI0S4MCj7QCWjggEEFnlHNiZKH+8Q=;
	b=0157SocumOpOVMStdiQvlQcViSu7xtiuo2L8NjTazwtAUGWI9Drn3V3kfAfT1v83reoD+/
	pNqw97Hs+B+3+3CLOojmEytZI8esq5smrQAoejhyvzkiyIaMoy+Tzc2Ol2xaljKua9vhis
	vixepQlfCVUuzJs5vJnlY9Ce8h3VfLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721670704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=j+CzKytqIYVeZ4VI0S4MCj7QCWjggEEFnlHNiZKH+8Q=;
	b=tgB0H9/w+kP/IADo96YjKvcusfzCBvsIDn0UV6OAYTfsHqW1iBvhwyBK6UxVDS+XQ6ql3h
	PxLevJkNiz/mE+Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0157Socu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="tgB0H9/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1721670704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=j+CzKytqIYVeZ4VI0S4MCj7QCWjggEEFnlHNiZKH+8Q=;
	b=0157SocumOpOVMStdiQvlQcViSu7xtiuo2L8NjTazwtAUGWI9Drn3V3kfAfT1v83reoD+/
	pNqw97Hs+B+3+3CLOojmEytZI8esq5smrQAoejhyvzkiyIaMoy+Tzc2Ol2xaljKua9vhis
	vixepQlfCVUuzJs5vJnlY9Ce8h3VfLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721670704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=j+CzKytqIYVeZ4VI0S4MCj7QCWjggEEFnlHNiZKH+8Q=;
	b=tgB0H9/w+kP/IADo96YjKvcusfzCBvsIDn0UV6OAYTfsHqW1iBvhwyBK6UxVDS+XQ6ql3h
	PxLevJkNiz/mE+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87262138A7;
	Mon, 22 Jul 2024 17:51:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XQC6HzCcnmbyBgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 22 Jul 2024 17:51:44 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-utils 00/10] Cleanup seq/* stuff and extend aseqsend
Date: Mon, 22 Jul 2024 19:52:04 +0200
Message-ID: <20240722175215.8223-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AF88A21B6A
X-Spamd-Result: default: False [-2.81 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
Message-ID-Hash: NIO2BLCPSMURRLPMNEYGNTZVMIHQUCD5
X-Message-ID-Hash: NIO2BLCPSMURRLPMNEYGNTZVMIHQUCD5
X-MailFrom: tiwai@suse.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NIO2BLCPSMURRLPMNEYGNTZVMIHQUCD5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

this is a series of cleanup / fix patches for alsa-utils/seq/* stuff,
including the extension of aseqsend to support UMP packet bytes.


Takashi

===

Takashi Iwai (10):
  configure: Requires the latest ALSA-lib release 1.2.12
  aplaymidi: Drop ifdef for UMP support
  aplaymidi: Allow to pass 0 to -u option, too
  aconnect: Drop superfluous ifdefs
  aseqdump: Drop ifdef for UMP support
  aseqdump: Check the -u option value properly
  configure: Drop unused conditionals
  aseqdump: Show SysEx prefix to UMP SysEx data dump
  aseqsend: Support UMP mode
  aseqsend: Support long options

 configure.ac              | 13 +-------
 seq/aconnect/aconnect.c   | 31 ------------------
 seq/aplaymidi/aplaymidi.c | 32 +++---------------
 seq/aseqdump/aseqdump.c   | 25 +++-----------
 seq/aseqsend/aseqsend.1   | 69 +++++++++++++++++++++------------------
 seq/aseqsend/aseqsend.c   | 54 +++++++++++++++++++++++++++++-
 6 files changed, 100 insertions(+), 124 deletions(-)

-- 
2.43.0

