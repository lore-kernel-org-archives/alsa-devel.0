Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1009FC7EE24
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jun 2023 13:18:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7693B1D6;
	Mon,  5 Jun 2023 15:17:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7693B1D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685971110;
	bh=ih5BrgHscULEJxZoJjqVtD9h/eUjFDAJVQCPx+KKsAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cz0Kvv7fwN5+cbbhCrf3GogAuSOEh31uvPMbKfuvnoBJ4L2McPXa9RLkXiun90AZl
	 wuj81J+H71E3p0YNsB/3C9nPP43CkUjqioyt+JCiQMg6wuXD2ic0Hgsr61dVRcFpOb
	 fNx1FTdTPtBJcTz0nGK8D/NkyXDKkYRzt9Zhjd90=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6DC01F8016C; Mon,  5 Jun 2023 15:17:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FDE4F80199;
	Mon,  5 Jun 2023 15:17:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C1140F80199; Mon,  5 Jun 2023 15:17:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2001:67c:2178:6::1d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1E3F5F80130
	for <alsa-devel@alsa-project.org>; Mon,  5 Jun 2023 15:17:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E3F5F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=HYgbmPXP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=L4KoVQxM
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53D9A1FE67;
	Mon,  5 Jun 2023 13:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1685971024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ/D4JXr2jkATGmTql3tYtvfsfon8UBRMwLFWJ2zmbo=;
	b=HYgbmPXPKxG1Oh9kEW67R4NktUDQpiudtrchPD2Rnv1aEj22Ool+IwRCH0YfCgYBWu8H4f
	2E+uF/g5bMp+v6zeN6ssEZYXCt+wpyN0trWXpgiM+j+skupm6UnkW7+IVD9FEbTgjW12Pe
	Sqws5dXs9aRehpxjXcynwxvHmydXC4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685971024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ/D4JXr2jkATGmTql3tYtvfsfon8UBRMwLFWJ2zmbo=;
	b=L4KoVQxMZTBs4QKvBjnzvzSRkieruEav2FMfzx0jz2k5mX0YenO2xU2yVkU2vomjR1ZzGB
	KJTs3iPhdh2ge7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26D38139C8;
	Mon,  5 Jun 2023 13:17:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id VG6OCFDgfWTxKwAAMHmgww
	(envelope-from <tiwai@suse.de>); Mon, 05 Jun 2023 13:17:04 +0000
Date: Mon, 05 Jun 2023 15:17:03 +0200
Message-ID: <878rcyhwvk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH RESEND v1 2/3] ALSA: hda: cs35l41: Fix endian conversions
In-Reply-To: <ff8d0da4-10f7-31a7-5cf9-7a4c0e009192@opensource.cirrus.com>
References: <20230525135955.2108140-1-sbinding@opensource.cirrus.com>
	<20230525135955.2108140-3-sbinding@opensource.cirrus.com>
	<87zg5eidcb.wl-tiwai@suse.de>
	<ff8d0da4-10f7-31a7-5cf9-7a4c0e009192@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: 5NJZRZNZ3NHAYLPE4R2DPHLPNWZNS24E
X-Message-ID-Hash: 5NJZRZNZ3NHAYLPE4R2DPHLPNWZNS24E
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5NJZRZNZ3NHAYLPE4R2DPHLPNWZNS24E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 05 Jun 2023 14:50:54 +0200,
Stefan Binding wrote:
> 
> Hi Takashi,
> 
> On 05/06/2023 08:21, Takashi Iwai wrote:
> > On Thu, 25 May 2023 15:59:54 +0200,
> > Stefan Binding wrote:
> >> @@ -379,10 +379,10 @@ static int cs35l41_save_calibration(struct cs35l41_hda *cs35l41)
> >>     				/* Calibration can only be applied
> >> whilst the DSP is not running */
> >>   				ret = cs35l41_apply_calibration(cs35l41,
> >> -								cpu_to_be32(cl->calAmbient),
> >> -								cpu_to_be32(cl->calR),
> >> -								cpu_to_be32(cl->calStatus),
> >> -								cpu_to_be32(cl->calR + 1));
> >> +								(__be32)cpu_to_be32(cl->calAmbient),
> >> +								(__be32)cpu_to_be32(cl->calR),
> >> +								(__be32)cpu_to_be32(cl->calStatus),
> >> +								(__be32)cpu_to_be32(cl->calR + 1));
> > Do we really need those cast?  Even if yes, it must be with __force
> > prefix for the endian cast in general.
> 
> These casts were added because we found some warnings when we ran the
> static analyzer sparse locally.
> I think these warnings are very minor, and we can drop this patch if
> you prefer?

The warnings must be bogus, or maybe pointing to other things?
The cpu_to_be32() macro itself must return a __be32 value, hence it
makes no sense to add an extra cast .

If the static analysis still shows such a warning, it should be fixed
differently -- either fix the analyzer or fix the cpu_to_be32() macro
itself.

The changes of the argument types to __be32 are fine.  I'm arguing
only about those unnecessary cast.


thanks,

Takashi
