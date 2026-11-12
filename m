Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6CA606A31C
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Hm3yQ+RC;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=z0cH6vr3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IzWHx5my;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EHyjbC6m;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qpXHmoM8
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B94D16022E;
	Thu, 12 Nov 2026 13:40:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B94D16022E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794487225;
	bh=oH0lh3Dwg11s1nJnqHC5f/UqlLmbH/d3uXicSa0ILQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Hm3yQ+RCZl3g/YpJxuwImi5S/ogM7pjIicspWyRbZHyWadFRKdahzt7h/V5FZazJ6
	 oPne5bcBbAXJj3CK5SuPCBs7thmF9w52dkA630zMQqPQLrGN0+kR3fe5BzdxoeudHf
	 nk6i9m+1E97TS/y8wbquokl60r4eRO0ZJK32qTsA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14D36F805F9; Thu, 12 Nov 2026 13:39:51 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 655CAF80600;
	Thu, 12 Nov 2026 13:39:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0FD0EF8016E; Thu, 12 Nov 2026 13:39:44 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794487183;
	b=TBOP7z7tvfSgn9kgrkxQZDSszTNXwRId8T0wULIv7BBpEuemPf04pypr+5AJiQoW8lMV
	 F5YAkCnIB0RJ2crBMmwxMraxh8utnfrCj4ign5BektGCw5JH79iLXTh6SkgKnzXKIyS4B
	 a/vMHv36eR0NCJo0y7u92/E6vvkroxQiOHnlft3QAXG6gBo8ml56V3PKoA/NzIoxkL5EL
	 cd9CxnWHwfeUh3tQj/9QvjxCGIjDQ+C55k/o6VJ27+jTodULqYMxUMs25yr3j6pu+9J2J
	 fY30APySGfBCIRYNRNkF1F+vVEeEdOL/XyoUzxhC0ssu2xqwzJYRdsuprPavSgTQ93w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794487183;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=oH0lh3Dwg11s1nJnqHC5f/UqlLmbH/d3uXicSa0ILQA=;
	b=UqJ8lDLqFX6xra6E5tzfOKrA04E9ArTDSJR+KiwruUOViply1z9povfJCANiWYoo6lXB
	 E9qD24J24C+OgvY9gcFMj997Ka87EfIbU6jKTXSz1fNS5olCKhfn3c9PIQRvyqXv24aQI
	 NIOKps2RJ/fs7s9UP+Xi4i699wib2BEOS/+58h0V8mbuafXL//CInDXfq31CJkcr+W86I
	 8vRGOysyHsUKIvzXRgSg/dC9ubSYDRCiP8xumsMEr7U9+C+1/Y+FgMRbiqoiqlKH91VlA
	 aLReG4S6y5hd/JMpTxe147kU3RnxaagK4cwqRpinUZpp2CB2taf0Ik+GICzhG+sYXsw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=z0cH6vr3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=IzWHx5my;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=EHyjbC6m;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=qpXHmoM8;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 28B86F800DF
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2026 13:39:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28B86F800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=z0cH6vr3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=IzWHx5my;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=EHyjbC6m;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=qpXHmoM8
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D5C451F388;
	Thu, 12 Nov 2026 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1794487181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kiwSirOigF/qJvwquSbpNG7fgBeF8dwYpmmK5AWpf0=;
	b=z0cH6vr3S1IkK37jprtC0FQQgCKTnSNWRndG9RSkWambM5BBi0a5sHBhgftRAli793oY0R
	fOTYID3XTKGtZ7T0ljy4XHcxfw/JTKIJ6xqsvnVXs2GWx8k5RcQzF80M0pUj/ylgH2tf4h
	yduA2wvRp/6aftrE5fhCG/NzYR6oMVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794487181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kiwSirOigF/qJvwquSbpNG7fgBeF8dwYpmmK5AWpf0=;
	b=IzWHx5myU8g4iOqmQYQho6FMRa+qAJX8MDzODdWwEgIL3bGNfBHfTRfAD2jP1GtTxAViB9
	ztuY8tjQnuqsUFAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EHyjbC6m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qpXHmoM8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1794487180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kiwSirOigF/qJvwquSbpNG7fgBeF8dwYpmmK5AWpf0=;
	b=EHyjbC6mJfVsJBLRQ45FpJeZD37cuKi3OfZyQ0xQK889uqHQpiGygzmiJeXQhQ7xziLcuC
	Fxj+pLSB56huJINZsmGeXsxZFySQxdxiMlY2Z5R6HQaZqognE50XNlczikpFUgdmf2UyjA
	mRDU2bd/JvmuGjv8p4E9ye27w2pvaoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794487180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kiwSirOigF/qJvwquSbpNG7fgBeF8dwYpmmK5AWpf0=;
	b=qpXHmoM8AQ9klj3QPsG64zGQsmNHCN5FebGSv/AY2UeOKKqbwSQYzVAr7ZSa5J6SeyRuoS
	vBh3rbKPw5v5b9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9755D13432;
	Thu, 12 Nov 2026 12:39:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zZ/BG4yz9WodTwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 12 Nov 2026 12:39:40 +0000
Date: Thu, 12 Nov 2026 13:39:40 +0100
Message-ID: <87jymirzoz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang <kailang@realtek.com>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: Remove Headphone MIC support
In-Reply-To: <3c8129fbfa6d4ee2b464735f2f31dffa@realtek.com>
References: <3c8129fbfa6d4ee2b464735f2f31dffa@realtek.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D5C451F388
Message-ID-Hash: 3D5TPAZFDKIXVN6CJTTA2XOZQOI7SWTU
X-Message-ID-Hash: 3D5TPAZFDKIXVN6CJTTA2XOZQOI7SWTU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3D5TPAZFDKIXVN6CJTTA2XOZQOI7SWTU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Thu, 12 Nov 2026 08:59:14 +0100,
Kailang wrote:
> 
> Hi Takashi,
> 
> Dell QC DT unit don't support Headphone MIC.
> This patch was changed model to NO Headphone MIC model.
> This modify also fixed headphone popping noise issue.

Applied now.  Thanks.


Takashi
