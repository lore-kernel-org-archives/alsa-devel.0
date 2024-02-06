Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00653C4828D
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Feb 2024 14:54:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5954D852;
	Tue,  6 Feb 2024 15:54:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5954D852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707231268;
	bh=6imiZNz13DtNsVm7OhjM91Tu6n6+upch3RjcbTaBXbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=i7HsZ/rbwsnmwaVzzKB3QeOvfXmmlzDbVDHs46F1ttA2q+ABc3r91viq0jChYLd1c
	 NFk1JGXAcWtk/vPFQoZUyvKhwe05QIWDAquAEviRiHJMxV4XL1kxSa5C5cKsaVraD0
	 6MNyaDm4OyoDylAhJ3Adg1aIaSIu+HBbP5ZOE+aU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58492F8057B; Tue,  6 Feb 2024 15:53:55 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 67BB4F805AA;
	Tue,  6 Feb 2024 15:53:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63A26F801EB; Tue,  6 Feb 2024 15:53:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 92832F80153
	for <alsa-devel@alsa-project.org>; Tue,  6 Feb 2024 15:53:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92832F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Gd8XC4jH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=KlIBRPwB;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Gd8XC4jH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=KlIBRPwB
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 890D8220AD;
	Tue,  6 Feb 2024 14:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1707231224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEGImGG0Ff6z25ekPfLY3b5KTypKA7hNz0dlcxRASQs=;
	b=Gd8XC4jHmAO2wIh9frwlto9XxCy5MYvJewPaeif1JTc76zhIL49XXS+ftX3Nrk5y5F+0Ib
	kb8zevdT/b2sOVr+QUkTw6EwrWVxuckdhiafBvDzV0N9OaXfGzC/QBrFNDJJRGXPG3Gu2Q
	6w5NhzyGSL+gLom0GAbnm4gRoV5pe20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707231224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEGImGG0Ff6z25ekPfLY3b5KTypKA7hNz0dlcxRASQs=;
	b=KlIBRPwBqPNyqo9m1MMtV8YIVgZTYkqY4/WYuTbYOsetUNgX+vC8/51oPkoo8pHPgzYyZX
	CNIYGmYF15FKqCCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1707231224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEGImGG0Ff6z25ekPfLY3b5KTypKA7hNz0dlcxRASQs=;
	b=Gd8XC4jHmAO2wIh9frwlto9XxCy5MYvJewPaeif1JTc76zhIL49XXS+ftX3Nrk5y5F+0Ib
	kb8zevdT/b2sOVr+QUkTw6EwrWVxuckdhiafBvDzV0N9OaXfGzC/QBrFNDJJRGXPG3Gu2Q
	6w5NhzyGSL+gLom0GAbnm4gRoV5pe20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707231224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEGImGG0Ff6z25ekPfLY3b5KTypKA7hNz0dlcxRASQs=;
	b=KlIBRPwBqPNyqo9m1MMtV8YIVgZTYkqY4/WYuTbYOsetUNgX+vC8/51oPkoo8pHPgzYyZX
	CNIYGmYF15FKqCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46FC3139D8;
	Tue,  6 Feb 2024 14:53:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K0myEPhHwmUiVwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 06 Feb 2024 14:53:44 +0000
Date: Tue, 06 Feb 2024 15:53:43 +0100
Message-ID: <87sf25wsnc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>,
	srinivas.kandagatla@linaro.org,
	mathias.nyman@intel.com,
	perex@perex.cz,
	conor+dt@kernel.org,
	corbet@lwn.net,
	lgirdwood@gmail.com,
	andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	Thinh.Nguyen@synopsys.com,
	broonie@kernel.org,
	bgoswami@quicinc.com,
	tiwai@suse.com,
	robh+dt@kernel.org,
	konrad.dybcio@linaro.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v13 32/53] ALSA: usb-audio: Check for support for
 requested audio format
In-Reply-To: <2024020617-limb-name-f852@gregkh>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
	<20240203023645.31105-33-quic_wcheng@quicinc.com>
	<87wmrhvir7.wl-tiwai@suse.de>
	<2024020617-limb-name-f852@gregkh>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Gd8XC4jH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KlIBRPwB
X-Spamd-Result: default: False [2.11 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 BAYES_HAM(-0.08)[63.26%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLe67txhfobum3fqdb5xx8e3au)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[quicinc.com,linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,synopsys.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 890D8220AD
X-Spamd-Bar: ++
Message-ID-Hash: LYAMD64A5432JXDVFNR3C3FUQTTN7PBB
X-Message-ID-Hash: LYAMD64A5432JXDVFNR3C3FUQTTN7PBB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LYAMD64A5432JXDVFNR3C3FUQTTN7PBB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 06 Feb 2024 15:50:21 +0100,
Greg KH wrote:
> 
> On Tue, Feb 06, 2024 at 02:12:44PM +0100, Takashi Iwai wrote:
> > On Sat, 03 Feb 2024 03:36:24 +0100,
> > Wesley Cheng wrote:
> > > 
> > > Allow for checks on a specific USB audio device to see if a requested PCM
> > > format is supported.  This is needed for support when playback is
> > > initiated by the ASoC USB backend path.
> > > 
> > > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > 
> > Just cosmetic:
> > 
> > > +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> > > +			struct snd_pcm_hw_params *params, int direction)
> > > +{
> > > +	struct snd_usb_audio *chip;
> > > +	struct snd_usb_substream *subs;
> > > +	struct snd_usb_stream *as;
> > > +	const struct audioformat *fmt;
> > > +
> > > +	/*
> > > +	 * Register mutex is held when populating and clearing usb_chip
> > > +	 * array.
> > > +	 */
> > > +	mutex_lock(&register_mutex);
> > > +	chip = usb_chip[card_idx];
> > > +	if (!chip) {
> > > +		mutex_unlock(&register_mutex);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	if (enable[card_idx]) {
> > > +		list_for_each_entry(as, &chip->pcm_list, list) {
> > > +			subs = &as->substream[direction];
> > > +			fmt = snd_usb_find_substream_format(subs, params);
> > > +			if (fmt) {
> > > +				mutex_unlock(&register_mutex);
> > > +				return as;
> > > +			}
> > > +		}
> > > +	}
> > > +	mutex_unlock(&register_mutex);
> > 
> > I prefer having the single lock/unlock call pair, e.g.
> > 
> > 	struct snd_usb_stream *as, *ret;
> > 
> > 	ret = NULL;
> > 	mutex_lock(&register_mutex);
> > 	chip = usb_chip[card_idx];
> > 	if (chip && enable[card_idx]) {
> > 		list_for_each_entry(as, &chip->pcm_list, list) {
> > 			subs = &as->substream[direction];
> > 			if (snd_usb_find_substream_format(subs, params)) {
> > 				ret = as;
> > 				break;
> > 			}
> > 		}
> > 	}
> > 	mutex_unlock(&register_mutex);
> > 	return ret;
> > }
> > 
> > In this case, we shouldn't reuse "as" for the return value since it
> > can be non-NULL after the loop end.
> 
> Why not just use guard(mutex) for this, making it all not an issue?

Heh, it's too new ;)
That should work gracefully, yes.


Takashi
