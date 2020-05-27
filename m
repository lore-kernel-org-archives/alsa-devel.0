Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9492AC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 22:15:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157AF206F1
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 22:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Zkk3R2fC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk header.b="dp4TY0Xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157AF206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xwax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 619A5177C;
	Thu, 28 May 2020 00:14:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 619A5177C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590617744;
	bh=h9Keft9rxq8QEdeI6xkE1rOwePFqbTe1qDlzIjvngMo=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Zkk3R2fCnTXVZHGvFN4CN9taR1OVin82+FyY/x1kKixUUZLeLPK26CI0vcygP2jzx
	 EcSVkfrzZfqiATIqaeI1pl1ays7SeT6djr1GdLG8wvRSl+6ArygSGeIvpIv/EKnLkp
	 n36oaaQ1tbZboc2hQwqmZ8RHThWY0sEKYJ0S2lBk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5BC9F80149;
	Thu, 28 May 2020 00:14:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 374C6F8014E; Thu, 28 May 2020 00:14:52 +0200 (CEST)
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79EC3F80146
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2020 00:14:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79EC3F80146
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk
 header.b="dp4TY0Xm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
 ; s=a;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
 Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N6QHx9jPI4eQBojV9Nn3Cu/F3pf2O6BvRqMRwDc0Hoc=; b=dp4TY0XmIhSV8PIlGEAEmh6r0o
 VKhGlw/tc5lvIKQ69zVHV2kXnm2vw8JpyBdr2L5X0ANHBgkq3QHMx6leWQfx0QymOSAgxTlsscYfk
 x2WjQlxDumrwgY0MZfMVlRA1O8sEsRsqdD/Fl4E+b6rUMsj34kBlRr0VdV5BjrYX8nSzVDcGJcbGf
 111MRGOmkrDz+juybXettlXWvof39yylvbjlrkkFFlp8yInBEZoU+u9RyD5fE7dq70vbRPy2f3YH9
 FAQJBZlHO8Rk6xRkFRd8bhRgBHkaQNXOIubH6J8bXBNdrGRAeHTvGhvKPIYxE2s5MzQTiZabWqx3B
 9j+7zJYw==;
Received: from cpc1-hari17-2-0-cust102.20-2.cable.virginm.net ([86.18.4.103]
 helo=stax.localdomain) by jazz.pogo.org.uk with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93.0.4 (FreeBSD))
 (envelope-from <mark@xwax.org>) id 1je4Jy-000GMv-2z
 for alsa-devel@alsa-project.org; Wed, 27 May 2020 23:14:46 +0100
Received: from mark (helo=localhost)
 by stax.localdomain with local-esmtp (Exim 4.84)
 (envelope-from <mark@xwax.org>) id 1je4Jx-0000al-Q4
 for alsa-devel@alsa-project.org; Wed, 27 May 2020 23:14:45 +0100
Date: Wed, 27 May 2020 23:14:45 +0100 (BST)
From: Mark Hills <mark@xwax.org>
To: alsa-devel@alsa-project.org
Subject: alsa-lib: mmap API disables blocking I/O or sw_params
Message-ID: <2005272214510.31320@stax.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

I'm swapping out a vanilla loop based on RW_INTERLEAVED for 
MMAP_INTERLEAVED, to reduce memory copies:

The equivalent code becomes:

  snd_pcm_avail_update()
  snd_pcm_mmap_begin()
  snd_pcm_mmap_commit()

but what I find no longer works:

* Blocking I/O: it's necessary to make explicit calls to snd_pcm_wait()  
  with syscall overhead of poll()

* Automatic start (and perhaps others): so I have to count the frames 
  committed and call snd_pcm_start() explicitly.

I don't think these are conceptually incompatible with mmap, so is this 
the intended behaviour and an important omission from the docs? Or is the 
mmap API not widely used and I'm stumbling on bugs?

-- 
Mark
