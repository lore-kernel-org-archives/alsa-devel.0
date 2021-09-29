Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD6AC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 19:39:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8348B61462
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 19:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8348B61462
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19FF216A3;
	Wed, 29 Sep 2021 21:38:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19FF216A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632944360;
	bh=+Ze6H99DU3DmimO5MZooJ8rZyqjDzDrfayRI5OQoqFU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KrZij0tsczWOE06N63DlYjgaWYBUM6LRb7+S1mXY6t8nPvUk8pxeBXgGBwnGCyC/z
	 Hh2qlPIW7Ma5tGjUPrPu0e/qA5cCa7Gac0CFBpLphCju5an/2LAz1XApheXQq9s00F
	 CA9NsVNQLTgFv/3x7lpB8vLutddGA7DBclkyAupg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D6ABF801F7;
	Wed, 29 Sep 2021 21:38:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EEE68F80227; Wed, 29 Sep 2021 21:38:27 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D87DF80105
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 21:38:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D87DF80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="QYFRIUeg"
Received: by mail-vs1-xe30.google.com with SMTP id f2so3490327vsj.4
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ucIar4DtI5VBRHRMD0idsOuR7XTb9ToL4i59MWLOWJQ=;
 b=QYFRIUegd6a0pgvgGCIQGIJfMZqSgFsK+s4WvG0a4PQblCgcazAB5iRWfTr4NTa0OH
 ioj6H1wZ4J4XEmWTJTxjGYU1U0W18nwvCH2dRRhCIItgqRp4n2PLQovHPeLSZLxaPxSs
 u2rocOevsB3s/gaHaHoFdZTAotX9ZA2dLQ7WwQS8DAv1zuxC1vYmCB2Qq5EGxytanvpc
 ILOeizUFxHRbOuljIHCkWTMyNCKOsGN+aUyOdh2JU/qw+ABfCfpC7v27yzvJYxY6ms84
 ZMVLHbrpHqpsDN+KRMC6MtLhn8hTQs9pyj6NdCtnrAAU2h7Rzr7mSYxo/vvRWq1tE4JI
 ye2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ucIar4DtI5VBRHRMD0idsOuR7XTb9ToL4i59MWLOWJQ=;
 b=CeQW8K98WZgBRjSpKAivfuPgituompHE1SaZHOVtzjRn01wSb4qb2vcAGVlECq7U3d
 hQ4ReWvg0e+sedYrRZHzQDORqvHwew2i6Xf4ArFSptl/Zy3QQqhgZGcxyyV4AhFCVsox
 UkfuYvqUCKZAREYjilZUaWP5F2ELHrRw8umcfKN2rawtLylJfThH0zfFjh6LUScB6KaT
 9qdUPcSfJPPecBSJ4WHgfKzbi3wT8f7jAhlbnU4GHW4UMILycGcvbOLqe6Z3jx7+offx
 s/RStOFiLSF7a5XJOGdHdDU6+fIAkRKZU68gSqKb6q9fI/eXrwPiaR5dtsuW9kdfd4eU
 KHFw==
X-Gm-Message-State: AOAM530FGoPCHqIpzc9YjUMG4GFcbXq9yeTdLO9Gp/Nble4KP8gYMfuU
 iPxH6g2sg0+j58puVLP2BZ4D8Inq093hI0D7
X-Google-Smtp-Source: ABdhPJzcWRjfDwX6XzLQxsuAQGPcz7FGUpjbs460sXCFc4lfV2R37rSeMpeflft+T1OaeqrYgVerbg==
X-Received: by 2002:a05:6102:350:: with SMTP id
 e16mr262642vsa.12.1632944298672; 
 Wed, 29 Sep 2021 12:38:18 -0700 (PDT)
Received: from geday ([2804:7f2:8280:7522:98f0:31ff:fe93:2dc7])
 by smtp.gmail.com with ESMTPSA id q65sm434074vke.56.2021.09.29.12.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 12:38:18 -0700 (PDT)
Date: Wed, 29 Sep 2021 16:38:19 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bert Schiettecatte <bert@noisetron.com>
Subject: Re: Behringer UFX1604 and UFX1204 unneeded implicit feedback
Message-ID: <YVTAq9TE3htZRu/u@geday>
References: <YVS+AsiTRt1FqMn0@geday>
 <effffcec-7bab-4225-8bc4-a110f4c3f878@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <effffcec-7bab-4225-8bc4-a110f4c3f878@www.fastmail.com>
Cc: alsa-devel@alsa-project.org
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

On Wed, Sep 29, 2021 at 12:29:54PM -0700, Bert Schiettecatte wrote:
> implicit feedback is required for other platforms as well, for example mac osx

Pardon my ignorance, but how so? Isn't ALSA for Mac OSX just alsa-lib?

Please enlighten me.

> 
> On Wed, Sep 29, 2021, at 12:26 PM, Geraldo Nascimento wrote:
> > Hello Takashi and everyone,
> >
> > Behringer UFX1204 and UFX1604 have sync endpoints and we set up
> > implicit feedback sync on them. This is against the UAC spec.
> > We've already fixed a major source of noise by explictly setting up
> > the Clock Selector. Therefore in my humble opinion we should now
> > disable implicit feedback sync for those two devices.
> >
> > What do you think?
> >
> > Thank you,
> > Geraldo Nascimento
