Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677D7C02190
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:18:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8103D601C5;
	Wed, 29 Jan 2025 15:18:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8103D601C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1738160300;
	bh=Klzjx1enmgJl+CA4heJnNYFZ5BoKRIQFiOumD/Pqidk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gXEUlin8KtlgExhRd7I8DrITMghuuOjWovA5vUCO/G8xOpCTJCJB550V4rhDiXC4G
	 8cdNS8Rb+cyKZ852g8HijLDVn0YnZLPj9XsRNBbK5rcrokunY1evdHCyWQ7D2SeShh
	 85cA9R99RPJWl3P+Mteu0NhyYAUj/4MdQTOuuhOo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 435A9F805C3; Wed, 29 Jan 2025 15:17:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 35C5FF805C5;
	Wed, 29 Jan 2025 15:17:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D926DF80518; Wed, 29 Jan 2025 15:17:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2418CF8047C
	for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2025 15:17:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2418CF8047C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=gfa1e8Lv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=NhZLsinx;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=gfa1e8Lv;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=NhZLsinx
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1641921101;
	Wed, 29 Jan 2025 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1738160258;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qyhd4XJC/bTE2vKD2yDi+IfmDbjRuAA5nOO0I7nFKc0=;
	b=gfa1e8Lv4xWU4AC/vS+IRIwOF9ObJViNAzp6OvQAA0vFuOXHjR7TgozwyBDSfJbbpyUcZ0
	TeqwILbTWIwx71fhXVPFiMcUjBaFHybx+F5o09GJAJu1WJgs2se/Ph3UDWCMCoF2O0rmdi
	BczyTWjEpRbSwqbTSUZ/U5kXezeygow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738160258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qyhd4XJC/bTE2vKD2yDi+IfmDbjRuAA5nOO0I7nFKc0=;
	b=NhZLsinxjZyXHlwtbTF1baIYB+WLAfsPIibF6Gn5pECUyxcECt3WER0hniiJz2qPIOlTHs
	OGomZBFE01sIhRDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1738160258;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qyhd4XJC/bTE2vKD2yDi+IfmDbjRuAA5nOO0I7nFKc0=;
	b=gfa1e8Lv4xWU4AC/vS+IRIwOF9ObJViNAzp6OvQAA0vFuOXHjR7TgozwyBDSfJbbpyUcZ0
	TeqwILbTWIwx71fhXVPFiMcUjBaFHybx+F5o09GJAJu1WJgs2se/Ph3UDWCMCoF2O0rmdi
	BczyTWjEpRbSwqbTSUZ/U5kXezeygow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738160258;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qyhd4XJC/bTE2vKD2yDi+IfmDbjRuAA5nOO0I7nFKc0=;
	b=NhZLsinxjZyXHlwtbTF1baIYB+WLAfsPIibF6Gn5pECUyxcECt3WER0hniiJz2qPIOlTHs
	OGomZBFE01sIhRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E938F137DB;
	Wed, 29 Jan 2025 14:17:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zv6SN4E4mmcJGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 29 Jan 2025 14:17:37 +0000
Date: Wed, 29 Jan 2025 15:17:37 +0100
Message-ID: <877c6d7lha.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v6.14-merge-window
In-Reply-To: <5553a88a7f8fd2ec9b1ebb0ceec1e12f.broonie@kernel.org>
References: <5553a88a7f8fd2ec9b1ebb0ceec1e12f.broonie@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Message-ID-Hash: A6VDJFL23XMH4VWLM2KJZXR62D2DWJN6
X-Message-ID-Hash: A6VDJFL23XMH4VWLM2KJZXR62D2DWJN6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/A6VDJFL23XMH4VWLM2KJZXR62D2DWJN6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 29 Jan 2025 14:23:08 +0100,
Mark Brown wrote:
> 
> The following changes since commit fee89ddd76e45841a2b01d87b481bc02483f4572:
> 
>   ASoC: xilinx: xlnx_spdif: Simpify using devm_clk_get_enabled() (2025-01-16 15:20:41 +0000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.14-merge-window
> 
> for you to fetch changes up to 6c1bb4031729871fa203983bd77bed1ee3c61347:
> 
>   ASoC: codec: es8316: "DAC Soft Ramp Rate" is just a 2 bit control (2025-01-27 16:22:37 +0000)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v6.14
> 
> A bunch of fixes that came in during the merge window, plus a few new
> device IDs.  The i.MX changes are a little large since they add some new
> quirk data as well as device IDs, and the audio graph card change for
> picking the correct endpoint for links is large due to updating a number
> of call sites.

Pulled now.  Thanks.


Takashi
