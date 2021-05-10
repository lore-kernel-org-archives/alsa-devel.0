Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38374C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 09:10:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F566157F
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 09:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F566157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79FC3828;
	Tue, 11 May 2021 11:09:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79FC3828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620724205;
	bh=4rRsS5KRH4MOyCTnzUxn/ytiwuxMFCoJ22aKEJrmc/Y=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tt4J5RG+3MLDQT+jL+maXJZBtwhvtR3n6jc/hADCqCOgR4fjZMTUwcRvAK4V0A8Q2
	 QIQz7y6nGIMviowPZubJ/XeZjYVSnFMdcBJL3XVZfolOFO9oVkaRnCT+U0qXdA++nK
	 FZxlG2KzuMDbmYOjAORg6XWdeFh8h6+kUwrfzvao=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBA4CF80245;
	Tue, 11 May 2021 11:08:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4FDF7F80240; Mon, 10 May 2021 21:22:12 +0200 (CEST)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 618DCF800EA
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 21:22:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 618DCF800EA
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net
 [72.74.133.215]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14AJM3dI013584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 May 2021 15:22:05 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id F267215C3CD9; Mon, 10 May 2021 15:22:02 -0400 (EDT)
Date: Mon, 10 May 2021 15:22:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 00/53] Get rid of UTF-8 chars that can be mapped as ASCII
Message-ID: <YJmH2irxoRsyNudb@mit.edu>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
 <20210510135518.305cc03d@coco.lan>
 <de6d1fa5b7934f4afd61370d9c58502bef588466.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de6d1fa5b7934f4afd61370d9c58502bef588466.camel@infradead.org>
X-Mailman-Approved-At: Tue, 11 May 2021 11:08:22 +0200
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-iio@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org,
 dri-devel@lists.freedesktop.org, keyrings@vger.kernel.org,
 linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, x86@kernel.org,
 linux-acpi@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-input@vger.kernel.org, linux-ext4@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-sgx@vger.kernel.org,
 coresight@lists.linaro.org, rcu@vger.kernel.org,
 mjpeg-users@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-rdma@vger.kernel.org, linux-integrity@vger.kernel.org
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

On Mon, May 10, 2021 at 02:49:44PM +0100, David Woodhouse wrote:
> On Mon, 2021-05-10 at 13:55 +0200, Mauro Carvalho Chehab wrote:
> > This patch series is doing conversion only when using ASCII makes
> > more sense than using UTF-8. 
> > 
> > See, a number of converted documents ended with weird characters
> > like ZERO WIDTH NO-BREAK SPACE (U+FEFF) character. This specific
> > character doesn't do any good.
> > 
> > Others use NO-BREAK SPACE (U+A0) instead of 0x20. Harmless, until
> > someone tries to use grep[1].
> 
> Replacing those makes sense. But replacing emdashes — which are a
> distinct character that has no direct replacement in ASCII and which
> people do *deliberately* use instead of hyphen-minus — does not.

I regularly use --- for em-dashes and -- for en-dashes.  Markdown will
automatically translate 3 ASCII hypens to em-dashes, and 2 ASCII
hyphens to en-dashes.  It's much, much easier for me to type 2 or 3
hypens into my text editor of choice than trying to enter the UTF-8
characters.  If we can make sphinx do this translation, maybe that's
the best way of dealing with these two characters?

Cheers,

					- Ted
