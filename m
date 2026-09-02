Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D642C61DD6
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:45:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08CEE60203;
	Wed,  2 Sep 2026 08:45:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08CEE60203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788331522;
	bh=GXHZpIeBe3j2/DE3vNWBoC8rRW53KjIG2dhtuoW9k0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UglkaL+EK4BPghkpZBBhR8hXVilTXb7tc5DLm1v+kzNNep8lhDc1FkAXEE1yzum1P
	 KN6R3uT//LNaD9JzX0hCDQZhBiSZoixUJyVefL/joeqFbK3l9I4X9saPQBLOsOLgpA
	 H2SBB8efQaXI2ln2z8f6+cf+XTvsws4wAdQ2EoCc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B859EF80600; Wed,  2 Sep 2026 08:44:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 88307F805FD;
	Wed,  2 Sep 2026 08:44:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C1C3F80548; Wed,  2 Sep 2026 08:44:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788331473;
	b=b2mKOME8hgq31v5tKWyCApgmSlZg5t+dCxJ11zYNGvFhrf2ZAnaaaCzSlJ0UEf0MI/pg
	 O1EwqoQFZL6dlq8wZPLWz4npku9T6ZDqJeUnbsaQgbhxKrW9vu2rV6CDUp/mHfBMZKqwi
	 IbitQ1sZKsRrbJ5beRXndX86VvX9aKLotOFES0HWOi7lbld+JVfJ/31YBE+BceICsZpZm
	 PbZq66bKdb+vl6FdSsrUmNInVDSVm9z4bFGAFSK6iiHUXSzcocF2NafMe78sVvTWYuMvU
	 ndZyJ2tNeCsdZjpIKz1ixVIy6XQhRozPL60B4qziUuA7kBZS001eq43Q6OoiX3vM1Zw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788331473;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=GXHZpIeBe3j2/DE3vNWBoC8rRW53KjIG2dhtuoW9k0g=;
	b=P7lVjnSJ6ouEax2Qw11lTs51WJBD24LK5ak2+u7WvojLox8QeTeIr5W/QAEt3f3cyNt5
	 gkynIxgox+pjwi6F16ZlVllKEiFHlZw/MGTd3th4BLpqpGBnZI6+VMLkUdXf2YoQxlSar
	 bUsYHQY5k1O1CBoXGRCWWKFNrAYZ385RKls2wYHzBLOnM/ru9jQ58CmHJ4VSpRGCTPei2
	 3FNNrNDsxDSvYuOxoHkEetfAE+Z0UonzxCdJ9JEJ5za/odCG8b797r/TsW2YqW8YnMuLH
	 7p2sfCJ+U6bOzL+KFLhZyQMrzNF4aLepApov+oEStpG02i8/Qu0VnupGyHG8QpkNbBQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=OfRHVwt+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+ycOlvhG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=rDDKTCN3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tjamup4D;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F3499F8016D
	for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2026 08:44:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3499F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=OfRHVwt+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=+ycOlvhG;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=rDDKTCN3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=tjamup4D
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C294221F1B;
	Wed,  2 Sep 2026 06:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788331466;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F1cOAs96rveVWIlHjWvhQ25ERcXFHWsJh8TxjoMTleA=;
	b=OfRHVwt+1h30/s3D5z0wdyHIy3jAQJRRSOMAn+B2uUSrwEXHodaM909gh2NokA8XW48rPj
	2ja0W1k43l59m7x7nFtexNfwh1I2mr1UGXtozfp5OgbNtDZtBz89q/OkaefjloH2t1OdhH
	UPWtJ/XvyOWp51/g1XqXPBgJw7gWees=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788331466;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F1cOAs96rveVWIlHjWvhQ25ERcXFHWsJh8TxjoMTleA=;
	b=+ycOlvhGCe9DFYFcY1HvP246k6HY/V/8DrHp52AluOd7g3owM12496Bap/b4bQ0b/CBFo2
	gfRfNc49j0DDpfCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rDDKTCN3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tjamup4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1788331462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F1cOAs96rveVWIlHjWvhQ25ERcXFHWsJh8TxjoMTleA=;
	b=rDDKTCN307o1ywuE1jQjTMxhblk6eDNr1yqCCRS72vO0SjleSn1HPJZyUp6/FX4f96sfQx
	FV6Wk0T8Suicczz2tf8nd4Q4wTvu4rR/QEmpQWgyfnWIJUQqbvvvxPW4Ob7LUEzf+txyMt
	o5BhkGTWvvgAGMyg+GC67/XynOamSz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788331462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F1cOAs96rveVWIlHjWvhQ25ERcXFHWsJh8TxjoMTleA=;
	b=tjamup4DLeddQNlIK463kvin56k7DDs9jB/EnLFNpnzji9+xpKiO8O1OQkMgUJj3vKu9xB
	9GQsm+Ea0Eff+8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 858C0136E6;
	Wed,  2 Sep 2026 06:44:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wHVVH8bFl2q2PQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 02 Sep 2026 06:44:22 +0000
Date: Wed, 02 Sep 2026 08:44:22 +0200
Message-ID: <87ik4ob1a1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Allen Abraham <allenabraham713@gmail.com>
Cc: "tiwai@suse.com" <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add mute LED quirk for HP Pavilion
 14-dv0xxx
In-Reply-To: 
 <CACw2+N5x_DCXKj_k-iV8sQ=hcS7KxVyfRZsaR8PPx6qpRAFMug@mail.gmail.com>
References: 
 <CACw2+N5x_DCXKj_k-iV8sQ=hcS7KxVyfRZsaR8PPx6qpRAFMug@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C294221F1B
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
Message-ID-Hash: BASBMQEDM72PUYJWYG22IZA56O2V6C3T
X-Message-ID-Hash: BASBMQEDM72PUYJWYG22IZA56O2V6C3T
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BASBMQEDM72PUYJWYG22IZA56O2V6C3T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 01 Sep 2026 14:26:44 +0200,
Allen Abraham wrote:
> 
> 
> HP Pavilion 14-dv0054tu (PCI SSID 103c:87c9) with Realtek ALC287 codec
> controls the mute LED on the F5 key via GPIO 4 (mask 0x10).
> Add a quirk entry with ALC287_FIXUP_HP_GPIO_LED to enable the mute LED.
> 
> Signed-off-by: Allen <allenabraham713@gmail.com>

The patch isn't cleanly applicable, as your mailer likely broke the
spaces and tabs.  And, your Signed-off-by tag is incomplete; it must
be with a real name (or a known identity).

Please fix your mailer setup and resubmit with a proper Signed-off-by
tag.


thanks,

Takashi
