Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187ED606D80B
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=s1zIPhLk;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tNEBloT/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gnrFI0ew;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tNEBloT/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gnrFI0ew
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C492D6020D;
	Mon,  2 Nov 2026 15:26:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C492D6020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793629590;
	bh=xmlntSNNNXXs8BZZglEiVR6YZIuMFu71tbZm1HA5Fnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=s1zIPhLk+cudBztPz9CKoXf3Uk4O+rqUfRoqLfcrXBS0G3QgVt4/kCesxvxgUmT9u
	 B8qWi/psjvEPQwdjOm5n6SckrHS9wgM6f14QwHq8IUM8GXqvs/0CvGYm1KXw/f4gju
	 E7M7Jjad+80YNF2bYCGtWnX1lRp/0I+s5aDPlHgQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15003F80608; Mon,  2 Nov 2026 15:25:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F3B8F80608;
	Mon,  2 Nov 2026 15:25:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2D08F8025E; Mon,  2 Nov 2026 15:18:02 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AE44DF80095
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 15:18:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE44DF80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=tNEBloT/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gnrFI0ew;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=tNEBloT/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gnrFI0ew
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3DEF1F38A;
	Sat, 31 Oct 2026 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793460733;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tl/Wi3nZo7NoOYfAQin9XmTORwDvi2mJoZ+KnfGsglk=;
	b=tNEBloT/q7lTvBm8/XBQGUSieWB4XcKHK2kJ64vuQaIaWkKXh93rWDGW7vVAZmjOmgLE8w
	thTOntgDgN0WqYyJY+fNe+cnZsjdLmrzKgfiYbSSjlSX+bGlSN9GlElLVYP1Liwm/pgSF3
	dPd1OCRuul+lnmULzVsvM3O4mqyEwG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793460733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tl/Wi3nZo7NoOYfAQin9XmTORwDvi2mJoZ+KnfGsglk=;
	b=gnrFI0ew6VPw3j2uFbsZelnKQxSI7Ciw9dZA0WIyW8XAN4tnbxk+9ca43FCElE3lwKVvLW
	0noS7vd9LN3TTyBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793460733;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tl/Wi3nZo7NoOYfAQin9XmTORwDvi2mJoZ+KnfGsglk=;
	b=tNEBloT/q7lTvBm8/XBQGUSieWB4XcKHK2kJ64vuQaIaWkKXh93rWDGW7vVAZmjOmgLE8w
	thTOntgDgN0WqYyJY+fNe+cnZsjdLmrzKgfiYbSSjlSX+bGlSN9GlElLVYP1Liwm/pgSF3
	dPd1OCRuul+lnmULzVsvM3O4mqyEwG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793460733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tl/Wi3nZo7NoOYfAQin9XmTORwDvi2mJoZ+KnfGsglk=;
	b=gnrFI0ew6VPw3j2uFbsZelnKQxSI7Ciw9dZA0WIyW8XAN4tnbxk+9ca43FCElE3lwKVvLW
	0noS7vd9LN3TTyBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DC0313432;
	Sat, 31 Oct 2026 15:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dWxiF/wJ5mpTEQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 31 Oct 2026 15:32:12 +0000
Date: Sat, 31 Oct 2026 16:32:12 +0100
Message-ID: <87h5i1sx6r.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.4-merge-window
In-Reply-To: <f3c0e30fe8b901ae314a5400bc8dda92@kernel.org>
References: <f3c0e30fe8b901ae314a5400bc8dda92@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: 36CXE2JQROH4DZM6AYPRXB53CNGMR7HA
X-Message-ID-Hash: 36CXE2JQROH4DZM6AYPRXB53CNGMR7HA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/36CXE2JQROH4DZM6AYPRXB53CNGMR7HA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Thu, 29 Oct 2026 19:18:34 +0100,
Mark Brown wrote:
> 
> The following changes since commit 73be2ee656f2722d498504259b9f1fdef8419431:
> 
>   ASoC: codecs: Fix more control definitions that write another control's bits (2026-10-18 13:22:10 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.4-merge-window
> 
> for you to fetch changes up to 11ae63bd9030349a0136fb2edd1622a4a029edc8:
> 
>   ASoC: SOF: Intel: hda: Stop the controller before freeing its DMA buffers (2026-10-29 11:41:21 +0000)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.4
> 
> A moderately large collection of fixes and quirks that have come in
> during the merge window, everything here is driver specific and none of
> it unusually severe.

Pulled now.  Thanks.


Takashi
