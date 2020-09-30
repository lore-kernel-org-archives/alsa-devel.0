Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ADAC4727F
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:47:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B945C207F7
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aebjFu2A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjiTNGFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B945C207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2FA9018C8;
	Thu,  1 Oct 2020 15:46:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2FA9018C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601560025;
	bh=Fl0gWvmfXmejHi4EkMTsQTZGLiXma9CtfTHw7weRdJQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aebjFu2AOPR3jo/t2y46crAoLjTjHwuDKnlYuifvKtHywUJVkBLuZaZnQj45rhc21
	 tNJis4rUziGhF60AvXQ22WVoj+hUQmGwN6b7zK//ywrBeHJf5Hu9JmLMuRkUwZ2LEv
	 J1DvqHNnY7mymMWaf3SDCUFDYhysD3/4xM3/oDBc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65F71F80329;
	Thu,  1 Oct 2020 15:40:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 78B49F801ED; Wed, 30 Sep 2020 16:26:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6257AF800DF
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2020 16:26:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6257AF800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KjiTNGFe"
Received: from kernel.org (unknown [87.71.73.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4FE0F20754;
 Wed, 30 Sep 2020 14:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601475995;
 bh=Fl0gWvmfXmejHi4EkMTsQTZGLiXma9CtfTHw7weRdJQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KjiTNGFe5eTBdlXhF/NHplwtol5FYNLNxilPqKQv6JM7qzFpC1oscmHw8w7JZ6bPS
 DMKgScFLDkfuKtoCeOjffSJqprhEpbZkmUsXsiby6BhkBtcft1Fr0y1KDRK6Jmh86a
 QzcATOFg5nZHWWzlf7PwQmBO1ehMJBH5Itwvqrpk=
Date: Wed, 30 Sep 2020 17:26:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v4 22/52] docs: get rid of :c:type explicit declarations
 for structs
Message-ID: <20200930142624.GM2142832@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
 <f74a2b4e1c8c475b5a053f5edd9da5a818be4b1f.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f74a2b4e1c8c475b5a053f5edd9da5a818be4b1f.1601467849.git.mchehab+huawei@kernel.org>
X-Mailman-Approved-At: Thu, 01 Oct 2020 15:40:08 +0200
Cc: alsa-devel@alsa-project.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>, Tom Rix <trix@redhat.com>,
 linux-fpga@vger.kernel.org,
 =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
 linux-mm@kvack.org, Jonathan Corbet <corbet@lwn.net>,
 Satya Tangirala <satyat@google.com>, Eric Biggers <ebiggers@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>,
 linux-media@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-fscrypt@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Puranjay Mohan <puranjay12@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, "Alexander A. Klimov" <grandmaster@al2klimov.de>,
 Andrew Morton <akpm@linux-foundation.org>
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

On Wed, Sep 30, 2020 at 03:24:45PM +0200, Mauro Carvalho Chehab wrote:
> The :c:type:`foo` only works properly with structs before
> Sphinx 3.x.
> 
> On Sphinx 3.x, structs should now be declared using the
> .. c:struct, and referenced via :c:struct tag.
> 
> As we now have the automarkup.py macro, that automatically
> convert:
> 	struct foo
> 
> into cross-references, let's get rid of that, solving
> several warnings when building docs with Sphinx 3.x.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
...
>  Documentation/vm/ksm.rst                      |  2 +-
>  Documentation/vm/memory-model.rst             |  6 ++---
>  mm/ksm.c                                      |  2 +-
>  mm/memblock.c                                 |  4 ++--

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

>  30 files changed, 93 insertions(+), 93 deletions(-)
> 
