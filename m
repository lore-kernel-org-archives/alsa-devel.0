Return-Path: <SRS0=cVLY=DK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C3CC4363D
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:25:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6C4206DB
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BYQOh2u5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2pJ7ORP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6C4206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DEDDD18F4;
	Sat,  3 Oct 2020 11:24:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DEDDD18F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601717110;
	bh=kL1oT9jESZhdHr78QJxp6JYT0/KTUQ2i0XtO3OHsZp0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BYQOh2u58nTHoZtX4bmswbdUy8D69Wue15/sX+sAgpfzS9fRrF6T8JdcscAxCFP7l
	 Fs3yzbLcw+VMCzW1KJxHdTRAXlHGPtWZYRLaobhvzIaZJMA7CaAghNUNiRS8m8Y3lq
	 j3IXHisheT+n5jqcMLPM7YMU2w5OLx7hwlf6ZkI0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B41AF801DB;
	Sat,  3 Oct 2020 11:24:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38232F801F5; Sat,  3 Oct 2020 11:24:17 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5EB45F800E5
 for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2020 11:24:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5EB45F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="a2pJ7ORP"
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 48E5F206CA;
 Sat,  3 Oct 2020 09:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601717052;
 bh=kL1oT9jESZhdHr78QJxp6JYT0/KTUQ2i0XtO3OHsZp0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a2pJ7ORPNftPezUtGNDEo3IdF+22iGYUbdI48c71wE2Bl7X3PX2d1E2Lf8SWD5kjT
 d3m5SeRIm/MbiiobKPxgT9GQmXlTtncOpRjQRHQueXRMYvo5ZfW9tt7Q85qCa8zDeZ
 sv/wTeiiprt2oRHGkiHuF4E+6OZX2Tt5QacDkr3A=
Date: Sat, 3 Oct 2020 12:24:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] Ancillary bus implementation and SOF multi-client
 support
Message-ID: <20201003092407.GG3094@unreal>
References: <20201001050534.890666-1-david.m.ertman@intel.com>
 <20201003090452.GF3094@unreal> <20201003091036.GA118157@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003091036.GA118157@kroah.com>
Cc: linux-rdma@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
 alsa-devel@alsa-project.org, linux-netdev <netdev@vger.kernel.org>
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

On Sat, Oct 03, 2020 at 11:10:36AM +0200, Greg KH wrote:
> On Sat, Oct 03, 2020 at 12:04:52PM +0300, Leon Romanovsky wrote:
> > Hi Dave,
> >
> > I don't know why did you send this series separately to every mailing
> > list, but it is not correct thing to do.
> >
> > RDMA ML and discussion:
> > https://lore.kernel.org/linux-rdma/20201001050534.890666-1-david.m.ertman@intel.com/T/#t
> > Netdev ML (completely separated):
> > https://lore.kernel.org/netdev/20201001050851.890722-1-david.m.ertman@intel.com/
> > Alsa ML (separated too):
> > https://lore.kernel.org/alsa-devel/20200930225051.889607-1-david.m.ertman@intel.com/
>
> Seems like the goal was to spread it around to different places so that
> no one could strongly object or review it :(

It took me time to realize why I was alone expressing my thoughts :).

BTW, I'm looking on ALSA thread and happy to see that people didn't like
"ancillary" name. It is far from intuitive name for any non-English speaker.

Thanks

>
> greg k-h
