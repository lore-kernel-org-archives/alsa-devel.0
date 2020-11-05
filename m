Return-Path: <SRS0=j4zi=EL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAFEC4742C
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:50:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3284C21556
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sgFucP7T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sDW2kw2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3284C21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86DBE166F;
	Thu,  5 Nov 2020 08:49:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86DBE166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604562623;
	bh=Sr3161m8DFEJjqcKEurO6aH+G1uY8m8T+wL9eSUV+J8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sgFucP7TOHkZfhRHJkCnS1ATzcs8gEj3x/KtWqfJ98i9ZAS5tTcMi+KNFUrLU16Zv
	 FOfmiXBDCmkUAo+1k1VhYeeLPLzGfy1a5JXZKNGJuTmShfqb+Yo8C8DKWPjKJZRDd4
	 D3xKgYr2hKaEdZCQ++3/7vxNkRPLBHRrfScZZjYs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 108C9F80162;
	Thu,  5 Nov 2020 08:49:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3BA23F80171; Thu,  5 Nov 2020 08:49:32 +0100 (CET)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F30BCF80150
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2020 08:49:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F30BCF80150
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="sDW2kw2W"
Received: by mail-ej1-x644.google.com with SMTP id s25so1224667ejy.6
 for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2020 23:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HiHN7cEc9FvAFXuwqXLWF0XbMGI5NJnlheI3AC/p0Rk=;
 b=sDW2kw2WIZtOBBqP3OLvBf0PZR4l//kVfPnpgjZLMq0vnE4tjG4Ig8z5tff+gOMOP0
 snGDBlsMM8PeDWRiOvFXKxwsoy/1Xtb6Xcc7mo4BQMPh/IrM38WXigtT7wQwr6ggUOjR
 dnfFwV5wvxh5jl5IGJroHGHpfEDC4ES+wgWgBUaJCOqtZ8QG5P0CUCQzNp78U2eeV7O5
 yCCmjn+yqQ4xcVOlwAcacEw2ny9JMCkuwMdXa4VYdR8fSYj/JM2Oeviqgge95DNvbHBt
 rfnzbtVc3h3BTVvE+MV5I+onfG+QEpeqBoYtXw43J1bzbdBKp+zHOxdL3J2AqKAJxUFO
 MhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HiHN7cEc9FvAFXuwqXLWF0XbMGI5NJnlheI3AC/p0Rk=;
 b=A6l5HcP/jP3Z1ECrdd7amjgSoUM9C/U61yJZjXPj/DuatkW0uBOZyn7hAt1lozYq3H
 8Tpo56upUJxM4Yxjxr5LBpsUDa4CW7a9Q55/xG7cUItjmOv4EFxAcsJZKNKlpAzWmXnl
 +XUrKZSg3sGclWTto3hBO0Gj3fFJV4PEYsTdSD5c6PVOOVJJF7C5uMeruJ2V/seIyqbu
 1SHurI8DAsBAaQ1cQl7RlJASCG13HKJE3xE6AdjTt3HK+qtP0qq6taTqGOy85Hg5zuXz
 tqoP9bVECgddu23KIt2nRef6/f7ez9yzSZLdIkVD8Ac5259KyjiOGUeeze9zce/5rtrW
 TJAA==
X-Gm-Message-State: AOAM530kXbGOg8m2o+zsLuDJR/ZHL3DWc9RKn8CBUD2/efkl9R+dKmG3
 bSZwefdWB2cfsYmQVFyFnXhn5kXhMh/v3ivJBWCYtQ==
X-Google-Smtp-Source: ABdhPJzMyeNcHa42GSktT9mkjMahMnmlITf9LkRgdVukR/ujD9xIfq3TSrJb0lT83dAIiwc3ssEcu4HrZhS0QU6AnNw=
X-Received: by 2002:a17:906:4306:: with SMTP id
 j6mr1091381ejm.523.1604562563054; 
 Wed, 04 Nov 2020 23:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20201101201542.2027568-1-leon@kernel.org>
 <20201101201542.2027568-7-leon@kernel.org>
 <20201103154525.GO36674@ziepe.ca>
 <CAPcyv4jP9nFAGdvB7agg3x7Y7moHGcxLd5=f5=5CXnJRUf3n9w@mail.gmail.com>
 <20201105073302.GA3415673@kroah.com>
In-Reply-To: <20201105073302.GA3415673@kroah.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 4 Nov 2020 23:49:11 -0800
Message-ID: <CAPcyv4iJZNsf9fnx2BkyCG9ECm85mFshaoxaZ3=kzMz-2-hCQQ@mail.gmail.com>
Subject: Re: [PATCH mlx5-next v1 06/11] vdpa/mlx5: Connect mlx5_vdpa to
 auxiliary bus
To: gregkh <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Takashi Iwai <tiwai@suse.de>, Jason Wang <jasowang@redhat.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Leon Romanovsky <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Doug Ledford <dledford@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "Patil,
 Kiran" <kiran.patil@intel.com>, Mark Brown <broonie@kernel.org>,
 Parav Pandit <parav@nvidia.com>, David M Ertman <david.m.ertman@intel.com>,
 Roi Dayan <roid@nvidia.com>, virtualization@lists.linux-foundation.org,
 "Saleem, Shiraz" <shiraz.saleem@intel.com>, Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, "David S . Miller" <davem@davemloft.net>
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

On Wed, Nov 4, 2020 at 11:32 PM gregkh <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 04, 2020 at 03:21:23PM -0800, Dan Williams wrote:
> > On Tue, Nov 3, 2020 at 7:45 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > [..]
> > > > +MODULE_DEVICE_TABLE(auxiliary, mlx5v_id_table);
> > > > +
> > > > +static struct auxiliary_driver mlx5v_driver = {
> > > > +     .name = "vnet",
> > > > +     .probe = mlx5v_probe,
> > > > +     .remove = mlx5v_remove,
> > > > +     .id_table = mlx5v_id_table,
> > > > +};
> > >
> > > It is hard to see from the diff, but when this patch is applied the
> > > vdpa module looks like I imagined things would look with the auxiliary
> > > bus. It is very similar in structure to a PCI driver with the probe()
> > > function cleanly registering with its subsystem. This is what I'd like
> > > to see from the new Intel RDMA driver.
> > >
> > > Greg, I think this patch is the best clean usage example.
> > >
> > > I've looked over this series and it has the right idea and
> > > parts. There is definitely more that can be done to improve mlx5 in
> > > this area, but this series is well scoped and cleans a good part of
> > > it.
> >
> > Greg?
> >
> > I know you alluded to going your own way if the auxiliary bus patches
> > did not shape up soon, but it seems they have and the stakeholders
> > have reached this consensus point.
> >
> > Were there any additional changes you wanted to see happen? I'll go
> > give the final set another once over, but David has been diligently
> > fixing up all the declared major issues so I expect to find at most
> > minor incremental fixups.
>
> This is in my to-review pile, along with a load of other stuff at the
> moment:
>         $ ~/bin/mdfrm -c ~/mail/todo/
>         1709 messages in /home/gregkh/mail/todo/
>
> So give me a chance.  There is no rush on my side for this given the
> huge delays that have happened here on the authorship side many times in
> the past :)

Sure, I was more looking to confirm that it's worth continuing to
polish this set given your mention of possibly going a different
direction.

> If you can review it, or anyone else, that is always most appreciated.

Thanks, will do.
