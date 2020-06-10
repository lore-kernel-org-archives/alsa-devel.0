Return-Path: <SRS0=lC1U=7X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0264C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 07:18:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4871520829
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 07:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IlJ9yNfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4871520829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D839D15E4;
	Wed, 10 Jun 2020 09:17:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D839D15E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591773480;
	bh=nmcdEattGRG4Rcv0Ohh2Flc7pJOrXsmyEnaq1bib4Rg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IlJ9yNfCL4zNZgfRa3ztiNzr3yOgVGCIXeChmv17jaS8V1XqprhIj8nyMbx5MrHsW
	 zeRe0OmAYZG+WEdHqoRdQAZTdIRHUWiONCbBAaeXAybh5m0uySoXFhgA3r6zVOOgQK
	 bGpHEJ6o1F9Li7vXVmZCXOd/NJp3+F42wCOHQaRY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3812CF801F7;
	Wed, 10 Jun 2020 09:17:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2214FF8021C; Wed, 10 Jun 2020 09:14:21 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72F83F80088
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2020 09:14:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72F83F80088
Received: by verein.lst.de (Postfix, from userid 2407)
 id ADF4A68AEF; Wed, 10 Jun 2020 09:14:10 +0200 (CEST)
Date: Wed, 10 Jun 2020 09:14:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Rientjes <rientjes@google.com>
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
Message-ID: <20200610071410.GD1397@lst.de>
References: <20200520111136.GA3802@amd> <1591545088.74ii116nf2.none@localhost>
 <20200608061950.GA17476@lst.de> <1591624340.z01ejtod28.none@localhost>
 <alpine.DEB.2.22.394.2006081928070.148886@chino.kir.corp.google.com>
 <20200609054306.GA9606@lst.de>
 <alpine.DEB.2.22.394.2006092213110.154443@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006092213110.154443@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alsa-devel@alsa-project.org, x86@kernel.org, tiwai@suse.com,
 linux-kernel@vger.kernel.org, "Alex Xu \(Hello71\)" <alex_y_xu@yahoo.ca>,
 hch@infradead.org, mingo@redhat.com, bp@alien8.de, Pavel Machek <pavel@ucw.cz>,
 hpa@zytor.com, tglx@linutronix.de, Christoph Hellwig <hch@lst.de>
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

On Tue, Jun 09, 2020 at 10:26:45PM -0700, David Rientjes wrote:
> If this option should not implicitly be set for DMA_COHERENT_POOL, then I 
> assume we need yet another Kconfig option since DMA_REMAP selected it 
> before and DMA_COHERENT_POOL selects DMA_REMAP :)

Yes, but what do we actually need DMA_REMAP for just for the coherent
pool?  We shuldn't really remap anything for AMD-SEV.  Sorry for not
noticing this earlier.
