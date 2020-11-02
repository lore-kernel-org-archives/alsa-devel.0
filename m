Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEFCC2D0A3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:50:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03AEA2222B
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uXLLk+q8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cf1MSWB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AEA2222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90147178B;
	Tue,  3 Nov 2020 08:49:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90147178B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604389836;
	bh=jAq/Z8SL0B8yo1ovuOe22KMrwKRKb8HoLKSh4m+py5A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uXLLk+q8WmwopG1mkn6jbMqZV9XRoKY+pY5SmpFKoJF/f8pEudiFmdU2wNVbqd0Cx
	 vDU3q6hku5lFABo6qXv/5/eNiKy0QicIt982tLEx7AuNixM4cwN8tBGruF5zsR7DUI
	 BfAu2fgJqnjDM6koltPJVtWnufPEi+wK8MSiA/fw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72FD4F80507;
	Tue,  3 Nov 2020 08:45:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 615CEF80256; Mon,  2 Nov 2020 16:41:58 +0100 (CET)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9EFFF80232
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2020 16:41:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9EFFF80232
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="cf1MSWB7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=UmWNoo+0jio1rsbpATbpnTKOP6YpDT2+8aHnhsn1BNQ=; b=cf1MSWB7BC+d/XGfBcQ2kzWTKP
 Peh8sMqwcaL1avawa0skij5vzCJuMhLjyf5+3duC9LV64xK5h7mYlExaCNl16g5xIgy0XYatg9Kkf
 8MzQdAQ7nqnViyK6PC8RcELKGC+j9GZJ7ckJm169iVg6QlV5ggKqdv+lcQqqbrPMl+FlSrL0fJtVH
 h3aIS4VO2YSOq9iZcZt7+s5WtKwHYRjz80MESyljeOHnTABAzm0KwnO67EhkQGqAYQ3ow0H2PyBl3
 OZ6Wcz1eC4cFYhDOYdlGwsV1WdJGKy68/ZW9RvzSJwxRicr1Ax69ZJI0224mH0dP7B11Lada3H09n
 ylAgZRSA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1kZbx7-0002Pe-5d; Mon, 02 Nov 2020 15:41:01 +0000
Date: Mon, 2 Nov 2020 15:41:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 1/8] mm: slab: provide krealloc_array()
Message-ID: <20201102154101.GO27442@casper.infradead.org>
References: <20201102152037.963-1-brgl@bgdev.pl>
 <20201102152037.963-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102152037.963-2-brgl@bgdev.pl>
X-Mailman-Approved-At: Tue, 03 Nov 2020 08:45:21 +0100
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
 Gustavo Padovan <gustavo@padovan.org>,
 Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 David Rientjes <rientjes@google.com>,
 virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>,
 linux-media@vger.kernel.org, Robert Richter <rric@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 linux-gpio@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 netdev@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
 James Morse <james.morse@arm.com>, Daniel Vetter <daniel@ffwll.ch>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, Nov 02, 2020 at 04:20:30PM +0100, Bartosz Golaszewski wrote:
> +Chunks allocated with `kmalloc` can be resized with `krealloc`. Similarly
> +to `kmalloc_array`: a helper for resising arrays is provided in the form of
> +`krealloc_array`.

Is there any reason you chose to `do_this` instead of do_this()?  The
automarkup script turns do_this() into a nice link to the documentation
which you're adding below.

Typo 'resising' resizing.
