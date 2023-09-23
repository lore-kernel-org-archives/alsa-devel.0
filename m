Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DBDCE7A89
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Sep 2023 10:40:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44BACAEA;
	Sat, 23 Sep 2023 12:39:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44BACAEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695465628;
	bh=sSrBBl15W93LQipW7P0EmyWUaBmShrK4g19it7MwOTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NtnNlanHAnuhysWwl36w8SlHhxUk0fjblbmumDmMNsDNVlRrtpp/kKQqmvDUW980H
	 t3sHSuTllz2qeaGvc4YBBbHaIaJ2ZQOdaxcFSJ94HkdKLL4KDPLuJce12UuKO4Y3PZ
	 0E81UmQsffa5ygMidfK/JNC6xD+kc/VQKoiVzFuY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B166AF8055A; Sat, 23 Sep 2023 12:39:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C4163F8025A;
	Sat, 23 Sep 2023 12:39:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31109F8025A; Sat, 23 Sep 2023 12:37:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 704F3F800F4
	for <alsa-devel@alsa-project.org>; Sat, 23 Sep 2023 12:37:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 704F3F800F4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=JuvpEpMq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=NSa4rUvK
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4D8321B1D;
	Sat, 23 Sep 2023 10:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1695465447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2W9BF97SqiNwR44UTKyJIL2C/qyxi5M9MCWRyPEaLmw=;
	b=JuvpEpMqV9y6fLJbjdzMQwg0h+Lsx2O4wFgIem1jQy2SwHoPlS56wrP58UaOLsuEIbr795
	ark93U4IZpw51JiDfUhS9fhTaT9MBKVM5fZNKyW2WfYZU9i86j6IXimOPF2Gd1acl8mZzy
	AYBzIS199Kx/yveg+WnzkfkTguGYa4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1695465447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2W9BF97SqiNwR44UTKyJIL2C/qyxi5M9MCWRyPEaLmw=;
	b=NSa4rUvK8i4/moouamWix2DGnqjmSWbUDYD33kKY4vanvTr5WtgjXl93Mu5I8XwlVh4iGh
	EUYD6YXmGg66HXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84B781390B;
	Sat, 23 Sep 2023 10:37:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id i9IlH+e/DmUQZwAAMHmgww
	(envelope-from <tiwai@suse.de>); Sat, 23 Sep 2023 10:37:27 +0000
Date: Sat, 23 Sep 2023 12:37:26 +0200
Message-ID: <87h6nlb2ft.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kees Cook <keescook@chromium.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	alsa-devel@alsa-project.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jason Montleon <jmontleo@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Annotate struct hda_conn_list with
 __counted_by
In-Reply-To: <20230922175042.work.547-kees@kernel.org>
References: <20230922175042.work.547-kees@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: PILKSNAXMXS6IVX6BPRSUGSC4PIP7DLA
X-Message-ID-Hash: PILKSNAXMXS6IVX6BPRSUGSC4PIP7DLA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PILKSNAXMXS6IVX6BPRSUGSC4PIP7DLA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 22 Sep 2023 19:50:42 +0200,
Kees Cook wrote:
> 
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct hda_conn_list.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied now.  Thanks.


Takashi
