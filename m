Return-Path: <SRS0=jAxA=GI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6DBC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jan 2021 03:14:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA48722573
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jan 2021 03:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA48722573
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30BEF1669;
	Tue,  5 Jan 2021 04:13:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30BEF1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609816439;
	bh=yvoSzg344dN/N+DqfiYgrY7pc/I34P5dAbpEpkhBIJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nla3CnxzpRdX+JPPus/oy4jLRYzYw1lI8AgEy9AOLZ1OIODVNa5WpXcbkA5lLfjOv
	 5mdjJEkg6Mjs9rcq+IMziUcUlPRnVdXCe3w/ALHo/v9ZFy5JV+rckea7vBWzNU+Mkj
	 zEg76wyJv7AXBK+LFnky50kkylwbsxMDhqM9Jykw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 758C4F801F5;
	Tue,  5 Jan 2021 04:13:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62E07F80258; Tue,  5 Jan 2021 04:13:06 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB822F8012B
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2021 04:12:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB822F8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="rQJxNXH+"
Received: by mail-ej1-x633.google.com with SMTP id d17so39393914ejy.9
 for <alsa-devel@alsa-project.org>; Mon, 04 Jan 2021 19:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yvoSzg344dN/N+DqfiYgrY7pc/I34P5dAbpEpkhBIJI=;
 b=rQJxNXH+GsHO6zvvAN5QlpD7RI9zvbxjhJhWT5bkV5oIVVbWJZULG+2WWV/lEPCGPb
 5LE9xwHUQp0sZ1hLMQf29jNLuIQZzVSzp8+Us0QEWtzd8y1GcaQ94MRaxCxsNS9qwF8U
 arYIf7Qri4YXmEU4dAVC5ouH+3+/w53ZK0cRc2Zgz5k5cI89Vmc2Bwn1F4cqsfRs7nHN
 ACSKhEPrnZS9J6vx+5lKjYWXuQ1gG6FXAXPsdtyEqEvKfkAacpVqZ1MHVWBPbOXHi7Zv
 an26E0lvekKWUDEGvpluK3itPhuYNM9RJIs9AkkkeMyy7TOAKGTfbWMrOsacHHDv4UP5
 FGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yvoSzg344dN/N+DqfiYgrY7pc/I34P5dAbpEpkhBIJI=;
 b=bO1pFCeHgELPCpMiOSiNY8Xo47c/kWH5jkW581kXYlj1dakQs09pgvNBUeALCtodu9
 BSXg/sP4tCrAAcNWT3hdMB+XevqeaMlLKylnHfKCVID0+AX2NLoaUjS8YZKuASI3DcVa
 M3RI7UVldEP63ItS3WcdZJXBS4rmDipzt4oHYCrfqZsmRabxObwwkmGGaWmj7qyqOMB4
 mHZ/6aR7xgTkj/KGQjLpclBnBJsmrZdCCCq+fvpsvsdJbs5mHXqZUpZ5ibv7F4juofHA
 eX4jh7bJNymtnoK50NEZmYCZ9kYeChUxXs66stHqKhm+0OZpmZ36NnYVbrvh7M1VtxJQ
 MSaQ==
X-Gm-Message-State: AOAM531hgIFnAoJyAuNJTbVz1SPJxTQHJU/jvk8juOddgSwqXmGWDnmB
 1OWGNOmyzF/33z1Qw/I6tKLRNZ+QS/MvGo0bc7DWww==
X-Google-Smtp-Source: ABdhPJxWhopuC35KPwfnKawh6cLcwSxhekWmpZrV2rdkrXYdZ1KZfaRVhs2RbvUV5dzGgIZtqDT24zcxcDmDY6YjXwA=
X-Received: by 2002:a17:906:a3c7:: with SMTP id
 ca7mr71056515ejb.523.1609816374613; 
 Mon, 04 Jan 2021 19:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20201218162817.GX552508@nvidia.com>
 <20201218180310.GD5333@sirena.org.uk>
 <20201218184150.GY552508@nvidia.com> <20201218203211.GE5333@sirena.org.uk>
 <20201218205856.GZ552508@nvidia.com> <20201221185140.GD4521@sirena.org.uk>
 <20210104180831.GD552508@nvidia.com> <20210104211930.GI5645@sirena.org.uk>
 <20210105001341.GL552508@nvidia.com>
 <CAPcyv4gxprMo1LwGTqGDyN-z2TrXLcAvJ3AN9-fbUs6y-LwXeA@mail.gmail.com>
 <20210105015314.GM552508@nvidia.com>
In-Reply-To: <20210105015314.GM552508@nvidia.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 Jan 2021 19:12:47 -0800
Message-ID: <CAPcyv4jAAC01rktNadUPv9jDRCOcDEO22uAOHXobpJ7TqAbp1w@mail.gmail.com>
Subject: Re: [resend/standalone PATCH v4] Add auxiliary bus support
To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kiran Patil <kiran.patil@intel.com>, alsa-devel@alsa-project.org,
 David Miller <davem@davemloft.net>, linux-rdma <linux-rdma@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, Martin Habets <mhabets@solarflare.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Fred Oh <fred.oh@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 Lee Jones <lee.jones@linaro.org>, Shiraz Saleem <shiraz.saleem@intel.com>,
 Netdev <netdev@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Parav Pandit <parav@mellanox.com>
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

On Mon, Jan 4, 2021 at 5:53 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Jan 04, 2021 at 04:51:51PM -0800, Dan Williams wrote:
> > On Mon, Jan 4, 2021 at 4:14 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Mon, Jan 04, 2021 at 09:19:30PM +0000, Mark Brown wrote:
> > >
> > >
> > > > > Regardless of the shortcut to make everything a struct
> > > > > platform_device, I think it was a mistake to put OF devices on
> > > > > platform_bus. Those should have remained on some of_bus even if they
> > > >
> > > > Like I keep saying the same thing applies to all non-enumerable buses -
> > > > exactly the same considerations exist for all the other buses like I2C
> > > > (including the ACPI naming issue you mention below), and for that matter
> > > > with enumerable buses which can have firmware info.
> > >
> > > And most busses do already have their own bus type. ACPI, I2C, PCI,
> > > etc. It is just a few that have been squished into platform, notably
> > > OF.
> > >
> >
> > I'll note that ACPI is an outlier that places devices on 2 buses,
> > where new acpi_driver instances are discouraged [1] in favor of
> > platform_drivers. ACPI scan handlers are awkwardly integrated into the
> > Linux device model.
> >
> > So while I agree with sentiment that an "ACPI bus" should
> > theoretically stand on its own there is legacy to unwind.
> >
> > I only bring that up to keep the focus on how to organize drivers
> > going forward, because trying to map some of these arguments backwards
> > runs into difficulties.
> >
> > [1]: http://lore.kernel.org/r/CAJZ5v0j_ReK3AGDdw7fLvmw_7knECCg2U_huKgJzQeLCy8smug@mail.gmail.com
>
> Well, this is the exact kind of thing I think we are talking about
> here..
>
> > > It should be split up based on the unique naming scheme and any bus
> > > specific API elements - like raw access to ACPI or OF data or what
> > > have you for other FW bus types.
> >
> > I agree that the pendulum may have swung too far towards "reuse
> > existing bus_type", and auxiliary-bus unwinds some of that, but does
> > the bus_type really want to be an indirection for driver apis outside
> > of bus-specific operations?
>
> If the bus is the "enumeration entity" and we define that things like
> name, resources, gpio's, regulators, etc are a generic part of what is
> enumerated, then it makes sense that the bus would have methods
> to handle those things too.
>
> In other words, the only way to learn what GPIO 'resource' is to ask
> the enumeration mechnism that is providing the bus. If the enumeration
> and bus are 1:1 then you can use a function pointer on the bus type
> instead of open coding a dispatch based on an indirect indication.
>

I get that, but I'm fearing a gigantic bus_ops structure that has
narrow helpers like ->gpio_count() that mean nothing to the many other
clients of the bus. Maybe I'm overestimating the pressure there will
be to widen the ops structure at the bus level.
