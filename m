Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97892E71083
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Sep 2023 15:05:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D26A3AE9;
	Thu, 21 Sep 2023 17:04:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D26A3AE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695308728;
	bh=oo4GNctLz8Shf19nIoryBMjQyKRYmeTybgYDXDbksM4=;
	h=From:In-Reply-To:References:To:Cc:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iz5stueTK36s5oOo/6tCZWKA3vzsA0YKV2VXq9DJWuRWNEZdaT8LkKWw44affMNXq
	 4HepfQBLzSIJxHP/4Zb/rP+2X4yCsqSwfckLB9QpZ/wKX9uoCXpWOVvyl0fm1V5jEa
	 6a04X3ctCkaNDFBN7/GyMiARqOH9312Rd1bGYuiQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7CCF4F80558; Thu, 21 Sep 2023 17:04:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 32D68F8025A;
	Thu, 21 Sep 2023 17:04:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 601A9F8025A; Thu, 21 Sep 2023 17:04:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C26F0F80125
	for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2023 17:03:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C26F0F80125
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=GQfJ8UMY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695308634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oo4GNctLz8Shf19nIoryBMjQyKRYmeTybgYDXDbksM4=;
	b=GQfJ8UMYKv46yIYlJv5tigFbHc0cc7U7UX0714JeO8zupajORR7/E1xo/XYAbkyE3oBk9t
	RjBuvG7odqghg+2Ngea267373gvcHruXV4k99eegTPVdqo+HJrLzqU2w+di4bepy5InHCg
	ij7IXN39K1Qltr4PmbUilCJaiIPWHWM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-679-hp6VtaakNtupnp-MguiVZA-1; Thu, 21 Sep 2023 11:03:47 -0400
X-MC-Unique: hp6VtaakNtupnp-MguiVZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7FF71C01EA3;
	Thu, 21 Sep 2023 15:03:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A56CC40C200E;
	Thu, 21 Sep 2023 15:03:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <87o7hvzn12.wl-tiwai@suse.de>
References: <87o7hvzn12.wl-tiwai@suse.de>
 <20230920222231.686275-1-dhowells@redhat.com>
 <20230920222231.686275-2-dhowells@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
    Al Viro <viro@zeniv.linux.org.uk>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Christoph Hellwig <hch@lst.de>,
    Christian Brauner <christian@brauner.io>,
    David Laight <David.Laight@ACULAB.COM>,
    Matthew Wilcox <willy@infradead.org>,
    Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
    linux-block@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
    Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
    Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
    Suren Baghdasaryan <surenb@google.com>,
    Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
    alsa-devel@alsa-project.org
Subject: Re: [PATCH v5 01/11] sound: Fix snd_pcm_readv()/writev() to use iov
 access functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <809185.1695308608.1@warthog.procyon.org.uk>
Date: Thu, 21 Sep 2023 16:03:28 +0100
Message-ID: <809186.1695308608@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Message-ID-Hash: SWKRTAWLTO3OC7MWOOHZQ7VYADG3HQIF
X-Message-ID-Hash: SWKRTAWLTO3OC7MWOOHZQ7VYADG3HQIF
X-MailFrom: dhowells@redhat.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SWKRTAWLTO3OC7MWOOHZQ7VYADG3HQIF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Takashi Iwai <tiwai@suse.de> wrote:

> Would you apply it through your tree, or shall I apply this one via
> sound git tree?

It's a prerequisite for a later patch in this series, so I'd prefer to keep it
with my other patches.

David

