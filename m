Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B224EC433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:52:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BFBC206BE
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ff5VkT+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFBC206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shiny.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A309A167E;
	Wed,  1 Jul 2020 16:51:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A309A167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593615169;
	bh=Dq5whM44wnWttBYmnnVvlJ7we8oy330ugPRIjJO/KzU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ff5VkT+81vl9Ax7NOetmrd8nT5qwnNXBuWxdCp8szVACTnBrGf572F2Gi6mHx6Qk2
	 C3b2Ri4eNp9tFeHX7z61aLEaMMybKtomVIF0ga0PveeaKtdGb14LXRz7//BrxsxN0r
	 UJiz1UiKV1P7zgiO/3rB+VrEUfosxjahVSWu6zLU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21DB4F8020C;
	Wed,  1 Jul 2020 16:51:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B8F3F80217; Wed,  1 Jul 2020 16:51:57 +0200 (CEST)
Received: from denise.shiny.it (denise.shiny.it [185.206.84.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBE14F801D8
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 16:51:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBE14F801D8
Received: from wc1 (localhost [127.0.0.1])
 by denise.shiny.it (8.15.2/8.15.2) with ESMTP id 061Epi5m022388;
 Wed, 1 Jul 2020 16:51:45 +0200
Date: Wed, 1 Jul 2020 16:51:51 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: Mark Hills <mark@xwax.org>
Subject: Re: [PATCH 3/3] echoaudio: Address bugs in the interrupt handling
Message-ID: <20200701165035.2be3cb2e@wc1>
In-Reply-To: <2007011320590.17595@stax.localdomain>
References: <2006161409060.30751@stax.localdomain>
 <20200616131743.4793-3-mark@xwax.org> <20200617000134.60c5e2b5@wc1>
 <2006171158070.2561@stax.localdomain> <20200619215655.07b6f3ed@wc1>
 <2006192200200.12984@tamla.localdomain>
 <20200629000139.0212fa11@wc1>
 <2007011320590.17595@stax.localdomain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
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

On Wed, 1 Jul 2020 13:25:07 +0100 (BST)
Mark Hills <mark@xwax.org> wrote:

> On Mon, 29 Jun 2020, Giuliano Pochini wrote:
> 
> > Since I could not reproduce that problem before, except in some rare 
> > random circumstances, I'm not a good tester at all. At most I can say 
> > that your patch does not make things worse :)
> 
> What software are you using on the device, and are you using x86_64 and 
> dmix?
> 
> I think some issues might be exaggerated by dmix which has a unique way
> of opening the device several times. And then chromium exercises dmix a
> lot with all of its threads/forks. That would I presume be how it
> exercises races between pcm_pointer and interrupts.

x86_64 now. When I wrote the driver I had a powermac. I also can test it on
a x86_32 laptop with an Indigo-IO card.

I tested both plughw and dmix, but I don't use the latter often.


-- 
Giuliano.
