Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C8CC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:19:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2D120791
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EPFPQ/cE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk header.b="Gpzf8ril"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2D120791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xwax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD8B71766;
	Tue, 23 Jun 2020 13:19:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD8B71766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592911191;
	bh=CMpGWz26CAcT6dyOZAokKDYB0Bpny6Zdx93NbMLM2y0=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EPFPQ/cELd5QmgL7fF5riisYzCBTHC/kH9CY0/kCEL43OmY04QV44Xp/Ot9Lxc+ZE
	 duwnCDF5NUsYj1ThbfTMD0thaye03JsZdUBbP42ybjFeXXaH7K7C1eif6KHCFKqGDU
	 6v5heeXVg0v6pUMXLGN5q7WYGfgMMK/fXouyzX5Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42D82F80218;
	Tue, 23 Jun 2020 13:19:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0FCD6F80234; Tue, 23 Jun 2020 13:19:00 +0200 (CEST)
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22100F800B2
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 13:18:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22100F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk
 header.b="Gpzf8ril"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
 ; s=a;
 h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:Subject:
 cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t0gLWy+AW8thWNeEhEHNZSLqqJiIKyFaYHgDar6IH/0=; b=Gpzf8ril+xRIn/20EaE8fYiH4j
 rUjJwpSbtAT6H6cZYIYTrbfKnZThWWFyOQZ9g6ciBwGeSyn2PInDIKJrBAXnX3GO1P7akUNrQZvO+
 fxl16n9t3cSnD1jdJQbymyD2KNMIGx82ghFpjuUaIaWwd5NNLrFuUuu+MiTtXisAahD551/mFnrSk
 Dw6kMDzEi2pnbQaf5CbJUNq90+RyWbttkKJVm3wRfvd2UUBckdocmc1hLpbf4W29xBLKzO5RSjLX0
 dUOscO4oBSF2bxpQ4fW6Z1LUTWfDfki+bKybDQcI3TosGGsSnc/JgKZsb/WTBn2uhWL+fQ9HbMwrY
 v5FpSL/A==;
Received: from cpc1-hari17-2-0-cust102.20-2.cable.virginm.net ([86.18.4.103]
 helo=stax.localdomain) by jazz.pogo.org.uk with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94 (FreeBSD))
 (envelope-from <mark@xwax.org>)
 id 1jngx0-000Ecd-Ej; Tue, 23 Jun 2020 12:18:50 +0100
Received: from mark (helo=localhost)
 by stax.localdomain with local-esmtp (Exim 4.84)
 (envelope-from <mark@xwax.org>)
 id 1jngwz-0001GQ-Pc; Tue, 23 Jun 2020 12:18:49 +0100
Date: Tue, 23 Jun 2020 12:18:49 +0100 (BST)
From: Mark Hills <mark@xwax.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 3/9] conf: Read a host-specific asoundrc
In-Reply-To: <s5hbllaoxwk.wl-tiwai@suse.de>
Message-ID: <2006231204280.1412@stax.localdomain>
References: <2006221356390.20421@stax.localdomain>
 <20200622131515.23385-3-mark@xwax.org> <s5hbllaoxwk.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org
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

On Tue, 23 Jun 2020, Takashi Iwai wrote:

> On Mon, 22 Jun 2020 15:15:09 +0200,
> Mark Hills wrote:
> > 
> > On systems with a network mounted home directory this is thoroughly
> > useful to allow for a core set of asoundrc settings, but with different
> > settings on different hosts.
> > 
> > It's not possibly to implement this in our own asoundrc or local
> > customisation, as it's too late. The installation file must be modified.
> > 
> > This is similar to ~/.Xdefaults-* on some systems.
> > 
> > Signed-off-by: Mark Hills <mark@xwax.org>
> 
> This kind of change popping up sometimes in the past, too, and I have
> a mixed feeling whether to take such a change globally or not.
> 
> In one side, it can work, but OTOH, if you can deal with that detail,
> you're certainly able to set up the environment variable easily, too.

I'm happy for a concern to be raised.

Can you clarify, which environment variable?

I wasn't aware it was possible to override asoundrc with an environment 
variable, until I looked up just now and found ALSA_CONFIG_PATH in the 
code.

Though I do have vague recollection of trying this some years ago. I think 
perhaps I ad issues using it to read other config files. I will re-visit 
when I have time.

FYI To solve my development work, I have:

  ~/.asoundrc      --  my personal settings
  ~/.asoundrc-xxx  --  host specific settings

and I must read both, in that order.

-- 
Mark
