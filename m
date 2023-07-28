Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAD0C001DC
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 09:18:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77AFE4E;
	Mon, 31 Jul 2023 11:17:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77AFE4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690795126;
	bh=9cLix/YKxH7lzuGtSKFakpQjTQu+3UVNSEjYcMlH7zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=q3e4yHT6KTkqwGK3KNYJW0nEjlQLcL7PMdnjyL6t2BOczq8lD6Sq5d8RzZYPhDqoH
	 gPOBkFqeZXSYo81O345R0sON9NWGvkAd8L8tr6yqYZkvvTKEtUSvqbQIlHSIu93684
	 ZHOH6o1JYsbZays0Ptm/Nmf4tklo2aloUPXPPipE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5903FF80153; Mon, 31 Jul 2023 11:17:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F3D5F8016D;
	Mon, 31 Jul 2023 11:17:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C5173F8019B; Fri, 28 Jul 2023 06:47:30 +0200 (CEST)
Received: from mailhost.m5p.com (mailhost.m5p.com [74.104.188.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 78F8DF80153
	for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2023 06:47:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78F8DF80153
Received: from m5p.com (mailhost.m5p.com [IPv6:2001:470:1f07:15ff:0:0:0:f7])
	by mailhost.m5p.com (8.16.1/8.15.2) with ESMTPS id 36S4kbWF078991
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 28 Jul 2023 00:46:43 -0400 (EDT)
	(envelope-from ehem@m5p.com)
Received: (from ehem@localhost)
	by m5p.com (8.16.1/8.15.2/Submit) id 36S4ka3c078990;
	Thu, 27 Jul 2023 21:46:36 -0700 (PDT)
	(envelope-from ehem)
Date: Thu, 27 Jul 2023 21:46:36 -0700
From: Elliott Mitchell <ehem+xen@m5p.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ALSA: xen-front: refactor deprecated strncpy
Message-ID: <ZMNILDgqHEGf8fNF@mattapan.m5p.com>
References: <20230727-sound-xen-v1-1-89dd161351f1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727-sound-xen-v1-1-89dd161351f1@google.com>
X-MailFrom: ehem@m5p.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 4BD4A6CTFMH4FPV5N3HIOMJVGLDYJHH3
X-Message-ID-Hash: 4BD4A6CTFMH4FPV5N3HIOMJVGLDYJHH3
X-Mailman-Approved-At: Mon, 31 Jul 2023 09:17:20 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4BD4A6CTFMH4FPV5N3HIOMJVGLDYJHH3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Jul 27, 2023 at 09:53:24PM +0000, Justin Stitt wrote:
> Technically, my patch yields subtly different behavior. The original
> implementation with `strncpy` would fill the entire destination buffer
> with null bytes [3] while `strscpy` will leave the junk, uninitialized
> bytes trailing after the _mandatory_ NUL-termination. So, if somehow
> `pcm->name` or `card->driver/shortname/longname` require this
> NUL-padding behavior then `strscpy_pad` should be used. My
> interpretation, though, is that the aforementioned fields are just fine
> as NUL-terminated strings. Please correct my assumptions if needed and
> I'll send in a v2.

"uninitialized bytes" => "leak of sensitive information" => "security hole"

One hopes the unitialized bytes don't contain sensitive information, but
that is the start of the chain.  One can hope the VM on the other end is
friendly, but that isn't something to rely on.

I'm not in charge of any of the appropriate subsystems, I just happened
to randomly look at this as message on a mailing list I'm on.  Could be
the maintainers will find this acceptable.


-- 
(\___(\___(\______          --=> 8-) EHM <=--          ______/)___/)___/)
 \BS (    |         ehem+sigmsg@m5p.com  PGP 87145445         |    )   /
  \_CS\   |  _____  -O #include <stddisclaimer.h> O-   _____  |   /  _/
8A19\___\_|_/58D2 7E3D DDF4 7BA6 <-PGP-> 41D1 B375 37D0 8714\_|_/___/5445


