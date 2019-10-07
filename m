Return-Path: <SRS0=Jk6f=YA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF97DECE58D
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:17:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A753206C2
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dvzTm2nI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A753206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B54A1857;
	Mon,  7 Oct 2019 16:17:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B54A1857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570457870;
	bh=G5STUMb8Yjz+gXBAaL4ia6X29t7BQNa2YXm7WheQqH0=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dvzTm2nIrApZyVslpT8cChZau4fRaC29XJ9YDb6iSivlGCKl2kS6N9a+lP1XAQHro
	 m7SDZbfS1o8nH9zA8orR5jlddvfmFelzFMEqE4T0tMq4nrkKVRwYbRDP46svHue0TG
	 RXChKVYN0b+RuPY1Pue0y9zILfntyRB1LXqoD7Y4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DCE5F80137;
	Mon,  7 Oct 2019 16:17:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F04DEF802BE; Mon,  7 Oct 2019 16:16:58 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D077CF80137
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2019 16:16:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D077CF80137
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Oct 2019 07:16:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; d="scan'208";a="206419116"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.252.41.73])
 by fmsmga001.fm.intel.com with ESMTP; 07 Oct 2019 07:16:52 -0700
Date: Mon, 7 Oct 2019 16:16:51 +0200
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Jaroslav Kysela <perex@perex.cz>
Message-ID: <20191007141650.GA9384@ubuntu>
References: <20191006104715.GA14691@ubuntu>
 <7f7434ad-407b-002d-d2af-860ce49bae32@perex.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f7434ad-407b-002d-d2af-860ce49bae32@perex.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] what's the kernel policy WRT firmware parsing
 security?
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Jaroslav,

On Sun, Oct 06, 2019 at 04:10:28PM +0200, Jaroslav Kysela wrote:
> Dne 06. 10. 19 v 12:47 Guennadi Liakhovetski napsal(a):
> > Hi,
> > 
> > I decided to have a look at whether the ALSA topology parsing is bullet
> > proof against malformed topology files. It seems not quite to be the case.
> > At least I seem to have found a possibility of crashing the kernel by a
> > malformed topology file. I haven't tested it, so, maybe I'm wrong.
> > 
> > In principle, firmware files can only be written by root, and if you have
> > root access to the system, it's anyway doomed. Is this the approach and
> > we aren't really trying to make topology parsing 100% safe, or do we want
> > to fix any such possible parsing issues?
> 
> The kernel should not crash. Dot. If you found a serious issue, please,
> report it or better, send the fix.

Sorry, I'm still configuring / getting used to mutt and git send-mail on this
PC, so adding you to CC didn't work out :-/ Here's a link:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-October/156352.html

Thanks
Guennadi

> 				Thanks,
> 					Jaroslav
> 
> -- 
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
