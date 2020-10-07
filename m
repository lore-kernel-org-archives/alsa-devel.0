Return-Path: <SRS0=3CTx=DO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E38C4363D
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 02:50:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A617C207EA
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 02:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vBGK0Q5y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="MRl1ZMYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A617C207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 951B216CB;
	Wed,  7 Oct 2020 04:49:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 951B216CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602039041;
	bh=KnwfFVKsKp11ELDJ3Gxt20tWc3hKiUpWDIgCeiCPHN8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vBGK0Q5y75dXITXQ8PNKoyddvVG5M+OiFJsCHHZTk8M3OMdfbXGpcvJseGSSKO2tK
	 VRFUIYSOXWYlGd61eff2mxMlG/ikGH+PUizW95gekME16IZ9CtNnQce8t6ikMN9XzQ
	 ztl6NLoBFQk9oT1Bjvst4LZ3l0XvFsQohZWreEkQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A02FF80127;
	Wed,  7 Oct 2020 04:49:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93555F80128; Wed,  7 Oct 2020 04:49:48 +0200 (CEST)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25F63F800EE
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2020 04:49:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25F63F800EE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="MRl1ZMYO"
Received: by mail-ej1-x642.google.com with SMTP id ce10so781175ejc.5
 for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2020 19:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KnwfFVKsKp11ELDJ3Gxt20tWc3hKiUpWDIgCeiCPHN8=;
 b=MRl1ZMYOEbwZeFSOJvelImWo3hXPk8iz21nm8/a1AV9HzB+TM/1DyFiGY04cS/YTeP
 zqoWdPJjsOwnYPHyJdSg1ic2dS4ggzbTOdQRTJXzEeqYn2n659guFCAty0M6ZKwUgo3u
 ZvjV+kHy7oIOtPzIHH45mqZvYE4/iW4Mb2Ov6ys79xm6PsuP8Wwg0ecVcHOW66LAY7nS
 aaGkUOiiE0NwUSkTlvGO+1nsVgJpeLLxwT2GGGlvn/RDLpo7XGRLp+QQuBAXlHzx1AZC
 rSjXVOyAkflDvsIGjG3v+vP27q1d9yWJlEj6PsEcqonLqZ0uSfPy80Ae45yDvpRJNsaD
 3gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KnwfFVKsKp11ELDJ3Gxt20tWc3hKiUpWDIgCeiCPHN8=;
 b=ojyef8DeE4Rw/sW8sn+JLLP6FDAtCpY3g7aOQmRPuvcijbBY8+SN6AXDyoTWxiVBOk
 Q13geGrUTqluZg0waP0x9HK1ZHsDtSfS8cDz0AYks0/LbpJ8h2fnP5k98h3qSNxccIIm
 dTRiDlpBNdxwSFNW3ksAjoQdRPCd4+01JV8AVWauAmLUGhPwylqaYVYztCoeTjrFDyic
 hEJTCNu8inZYK1ARDJRsgVPmaZQTU3SttRbAblwAS0ldP9qXB5hkFQOyXYbf0C+SXtTZ
 xWTkBIzgRaGqeu711SLbxwg0ZorCPlFbNjraHZqi0EVS6RrSmwnzndHdE91Sor6Elm5t
 x2xw==
X-Gm-Message-State: AOAM532eS86lATjobvg/wpGYe6L2+zWd4YBoGMhiQOWcHWbGhzpHQybN
 tC3YB/W8wg1pjWRmL78/h2uiE6FUEmOlzzu3NlmR8A==
X-Google-Smtp-Source: ABdhPJz5q3MciR3ka21H9LsrtLuU6IAfrbeFeHtNQjJAqUG6AF5ysugJFjVS8y9CektO40ja+AxQrmlnqqKlaTNAyEw=
X-Received: by 2002:a17:906:4306:: with SMTP id
 j6mr1137224ejm.523.1602038978549; 
 Tue, 06 Oct 2020 19:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201005182446.977325-1-david.m.ertman@intel.com>
 <20201005182446.977325-2-david.m.ertman@intel.com>
 <20201006071821.GI1874917@unreal>
 <b4f6b5d1-2cf4-ae7a-3e57-b66230a58453@linux.intel.com>
 <20201006170241.GM1874917@unreal>
 <BY5PR12MB43228E8DAA0B56BCF43AF3EFDC0D0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201006172650.GO1874917@unreal> <3ff1445d86564ef3aae28d1d1a9a19ea@intel.com>
 <20201006192036.GQ1874917@unreal>
In-Reply-To: <20201006192036.GQ1874917@unreal>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 6 Oct 2020 19:49:27 -0700
Message-ID: <CAPcyv4iC_KGOx7Jwax-GWxFJbfUM-2+ymSuf4zkCxG=Yob5KnQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] Add ancillary bus support
To: Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "kuba@kernel.org" <kuba@kernel.org>, "parav@mellanox.com" <parav@mellanox.com>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
 "fred.oh@linux.intel.com" <fred.oh@linux.intel.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "broonie@kernel.org" <broonie@kernel.org>, Parav Pandit <parav@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Ertman,
 David M" <david.m.ertman@intel.com>, "Saleem,
 Shiraz" <shiraz.saleem@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "Patil, Kiran" <kiran.patil@intel.com>
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

On Tue, Oct 6, 2020 at 12:21 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Oct 06, 2020 at 05:41:00PM +0000, Saleem, Shiraz wrote:
> > > Subject: Re: [PATCH v2 1/6] Add ancillary bus support
> > >
> > > On Tue, Oct 06, 2020 at 05:09:09PM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Leon Romanovsky <leon@kernel.org>
> > > > > Sent: Tuesday, October 6, 2020 10:33 PM
> > > > >
> > > > > On Tue, Oct 06, 2020 at 10:18:07AM -0500, Pierre-Louis Bossart wrote:
> > > > > > Thanks for the review Leon.
> > > > > >
> > > > > > > > Add support for the Ancillary Bus, ancillary_device and ancillary_driver.
> > > > > > > > It enables drivers to create an ancillary_device and bind an
> > > > > > > > ancillary_driver to it.
> > > > > > >
> > > > > > > I was under impression that this name is going to be changed.
> > > > > >
> > > > > > It's part of the opens stated in the cover letter.
> > > > >
> > > > > ok, so what are the variants?
> > > > > system bus (sysbus), sbsystem bus (subbus), crossbus ?
> > > > Since the intended use of this bus is to
> > > > (a) create sub devices that represent 'functional separation' and
> > > > (b) second use case for subfunctions from a pci device,
> > > >
> > > > I proposed below names in v1 of this patchset.
> > > >
> > > > (a) subdev_bus
> > >
> > > It sounds good, just can we avoid "_" in the name and call it subdev?
> > >
> >
> > What is wrong with naming the bus 'ancillary bus'? I feel it's a fitting name.
> > An ancillary software bus for ancillary devices carved off a parent device registered on a primary bus.
>
> Greg summarized it very well, every internal conversation about this patch
> with my colleagues (non-english speakers) starts with the question:
> "What does ancillary mean?"
> https://lore.kernel.org/alsa-devel/20201001071403.GC31191@kroah.com/
>
> "For non-native english speakers this is going to be rough,
> given that I as a native english speaker had to go look up
> the word in a dictionary to fully understand what you are
> trying to do with that name."

I suggested "auxiliary" in another splintered thread on this question.
In terms of what the kernel is already using:

$ git grep auxiliary | wc -l
507
$ git grep ancillary | wc -l
153

Empirically, "auxiliary" is more common and closely matches the
intended function of these devices relative to their parent device.
