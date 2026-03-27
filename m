Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4A4109E544
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2026 09:32:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AAA6601AE;
	Fri, 27 Mar 2026 10:32:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AAA6601AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774603973;
	bh=HzcBiXs78A+wpGo9thtrwnYZpGdKFQhqVzAHSwRbkq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VMfloknhCn2+f3Yz0IKZZgPf/P1YqJA4byt8dKSAYp7uiqqTFZ2c0ha5BDIWZMoWM
	 RafTF4BObPaCQuqA5tOtjziliALR/kKVuip30Ag9Hu+JIzBJueVu1NIQmRMBhhy4ne
	 zxBZmojZJIL5jRtYVLrPxpYZ1EOTEN7octPk1azk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0FDDFF805EB; Fri, 27 Mar 2026 10:32:17 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6969DF805F5;
	Fri, 27 Mar 2026 10:32:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69509F804F3; Fri, 27 Mar 2026 10:32:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7575CF80212
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2026 10:32:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7575CF80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=2KZbmi9k;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=5Sdyy/6V;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=2KZbmi9k;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=5Sdyy/6V
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ADDA84D1C7;
	Fri, 27 Mar 2026 09:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774603925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/4G0UcpWQ99BrHsgNRLMkbfpesta0/cOELzLUlyJDw=;
	b=2KZbmi9kOZcgP03AfwYWQUdZBY3OGP1nVLlvsCaXtNZIxin6QQCk4VPn5w9zUYVmJ9K6RF
	6rqT4e2Jwh7ErO9sXXQiK20E4xu9upJw8kx8oFl13yAfkrKBy1JIX+AgEF+jCktyEiVvPl
	on+sHK+zspJQxlyTs+WCl0KmXtSijro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774603925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/4G0UcpWQ99BrHsgNRLMkbfpesta0/cOELzLUlyJDw=;
	b=5Sdyy/6V9OBwoxUDo+UQbywjkJuNEpRjP5jzE1bI/d/JN7jEuC+w/NeGFxKsp0FyXHDucM
	s9oDD+5r6bM1CeAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1774603925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/4G0UcpWQ99BrHsgNRLMkbfpesta0/cOELzLUlyJDw=;
	b=2KZbmi9kOZcgP03AfwYWQUdZBY3OGP1nVLlvsCaXtNZIxin6QQCk4VPn5w9zUYVmJ9K6RF
	6rqT4e2Jwh7ErO9sXXQiK20E4xu9upJw8kx8oFl13yAfkrKBy1JIX+AgEF+jCktyEiVvPl
	on+sHK+zspJQxlyTs+WCl0KmXtSijro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774603925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/4G0UcpWQ99BrHsgNRLMkbfpesta0/cOELzLUlyJDw=;
	b=5Sdyy/6V9OBwoxUDo+UQbywjkJuNEpRjP5jzE1bI/d/JN7jEuC+w/NeGFxKsp0FyXHDucM
	s9oDD+5r6bM1CeAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 866F14A0A2;
	Fri, 27 Mar 2026 09:32:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8jJyH5VOxmlzIgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Mar 2026 09:32:05 +0000
Date: Fri, 27 Mar 2026 10:32:05 +0100
Message-ID: <87ldfdsjmy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E9sar?= Montoya <sprit152009@gmail.com>
Cc: alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add mute LED quirk for HP Pavilion
 15-eg0xxx
In-Reply-To: <20260321153603.12771-1-sprit152009@gmail.com>
References: <20260321153603.12771-1-sprit152009@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.981];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: T2TJMO6V7JIB6R42ECIYF6USNI7353RZ
X-Message-ID-Hash: T2TJMO6V7JIB6R42ECIYF6USNI7353RZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T2TJMO6V7JIB6R42ECIYF6USNI7353RZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 21 Mar 2026 16:36:03 +0100,
César Montoya wrote:
> 
> The HP Pavilion 15-eg0xxx with subsystem ID 0x103c87cb uses a Realtek
> ALC287 codec with a mute LED wired to GPIO pin 4 (mask 0x10). The
> existing ALC287_FIXUP_HP_GPIO_LED fixup already handles this correctly,
> but the subsystem ID was missing from the quirk table.
> 
> GPIO pin confirmed via manual hda-verb testing:
>   hda-verb SET_GPIO_MASK 0x10
>   hda-verb SET_GPIO_DIRECTION 0x10
>   hda-verb SET_GPIO_DATA 0x10
> 
> Signed-off-by: César Montoya <sprit152009@gmail.com>

Thanks, applied now.


Takashi
