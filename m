Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3235CC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 25 May 2022 21:52:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C44FC16A9;
	Wed, 25 May 2022 23:51:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C44FC16A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653515520;
	bh=RJBqCEbCNY0ooTTHUDW8T5ccFZ9a+R65ZzhmVt+2S44=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fp+IKC3y88HvoJ1NRqqU4TL8sxmNEXIYD8sMQqsFisKYMAlcUqfk/gsnW0J/b4S5w
	 SYXRQmKW9lrQhrEr6SaiIXbfpjdSc5M4gDYn3iFYZUXQ8ZLbbNPdFfW8ueP2UieM2n
	 I33nGwnzJITcy6ZKUZOL+pie6GdR7zTn/uWOqQ7o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57019F80116;
	Wed, 25 May 2022 23:51:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5948F8016D; Wed, 25 May 2022 23:51:08 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DF41F80116
 for <alsa-devel@alsa-project.org>; Wed, 25 May 2022 23:51:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DF41F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.b="R8xzes5U"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EA7F761AB6;
 Wed, 25 May 2022 21:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68EFC385B8;
 Wed, 25 May 2022 21:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1653515457;
 bh=RJBqCEbCNY0ooTTHUDW8T5ccFZ9a+R65ZzhmVt+2S44=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=R8xzes5UjWb8BqqxzRNWgPf7cEHyaAbeSDj+v3F0k3sq8Asguyz6Vmo/uMlX6uzmY
 8HryaeniW2c258rIiLOGG2MjKsnv6NbBuzhNNsrGT4ET41NSmI5sqMNPKOc8It7ZVv
 QGSPkTQx3i5p9WrHix2LggCVXiwA2BU9p5l/o92c=
Date: Wed, 25 May 2022 14:50:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 8cb8311e95e3bb58bd84d6350365f14a718faa6d
Message-Id: <20220525145056.953631743a4c494aabf000dc@linux-foundation.org>
In-Reply-To: <628ea118.wJYf60YnZco0hs9o%lkp@intel.com>
References: <628ea118.wJYf60YnZco0hs9o%lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-fbdev@vger.kernel.org, linux-parport@lists.infradead.org,
 kvm@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-staging@lists.linux.dev, alsa-devel@alsa-project.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-omap@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Thu, 26 May 2022 05:35:20 +0800 kernel test robot <lkp@intel.com> wrote:

> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 8cb8311e95e3bb58bd84d6350365f14a718faa6d  Add linux-next specific files for 20220525
> 
> Error/Warning reports:
> 
> ...
>
> Unverified Error/Warning (likely false positive, please contact us if interested):

Could be so.

> mm/shmem.c:1948 shmem_getpage_gfp() warn: should '(((1) << 12) / 512) << folio_order(folio)' be a 64 bit type?

I've been seeing this one for a while.  And from this report I can't
figure out what tool emitted it.  Clang?

>
> ...
>
> |-- i386-randconfig-m021
> |   `-- mm-shmem.c-shmem_getpage_gfp()-warn:should-((()-)-)-folio_order(folio)-be-a-bit-type

If you're going to use randconfig then shouldn't you make the config
available?  Or maybe quote the KCONFIG_SEED - presumably there's a way
for others to regenerate.

Anyway, the warning seems wrong to me.


#define PAGE_SIZE               (_AC(1,UL) << PAGE_SHIFT)

#define BLOCKS_PER_PAGE  (PAGE_SIZE/512)

	inode->i_blocks += BLOCKS_PER_PAGE << folio_order(folio);

so the RHS here should have unsigned long type.  Being able to generate
the cpp output would be helpful.  That requires the .config.

