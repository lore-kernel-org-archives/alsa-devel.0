Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA90C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 10:17:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146C420760
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 10:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="X4uRiulw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk header.b="QrlNy11Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146C420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xwax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 963A91665;
	Wed,  8 Jul 2020 12:16:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 963A91665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594203436;
	bh=vWVr5dhar1Gs0TslgM3QjLCek3oqcOWlW9ntQCj+lFU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X4uRiulwTp4MJ/0cHTyTvGI5dWf6GDBsd4+y9UM6id9h13CsmRdc7tCQFJ28KYbiS
	 AO8jU3b5RKxeid6Xm8LaMk916xQ/huVpE33DjrI8sKzbyhnw1hmbhH0p1jMJxmymIx
	 Xf03ov6Nr72iLoGYG188C6enVVaVD8N3Gb5jTSFI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CE81F80150;
	Wed,  8 Jul 2020 12:16:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCE27F8015A; Wed,  8 Jul 2020 12:16:24 +0200 (CEST)
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1B98F8011F
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 12:16:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1B98F8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk
 header.b="QrlNy11Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
 ; s=a;
 h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:Subject:
 cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7gYwUkTyCqQoMt3LJUKj6v5JoZDtza2N+qN0RUSqeOU=; b=QrlNy11YqmxHDaSWel0WsIxzWf
 M6FkJu0SQ4UbBstwT8p2nGLlwUdDLMNYgSJh5uuOPoBMFsWqN+evo9OyqdsrHQq4/PI5XsM//nzYU
 L9nD9kMIhu6U0sNVrHFhB7EfMDW1Krgm46uZs10zwFgbnhuy/BHjqvL1LpR2MBnmN2hu3ZDktzkBf
 EaTBou+VQIfFSooQF/j4vvDtcyRc9kkrlCl7yO33J2OQSgNmIpDfwqL+AEBon7hv6SdxNJHLkLM9Z
 LdiSu5uhDTErPudsp5oA8O8YDbKj6nrJm27FKubeqTnyqE28SNmeZ+EV6Ibi4keWYq/eWN25Wrblx
 mdHq3lng==;
Received: from cpc1-hari17-2-0-cust102.20-2.cable.virginm.net ([86.18.4.103]
 helo=stax.localdomain) by jazz.pogo.org.uk with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94 (FreeBSD))
 (envelope-from <mark@xwax.org>)
 id 1jt77k-0002PP-C2; Wed, 08 Jul 2020 11:16:20 +0100
Received: from mark (helo=localhost)
 by stax.localdomain with local-esmtp (Exim 4.84)
 (envelope-from <mark@xwax.org>)
 id 1jt77j-0000rI-Oq; Wed, 08 Jul 2020 11:16:20 +0100
Date: Wed, 8 Jul 2020 11:16:19 +0100 (BST)
From: Mark Hills <mark@xwax.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 1/4] echoaudio: Race conditions around "opencount"
In-Reply-To: <s5hr1tnenkv.wl-tiwai@suse.de>
Message-ID: <2007081115280.3085@stax.localdomain>
References: <20200701122723.17814-1-mark@xwax.org>
 <202007020108.pW8giznF%lkp@intel.com> <2007021037270.2435@stax.localdomain>
 <s5hr1tnenkv.wl-tiwai@suse.de>
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

On Tue, 7 Jul 2020, Takashi Iwai wrote:

> On Thu, 02 Jul 2020 11:53:51 +0200,
> Mark Hills wrote:
> > 
> > Takashi, my apologies, it looks like this patch broke the build of the 
> > Mona driver.
> > 
> > Thankfully the change is simple, as it just looks like a bit of confusion 
> > of responsibilies in the code for the Mona interface; the correct fix is 
> > to remove the code.
> > 
> > That is a lesson for working with only the echo3g driver enabled. Now I 
> > have done a full build of all echoaudio drivers, with no warnings or 
> > errors.
> > 
> > Here's a patch, or it can be squashed into the original patch if 
> > necessary.
> 
> Could you rather fold the fix into the patch and resubmit the whole
> patch set?  I'm just back from travel, and it'd be better anyway if I
> receive a fresh patch set to apply.

No problem, I'll follow up.

In the end, I decided it best to keep the patch separate, but re-order so 
as to not break the build.

-- 
Mark
