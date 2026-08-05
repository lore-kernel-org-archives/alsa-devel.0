Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE86CC55182
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:31:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21616601FD;
	Wed,  5 Aug 2026 09:31:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21616601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785915094;
	bh=WnqEqrdW07q2e/QUo0fztWds+1Q1BZI+V9K/DpDRSLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=D09cZH0ArauqTs2NbGd1R2KzlP4xPW/37foI1c0j380V42DqNySirX41T73D4Y+ew
	 FHzsGKDDV+3iHJTwVFbTcy1no7u1XsIhLz8FLhbs4DkRNuhbyU6McM6L3toObR91pM
	 jwqZ+R3M8NpKHmsaN2WlOQvPtIQW3EhJY1qHDN+k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C779F805F7; Wed,  5 Aug 2026 09:30:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A3D7F80600;
	Wed,  5 Aug 2026 09:30:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2319F8027B; Wed,  5 Aug 2026 09:30:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785915048;
	b=O6NMP30JQ4WhjuVWTlg4pKW/u/q1A0ruBWVFAU9MV58cPc2d0josbCjFDIGl2bRIx2xQ
	 p6IPLRBS5BnupDIffTQpWjkN1HRf0lH2B/85B2lQrjc2+Vbo4Bt7wIbbeF7geXpKxx8DG
	 UDbH8B1PgdNAcEitBbHc+WGGVwkxAQLjTYETttA19FxSGF/8j+oICV7vMqNb+kae0egPv
	 Yv8zNxC0qZyJO9l8zJ0LgIX0avnevVt2ODBIMZvqzS8PDr3oFA92E89s3aNFYGA1ZEOEn
	 Vc32RNyKn8S8a51sHhKf8oLEAWPth5FuYmX1PunEWy4AruJ6Bwo6A5LJMqQsh8XjAyA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785915048;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=WnqEqrdW07q2e/QUo0fztWds+1Q1BZI+V9K/DpDRSLc=;
	b=hHSwzI/27p2onRpxgosqIpcCczZqJSjKe7wyF0uXZgTrK84yJ7Xq+F6x8pa5LrPrZzxg
	 iJO0YzbxeyWiVD91HoDPibCZCuxSVQpFIRS97odrR5V3g/xvea/cbZ/QxU26AG5iKivQ3
	 zv9+u6hB6nPsMHrpIl3mddePbH9cUj5drb0xu5en1SbUaY6bVeiCtBdhuOzm28HCdl23k
	 tVttCRNFWpKJjkpWrX5nzJ+AeOUJATQhmt1YvP48cKauvmAw7lfQh8UqMkcuHrwEkE2LJ
	 cKnrccE0qlDOJ8p2e8JggLDhXDzckqoIfmcTa7yS5fof1ICY2kiC+2tlVY9ayWOIj0w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=DhRTtnvR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=oGOzzNY4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=nInUPaal;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=i0CKfbTd;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BAB64F80124
	for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2026 09:30:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BAB64F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=DhRTtnvR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=oGOzzNY4;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=nInUPaal;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=i0CKfbTd
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E0137FC25;
	Wed,  5 Aug 2026 07:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785915042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a3jyPXx6CzYfSrIK6EQLlmYMm6UceLM3t5fE5akEh1A=;
	b=DhRTtnvReaNwE4kEZ4CjrQCQTsgqv/RH97U1YVShbL129Pe2sfPsMSE/ENfa9fspxvAg/s
	eWTx/FY5QdECHFZ4iOkqd2oHc/03Jnq4eYtQ+cEFwdLK0t1j+GRMUFrLKmaW6LuhaxGQ0H
	/Ln9NP8CPGdXQgD3JRyGEnP7HIKGkDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785915042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a3jyPXx6CzYfSrIK6EQLlmYMm6UceLM3t5fE5akEh1A=;
	b=oGOzzNY4W016hwN2Nmee1UgL2AyeSly550PIaFw8jspXMMajrZpgLDtSz/7+nMljEmxlbV
	rqZAWHkJd6vdjBBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nInUPaal;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i0CKfbTd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1785915038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a3jyPXx6CzYfSrIK6EQLlmYMm6UceLM3t5fE5akEh1A=;
	b=nInUPaalEOuDCsek713VLa95IwqFfWqYn/0ESGiDMoaOLFlQS9AaXHG2hKz1I2iVOZD5/6
	ELZvLhdR4imiuQASwKjsTS3IzRDtMPMjzAj5FJtkhLyVMPRqQGVapNjPht8UJo+MLZzp3T
	NoUahUXr5MhnQVisJrPE7nVI8Be6mq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785915038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a3jyPXx6CzYfSrIK6EQLlmYMm6UceLM3t5fE5akEh1A=;
	b=i0CKfbTd6MwsgwvzXeOS76jIbO+MAQmtHTaz3pkgynJyD+/WeLw0cXcQ1iM8LOTn+lJwyX
	q1bTEllRNLX3gVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A676779C2;
	Wed,  5 Aug 2026 07:30:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Dc+qF57mcmrmPgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 05 Aug 2026 07:30:38 +0000
Date: Wed, 05 Aug 2026 09:30:37 +0200
Message-ID: <87pkzxgh2a.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v6 1/2] ALSA: control: tidy up whitespaces
In-Reply-To: <20260720103505.1860399-1-mstrozek@opensource.cirrus.com>
References: <20260720103505.1860399-1-mstrozek@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cirrus.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 9E0137FC25
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Message-ID-Hash: SNMFUNRC6IT27IWPZXEC5WJCMCYC4Z62
X-Message-ID-Hash: SNMFUNRC6IT27IWPZXEC5WJCMCYC4Z62
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SNMFUNRC6IT27IWPZXEC5WJCMCYC4Z62/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 20 Jul 2026 12:35:04 +0200,
Maciej Strozek wrote:
> 
> Clean up trailing whitespace in preparation for the card components
> changes.
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---
> added in v3, no changes since then

Now I applied both to for-next branch.
Please submit the corresponding alsa-lib update (either alsa-devel ML
or github PR).


thanks,

Takashi
