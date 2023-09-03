Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D78C83F2C
	for <alsa-devel@archiver.kernel.org>; Sun,  3 Sep 2023 16:38:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFBE374C;
	Sun,  3 Sep 2023 18:38:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFBE374C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693759132;
	bh=q2Sd5XHcv8EfHgfPOopJNecm0JeFzM0HEQ/IBlnKHM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Jg4qJlaHnacsj2zsmsfaNkeOx13xew/mxZaTFD3NU9qGmNv4me/hCKcHa2L0Li6lJ
	 lsZAEvCmf5ed4RwpYWdApmJeYrfj726VsBLwaa3WHBaHHEvCJGFd4FpExxDA2tJ4Cs
	 n+An+aEJ2pzDC+sI8aldWXC2pz3LM46ryNZ6cAlE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E74AF8047D; Sun,  3 Sep 2023 18:37:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F0CBF8047D;
	Sun,  3 Sep 2023 18:37:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7DDDAF8047D; Sun,  3 Sep 2023 18:37:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2001:67c:2178:6::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 755D4F800F5
	for <alsa-devel@alsa-project.org>; Sun,  3 Sep 2023 18:37:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 755D4F800F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=q3vnijbh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=zrck84tJ
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4376921836;
	Sun,  3 Sep 2023 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1693759040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Tie4rZws0/0HD6H9qhOXBjJ2HEonf2KMH2jm7Fi++g=;
	b=q3vnijbhPaSwaTR5mKAKd3j5wpKcP49odGDIcRnFqL2zSWDldQM5ihv1xAgYOxbYRzV8cU
	q1Pbve9Drud98LGeIUYE4lXiQO4s+QNQqmGbh/TmQYBsEwR2RevfB5B20r39Usai4xoo2b
	U49ISQd9jnSlYBw05EvfUZGCdRC6qfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693759040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Tie4rZws0/0HD6H9qhOXBjJ2HEonf2KMH2jm7Fi++g=;
	b=zrck84tJVC8XVTiDHSDVIjXjXdrX3F+vS1vhyqeiyfkNvpbLo7mV+1bfL9+bM1PpCK/i0m
	tJuT5BMikzXBNXDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16A0B13583;
	Sun,  3 Sep 2023 16:37:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4SylBEC29GSNIAAAMHmgww
	(envelope-from <tiwai@suse.de>); Sun, 03 Sep 2023 16:37:20 +0000
Date: Sun, 03 Sep 2023 18:37:19 +0200
Message-ID: <87sf7vkybk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix a potential memory leak in
 scarlett2_init_notify()
In-Reply-To: <8cde2320-517f-3a38-8c3f-f807791c6c52@wanadoo.fr>
References: 
 <fc275ed315b9157952dcf2744ee7bdb78defdb5f.1693746347.git.christophe.jaillet@wanadoo.fr>
	<871qffmj2d.wl-tiwai@suse.de>
	<8cde2320-517f-3a38-8c3f-f807791c6c52@wanadoo.fr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Message-ID-Hash: PHAEUK7TYQYYK74FBPZQWOK6CDELDNCL
X-Message-ID-Hash: PHAEUK7TYQYYK74FBPZQWOK6CDELDNCL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PHAEUK7TYQYYK74FBPZQWOK6CDELDNCL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 03 Sep 2023 17:04:47 +0200,
Christophe JAILLET wrote:
> 
> Le 03/09/2023 à 16:23, Takashi Iwai a écrit :
> > On Sun, 03 Sep 2023 15:06:00 +0200,
> > Christophe JAILLET wrote:
> >> 
> >> If usb_alloc_coherent() or usb_urb_ep_type_check() fail, we should release
> >> the resources previously allocated.
> > 
> > Those are freed in the caller side, start_input_streams() instead.
> 
> Thanks for the fast review.
> 
> Hmpm, If IIUC, resources allocated *before* the ending
> "ep->num_urbs++" still need to be freed here, otherwise
> free_midi_urbs() in the caller will not free them.
> 
> Do you agree?
> 
> If yes, I can send v2 which would look like:
> 	usb_alloc_urb()
> 	if (err)
> 		return -ENOMEM
> 
> 	usb_alloc_coherent()
> 	if (err) {
> 		usb_free_urb()
> 		urb = NULL
> 		return -ENOMEM
> 	}
> 	
> 	 usb_urb_ep_type_check()
> 	if (err) {
> 		usb_free_coherent()
> 		usb_free_urb()
> 		urb = NULL
> 		return -err
> 	}
> 
> Or, if yuo prefer, with an error handling path just like below, but
> without the final free_midi_urbs() + a comment explaining that the
> caller does this part of job instead.

Indeed.  The fix would be rather a oneliner like below, though:

--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -265,7 +265,7 @@ static void free_midi_urbs(struct snd_usb_midi2_endpoint *ep)
 
 	if (!ep)
 		return;
-	for (i = 0; i < ep->num_urbs; ++i) {
+	for (i = 0; i < NUM_URBS; ++i) {
 		ctx = &ep->urbs[i];
 		if (!ctx->urb)
 			break;

That was the intended behavior of free_midi_urbs().


Takashi
