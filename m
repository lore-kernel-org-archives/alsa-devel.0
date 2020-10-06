Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EDFC41604
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:36:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A7120789
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BdRKkBWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A7120789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5ED2516F5;
	Tue,  6 Oct 2020 20:35:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5ED2516F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602009407;
	bh=6EjkHWRzIa7ntF7uZhx8Q3cUQtg/j+CNm6E74HoeoaQ=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BdRKkBWEpgXRUzEl5pStD1yD0nqz9fVRqelQvh1y3MXEHKc2+F7poyii5jQJYB7BK
	 Bw1rvjT8a/i2ZBcTUEZO4+oPFithfqCx8vrG4ZX7/EB03Ebvi+t5s+JQReSuk7Id5X
	 GARNFonUlQDnBRCn42oWyvgU15GMMUZR4Ih7Is/k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6A6FF80127;
	Tue,  6 Oct 2020 20:35:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57414F8012C; Tue,  6 Oct 2020 20:35:52 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43231F80128
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 20:35:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43231F80128
IronPort-SDR: AixmMvffFBRVFz6GJuK3FL8Oy5gAMC7onymo0DNR+fJ7RIKq4STJBwhnQ9DZrNpu9P+9nviCxv
 oHg+TIHMm8YQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="228763410"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; d="scan'208";a="228763410"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 11:35:39 -0700
IronPort-SDR: HdVbTfOcjG7elY9ZVtCoWq9nW0ZjwMAp5bPyeduGT8Mjh9db+f0whfYbGxf58u6omlQg1uyODo
 yQKoLlPmb9mA==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; d="scan'208";a="342429016"
Received: from unknown (HELO rsridh2-mobl1) ([10.212.228.88])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 11:35:36 -0700
Message-ID: <cb6e2b44e396a6281e12b21253775b9cccf6784d.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/6] Add ancillary bus support
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Leon Romanovsky <leon@kernel.org>, Parav Pandit <parav@nvidia.com>
Date: Tue, 06 Oct 2020 11:35:35 -0700
In-Reply-To: <20201006172650.GO1874917@unreal>
References: <20201005182446.977325-1-david.m.ertman@intel.com>
 <20201005182446.977325-2-david.m.ertman@intel.com>
 <20201006071821.GI1874917@unreal>
 <b4f6b5d1-2cf4-ae7a-3e57-b66230a58453@linux.intel.com>
 <20201006170241.GM1874917@unreal>
 <BY5PR12MB43228E8DAA0B56BCF43AF3EFDC0D0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201006172650.GO1874917@unreal>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "parav@mellanox.com" <parav@mellanox.com>, "tiwai@suse.de" <tiwai@suse.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Dave Ertman <david.m.ertman@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "fred.oh@linux.intel.com" <fred.oh@linux.intel.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "broonie@kernel.org" <broonie@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kiran.patil@intel.com" <kiran.patil@intel.com>
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

On Tue, 2020-10-06 at 20:26 +0300, Leon Romanovsky wrote:
> On Tue, Oct 06, 2020 at 05:09:09PM +0000, Parav Pandit wrote:
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Tuesday, October 6, 2020 10:33 PM
> > > 
> > > On Tue, Oct 06, 2020 at 10:18:07AM -0500, Pierre-Louis Bossart
> > > wrote:
> > > > Thanks for the review Leon.
> > > > 
> > > > > > Add support for the Ancillary Bus, ancillary_device and
> > > > > > ancillary_driver.
> > > > > > It enables drivers to create an ancillary_device and bind
> > > > > > an
> > > > > > ancillary_driver to it.
> > > > > 
> > > > > I was under impression that this name is going to be changed.
> > > > 
> > > > It's part of the opens stated in the cover letter.
> > > 
> > > ok, so what are the variants?
> > > system bus (sysbus), sbsystem bus (subbus), crossbus ?
> > Since the intended use of this bus is to
> > (a) create sub devices that represent 'functional separation' and
> > (b) second use case for subfunctions from a pci device,
> > 
> > I proposed below names in v1 of this patchset.
> > 
> > (a) subdev_bus
> 
> It sounds good, just can we avoid "_" in the name and call it subdev?
> 
> > (b) subfunction_bus

While we're still discussing names, may I also suggest simply "software
bus" instead?

Thanks,Ranjani

