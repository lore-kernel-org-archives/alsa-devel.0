Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB08CA6007
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2026 08:52:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30626601EE;
	Thu,  8 Oct 2026 10:51:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30626601EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791449524;
	bh=znzbD72nPgN1Famhk5FwJ8hdyr3XpAWFzWNBebDwkAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Vvnr+4jHoNmZf4qUW450KgQvc5DQIYJPXBK7IljiHgHbgJYbHXqVyqIYCJPRav51d
	 qhmIrnhU+wetlRXMsmDqWKbXgVO0wHE1epPNkn+qMC2dKOSFx2gxzyqi/jTQjt5sZ2
	 Mpqpkr3xECbwvI1hUP7HRPtHi2TX5zP+LWANlRko=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23392F805FC; Thu,  8 Oct 2026 10:51:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74FB2F80602;
	Thu,  8 Oct 2026 10:51:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2B10F80571; Thu,  8 Oct 2026 10:51:20 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791449476;
	b=pdj+s0j1s9DYvd/UGmvc6xW2pXH2KLMnlL9yWccaKw1In90zOadM8d8crpbH3YdeZJZ3
	 vTY82dnWLEAeXfL+zv9UXyCWLKatQZk9Wo5YoWgNKXoLoIqiOrN5/x+95jO0V6xU63s7Z
	 w74Chrw/qLqxJatWH3va8XVUAXw0emrytGvYGo1ktSGf8I+pX56oCqR5jH75jCim7R07t
	 0DpvfXoBML+vuLE48E5OddPzifvL0W6e65k9YMIZqTGEoYit3p+jeP2XV/hM+/0uK1DWM
	 AEj/nxE2sHBxwbFJQYQzIM+Kgf2BR+8CJuPZkk+ePNljr9B8Qn64M6CzQkKen1CcqFA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791449476;
	h=DKIM-Signature:DKIM-Signature:Date:Message-ID:From:To:Subject:
	 MIME-Version;
	bh=znzbD72nPgN1Famhk5FwJ8hdyr3XpAWFzWNBebDwkAk=;
	b=jLD8W8c8t9yc8XfBZuGzYnWVF0N2jYw74babz/3sVFmpOXwwI9bK/jRwjsz3fKsFfdQb
	 IeiyUjfWjdDKiJUKuQaCCY3VOB5EvE2exLxmGmI6XLPrTpelzL6Of1O8ZF0aqNskxv2nD
	 x11e12jBrvl6krSIq1AKJWAbF2Klpx8KHQo1O0YMxvY5jiX9CymcVWxjnynJsv/Mdf09y
	 DMSW1pMFb31i3PPGnXOtyhN5hjDqtNGdrSVf/skji0TxIOdfpOE52aG5fEuZYEl7mWV73
	 +WlSR8rafNXqTIALf3U1GjOKjfY0kq7d3J1UZz5XGro8XXYX5MWta4LQo10hPxCuxMw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xi2P9uja;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=qnyfl8vU;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9C954F8007E
	for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2026 10:51:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C954F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=xi2P9uja;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=qnyfl8vU
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89A2D21B88;
	Thu,  8 Oct 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1791449474;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wIPzbU/ohsBoucWXoQZ3rjPyGsMP0RfhBD6plJqZaE8=;
	b=xi2P9ujaT3HRkApfQdwtOAn3FT8DE+nKWxK4gFjTglgTyJVUCHz9vW53+8OxYi8zpeJEsA
	bkgYeFSJ+k4ss5QsY4rL7gYeO0gbp+ECEk2wlIdzBis19soF3vBGhZ0tIfQCW4BDqfh11R
	EeZi4j0/9Fg+IxWa1mfZQtCXnkvZ4Y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791449474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wIPzbU/ohsBoucWXoQZ3rjPyGsMP0RfhBD6plJqZaE8=;
	b=qnyfl8vUGcoBZN5c2VhNfOwak3SrG7UUFzUJ3Xugx/ysJGO2B4g9ucY6GxoPIi3GJNm+Cm
	1hqrR50jDNj6CAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33B7C139CE;
	Thu,  8 Oct 2026 08:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u+gBBoJZx2r1VgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 08 Oct 2026 08:51:14 +0000
Date: Thu, 08 Oct 2026 10:51:13 +0200
Message-ID: <87pkxk60e6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.3-rc6
In-Reply-To: <20261008081955.A2A6D1AC57CE@finisterre.sirena.org.uk>
References: <20261008081955.A2A6D1AC57CE@finisterre.sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [0.00 / 50.00]
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
Message-ID-Hash: APYNINI3JPSVMGXRSXUTBOG42PECO2T4
X-Message-ID-Hash: APYNINI3JPSVMGXRSXUTBOG42PECO2T4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/APYNINI3JPSVMGXRSXUTBOG42PECO2T4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 08 Oct 2026 10:19:42 +0200,
Mark Brown wrote:
> 
> The following changes since commit a90ee4305c4a5df72c11b31dacfdc76e00fcf78a:
> 
>   Linux 7.3-rc6 (2026-10-04 13:45:25 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v7.3-rc6
> 
> for you to fetch changes up to 9ca0d0d0249230135dbf6fa1b9168e260151babc:
> 
>   ASoC: amd: acp: Add more ACP7.0 match entries for Cirrus Logic parts (2026-10-07 16:21:32 +0200)
> 
> ----------------------------------------------------------------
> ASoC: Fixes for v7.3
> 
> A fairly small collection of fixes and a few device quirks, nothing
> especially remarkable unless you have the affected system.

Pulled now.  Thanks.


Takashi
