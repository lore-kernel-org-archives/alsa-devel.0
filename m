Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122FFC4727E
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D6520759
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jr+/liW1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGtpalEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D6520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A56C1905;
	Thu,  1 Oct 2020 18:10:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A56C1905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601568695;
	bh=2c7/G0BHUelca92OMnP/WolWI88qEFGEbnHAsBNWxAs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jr+/liW17IBGYs6VZCskeJTlVItAeiAwaRvp8WSoxSHt+S4V65UVv/I7VvenGS9Fe
	 qXZRbEdiMOuijAMz9w2/e7HKB3wHH7lVvvBz2rvzPUKxLR2aWg2MzgsmasLQRT4Ph2
	 sYzYHS4D2xlBd3QAP61sFPrPkYFJKsHsBbmd0okM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 628D1F801DB;
	Thu,  1 Oct 2020 18:10:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D021F801F5; Thu,  1 Oct 2020 18:10:42 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F1C2F801D8
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 18:10:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F1C2F801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pGtpalEJ"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE83620759;
 Thu,  1 Oct 2020 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601568629;
 bh=2c7/G0BHUelca92OMnP/WolWI88qEFGEbnHAsBNWxAs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pGtpalEJG2ym4H+/A3Kde9p0DxRD9gWuCNM5Sf9oD+mvtyUKMikhhfJY7uFs2/BtO
 xKFf9NiRIFkWpe6RL4gfBGqEkZ7PK4Pfj8EBc+pD8HgiWxTskX1DzKdGkDf/Jh9Xu3
 TPRUjM2SAZcjMd/CBWENGd/NSgMhVmenrKKheMuo=
Date: Thu, 1 Oct 2020 18:10:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Ertman, David M" <david.m.ertman@intel.com>
Subject: Re: [PATCH 0/6] Ancillary bus implementation and SOF multi-client
 support
Message-ID: <20201001161030.GA3196351@kroah.com>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <20201001071403.GC31191@kroah.com>
 <DM6PR11MB2841D2BF0E467EF34625BCF7DD300@DM6PR11MB2841.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB2841D2BF0E467EF34625BCF7DD300@DM6PR11MB2841.namprd11.prod.outlook.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tiwai@suse.de" <tiwai@suse.de>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>,
 "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "parav@nvidia.com" <parav@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
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

On Thu, Oct 01, 2020 at 03:55:46PM +0000, Ertman, David M wrote:
> I have also sent this patch set to netdev and linux-rdma mailing lists.

And not cc:ed us on it?  Wonderful, we will never see the review
comments, and the developers there will not see ours :(

{sigh}

greg k-h
