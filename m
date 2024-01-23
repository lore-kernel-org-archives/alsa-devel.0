Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E9BC47DDB
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jan 2024 07:59:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67501741;
	Tue, 23 Jan 2024 08:59:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67501741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705996765;
	bh=pFyUKCV7PckLl73NJF0nEHxcP3YgpX8KAqzVymf34Ho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bcoOwAcNXC9LEHrwF30Xm+aBaMXrYPHl2Qghro78PwbHnzi7ZDvBZiiV25PL1gu9m
	 s6zD1yphykAEkXXcGAyBHwKUTVCNMc3TZkun/p2dEgHyTQSvX3/z4sz/zmzNuDG1HF
	 cC4VUYl3UcWcNrZKHknJj1AeTpwdo96W5Rw6lntM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E881AF805AF; Tue, 23 Jan 2024 08:58:53 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 36D9AF8057D;
	Tue, 23 Jan 2024 08:58:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 316FCF80494; Tue, 23 Jan 2024 08:53:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 62D66F8025F
	for <alsa-devel@alsa-project.org>; Tue, 23 Jan 2024 08:52:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62D66F8025F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Btl067fn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=2tgb3Y6k;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Btl067fn;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=2tgb3Y6k
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8AC2D21F4E;
	Tue, 23 Jan 2024 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1705996359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prvT3vWO52L/uHnktDoGcR4sTbjQr2MfIdjzVdS6mfY=;
	b=Btl067fn6lRnDDq9NCXx84J6dWAQopZuYVmvqMzXRrR+RVpx9ZmBRpOGISuAvXRIHiYIQR
	o7ZYGlM/dkzBw6ZO6ujOmDAchzYKXyaItbmEBtFAfyF5TrD3JZ5kkdcrazzltIPw+27mQJ
	VRkLzE72/Zflb+J2SbUn5FhTimUj/Ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705996359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prvT3vWO52L/uHnktDoGcR4sTbjQr2MfIdjzVdS6mfY=;
	b=2tgb3Y6kVFmEynpEywD4x7MKw0O2f7l6fOCo3iHycEJMQLD8dfRqVMEe+I40RPaY6m4wyW
	Wc/haavMLkLTnADA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1705996359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prvT3vWO52L/uHnktDoGcR4sTbjQr2MfIdjzVdS6mfY=;
	b=Btl067fn6lRnDDq9NCXx84J6dWAQopZuYVmvqMzXRrR+RVpx9ZmBRpOGISuAvXRIHiYIQR
	o7ZYGlM/dkzBw6ZO6ujOmDAchzYKXyaItbmEBtFAfyF5TrD3JZ5kkdcrazzltIPw+27mQJ
	VRkLzE72/Zflb+J2SbUn5FhTimUj/Ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705996359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prvT3vWO52L/uHnktDoGcR4sTbjQr2MfIdjzVdS6mfY=;
	b=2tgb3Y6kVFmEynpEywD4x7MKw0O2f7l6fOCo3iHycEJMQLD8dfRqVMEe+I40RPaY6m4wyW
	Wc/haavMLkLTnADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 540D813786;
	Tue, 23 Jan 2024 07:52:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qlsQE0dwr2UMZgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 23 Jan 2024 07:52:39 +0000
Date: Tue, 23 Jan 2024 08:52:38 +0100
Message-ID: <87wms0mqpl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	<alsa-devel@alsa-project.org>,
	<patches@opensource.cirrus.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/cs8409: Suppress vmaster control for Dolphin
 models
In-Reply-To: <20240122184710.5802-1-vitalyr@opensource.cirrus.com>
References: <20240122184710.5802-1-vitalyr@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Btl067fn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2tgb3Y6k
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.18)[96.06%]
X-Rspamd-Queue-Id: 8AC2D21F4E
Message-ID-Hash: EZNUUZOEGU6VRY24NOMSHDWCDA2WLSNL
X-Message-ID-Hash: EZNUUZOEGU6VRY24NOMSHDWCDA2WLSNL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EZNUUZOEGU6VRY24NOMSHDWCDA2WLSNL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 22 Jan 2024 19:47:10 +0100,
Vitaly Rodionov wrote:
> 
> Customer has reported an issue with specific desktop platform
> where two CS42L42 codecs are connected to CS8409 HDA bridge.
> If "Master Volume Control" is created then on Ubuntu OS UCM
> left/right balance slider in UI audio settings has no effect.
> This patch will fix this issue for a target paltform.
> 
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Applied, thanks.


Takashi
