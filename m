Return-Path: <SRS0=HcWj=ED=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671CBC4363A
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:16:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C65208C7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vQBpfIqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C65208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC4F7169D;
	Wed, 28 Oct 2020 09:15:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC4F7169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603872978;
	bh=TKvqJLlkLbq3Kj5f1V4maIueIwHzwDwk5+8EMQJmvPA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vQBpfIqhS/XwBj2buqumXBJ6YLBfvxTzeRwgrg+mWtXeQHtJ38CVVXwFw8ks5vGXg
	 detmNB/JKPntwN6Vm1GRzHduelLW7V9zs1csTSiih0IIbBLCb7Cc4AcZh6upl8nJ3p
	 d5MbE86j4QPfU2AMQyjUI2bfaW7orRIeYqU6srSg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2A16F80567;
	Wed, 28 Oct 2020 09:07:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5AF90F80212; Wed, 28 Oct 2020 04:26:29 +0100 (CET)
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by alsa1.perex.cz (Postfix) with ESMTP id 2FD04F800FF
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2020 04:26:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FD04F800FF
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id A654929A58;
 Tue, 27 Oct 2020 23:26:19 -0400 (EDT)
Date: Wed, 28 Oct 2020 14:26:12 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Tom Rix <trix@redhat.com>
Subject: Re: [RFC] clang tooling cleanups
In-Reply-To: <20201027164255.1573301-1-trix@redhat.com>
Message-ID: <alpine.LNX.2.23.453.2010281344120.31@nippy.intranet>
References: <20201027164255.1573301-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Wed, 28 Oct 2020 09:06:30 +0100
Cc: alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-rtc@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, qat-linux@intel.com, amd-gfx@lists.freedesktop.org,
 clang-built-linux@googlegroups.com, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org
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


On Tue, 27 Oct 2020, trix@redhat.com wrote:

> This rfc will describe
> An upcoming treewide cleanup.
> How clang tooling was used to programatically do the clean up.
> Solicit opinions on how to generally use clang tooling.
> 

This tooling is very impressive. It makes possible an idea that I had a 
while ago, to help make code review more efficient. It works like this. 

Suppose a patch, p, is the difference between the new tree, n, and the old 
tree, o. That is, p = n - o.

Now let clang-tidy be the transformation 't'. This gets you a much more 
readable patch submission, P = t(n) - t(o).

The only difficulty is that, if I submit P intead of p then 'git am' will 
probably reject it. This is solved by a little tooling around git, such 
that, should a patch P fail to apply, the relevant files are automatically 
reformatted with the officially endorsed transformation t, to generate a 
minimal cleanup patch, such that P can be automatically applied on top.

If the patch submission process required* that every patch submission was 
generated like P and not like p, it would immediately eliminate all 
clean-up patches from the workload of all reviewers, and also make the 
reviewers' job easier because all submissions are now formatted correctly, 
and also avoid time lost to round-trips, such as, "you can have a 
reviewed-by if you respin to fix some minor style issues".

* Enforcing this, e.g. with checkpatch, is slightly more complicated, but 
it works the same way: generate a minimal cleanup patch for the relevant 
files, apply the patch-to-be-submitted, and finally confirm that the 
modified files are unchanged under t.
