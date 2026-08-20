Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BFAC5DF85
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:32:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28D0660268;
	Thu, 20 Aug 2026 16:32:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28D0660268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787236361;
	bh=hbZ8x6/INTVPIXQ7g/QPDnHAAiJpq+jgb50RyucpZ5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=oXIFVSCOOoX3ZO2H2HMm25YqcmVkCT/Zeglj5juLAAu8APVLXtfARChkJJJUjsltt
	 wDsAFKkrUAvhzS1mPHir63s30ORBcTnjxd920vRfnukH/XqJEmy0+jrkW6ISX2zN3n
	 vW4KulyRDtaYTeHHVk5l2jsW21Xr30HUZhGAQoug=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9AE26F805F3; Thu, 20 Aug 2026 16:32:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 27571F805F3;
	Thu, 20 Aug 2026 16:32:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4AEC1F8053D; Thu, 20 Aug 2026 16:32:00 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787236319;
	b=mRohnvE/vsF6Gh8L4VbT1iLEcRw58KjNkkIUsvvpq5PrhRpDyLGByHyqNjf9OxFG38b2
	 VYHpCBd6S09NM9YW9vRkPlHXOcQSCpC8M3aP9rGC5vFEY9nv8I0zQ/J34Zca98O41P5Qx
	 G6NeUBp6EK1PWQUNxcCz+11dY09bdP6Ky6m6yTrTj6QagGqIn6TR2iLTBPeMzhghS0zmn
	 aGOdBOTlZAikxlwn43KrCc1mtcbCvaKGUUMzxhrt08brL0LaCrcu3Lg1fCT5/Ke5sSXxY
	 1npAUoFvReZ83gC93ft+WEOQltdhU48r/aNTi4j2C5Srbefn1WIWP2t5N7iW4WB8ytQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787236319;
	h=DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:Date:
	 Message-ID:From:To:Subject:MIME-Version;
	bh=hbZ8x6/INTVPIXQ7g/QPDnHAAiJpq+jgb50RyucpZ5w=;
	b=AsuUcVhvBGlcb2j8UDRVViKgb3EULcDl+MrNgXFyu3vHLrYQmEP0+uAgrjgO964T9SzH
	 wszPY4Ag9xsU5EO+QUr4YtCHwYLvl8q+0H5odvqQvN/Ud00DHEvt1T2PCsIS8MfVc6T5i
	 FWcvAZmu0tpw7DS25T7FLkHqwnLUsp8+6gs3iak5XMSxh3jw4FN5ReTHj4+CDfi9+xgGV
	 OA5Jb+qszv7xszM4KPXJRFMfOFddaBhKrCQymaXiAcTuRCqtYgGdsait3rxXm0IEfBxF/
	 eJkT8ClO5f9vkNO2rGi4dbB0Q2UDqcUwBg304HbcFibMRGxKqOBpRQ4t3gB62zxFOCQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b="0i5jU/lE";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=te68kvwx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=Kvyr80aH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=dcqx7VDP;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 924D0F80246
	for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2026 16:31:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 924D0F80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=0i5jU/lE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=te68kvwx;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Kvyr80aH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=dcqx7VDP
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B6043EB1;
	Thu, 20 Aug 2026 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787236313;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9F80ksxXnN6sgW2JrE0j94FBuzDVxgnuENFaSqhfUEY=;
	b=0i5jU/lEVS5TeJovCVzA6iDKuO8iQjA8KpFVbNHJd59A/Z7mQtpKJnin674eytgs4WBazG
	fmBHfs7zqQ0/yA/liNAzapv7Hgh1h6peOfsNmnFqgc0OPRCo0A543sCkWqjEpuoNN7P7Z/
	4g5ozOS+EgD/3OtAAMPTp1Qy1/O2qBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787236313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9F80ksxXnN6sgW2JrE0j94FBuzDVxgnuENFaSqhfUEY=;
	b=te68kvwxLqnMuq/RzLus11BNWN0uWhMwvxZX+af95Ezk2qoqp6WmQ5N45ocQXdPerxSvl/
	N4lH5Elv3XhtKwBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1787236309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9F80ksxXnN6sgW2JrE0j94FBuzDVxgnuENFaSqhfUEY=;
	b=Kvyr80aHFXY9OCDfyyGsipPjfnMiJS8lYUItq2RcX+3HtflQKVEMikVDmuVLHAP4VPCxEE
	cgM/05isCSsDJMgfcekz8Q1QLtbo2VhYP3ITn6Cg/hTGjPiAfe2ctZVb2kZ0mqwN1D/uHl
	YXCTsuo+z7o0QnZTfYpOORV0TUODBjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787236309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9F80ksxXnN6sgW2JrE0j94FBuzDVxgnuENFaSqhfUEY=;
	b=dcqx7VDPa0Ds5eCJbS/VXjjuwN7vBuLtMxoyFFR5J6v5eou9HktQ9McYLAm+gLtGK5GqXJ
	CpaTw/8qP9SB/WDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E20727A8;
	Thu, 20 Aug 2026 14:31:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MLs/FNUPh2obcAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 20 Aug 2026 14:31:49 +0000
Date: Thu, 20 Aug 2026 16:31:48 +0200
Message-ID: <87se48lv6z.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: Linux-audio BoF at Linux Plumbers Conference?
In-Reply-To: <5f459099-4364-46f9-a3b4-1c629aa91209@perex.cz>
References: <871pbsnce8.wl-tiwai@suse.de>
	<5f459099-4364-46f9-a3b4-1c629aa91209@perex.cz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Message-ID-Hash: XDBJ65FQDIKHUY5UMCYTK4Z3JVXI5RUR
X-Message-ID-Hash: XDBJ65FQDIKHUY5UMCYTK4Z3JVXI5RUR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XDBJ65FQDIKHUY5UMCYTK4Z3JVXI5RUR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 20 Aug 2026 16:02:45 +0200,
Jaroslav Kysela wrote:
> 
> On 8/20/26 15:34, Takashi Iwai wrote:
> > Hi,
> > 
> > a few people including Mark and me have talked about holding a small
> > meeting for the Linux audio stuff (finally again!) during the next
> > Linux Plumbers Conference (on Oct 5-7 at Prague).
> > 
> > Has anyone already planned to attend there and is interested to join?
> > If we have enough people, we can try an official BoF session.
> > Otherwise, we can just have an unofficial session at lunch time or
> > such, too.  Just let us know.
> 
> Hi,
> 
> I will be attending Linux Plumbers and would be pleased to participate in
> a BoF session or another type of meeting.

Awesome, looking forward to seeing you again!


Takashi
