Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18207EB64DD
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Aug 2023 13:29:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE0CD1DC;
	Wed,  9 Aug 2023 15:28:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE0CD1DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691587742;
	bh=j707/CEmk2PshwkjcQb6kXs/51Kpqns2s8PV//bK5UE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EwJ2L7nDkWeXMEFR+Q14dSAFbnTOJVHtT+qFDr8YjlKg5fTXTQzXStKXZon9HogLw
	 G0S35FBAb2rFv76IMlXf5GSkPF+AIBrZb/ACgxeHVykz2Pl1dO0VqurBzC4rI+thLf
	 1jqnqBUI5ybST0ha2ESvyCyGAl0ZNFYrrp1MsrxA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CCDACF800FE; Wed,  9 Aug 2023 15:27:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 43BD7F800F4;
	Wed,  9 Aug 2023 15:27:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 406DEF80134; Wed,  9 Aug 2023 15:27:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D0CFFF800F4
	for <alsa-devel@alsa-project.org>; Wed,  9 Aug 2023 15:27:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0CFFF800F4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=cETtlNG9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=cMXcQH5R
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C4651F38C;
	Wed,  9 Aug 2023 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1691587651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIX3lCVmUvfLng/H4i3S7o/LiXJASVOU5MA1UwUybqE=;
	b=cETtlNG9MiOHzy63fi+PoAP5oRprAs/ECbhLw7xdIqCeVYqAvZJyMFNpkaHVtIeXLMN54M
	zO9O9kB0lq3SHvvhd3CQYL1QUG29Ud3Mal4DlUsoerRbcayKd7g96xY1eiNjaKewpaMbQm
	U+0QVnhyBtUlDazBEaeFPRD1Ov7ifC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691587651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIX3lCVmUvfLng/H4i3S7o/LiXJASVOU5MA1UwUybqE=;
	b=cMXcQH5RUQZAqxD5fCypRYy8bxZaWaOdkcK9db7TPQ2VN5bxbfvarb2eZchirOL5N/YOHf
	itllA8/k+mc1lRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB70D13251;
	Wed,  9 Aug 2023 13:27:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cxxWOEKU02Q1DwAAMHmgww
	(envelope-from <tiwai@suse.de>); Wed, 09 Aug 2023 13:27:30 +0000
Date: Wed, 09 Aug 2023 15:27:30 +0200
Message-ID: <87sf8se471.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Curtis Malainey <cujomalainey@google.com>
Cc: alsa-devel@alsa-project.org,
	Curtis Malainey <cujomalainey@chromium.org>,
	Stephen Boyd <swboyd@google.com>
Subject: Re: [PATCH RFC 0/6] ALSA: Fix UAF with delayed kobj release
In-Reply-To: <87o7jgfxgj.wl-tiwai@suse.de>
References: <20230807135207.17708-1-tiwai@suse.de>
	<CAOReqxhV=gfwNpxnEU+ruOx6gjD2BSZbYPJ6+iWzkPCidFmCBA@mail.gmail.com>
	<CAOReqxgCDdXAEyF8pt4dePQ2H_ub=hYczvO1xGpKWAt35z5B2Q@mail.gmail.com>
	<87o7jgfxgj.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: R7BR57LWPLR2YYXLHM2H5ZCWU6YT3R6F
X-Message-ID-Hash: R7BR57LWPLR2YYXLHM2H5ZCWU6YT3R6F
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/R7BR57LWPLR2YYXLHM2H5ZCWU6YT3R6F/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 09 Aug 2023 10:10:04 +0200,
Takashi Iwai wrote:
> 
> On Tue, 08 Aug 2023 21:26:55 +0200,
> Curtis Malainey wrote:
> > 
> > On Mon, Aug 7, 2023 at 3:34 PM Curtis Malainey <cujomalainey@google.com> wrote:
> > >
> > > > It's just a RFC and only lightly tested.
> > >
> > > Thanks for the series
> > >
> > > I will be hammering this in my test setup for next several hours
> > 
> > Testing has yielded 0 bugs overnight.
> > 
> > After discussion it seems like this might be more of a workaround for
> > the APIs than properly using them. Adding Stephen for more input but
> > having two kobj in the same allocation is technically not correct as
> > you essentially refcounting the same thing twice. Also having an empty
> > release function essentially nullifies the purpose of the refcounts.
> > We should probably consider something that uses the API as intended
> > rather than trying to fight their function.
> 
> Moving each PCM device and control device to own object and properly
> release in the own device release could be another way to go.
> 
> OTOH, I'm still wondering whether how to assure synchronization if all
> device releases are done asynchronously.  If there are some
> dependencies between the resources (e.g. taking the parent's lock) at
> release, and how can it be guaranteed to work?  Or, the release calls
> must not touch anything outside its own?  If so, we'll still need to
> two places to finish the stuff: quiesce and release.

And now looking back at kobj code and device code, they do refcount
parent objects.  Maybe the problem is in our side -- the all devices
are created with the original real device as the parent, including the
card_dev, while there are some dependencies among children.  So, if we
build up a proper tree, pci_dev -> card_dev -> ctl_dev, pcm_dev, etc,
one of the problems could be solved.  It's more or less similar as
what I suggested initially (referring card_dev at pcm), while changing
the parent would make it implicitly.



Takashi
