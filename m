Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F03CC6B19
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:56:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52155601E0;
	Wed, 14 Oct 2026 07:56:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52155601E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791957370;
	bh=xMusnSmq7X17FmO88nGfTxeBvxXs0FBIyvelidrhwwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VrN5BsaQZE0T+FXVq0RWoxigX9hxM5Ala8u5CtXwltfHM0TycGaQoNn+evg5GtZOp
	 qFq4XMDYPSkiHKvQUGtjP+E38c83qqHnEHpRJaNHfEfOD+99I3M/pb7NioS/XJRA3l
	 PfxWpZcJkSF8OSCTvPl6YPWS9LLJhPFXQmESwOjg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D191BF805EC; Wed, 14 Oct 2026 07:55:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CDEEF805FF;
	Wed, 14 Oct 2026 07:55:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D733BF80448; Wed, 14 Oct 2026 07:55:27 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791957326;
	b=AFJ92DwCjxK2otpy/ni8AyAXDG3zq3lQImFj3dvPFbClThUAC/3PnfxSin0XsyrAGpAh
	 +okI+P8axaiiAXxxYovTgB9END4Vr+Ey8iDbq/vXwWwVQG4FjjebIdecPL1EcUSr9wLFe
	 wnjcO4u2VtNf3ztFp1cYrzMBiyfZYkYAVX6Hu1HX2PBJktjBBUTDtVc2NLuNNy+qobTTs
	 zWL2WJRsd7K7tDeiLGVbEcO2RwR9cqKO0sd6Q6p2mkJagQw2YC1Z2bIX4y6Jyty9vPF2N
	 k8uvAUxBA6p1af484SSIzgIOoRTFBZl7YuHdPGCiIKnPfLNkJOnZyozHVuETt/Id6Eg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791957326;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=xMusnSmq7X17FmO88nGfTxeBvxXs0FBIyvelidrhwwI=;
	b=CQvMmcjTrONyckOmuHADLVqfLM7mlq5CRnnLHjgAthPDncGgI06QR0yRmzpxk0JhmfW4
	 ddV/+XI5+IrPkO8f3QMkTiIvysiboycRgYVxLlLTY4NMEi1Mhn6GCzGoCr4JXxSmrkzrQ
	 /Ga158Vz2zKmUBEnazAfTn/AzdHjpsL4Un8XAdIrRVaDOwWRI4PQsjq+lHVdvedWH1Ghr
	 pY/0oBDFoakRqO78Zrg47sUJcST+pgV5scFNVIwLpW2K0hdnqyzFW7ZOz+64MHOHKqHQ2
	 8cS9+eEOsX6ERNWifqoO8OiPeyj+z43HyIcIT7HJjfkS5/CA+0QT5/pHBCuhiK5nMsQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Y0EWY5an;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=iLYpj8rt;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=FgxF3GWk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=s58Obshm;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C078BF800E4
	for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2026 07:55:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C078BF800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Y0EWY5an;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=iLYpj8rt;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=FgxF3GWk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=s58Obshm
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DAF2421E6C;
	Wed, 14 Oct 2026 05:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1791957325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tFYtpA/Cs8aARD1jOtOIy8DQlx2RowLARWyS7E4L59A=;
	b=Y0EWY5anBrqxX2+gGjXSrR01bhCfFcXK1QFGbdpBLfdrQ3YdpYVJ6ZcVPWmjZiraEZVEOp
	TMHDZ4YJ2uKjiKlXFiCAhoPkWmAbF5NHqh1I1b24IEaz3sd1K6rHvpARdl5aAEN6Y8AvIu
	LRN9yMBcGDQdykpL+HdbfYek3xvaGfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791957325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tFYtpA/Cs8aARD1jOtOIy8DQlx2RowLARWyS7E4L59A=;
	b=iLYpj8rtnWY+rrM5HhVrHy3ePreybAZdAuDPaEtvzEs7Uw/qcQq8JxTz+RXVIYiUwFqAT1
	xPfXPkwp4aB8jJBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1791957324;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tFYtpA/Cs8aARD1jOtOIy8DQlx2RowLARWyS7E4L59A=;
	b=FgxF3GWkGhm28TiC8nTeytz8xCdSM1GuKYLFJc4cNLG2b98WBQSzIpNcodGsSeWyjF5nlQ
	PWf6901Wh3uonh7Dd3Z5+NZlafy2J7aKxAOU7Wj+Nfb1AI07FM9lBsqCFYGQSYxuuB0+LN
	+w2YLLW97zSvXpo64cvH0iaOkd3v1mQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791957324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tFYtpA/Cs8aARD1jOtOIy8DQlx2RowLARWyS7E4L59A=;
	b=s58ObshmHr+9AlQY5w+jwo+nikbvBMHeRMnZcM0SP5bmfrf/reYBNW+0crMz+6bcn1FQRu
	CB3XHZRfPci8jUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49F1E1368E;
	Wed, 14 Oct 2026 05:55:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qUYTCEwZz2r2EgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 14 Oct 2026 05:55:24 +0000
Date: Wed, 14 Oct 2026 07:55:23 +0200
Message-ID: <87jynkg71w.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Sen Wang <sen@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Oster <philippdev5396@outlook.de>,
	Georg Wenzel <g.wenzel@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 0/2] ALSA: hda/tas2781: Skip invalid TAS2563 UEFI
 calibration data
In-Reply-To: <cover.1791895478.git.soyer@irl.hu>
References: <cover.1791895478.git.soyer@irl.hu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.de];
	FREEMAIL_CC(0.00)[ti.com,perex.cz,suse.com,outlook.de,gmail.com,vger.kernel.org,alsa-project.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: BQKV7OSM4XZML2AXOI3CGK6ASJWCBXMW
X-Message-ID-Hash: BQKV7OSM4XZML2AXOI3CGK6ASJWCBXMW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BQKV7OSM4XZML2AXOI3CGK6ASJWCBXMW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 13 Oct 2026 15:02:19 +0200,
Gergo Koteles wrote:
> 
> Hi,
> 
> Georg Wenzel experienced a regession with TAS2563 amplifiers. His laptop 
> lacks proper calibration data, and due to a bug, the driver failed to 
> apply them in the v6.16.x. That's why they worked.
> 
> The amplifiers operate even without calibration data, so the calibration 
> setup can be skipped if the data is invalid.
> 
> The first patch simplifies error paths in the tas2563_save_calibration() 
> function.
> 
> The second patch skips the zero UEFI calibration data as it is not 
> necessary to apply.
> 
> The previous patch for this problem
> 3bc4fc135ec7 ("ALSA: hda/tas2781: Enable bass speakers support")
> should be removed/reverted.
> 
> Gergo Koteles (2):
>   ALSA: hda/tas2781: Assign total_sz at the end of the function
>   ALSA: hda/tas2781: Skip invalid TAS2563 UEFI calibration data

Applied with the revert of the previous fix to for-next branch now.


thanks,

Takashi
