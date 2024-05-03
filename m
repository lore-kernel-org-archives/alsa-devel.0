Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5C3C4345F
	for <alsa-devel@archiver.kernel.org>; Fri,  3 May 2024 07:48:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EAF9BC0;
	Fri,  3 May 2024 09:47:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EAF9BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1714722480;
	bh=0LjN+RgCM/NbA+vxmMMMADV3hC1wK1/e5glTLyBwGTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jv+e6K/hahhT8zM9OTUUtHQE/40oBjjpg9PDuZamJs8KqnOvP046mAq5jqXnM4ijE
	 qHJE6SLgiOuoJU24qN2WUkfkGeVsfgP3AxZvAtML/BfP6f1nENFT3MpxG/BeivphE2
	 T5fjWDkg8/rmz14n8hba4POjlLLCLhAziUZjHsTY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7C66F805A1; Fri,  3 May 2024 09:47:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 51D49F805A9;
	Fri,  3 May 2024 09:47:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7BD79F80266; Fri,  3 May 2024 09:42:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 21DE6F800E2
	for <alsa-devel@alsa-project.org>; Fri,  3 May 2024 09:41:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21DE6F800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=H2h40Ybz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=d+ngBvXO;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=H2h40Ybz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=d+ngBvXO
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9866A22B7E;
	Fri,  3 May 2024 07:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1714722108;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gunftjrVkw4beEJHcIhpNH7D+9VWjwKFtIXJPtbrtFc=;
	b=H2h40Ybzwl4+ohfj8rjJQDun/VElHyL793NYk6hvRAVgx/LT3OqMrJHL+d0QZFyuAJwEyk
	sq4i0Jw0RzOmkwoYZB232H/1hr6XOZtp7Uf8zSyYxw1giJJv5ygWNDN0GlhrYMpxEcZmzI
	Twa1HG+mFEhDefmERvO8QTFeqsqF2L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714722108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gunftjrVkw4beEJHcIhpNH7D+9VWjwKFtIXJPtbrtFc=;
	b=d+ngBvXOFGAX0KV7jt2Hy2fNRxACDNnTXmilgc9h+XBhawg87yv3cPVqOSZery7PC6Tyqm
	pS9HcORxzb8xmXDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1714722108;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gunftjrVkw4beEJHcIhpNH7D+9VWjwKFtIXJPtbrtFc=;
	b=H2h40Ybzwl4+ohfj8rjJQDun/VElHyL793NYk6hvRAVgx/LT3OqMrJHL+d0QZFyuAJwEyk
	sq4i0Jw0RzOmkwoYZB232H/1hr6XOZtp7Uf8zSyYxw1giJJv5ygWNDN0GlhrYMpxEcZmzI
	Twa1HG+mFEhDefmERvO8QTFeqsqF2L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714722108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gunftjrVkw4beEJHcIhpNH7D+9VWjwKFtIXJPtbrtFc=;
	b=d+ngBvXOFGAX0KV7jt2Hy2fNRxACDNnTXmilgc9h+XBhawg87yv3cPVqOSZery7PC6Tyqm
	pS9HcORxzb8xmXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2718A139CB;
	Fri,  3 May 2024 07:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hyf5BzyVNGa+DAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 03 May 2024 07:41:48 +0000
Date: Fri, 03 May 2024 09:42:01 +0200
Message-ID: <878r0ribp2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<bard.liao@intel.com>,
	<yung-chuan.liao@linux.intel.com>,
	<kevin-lu@ti.com>,
	<cameron.berkenpas@gmail.com>,
	<baojun.xu@ti.com>,
	<soyer@irl.hu>,
	<Baojun.Xu@fpt.com>
Subject: Re: [PATCH v3] ALSA: ASoc/tas2781: Fix wrong loading calibrated data
 sequence
In-Reply-To: <20240502232450.484-1-shenghao-ding@ti.com>
References: <20240502232450.484-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.78 / 50.00];
	BAYES_HAM(-2.98)[99.92%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,139.com,alsa-project.org,vger.kernel.org,intel.com,ti.com,irl.hu,fpt.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
Message-ID-Hash: 2ARJLNUHVKBMFCE7ZDQBP5JA3H2EKACC
X-Message-ID-Hash: 2ARJLNUHVKBMFCE7ZDQBP5JA3H2EKACC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2ARJLNUHVKBMFCE7ZDQBP5JA3H2EKACC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 03 May 2024 01:24:49 +0200,
Shenghao Ding wrote:
> 
> Calibrated data will be set to default after loading DSP config params,
> which will cause speaker protection work abnormally. Reload calibrated
> data after loading DSP config params.
> 
> 'Fixes: 0a0877812628 ("ASoc: tas2781: Fix spelling mistake "calibraiton"
>  -> "calibration"")'

This usage of Fixes tag is utterly wrong: first off, drop the single
quote of the whole line.  Moreover, the suggested commit looks very
dubious.  It's merely a change to correct spelling, and this can't be
the culprit of the bug itself.  Please point to the right commit.

> @@ -13,8 +13,8 @@
>  // Author: Kevin Lu <kevin-lu@ti.com>
>  //
>  
> -#ifndef __TASDEVICE_DSP_H__
> -#define __TASDEVICE_DSP_H__
> +#ifndef __TAS2781_DSP_H__
> +#define __TAS2781_DSP_H__

This is unnecessary / related change, better to keep or do it in
another patch.

> @@ -1878,7 +1878,7 @@ int tas2781_load_calibration(void *context, char *file_name,
>  {
>  	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *)context;
>  	struct tasdevice *tasdev = &(tas_priv->tasdevice[i]);
> -	const struct firmware *fw_entry;
> +	const struct firmware *fw_entry = NULL;

Why is this needed?  If a NULL initialization is a must (for some
warning fix or whatever), do it in an individual fix patch instead.

The rest changes look OK, but it's a bit hard to judge because the
code has too few comments, unfortunately...


thanks,

Takashi
