Return-Path: <SRS0=gYtK=EM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9262AC2D0A3
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 08:47:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C438520B80
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 08:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UyJFCsjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C438520B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30B6E16A4;
	Fri,  6 Nov 2020 09:46:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30B6E16A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604652449;
	bh=nXUQ4GL6W41xEh7Is8wnu+Mihu4l8UOkwnOVzvooJps=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UyJFCsjP9Q67R88TJBCbOcZVNLPgHz6JShP1oPthbv6DP0MtxpLtFytNa1LnmrKjd
	 zT0kF1wVS4IbVbAoFFBCKsVpjleAvqG5BtGsW0XmgEmc8tPJqnGBbPIzs8fR36FJ6r
	 S4HqqWtfjXESSJZUWBp5kxBJq2IWhAWoKpL0p1Nc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57CD7F804EC;
	Fri,  6 Nov 2020 09:43:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A35FF80171; Thu,  5 Nov 2020 20:37:50 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF835F800EC
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2020 20:37:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF835F800EC
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A51B320704;
 Thu,  5 Nov 2020 19:37:44 +0000 (UTC)
Date: Thu, 5 Nov 2020 21:37:41 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 01/10] Add auxiliary bus support
Message-ID: <20201105193741.GC5475@unreal>
References: <20201023003338.1285642-1-david.m.ertman@intel.com>
 <20201023003338.1285642-2-david.m.ertman@intel.com>
 <CAPcyv4i9s=CsO5VJOhPnS77K=bD0LTQ8TUAbhLd+0OmyU8YQ3g@mail.gmail.com>
 <DM6PR11MB284191BAA817540E52E4E2C4DDEE0@DM6PR11MB2841.namprd11.prod.outlook.com>
 <f37a2b37-2fda-948d-1b8f-617395d43a08@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f37a2b37-2fda-948d-1b8f-617395d43a08@linux.intel.com>
X-Mailman-Approved-At: Fri, 06 Nov 2020 09:43:15 +0100
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Parav Pandit <parav@mellanox.com>, Greg KH <gregkh@linuxfoundation.org>,
 Takashi Iwai <tiwai@suse.de>, Netdev <netdev@vger.kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Fred Oh <fred.oh@linux.intel.com>, linux-rdma <linux-rdma@vger.kernel.org>,
 Doug Ledford <dledford@redhat.com>, Mark Brown <broonie@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "Ertman,
 David M" <david.m.ertman@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "Saleem, Shiraz" <shiraz.saleem@intel.com>,
 David Miller <davem@davemloft.net>, "Patil, Kiran" <kiran.patil@intel.com>
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

On Thu, Nov 05, 2020 at 01:32:40PM -0600, Pierre-Louis Bossart wrote:
>
> > > > +module_init(auxiliary_bus_init);
> > > > +module_exit(auxiliary_bus_exit);
> > > > +
> > > > +MODULE_LICENSE("GPL");
> > >
> > > Per above SPDX is v2 only, so...
> > >
> > > MODULE_LICENSE("GPL v2");
> > >
> >
> > added v2.
>
> "GPL v2" is the same as "GPL" here, it does not have any additional meaning.
>
> https://www.kernel.org/doc/html/latest/process/license-rules.html
>
> “GPL”	Module is licensed under GPL version 2. This does not express any
> distinction between GPL-2.0-only or GPL-2.0-or-later. The exact license
> information can only be determined via the license information in the
> corresponding source files.

+1,
https://lore.kernel.org/lkml/20201105193009.GA5475@unreal

>
> “GPL v2”	Same as “GPL”. It exists for historic reasons.
>
