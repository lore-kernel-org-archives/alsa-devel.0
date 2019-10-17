Return-Path: <SRS0=vl9c=YK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14102ECE58E
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:23:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1309220872
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XxAVJDwz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gtWpIetf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1309220872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A70FD1686;
	Thu, 17 Oct 2019 17:22:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A70FD1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571325801;
	bh=7cGuKmxrCNWIzhUIDRl77KQRUiMWEijzJONQy+GJckI=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XxAVJDwzHOD65a2jPH86JERgcZT1bWB6XICLC83PXXkdFke1Bg2cGgwivXOh9UMp1
	 NHNr4IKJ1gCmOiF07kFEjfKfH9O+bKUPyMRvmzOVsuqQi1sGeaXcdhlcP6lhjDJU+/
	 jMYL9jlBKDuOLsKow9uY3kvy2/c4SwzyxLVkRxfo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 144A3F804A9;
	Thu, 17 Oct 2019 17:22:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4FA7BF804AA; Thu, 17 Oct 2019 17:22:28 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8109F80276
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2019 17:22:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8109F80276
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="gtWpIetf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BhyZS7+sRv/JZoP4+6IBFbCyglVKgcF0rn92fjDmAO4=; b=gtWpIetf0FkX1pIJJ0IwoGVv1
 HsDLDA4LxEH/3ehgYeE2v/v4db7yQfFqttcJ3hZn40dmLYr7HcSeUIEDeiJ+SXdj6qWTsJDunTnJW
 UsVMf/lRaXRA6k+XOkmMYFfQ7ql2huqjvy76X4Ss6lAckL+3wwNBjXoTscIdmn7FZiz5en14jen27
 JMuybt8YtEWBjpZhLazYG0NlpASIKyzP0/YxdSi/9XBgUOIlAkuqw7PKFPdQJK0ouTyQSzShFMFkD
 9OvxDkSoKwSmw2Ygq9z9CN/k/9Icn8f2HccjIUmvMMzz9uZIagfqbuxRB3y3XfxsVL8Aq6+H9pp6x
 DFbYCt2dA==;
Received: from [2601:1c0:6280:3f0::9ef4]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iL7bW-0005jG-JK; Thu, 17 Oct 2019 15:22:19 +0000
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20191017152645.65892c78@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e8994e88-bdab-b3be-d62f-550ce9f2c76d@infradead.org>
Date: Thu, 17 Oct 2019 08:22:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017152645.65892c78@canb.auug.org.au>
Content-Language: en-US
Cc: Vinod Koul <vkoul@kernel.org>,
 moderated for non-subscribers <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] linux-next: Tree for Oct 17 (soundwire)
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 10/16/19 9:26 PM, Stephen Rothwell wrote:
> Hi all,
> =

> Changes since 20191016:
> =


on x86_64:

# CONFIG_BLOCK is not set

  CC [M]  drivers/soundwire/intel_init.o
In file included from ../drivers/soundwire/intel_init.c:12:0:
../include/linux/iomap.h: In function =91iomap_sector=92:
../include/linux/iomap.h:76:48: error: =91SECTOR_SHIFT=92 undeclared (first=
 use in this function); did you mean =91SECTIONS_SHIFT=92?
  return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
                                                ^~~~~~~~~~~~
                                                SECTIONS_SHIFT


-- =

~Randy
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
