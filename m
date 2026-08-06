Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B1DC55ABF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:47:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E43C46024D;
	Thu,  6 Aug 2026 15:47:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E43C46024D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786024031;
	bh=R65kntdrN16SqqBdfOis9k/k1MP5bRqRIE7q1H7ZPDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lAJvEhqlDcDFes95o7Z22IBT3KpXyt9yz9H7vw1GaGF+tufK/esV4UvNuUkXN1cvq
	 hshHYPhlh2aFdnoJMZoEABu2rjXNYLNVb32epPwQjYd+l0Wz+mynXEGBe3R0PG1U2c
	 bH7vo46dVTVNZ1Sa8xibf0hvjTdOug/Gt2GcMfGw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2BF6F805F4; Thu,  6 Aug 2026 15:46:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 142D8F805FA;
	Thu,  6 Aug 2026 15:46:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 65FC8F8055A; Thu,  6 Aug 2026 15:46:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786023987;
	b=B+GrlRGb0hcxtxCze65IvZSpBLTMhBDgzQEksEZ5IOvrey4p3bEMeuDdBWzWqRQOyKZU
	 0Hh/YbPIcAKJJmy6/QJsKXLr2/2jcyeOYQHArQFXknOnYy9DDW+5v5pG7+dF3M3Kuvz8m
	 mSBmnkWZpjeDqTbPNqyIE1hFeOr1OpowwoG9F6oKy3UCT4dgW+9P1GQYFFgC61Wk3OEKO
	 A6N5yX92CIs0cbk1o6zuX4HAUZ8VgtGXqMA+v/LfsiwZD6N1h8hOu1RgqeqQB9InYMEFL
	 FDf8xHtFpG4REBQnP2FnIyTRWX2EC3P6X8Thqgpi2vUKdZoQUIXV2Af4Z+YP4XK528g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786023987;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=R65kntdrN16SqqBdfOis9k/k1MP5bRqRIE7q1H7ZPDA=;
	b=i+OdeVIlu8L3KnwOcGvLJT26TFiGMpLHr2bNL1q9gT5YPgfv6N0wf8kkCKi8OYhy+Hie
	 lJ4WwrXP7vIIR1zpeVBof25qQzl67K7sezWDbOoeTp3BatF9lIZJjGPbLBOq05HHflK3t
	 lK8G9EsZqpp9jNtEjMqEtWFtlB1DYZsDtnR36SYl/dhkLVkXOU2X4t1cvOs4hPzGTcUoC
	 0SDqVeFzZzAHmi9zxmSjSIbQO+xpIb93JIKuRuNoxE6vSOPjrZNLlLVJuakcYkC3ZkpQl
	 sDc4AjU+IObVTCzsBW2LfnX1Bv1KrG3SA5nwbeXTXwTF95OHrN0/EAWOQwTIwyLXNFA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=tLeH6vsF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=qVCev5WW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=TfGfPAFK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=3Fv9NgJM;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0F24BF800B5
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 15:46:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F24BF800B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=tLeH6vsF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=qVCev5WW;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=TfGfPAFK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=3Fv9NgJM
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F135D3DF8;
	Thu,  6 Aug 2026 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786023981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNXMvY7GQc7t7WlryGFmyeFgelcjvzLeHSKvHa5iJpw=;
	b=tLeH6vsFkB5ZgQq/0xXXz43xE2doG4emETXeWWpfSKI7wsfcNfvQZuS0I0nAnF6noZeBZU
	0y0C9bHL+3+teIOxzVpTWwUmP0AfjLV32b/6MqaxuK1Js+hZmMiXtkGz1pdJoPC4dGvBaf
	fvPKJkQSFtVAnjpCbwhBhV5d0KN5aMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786023981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNXMvY7GQc7t7WlryGFmyeFgelcjvzLeHSKvHa5iJpw=;
	b=qVCev5WWJRCPYy59H+RRf4d4J9XoFuZexvFHMOangHRQrSQjy4P4bsCDuCpLgQFrIbhCJS
	YapCFQ1QgGWR9DBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1786023976;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNXMvY7GQc7t7WlryGFmyeFgelcjvzLeHSKvHa5iJpw=;
	b=TfGfPAFK+xKhFER01jBYflP8nnJo4w/P+O7fd79F8J9mdBHkaowOwkMiemQDr8ExNWb3kU
	I/OKmt1iMGCvX2p8QeoxgRjS9PUEVsfdtWV1NtVvXVWfxnlKIAaoVNfEKVFgS+i6aRLLeX
	9WwF2WpHN9prqT725TPeRv0s25+wSI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786023976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNXMvY7GQc7t7WlryGFmyeFgelcjvzLeHSKvHa5iJpw=;
	b=3Fv9NgJM+X/NXdLnJ92uAaopoU+CkxG1XK5MtE2RV7KBoaX4KQd0Y3XTT2/4FCvxZUacWY
	K5twpYwCd2MzrlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCF73779BF;
	Thu,  6 Aug 2026 13:46:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eEtUMCiQdGo+LgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Aug 2026 13:46:16 +0000
Date: Thu, 06 Aug 2026 15:46:16 +0200
Message-ID: <87wlu3cqfr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Stefan Binding (Opensource)" <sbinding@opensource.cirrus.com>
Cc: "'Gemayel Lira'" <gemayellira@gmail.com>,
	<alsa-devel@alsa-project.org>
Subject: Re: [PATCH] ALSA: hda/cs35l41: Add DSD property override for ASUS
 UX3405CA
In-Reply-To: <003401dd25a8$e3f8f4e0$abeadea0$@opensource.cirrus.com>
References: 
 <CAD96ZT+SnRnGr4Xd+NJkkVNpj8XrzL3Ete=pRgz05mqxAzbU2w@mail.gmail.com>
	<87pkzveg4g.wl-tiwai@suse.de>
	<003401dd25a8$e3f8f4e0$abeadea0$@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,cirrus.com:email,imap1.dmz-prg2.suse.org:helo,alsa-project.org:email]
Message-ID-Hash: G7WUTNPXR5VDUFAF6ENREXW64OFEXGQL
X-Message-ID-Hash: G7WUTNPXR5VDUFAF6ENREXW64OFEXGQL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G7WUTNPXR5VDUFAF6ENREXW64OFEXGQL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 06 Aug 2026 15:38:39 +0200,
Stefan Binding (Opensource) wrote:
> 
> Hi Takashi,
> 
> Unfortunately, this does not look like an ACPI issue.
> This laptop is an external boost laptop, but this patch is changing the
> properties to redefine it as internal boost.
> This could cause issues with the amplifiers.
> 
> It looks like speaker protection is kicking in after 1s, but I don't know
> why.
> I recommend the OP create a BugZilla so we can investigate this separately.
> I also recommend we do not take this patch, as it might damage this laptop.

OK, thanks for confirmation, it's an important information!


Takashi

> 
> Thanks,
> Stefan
> 
> > -----Original Message-----
> > From: Takashi Iwai <tiwai@suse.de>
> > Sent: Thursday, August 6, 2026 10:46 AM
> > To: sbinding@opensource.cirrus.com
> > Cc: Gemayel Lira <gemayellira@gmail.com>; alsa-devel@alsa-project.org
> > Subject: Re: [PATCH] ALSA: hda/cs35l41: Add DSD property override for ASUS
> > UX3405CA
> > 
> > On Sun, 02 Aug 2026 01:00:22 +0200,
> > Gemayel Lira wrote:
> > >
> > >
> > > The ASUS Zenbook 14 UX3405CA (SSID 1043:1A63) has internal CS35L41
> > > amplifiers, but was using the missing_speaker_id_gpio2 fallback entry.
> > > This caused the right speaker channel to bind with VSPK voltage switch
> > > disabled
> > > (VSPK: 0), leading to a volume drop ~1 second after starting playback
> > > due to power imbalance protection.
> > >
> > > Add an explicit entry for 10431A63 in cs35l41_config_table with
> > > internal boost type, 4500mA peak current, and switch its model mapping
> to
> > generic_dsd_config.
> > > This resolves the volume drop issue and enables proper internal boost
> > > for both channels.
> > >
> > > Pull Request on SOF Project:
> > > https://github.com/thesofproject/linux/pull/5866
> > >
> > > Signed-off-by: Gemayel Lira <gemayellira@gmail.com>
> > >
> > > From 10431A6300000000000000000000000000000000 Mon Sep 17
> > 00:00:00 2001
> > > From: Gemayel Lira <gemayellira@gmail.com>
> > > Date: Sat, 1 Aug 2026 19:15:00 -0300
> > > Subject: [PATCH] ALSA: hda/cs35l41: Add DSD property override for ASUS
> > > UX3405CA
> > >
> > > The ASUS Zenbook 14 UX3405CA (SSID 1043:1A63) has internal CS35L41
> > > amplifiers, but was using the `missing_speaker_id_gpio2` fallback entry.
> > > This caused the right speaker channel to bind with VSPK voltage switch
> > > disabled
> > > (VSPK: 0), leading to a volume drop ~1 second after starting playback
> > > due to power imbalance protection.
> > >
> > > Add an explicit entry for 10431A63 in cs35l41_config_table with
> > > internal boost type, 4500mA peak current, and switch its model mapping
> to
> > `generic_dsd_config`.
> > > This resolves the volume drop issue and enables proper internal boost
> for
> > both channels.
> > >
> > > Signed-off-by: Gemayel Lira <gemayellira@gmail.com>
> > 
> > Stefan, is this also covered in your side?
> > Or shall we just take this?
> > 
> > 
> > BTW, Gemayel, at the next time, please submit to linux-
> > sound@vger.kernel.org.  It's the place for kernel patches, while
> alsa-devel ML is
> > mostly for only user-space stuff.
> > 
> > 
> > thanks,
> > 
> > Takashi
> > 
> > 
> > > ---
> > >  sound/hda/codecs/side-codecs/cs35l41_hda_property.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> > > b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> > > index 416d7bf..1cf12f8 100644
> > > --- a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> > > +++ b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> > > @@ -104,6 +104,7 @@ static const struct cs35l41_config
> > cs35l41_config_table[] = {
> > >  	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> > 0, 1, -1, 1000, 4500, 24 },
> > >  	{ "10431863", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> > 1, 2, 0, 1000, 4500, 24 },
> > >  	{ "104318D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> > 0,
> > > 1, -1, 0, 0, 0 },
> > > +	{ "10431A63", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> > > +-1, 2, -1, 1000, 4500, 24 },
> > >  	{ "10431A83", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> > 0, 1, -1, 1000, 4500, 24 },
> > >  	{ "10431B93", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> > 1, 2, 0, 1000, 4500, 24 },
> > >  	{ "10431C9F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 },
> > 1,
> > > 2, 0, 1000, 4500, 24 }, @@ -530,7 +531,7 @@ static const struct
> > cs35l41_prop_model cs35l41_prop_model_table[] = {
> > >  	{ "CSC3551", "104317F3", generic_dsd_config },
> > >  	{ "CSC3551", "10431863", generic_dsd_config },
> > >  	{ "CSC3551", "104318D3", generic_dsd_config },
> > > -	{ "CSC3551", "10431A63", missing_speaker_id_gpio2 },
> > > +	{ "CSC3551", "10431A63", generic_dsd_config },
> > >  	{ "CSC3551", "10431A83", generic_dsd_config },
> > >  	{ "CSC3551", "10431B93", generic_dsd_config },
> > >  	{ "CSC3551", "10431C9F", generic_dsd_config },
> > > --
> > > 2.43.0
> 
