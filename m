Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FE8606A335
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Kbuikygp;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kQvVNbnL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Wm3IyQs+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kQvVNbnL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Wm3IyQs+
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22FFF601F6;
	Mon,  2 Nov 2026 15:22:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22FFF601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793629333;
	bh=EjYcI/2KOWv3mbW47J8dluHu/9nmMlBmq2YN8QaT7dQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Kbuikygp28eHHeeirg9fM2JZ7asyfyzqV1iTziBOjMbVYTU2e9opIncrJv6Q/5YIy
	 iJ1bXW24uW3DAzvCS5j3Ty8p1p4XyeMwHT727nnUWRQRU4CR7339ia/wjgMnPED6Uk
	 sT93m7tgJ9V08Or/GZyl7g66fpenQ7ZoCwSnQ0M4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F40A6F80604; Mon,  2 Nov 2026 15:21:38 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 665FAF805FC;
	Mon,  2 Nov 2026 15:21:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDEFAF80272; Mon,  2 Nov 2026 15:21:30 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 24BE0F80095
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 15:21:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24BE0F80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=kQvVNbnL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Wm3IyQs+;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=kQvVNbnL;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Wm3IyQs+
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3702C2209D;
	Mon,  2 Nov 2026 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793628233;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2exfNJAjFIm+V8iRAws74yjXejKyxK8RNSuUp596ULY=;
	b=kQvVNbnLQ5Bk+mSa61Cq4rr2uDKGhWSU+UBsTaMt0Lxur/LtoAmMtPnvdNFCkiyQuJUPL1
	1WtjzPzA5zZeGLuanhknuaGwyQ1IFEeD4Dh9M4LKRs6C/SD/4nK+CQz3jhE1CMtRD164QA
	WwzTR5KtBDvx9mQXsPwEChokn0hvwik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793628233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2exfNJAjFIm+V8iRAws74yjXejKyxK8RNSuUp596ULY=;
	b=Wm3IyQs+YnEqBfOq4HtkoispvZvaCD/itopMe/qeXoTIKcwoEQdq+p/ZXsYibGcmOvAaW3
	SLCMI/tGlTTwk9Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1793628233;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2exfNJAjFIm+V8iRAws74yjXejKyxK8RNSuUp596ULY=;
	b=kQvVNbnLQ5Bk+mSa61Cq4rr2uDKGhWSU+UBsTaMt0Lxur/LtoAmMtPnvdNFCkiyQuJUPL1
	1WtjzPzA5zZeGLuanhknuaGwyQ1IFEeD4Dh9M4LKRs6C/SD/4nK+CQz3jhE1CMtRD164QA
	WwzTR5KtBDvx9mQXsPwEChokn0hvwik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793628233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2exfNJAjFIm+V8iRAws74yjXejKyxK8RNSuUp596ULY=;
	b=Wm3IyQs+YnEqBfOq4HtkoispvZvaCD/itopMe/qeXoTIKcwoEQdq+p/ZXsYibGcmOvAaW3
	SLCMI/tGlTTwk9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2C4F134B3;
	Mon,  2 Nov 2026 14:03:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xgXtJUiY6GreHwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 02 Nov 2026 14:03:52 +0000
Date: Mon, 02 Nov 2026 15:03:52 +0100
Message-ID: <87zevr8h4n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Isma=EFl?= Bahloul <i.bahloul01@gmail.com>
Cc: linux-sound@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 0/8] ALSA: usb: add RME Babyface Pro driver
 (proprietary mode)
In-Reply-To: <20261027113140.134257-1-i.bahloul01@gmail.com>
References: <20261027113140.134257-1-i.bahloul01@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-10.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Message-ID-Hash: YMSFHMH2PEE4G6SZOGQKPD53UPFYE2LQ
X-Message-ID-Hash: YMSFHMH2PEE4G6SZOGQKPD53UPFYE2LQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YMSFHMH2PEE4G6SZOGQKPD53UPFYE2LQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, 27 Oct 2026 12:31:31 +0100,
Ismaïl Bahloul wrote:
> 
> Hi Takashi,
> 
> This is v7 of the RME Babyface Pro proprietary-mode driver.  The split
> is the one you asked for in the v4 review and that v5 introduced: a
> minimal core first, the mixer added piece by piece, suspend/resume near
> the end, the front panel and the DSP EQ last, and a design document.
> v7 keeps that split and folds in the fixes made since v6, and is
> rebased onto next-20261026, the most recent snapshot at the time of
> writing.
> 
> This is not an RFC.  The split you asked for in the v4 review has been
> in place since v5, the open points at the end are documented and none
> of them blocks a merge, so the series is submitted for merge rather
> than for another design round.

Thanks for the updates.  The split patches look much better than
before, which made easier to review.

I haven't fully reviewed in details, but I see you've received quite a
few complaints from Sashiko, so please check them again, and fix if
they are valid.  If they are to be ignored, just explain.

In general, a few things I noticed:

- Please try to use the new guard & co macros for spin/mutex locks and
  RCU.  They are much safer than manual lock/unlock.  (A caveat is
  that you need to be careful not to mix up with guard() and goto,
  though.)

- The inner loop of babyface_playback_copy() and *_capture_copy() can
  be simple memcpy().  You basically copy each 4 bytes as-is and they
  are continuous for channels, after all.

- The bf_seen_before() may lead to unlimited amount of list contents,
  which isn't really good.


thanks,

Takashi
