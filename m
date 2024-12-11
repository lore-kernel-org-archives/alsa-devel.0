Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724DFE7717D
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2024 11:35:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C4852C57;
	Wed, 11 Dec 2024 12:35:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C4852C57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733916922;
	bh=8ubElFPwjHycNjFrW9z0XYAiigHs4ZcryCq1r3llRow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vZwsdoMF7PXPfGW8J62TLIR2wjus1cyH+BEunnWzfuE7OYE5NEjqhfuMB7IeIMErp
	 J8JEfT7U5hxGn8v3Eu4x/+71yvT5r7TG3BFiWMVuDr9qAhN3HLKHbjkNccF4y/9FLA
	 qF6y+1+WvMKWe7na2UagdAOFcfdunaWUrz3TcrEI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BB30F805BF; Wed, 11 Dec 2024 12:33:12 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6161AF805C4;
	Wed, 11 Dec 2024 12:33:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1C34F80533; Wed, 11 Dec 2024 12:33:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 20E47F8016C
	for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2024 12:33:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20E47F8016C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=kweNVhfr;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=wCHSz1pl;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=kweNVhfr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=wCHSz1pl
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D63C721114;
	Wed, 11 Dec 2024 10:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1733914533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFHwJAzUaJg9vLlBzM9HuaXQrGkjzqZF6G6iw21/CnM=;
	b=kweNVhfrz1/Xz5hwZz84ok40l/5GrD4eLrgEHYGVAueVt41yly1P0/Q8ZjCQYklWuaZNx2
	1omDjHGLTOgIrlNWy4A7vQUVn5RYnsk8xOjUXxedNJprz69VYs2Wno70FmC7Fz69JiOP3a
	On4weW7CYHv3law4xPc3AcLUqdwjj94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733914533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFHwJAzUaJg9vLlBzM9HuaXQrGkjzqZF6G6iw21/CnM=;
	b=wCHSz1plVREcbIMmYJ5rc8+Iz0scQ4QlUmwfPwqfZSBcw400PLoljvnEV+oFRnr5XWFQmB
	Aq/JqIb2Lq0sNyCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1733914533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFHwJAzUaJg9vLlBzM9HuaXQrGkjzqZF6G6iw21/CnM=;
	b=kweNVhfrz1/Xz5hwZz84ok40l/5GrD4eLrgEHYGVAueVt41yly1P0/Q8ZjCQYklWuaZNx2
	1omDjHGLTOgIrlNWy4A7vQUVn5RYnsk8xOjUXxedNJprz69VYs2Wno70FmC7Fz69JiOP3a
	On4weW7CYHv3law4xPc3AcLUqdwjj94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733914533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFHwJAzUaJg9vLlBzM9HuaXQrGkjzqZF6G6iw21/CnM=;
	b=wCHSz1plVREcbIMmYJ5rc8+Iz0scQ4QlUmwfPwqfZSBcw400PLoljvnEV+oFRnr5XWFQmB
	Aq/JqIb2Lq0sNyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5BB31344A;
	Wed, 11 Dec 2024 10:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HN0nK6VvWWdiZgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 11 Dec 2024 10:55:33 +0000
Date: Wed, 11 Dec 2024 11:55:33 +0100
Message-ID: <87frmu32vu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: alsa-devel@alsa-project.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 30/37] ALSA: seq: Automatic conversion of UMP events
In-Reply-To: 
 <CAHbf0-HuzfubZiLBsPhc24HrmS54sAsoDd_DVHPj+nTFqtuFAQ@mail.gmail.com>
References: 
 <CAHbf0-HuzfubZiLBsPhc24HrmS54sAsoDd_DVHPj+nTFqtuFAQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
Message-ID-Hash: YUN3S6TYHUVWNS5Q77R2TXFS4MOOKQ24
X-Message-ID-Hash: YUN3S6TYHUVWNS5Q77R2TXFS4MOOKQ24
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YUN3S6TYHUVWNS5Q77R2TXFS4MOOKQ24/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 11 Dec 2024 11:35:09 +0100,
Mike Lothian wrote:
> 
> Hi
> 
> I'm not sure when this first appeared but I see the following when
> compiling/linking with Clang 19.1.5
> 
> vmlinux.o: warning: objtool: cc_ev_to_ump_midi2+0x5a5: return with
> modified stack frame

Could you figure out which line corresponds to this?


thanks,

Takashi
