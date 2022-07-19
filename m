Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198E8C43334
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jul 2022 00:31:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5970C1709;
	Tue, 19 Jul 2022 02:30:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5970C1709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658190666;
	bh=u4GVc7+wBuM4b6P+VS9sedKyNIgcx6NgudI8/KFaOwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c+7z6Rq8kdY4JCIuC2FGITlVngIsTi+W5Jx8GKZzooXfGJUHv5ITd3U1LBl+Qm6C0
	 TTDrrogevETNGFh7AuEp5872ypKZVnt95AARmEhw722GqW3qBShSWRSnHsqAFP63Y5
	 T+0kvcMvgXgVpXnJhRhlencMj1uxR14furiHLmS4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8309F80430;
	Tue, 19 Jul 2022 02:30:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8884DF80508; Tue, 19 Jul 2022 02:30:13 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E51BF80095
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2022 02:30:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E51BF80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="cmjJp4Wc"
Received: by mail-ej1-x62c.google.com with SMTP id oy13so24271418ejb.1
 for <alsa-devel@alsa-project.org>; Mon, 18 Jul 2022 17:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tHECUp5Nu2/GZmp47KHS0DA3aZn/HqPLp4AXTv+D1so=;
 b=cmjJp4Wc70UFyJOU6m9PHDv6cgBcSxACjV8XCYXocWtr/FcDcZs/QFmdPSXbhLyk3R
 FCPJlVcDF3a/bfbY1OWEBMjl7TtYtUqMl4/A/cUcxiW5hsr+PAuT1lF+4Ixp22UZhHaL
 sJIUDawrTaLiqBcojVG2hn0PPXAFrYn7zche+uxAV4J2eoaR53m7JLz9lb0PPCkXovqr
 TCkGxZqKxLlK4CUnskdjqrd6D8nX5LutfIhmOojrYGQhrbAL0nFeOJB3HSXXDc75ja4Q
 Ur9wiz3Bf1hLJs4caVo1AfyVNX5xpE4+6LBYPFFX8y4zfXhOa+ndM9cAVlVQj/YWQdYx
 EP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tHECUp5Nu2/GZmp47KHS0DA3aZn/HqPLp4AXTv+D1so=;
 b=r/byKvBt1I9netRjxML0FUKHd5sqTh69lZB5rmLmwzZ3t7qHaTgrqtVToWE/aIY2wg
 mnDE4ebGtJVdHUEqOHf0zrB4fp4pzlQHO6BxD7Oy3zz6v2a51UoEVQxYHZwi3ZYzPu9y
 bvQL1nnz3BsHDeg7E5sJSPnhn+Xgx2pnGGI3WFdr/nvAPZObSDBhdJtgZeZlolSYNJuT
 t5BxsU9eIHaCFzKXqnhv9cfX3uAkj1w23Ao0o8thUryHYvU0uZTPRaVgz4cz2oyVsskZ
 462YmwE0rZwvCBIDq+JGT/JmGINiH6H6eRHAQuo8iQ71uDaNGw9rQRli3U3mvwc4cLZS
 j0Pg==
X-Gm-Message-State: AJIora+m0V+rQzTFKkmDNViQrtBOe2mcZFTWRLY8dPyHcI/4qY4NhA0u
 J8rseNygAy7wVwfsSJWvjV2NhElRhbEP1iVFXMI=
X-Google-Smtp-Source: AGRyM1svWNwoYq60pp37EFhGkxbFoEzaD37OWwpIsvtcVPSeTlz8BczIXRa0zpFaHGe5N9WvcJ4GnRQwW7CTE2lGvM0=
X-Received: by 2002:a17:907:96ac:b0:72f:1dea:5b66 with SMTP id
 hd44-20020a17090796ac00b0072f1dea5b66mr10887738ejc.266.1658190608048; Mon, 18
 Jul 2022 17:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220718072144.2699487-1-airlied@gmail.com>
 <YtWeUOJewho7p/vM@intel.com>
In-Reply-To: <YtWeUOJewho7p/vM@intel.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 19 Jul 2022 10:29:56 +1000
Message-ID: <CAPM=9tyhOfOz1tn7uNsg_0EzvrBHcSoY+8bignNb2zfgZr6iRw@mail.gmail.com>
Subject: Re: [PATCH] docs: driver-api: firmware: add driver firmware
 guidelines.
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Wireless List <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Network Development <netdev@vger.kernel.org>,
 "dri-devel@lists.sf.net" <dri-devel@lists.sf.net>,
 Dave Airlie <airlied@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
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

> > +* Firmware should be versioned with at least a major/minor version. It
> > +  is suggested that the firmware files in linux-firmware be named with
> > +  some device specific name, and just the major version. The
> > +  major/minor/patch versions should be stored in a header in the
> > +  firmware file for the driver to detect any non-ABI fixes/issues. The
> > +  firmware files in linux-firmware should be overwritten with the newest
> > +  compatible major version. Newer major version firmware should remain
> > +  compatible with all kernels that load that major number.
>
> would symbolic links be acceptable in the linux-firmware.git where
> the <fmw>_<major>.bin is a sym link to <fwm>_<major>.<minor>.bin
>
> or having the <fwm>_<major>.bin really to be the overwritten every minor
> update?

I don't think providing multiple minor versions of fw in
linux-firmware is that interesting.
Like if the major is the same, surely you always want the newer ones.
As long as the
ABI doesn't break. Otherwise we are just wasting disk space with fws
nobody will be using.

Dave.
