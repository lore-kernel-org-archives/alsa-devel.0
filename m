Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF429F3D32D
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:26:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44D38602BA;
	Thu,  5 Mar 2026 17:26:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44D38602BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772727975;
	bh=E+xhyK1WvDvZgKyHcVKBT+4IPXK22DrvgR5QtL4WLys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mk3zFs0ek2OXTI5uXIMi38DbfYy7SgEBnissOz2mvU3bpla78sFABK/sU5KUqQ6hJ
	 yY+Rh0JqiWajn1QMnZK+MhkFxwKRdotk4lnBcAjbHbmwRPqhkT6Y6tDRM+23l/bpZP
	 3tSCqaagEC03B6n5amu5q6HqSXThmK+lQ2ASzLPA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED47BF805F0; Thu,  5 Mar 2026 17:25:36 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A240F805F4;
	Thu,  5 Mar 2026 17:25:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 65438F8025A; Thu,  5 Mar 2026 17:25:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9C07DF80087
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2026 17:25:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C07DF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=plSPaHxd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=vllcqjh6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=plSPaHxd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=vllcqjh6
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45C7F3E772;
	Thu,  5 Mar 2026 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1772727926;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCW80X4l814i5jqh/o4QUL7HBvpx3DQfYnnssG2SJNo=;
	b=plSPaHxdcYBkTmXOzVyoCqeT/T/xb80LGAW87JUUOcY7oZSBWjrZflKtF+dqrxPk5RfhNR
	r35pPn39NSerRcN8qb5Xv82YAG0EOzP86HN2Y/0ZqBvwxDFVQHJuwX5pPmNpXitSvXZkvQ
	aPwzM8sl9crj+AcqbapOQy2WmyzvD4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772727926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCW80X4l814i5jqh/o4QUL7HBvpx3DQfYnnssG2SJNo=;
	b=vllcqjh6j8Vg7ioKMeMCtUusJVDHFEmq8V7LqWlfp1JAn5jYUySR50faiMX7jr73W7jHOT
	elmV3wC1f2fI1vCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=plSPaHxd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vllcqjh6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1772727926;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCW80X4l814i5jqh/o4QUL7HBvpx3DQfYnnssG2SJNo=;
	b=plSPaHxdcYBkTmXOzVyoCqeT/T/xb80LGAW87JUUOcY7oZSBWjrZflKtF+dqrxPk5RfhNR
	r35pPn39NSerRcN8qb5Xv82YAG0EOzP86HN2Y/0ZqBvwxDFVQHJuwX5pPmNpXitSvXZkvQ
	aPwzM8sl9crj+AcqbapOQy2WmyzvD4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772727926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wCW80X4l814i5jqh/o4QUL7HBvpx3DQfYnnssG2SJNo=;
	b=vllcqjh6j8Vg7ioKMeMCtUusJVDHFEmq8V7LqWlfp1JAn5jYUySR50faiMX7jr73W7jHOT
	elmV3wC1f2fI1vCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20B333EA68;
	Thu,  5 Mar 2026 16:25:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ENOABnauqWmScAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 05 Mar 2026 16:25:26 +0000
Date: Thu, 05 Mar 2026 17:25:25 +0100
Message-ID: <87h5quw8ei.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.0-rc2
In-Reply-To: <7ad7ff6760638a45f9d77f53a870e817@kernel.org>
References: <7ad7ff6760638a45f9d77f53a870e817@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 45C7F3E772
Message-ID-Hash: BZ3DL5ER5L5QWZM3KQTQY3R4ETSUC3IC
X-Message-ID-Hash: BZ3DL5ER5L5QWZM3KQTQY3R4ETSUC3IC
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BZ3DL5ER5L5QWZM3KQTQY3R4ETSUC3IC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 05 Mar 2026 17:08:54 +0100,
Mark Brown wrote:
> 
> The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:
> 
>   Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.0-rc2
> 
> for you to fetch changes up to 325291b20f8a6f14b9c82edbf5d12e4e71f6adaa:
> 
>   ASoC: amd: yc: Add DMI quirk for ASUS EXPERTBOOK PM1503CDA (2026-03-04 11:40:17 +0000)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.0
> 
> A moderately large pile of fixes, though none of them are  super major,
> plus a few new quirks and device IDs.

Pulled now.  Thanks.


Takashi
