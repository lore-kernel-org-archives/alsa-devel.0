Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C126EC2D0BF
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:49:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D98A206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RqXsxgDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D98A206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6450016BB;
	Tue, 10 Dec 2019 16:48:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6450016BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575992945;
	bh=44IdxZv+H74wxJzWG0FU2KydZSDctuox4kRlUQPDydU=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RqXsxgDlv1AeFOFpT3LpiRxwCHYk6FlAnRtFdYfH5BSnwUQl0iAPX0eYdLm8UqG7L
	 BDsTL5cdnteRy4LsGaGV8eyG8TCh/aF3wDmDklykYQK4WzAyN+HiZaARqh94y//2+L
	 YBdOcDBaiMJ50C50i4TxwHiKGEhNQ8wiezBGt0/o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D615DF800B4;
	Tue, 10 Dec 2019 16:46:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50B08F80265; Tue, 10 Dec 2019 16:46:53 +0100 (CET)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net
 [83.223.78.240])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B373EF801D8
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 16:46:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B373EF801D8
Received: from h08.hostsharing.net (h08.hostsharing.net
 [IPv6:2a01:37:1000::53df:5f1c:0])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "*.hostsharing.net",
 Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
 by bmailout2.hostsharing.net (Postfix) with ESMTPS id D29CC2801A03E;
 Tue, 10 Dec 2019 16:46:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 7B3DC973; Tue, 10 Dec 2019 16:46:49 +0100 (CET)
Date: Tue, 10 Dec 2019 16:46:49 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Message-ID: <20191210154649.o3vsqzrtofhvcjrl@wunner.de>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <77aa6c01aefe1ebc4004e87b0bc714f2759f15c4.1575985006.git.lukas@wunner.de>
 <MWHPR12MB1358AEEBD730A4EDA78894E6F75B0@MWHPR12MB1358.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR12MB1358AEEBD730A4EDA78894E6F75B0@MWHPR12MB1358.namprd12.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda/hdmi - Fix duplicate unref of
	pci_dev
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

On Tue, Dec 10, 2019 at 03:34:27PM +0000, Deucher, Alexander wrote:
> > Nicholas Johnson reports a null pointer deref as well as a refcount underflow
> > upon hot-removal of a Thunderbolt-attached AMD eGPU.
> > He's bisected the issue down to commit 586bc4aab878 ("ALSA: hda/hdmi - fix
> > vgaswitcheroo detection for AMD").
> > 
> > The commit iterates over PCI devices using pci_get_class() and unreferences
> > each device found, even though pci_get_class() subsequently unreferences
> > the device as well.  Fix it.
> 
> The pci_dev_put() a few lines above should probably be dropped as well.

That one looks fine to me.  The refcount is already increased in the
caller get_bound_vga() via pci_get_domain_bus_and_slot() and it's
increased again in atpx_present() via pci_get_class().  It needs to
be decremented in atpx_present() to avoid leaking a ref.

Thanks,

Lukas

> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c index
> > 35b4526f0d28..b856b89378ac 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -1419,7 +1419,6 @@ static bool atpx_present(void)
> >  				return true;
> >  			}
> >  		}
> > -		pci_dev_put(pdev);
> >  	}
> >  	return false;
> >  }
> > --
> > 2.24.0
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
