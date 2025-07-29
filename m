Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60527C87FC9
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Jul 2025 15:50:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7B1C60215;
	Tue, 29 Jul 2025 17:49:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7B1C60215
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1753804201;
	bh=IVNy6v9HGzm94qke8swRbmLaY42nxP91LpFEJqAQ4l0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eDiQhLSi2PYcf9WpxEis28bLWCdUoGNoQvLgB2f5NAAC9+Lp1FauIUQZziSCaDL1A
	 CusX/9ykg+yo76wzaBK6KGXiG6SStgL0jnkGqOh5TXJHeqby3gH7z61jMwwM2Mkbyo
	 rS59sfq4SW30ls9E8cEIqI85JIa9MvHqJjgPsYKc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F931F805D7; Tue, 29 Jul 2025 17:49:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B7B55F805C5;
	Tue, 29 Jul 2025 17:49:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4E4CF80254; Tue, 29 Jul 2025 17:49:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7B1BDF80124
	for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2025 17:49:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B1BDF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Ai7G92Bu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=X9z8Bcm6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Ai7G92Bu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=X9z8Bcm6
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 64DF11F397;
	Tue, 29 Jul 2025 15:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1753804148;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpUU701DImrDdhgMT8J+8eS3XOnIAyB/YwvE+FSAL4M=;
	b=Ai7G92BuqFGZXtbhwbN0/wqybH13lSuUBzlkavMBR8p6xsTzs+EMVYyX+2wLSdB9aOguoe
	+uQ1ONwfJ2VVLIjaihWnmch3vfWuKjKSgblxbS12FBOxwQu9RPD2Fcv/2QqYJ4Tu6Al8hQ
	bIp77nrgNthZ3vEnh9qnVHkv71ydB4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753804148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpUU701DImrDdhgMT8J+8eS3XOnIAyB/YwvE+FSAL4M=;
	b=X9z8Bcm6sYXYHh1OFKCmWnsi2eeutNHmilCSnz6pg36gXXONGiKNFnKV8+hCDI3RRR3YeE
	dLhHhedtkxWYChBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1753804148;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpUU701DImrDdhgMT8J+8eS3XOnIAyB/YwvE+FSAL4M=;
	b=Ai7G92BuqFGZXtbhwbN0/wqybH13lSuUBzlkavMBR8p6xsTzs+EMVYyX+2wLSdB9aOguoe
	+uQ1ONwfJ2VVLIjaihWnmch3vfWuKjKSgblxbS12FBOxwQu9RPD2Fcv/2QqYJ4Tu6Al8hQ
	bIp77nrgNthZ3vEnh9qnVHkv71ydB4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753804148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpUU701DImrDdhgMT8J+8eS3XOnIAyB/YwvE+FSAL4M=;
	b=X9z8Bcm6sYXYHh1OFKCmWnsi2eeutNHmilCSnz6pg36gXXONGiKNFnKV8+hCDI3RRR3YeE
	dLhHhedtkxWYChBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 273EF13A73;
	Tue, 29 Jul 2025 15:49:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OXfrB3TtiGjMUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Jul 2025 15:49:08 +0000
Date: Tue, 29 Jul 2025 17:49:07 +0200
Message-ID: <877bzrt2to.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<alsa-devel@alsa-project.org>,
	<shenghao-ding@ti.com>,
	<13916275206@139.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ALSA: hda: Fix the wrong register was used for DVC of
 TAS2770
In-Reply-To: <20250729145849.55057-1-baojun.xu@ti.com>
References: <20250729145849.55057-1-baojun.xu@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,alsa-project.org,ti.com,139.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,suse.de:mid]
Message-ID-Hash: 5YVSERFF6EWV7BPRDURFXWGBC7ZNECKI
X-Message-ID-Hash: 5YVSERFF6EWV7BPRDURFXWGBC7ZNECKI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5YVSERFF6EWV7BPRDURFXWGBC7ZNECKI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 29 Jul 2025 16:58:49 +0200,
Baojun Xu wrote:
> 
> The wrong register was used for digital volume control of TAS2770,
> The definition was changed, and usage was also updated.
> 
> Fixes: ab29b3460c5c ("ALSA: hda: Add TAS2770 support")
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>

Applied now.  Thanks.


Takashi
