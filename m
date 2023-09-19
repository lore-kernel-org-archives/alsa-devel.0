Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6233CD548C
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Sep 2023 07:43:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87919A4B;
	Tue, 19 Sep 2023 09:42:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87919A4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695109392;
	bh=C7DpkmodZfVUe1R9lh7ReNhYISBDIY+teiqxNa+sPRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Z7z0FVICSTbEXr5zG0q73gC8wxOfbDU5TSmfWzSK+P0pHgokM9s/lyHo2/bpw9Jvi
	 KK/JgCpdYb2lkBPDvUTGuLDAe286kpQp7T2YX8LL48/yiBraDARROD34NzsEackVUd
	 HtAzDSZRDG6PyEh38SU4+SQgNK14Or0lspr9YfKI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38778F80494; Tue, 19 Sep 2023 09:41:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C1CB6F8025A;
	Tue, 19 Sep 2023 09:41:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77AC7F8025A; Tue, 19 Sep 2023 09:41:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9DDBCF800F4
	for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2023 09:41:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DDBCF800F4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=cY8XcfwD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=mKvUEzz+
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F40101F383;
	Tue, 19 Sep 2023 07:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1695109303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VEDZHtSV4C0X1DXJfPgk4WnB1OG4ZAgbRRJCV5ZC0o=;
	b=cY8XcfwD0tSXSxufRLoITWp6doJdyps4l3fdQGsb2cssWaoxIRW147W4jlw7+RZjqEvRS8
	TM8i+2rSXGLM8D4GyN11Lsxz+FwTO/saZjxF4925vFSsT9bHgMIMnVZDiHW6MUaEeflg3A
	q0ZzR2hJn8YAqtszBFVsMyTddfqrrZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1695109303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VEDZHtSV4C0X1DXJfPgk4WnB1OG4ZAgbRRJCV5ZC0o=;
	b=mKvUEzz+RP78CgyMOD+lW9xvV0GrNqS9MmhxrzrgTfzMBgRlTXlzv80DqAnoDQzrmJ1f9L
	NDnPznBF860QEtAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCBC3134F3;
	Tue, 19 Sep 2023 07:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pfv9MLZQCWXfcwAAMHmgww
	(envelope-from <tiwai@suse.de>); Tue, 19 Sep 2023 07:41:42 +0000
Date: Tue, 19 Sep 2023 09:41:42 +0200
Message-ID: <8734zazk21.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: usb-audio: scarlett_gen2: Fix another
 -Wformat-truncation warning
In-Reply-To: <12419771-0fa4-4d44-86fb-440ae14ffda2@linux.intel.com>
References: <20230919071205.10684-1-peter.ujfalusi@linux.intel.com>
	<875y46zl3f.wl-tiwai@suse.de>
	<12419771-0fa4-4d44-86fb-440ae14ffda2@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BFVXRIMWVXP5P4SGNEL5MLVHGSCR37JR
X-Message-ID-Hash: BFVXRIMWVXP5P4SGNEL5MLVHGSCR37JR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BFVXRIMWVXP5P4SGNEL5MLVHGSCR37JR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 19 Sep 2023 09:22:58 +0200,
Péter Ujfalusi wrote:
> 
> 
> 
> On 19/09/2023 10:19, Takashi Iwai wrote:
> > On Tue, 19 Sep 2023 09:12:05 +0200,
> > Peter Ujfalusi wrote:
> >>
> >> The recent enablement of -Wformat-truncation leads to a false-positive
> >> warning for mixer_scarlett_gen2.c.
> >>
> >> For suppressing the warning, replace snprintf() with scnprintf().
> >> As stated in the above, truncation doesn't matter.
> >>
> >> Fixes: 78bd8f5126f8 ("ALSA: usb-audio: scarlett_gen2: Fix -Wformat-truncation warning")
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > 
> > While I applied it now, I wonder why this didn't show up with my local
> > test.
> 
> I wondered about the same thing...
> 
> > Which compiler are you using?
> 
> $ gcc --version
> gcc (GCC) 13.2.1 20230801

Ah mine is still gcc12, and this might be.


Takashi
