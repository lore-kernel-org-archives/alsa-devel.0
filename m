Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEC5CA5FC5
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:46:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 493176025B;
	Wed, 30 Sep 2026 15:46:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 493176025B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790776006;
	bh=+SA6ddJyH8MJ8wcd+8JjbY0ONor9rBjsMIiYkscBaLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FThBxz/o3+Rp1AIu5TQchNiJjXzwEIR+6u9HAzXRBeKLyRjEAgZoUF6OtdUaxuqiD
	 Ggw9yaTZkzydL8Vc5rxCzeq8ZkGyciCgAYo3Th5Oa9eodXxHykosgGsB8Pyc4SSEA2
	 NQowsj8IaufVPslLfrKinwEBraMg9jkTG6Lu7KWA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B4E7F805F6; Wed, 30 Sep 2026 15:46:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E34C5F805F5;
	Wed, 30 Sep 2026 15:46:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4902FF80542; Wed, 30 Sep 2026 15:46:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790775965;
	b=IDBSaYAuouDWm7Lq+TVgIHFZOsR+eIXfC0c93GRaX7in+LiOjOtVz9inZ2tkxdo6RjgK
	 UmXMu/jiTmjtvmaFH6OseKgjAq3doh6JQ4OAPjw782YKmEfgr1LujXhPtgPRavM2xDg4E
	 40wwdDNAtyLNMJUiCRMOS52f1Yl/8oW14BWn17ZsBmm6CMOFDDYjOpOLJ/Wiu6pbl4oMn
	 I3KH4DMWYIUzQLJmW5taolX0u9OkvOlncZCEbkNPZYx/dwC2hwoAq7ZAlDrH1n4fcvXXQ
	 pczOuHaSm5CJqlRf77aiy2EP2UjsfOUqlRFtTLkg3vkBvQKxzCouuR8okDFtF+Aom8A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790775965;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=+SA6ddJyH8MJ8wcd+8JjbY0ONor9rBjsMIiYkscBaLQ=;
	b=B/GIKgXQ6Gn48vsOw86aw/on8Lc83KVrNCck/EdxhUcVgFjbi8u1ywDTYUMyNNDadXii
	 RVigh721BQwOemuU+fv7ox4fZNITIKzGHvKp5ZFZKgnPt+MXmGuFS+Ij2+pGE2ah3NLbR
	 DwTT2Pm7Omtw1TKdbkcWhJK2wKDAUGBPG5h9hxc/56XDVkf06EX+iginsZszVTqMbgUeH
	 tY1kqxowNgp57xdx4gMy58rkFs1RlokWQzeADMD/AHVLh7TvCgKsoZxJzlpO4ss5u0m+d
	 30Fc6AZnrnoEFwDmaVUpCeIPKelplSqbXsmBcagrtSDnRdFacRwf8DYKOJvHxjZf/Ng==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=NP1PutO1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=xvje+KtG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="d/7wqu5A";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=VHml9fZX;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 20BCDF80496
	for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2026 15:46:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20BCDF80496
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=NP1PutO1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=xvje+KtG;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=d/7wqu5A;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=VHml9fZX
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E1581F816;
	Wed, 30 Sep 2026 13:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790775959;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ndgGPmhdy9D5k4C4xPBki2Pt7tdr8qIjehOZfPsDVAg=;
	b=NP1PutO1AlbEDDBzRPrwv5USQmNkeJ03MsYNCLpJJuTw4ZIb3aL0lkDlOtISNxeRa7e9VM
	ZfWrlFvs1SZZmdKlKrXgS+l7tOcvVXG4u4W3DpGEvjrM4QwM3TZLzvXuVTdCX4U+D+p2QP
	DLn6/vT5KIEcFfo+AmU2r66D/4NaEoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790775959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ndgGPmhdy9D5k4C4xPBki2Pt7tdr8qIjehOZfPsDVAg=;
	b=xvje+KtGXq4gPJwyKT7c8Nbr5P5hXlzNxNRETTxmTRCpt4f08Qfbo/9cS1doWwok3oJSsI
	DaqlnMuic+x7SNAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1790775955;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ndgGPmhdy9D5k4C4xPBki2Pt7tdr8qIjehOZfPsDVAg=;
	b=d/7wqu5AvXtvRSviKdqzDvaWAGv7RHtWNkzEWO4cjndsybGfEeb2bDx6HYo8NxFy28sGuW
	M+dGlu6XHCWdfGkWcpI6APYPDJ3NtB2XdF/OSTGrkqGai4/CJD45lCCWk75LMEpeK30f1i
	/dhegvKvQVRTBJC+zzNpThGnK61cUlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790775955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ndgGPmhdy9D5k4C4xPBki2Pt7tdr8qIjehOZfPsDVAg=;
	b=VHml9fZXMct3yrZDMEEp68GtTYMgmgENEIFtLdFHIbNGs54ftwSC+OKY59PYJ1VIpzf/g8
	cygcjThi1A4OtTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B294513722;
	Wed, 30 Sep 2026 13:45:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZwBVIpISvWpiSAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 30 Sep 2026 13:45:54 +0000
Date: Wed, 30 Sep 2026 15:45:54 +0200
Message-ID: <87jyo24zu5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: dchristensen8 <dchristensen8@proton.me>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/ca0132: Add Sound BlasterX AE-5 external RGB
 LED strip support
In-Reply-To: 
 <0UViNKefxgxrLggTEzDgzIe9-kh2EqU2Pnip6zuyJl1sthZtgJ-OIai3KBgkltft587c-ryvum1IqQZt-awOQTdrohMWKh79F3X8u6JOjuo=@proton.me>
References: 
 <eFYfxKMV2ei__fURd-elssegCIVmOuRDne6lj9PMaM2bEgnYkz7Tzf6JLrgEaPZtvrUC_wHnmnwaUZAOdg0uh24nt73FQqi6T65qvJebHJA=@proton.me>
	<87fqys19vt.wl-tiwai@suse.de>
	<0UViNKefxgxrLggTEzDgzIe9-kh2EqU2Pnip6zuyJl1sthZtgJ-OIai3KBgkltft587c-ryvum1IqQZt-awOQTdrohMWKh79F3X8u6JOjuo=@proton.me>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.25 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.15)[-0.747];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: IB7TVMXI6MNYCPLAKEAUHMRTPQW4QBH5
X-Message-ID-Hash: IB7TVMXI6MNYCPLAKEAUHMRTPQW4QBH5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IB7TVMXI6MNYCPLAKEAUHMRTPQW4QBH5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 29 Sep 2026 16:22:07 +0200,
dchristensen8 wrote:
> 
> Thanks for the quick review!
>   
>     I went with sysfs mainly because of the streaming nature of WS2812 strips (using an atomic DMA frame):         
>   
>     -The LED subsystem has no strip or pixel-buffer concept, individual led_classdevs would hit sysfs with thousands of writes/sec at 30-60 FPS (and leds-class.rst advises against it for addressable arrays anyway).
>     -An ALSA kcontrol could hold raw bytes, but pushing frames at 60 Hz spams control change events to PipeWire/PulseAudio.
>   
>     I initially went with text attributes  (ae5_strip_leds/ae5_strip_num_leds) so basic shell scripts could just echo colors into it, but I know comma-separated lists bend the "one value per file" rule. Would you prefer a bin_attribute for raw RGB bytes instead? or keeping both?              
>   
>     All your code points make total sense too. I have no objections.
>   
> Let me know your thoughts on the sysfs format.

On the second though, why not simply to use an ALSA control element
with bytes data?  It can hold up to 512 bytes, so 100 of 24bit RGB
strips can fit.
You can declare the element as volatile (and with IFACE_CARD), so that
pipewire or alsactl won't be bothered by the changes.


thanks,

Takashi
