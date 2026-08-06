Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA64C56205
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:59:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB38E6025D;
	Thu,  6 Aug 2026 16:59:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB38E6025D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786028392;
	bh=lodbG47Jdyfwe3HviPus+WatmxgS+W1XeQIdm0mkiZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=K96UBZCS6aIHoB6LkDuriTCk/wqn9Vz53nsot+eXOGVM02PAh18Cg4L9d54t2WHEm
	 qegV6Fjej9RWwYATF4iU9Jnnmb+ynksvXV24A3WZG54zfFzKmpTFodkAqBs8r+K613
	 w3ifUN6WOz3h0gu9frjj1lji5yO71Mj4XruRs2h4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25119F805FF; Thu,  6 Aug 2026 16:59:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CECA6F80600;
	Thu,  6 Aug 2026 16:59:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A645F8055A; Thu,  6 Aug 2026 16:59:13 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786028349;
	b=rShSqnuEsNvyqzjd1UCtfGeJgfDKn5J25IL4QtjmYOAxHV147JnCpzhicYD17ifAbJQf
	 p3zeGbD/+zhs+xX5FHvlnbPLytcsnOS+u1vRVFWg+QEP0T6yPbHG25FbjeXVaOCp9tQSj
	 q39aETLTcbbwVMYHni2xFSIX/+IdqiCbGabYLb7JVkFzHG8rh/YockkRD5ZZJTEe2JNzW
	 nW6KkcCmHQfkAk2i28+rhSgnXRLiYTz/F+vN9Mg51GSzOpb5oYi5WknfrNBWmxkJSrJjk
	 9JCXe8AEMKHXyxrAhX2d2KU77ImZB6y5D7wOgDYD6nY4IJmWuboNk4PK+04sEvGJBEw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786028349;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=lodbG47Jdyfwe3HviPus+WatmxgS+W1XeQIdm0mkiZs=;
	b=Hc23mvFwzpQrMhOrbs4r4F4i4bXAiZOYkoOBXky8aaO+g9rKX4b3h0ATjupMcRKABmCk
	 C0L84DX2tnZXgz388pJVypgNUnSicSHKDrq3sfW3MTrZReCDCRtgx5d+epkpSROxvZrpf
	 Ze1aLtU5zJqN9VDdytLo2RHlcy+HFKh5jAzUIbKP01GlLTIDPkw1Pcrpj2TD/FqWRIFOs
	 eJrGSXXK+a61l/bkpfmPTbTIqNaFmheLnLHWGasmF/vbhPMufGMhE7WHH4PO7nVF0VfF2
	 iMJqCCUMGhhrq9x9zMtxvsKhq7xBQXmfY7qUKSlBuQcVFMT2Eds0nnZ7eSBeItADqEw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xmp4VCCl;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=CtAQFgUv;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=tyOM8ggU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=sXAvb8A9;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D7413F800BA
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 16:59:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7413F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xmp4VCCl;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=CtAQFgUv;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=tyOM8ggU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=sXAvb8A9
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D25C5800F2;
	Thu,  6 Aug 2026 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786028343;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WsUfzM89j8BDKave/yzMiXadUAqkb5eeZ2czNZOJVok=;
	b=xmp4VCCl7FXTZmeT1VimWV/jLIxH5xlCFvN78yZmLXNWyo7RRFGsNgnyRQQ55PkiIwgeIL
	I/Qx2ywYQlDc+LGbHocu1b1BPApu2o4wIw4ohJLZEQHDzy3OzuHPVO3Mp1FkobeoIObbke
	Xb20w0vz47r4+kzQsSvwKSp/p70M1Ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786028343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WsUfzM89j8BDKave/yzMiXadUAqkb5eeZ2czNZOJVok=;
	b=CtAQFgUvhcSJigNRARCuWVZsCvZyu8+ptTBHta6VC+uSrLbpYv96HX4JoafCXj8iEdw2a9
	RXe32dhN8S+Pu+CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tyOM8ggU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sXAvb8A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786028338;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WsUfzM89j8BDKave/yzMiXadUAqkb5eeZ2czNZOJVok=;
	b=tyOM8ggU3y21Bfsy4sMLLhb6OhUms6cU7WciCgIRnkJHSz72o1p86f5YO6cL3m4rV+Kf0M
	St8TwL+06zcY21JhOYdt68xMP3JpvlhZ203Grkgui4k6DgbY4stcuBCWE14KHoewHMUW8l
	RLkUoqaLqWXtYod48cyMhujrdUEGqCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786028338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WsUfzM89j8BDKave/yzMiXadUAqkb5eeZ2czNZOJVok=;
	b=sXAvb8A9TXTjV/k86Q0g56gqZehthKiE2GDZ+KE0NRpxOJiwUzt969NAZ3iye2s9amkHdf
	oeEV25zmE5jCqOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACE24779B6;
	Thu,  6 Aug 2026 14:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id snH5KDKhdGqodQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Aug 2026 14:58:58 +0000
Date: Thu, 06 Aug 2026 16:58:58 +0200
Message-ID: <87ldajcn2l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: ankirin <ankirin4@gmail.com>
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable speaker on Xiaomi Notebook Pro
 15 (1d72:1709)
In-Reply-To: <20260806141815.40527-1-ankirin4@gmail.com>
References: <20260806141815.40527-1-ankirin4@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D25C5800F2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Message-ID-Hash: 6HPO6MPCVLTFZHGAKQNDQVNDTDZ5FYQG
X-Message-ID-Hash: 6HPO6MPCVLTFZHGAKQNDQVNDTDZ5FYQG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6HPO6MPCVLTFZHGAKQNDQVNDTDZ5FYQG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 06 Aug 2026 16:18:15 +0200,
ankirin wrote:
> 
> The Xiaomi Notebook Pro 15 (subsystem 1d72:1709, Realtek ALC256)
> silences its internal speaker on Linux: the codec sets coefficient
> register 0x10 to 0x0220 (bit 9 set) on boot and after S3 resume.
> 
> This is the same mechanism already supported for the Xiaomi Mi
> Laptop Pro 15 (1d72:1905) via ALC256_FIXUP_XIAOMI_PRO15_RESUME,
> which clears the stuck coef bit on every codec init. Add the
> missing 1d72:1709 SSID entry to the quirk table.
> 
> Verified on this board: with bit 9 cleared (coef 0x10 = 0x0020),
> the internal speaker outputs normally, including across
> suspend/resume.
> 
> Signed-off-by: ankirin <ankirin4@gmail.com>

The Signed-off-by is a legal requirement, hence it needs to be with a
real name (or a known identity).  Please resubmit with the correction.


thanks,

Takashi
