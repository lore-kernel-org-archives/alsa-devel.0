Return-Path: <SRS0=3BcS=MA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8B1C07E96
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 10:15:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6079361C17
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 10:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6079361C17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED3471691;
	Thu,  8 Jul 2021 12:14:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED3471691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625739347;
	bh=NU8g0Ar28yIHIe9k+acEs9s3ICgVOy0+R+xZGw0Ig6Q=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NM4V620cxbp67ejX0hMj0wl/+s+jgMcOpgYGPPD5KUvY7/x0Tg6k4i54em4fa5buw
	 dPenwfywzh158dNdb8tvr1gK/e/jcD/DN3uaVumPUa6kiGubTX45NZ09OhcTgULckb
	 RX5hJJIukhBA/99NCpwUbL/+YHlnO9cyep/MH9jE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BDC9F805B2;
	Thu,  8 Jul 2021 12:04:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2A43F80249; Tue,  6 Jul 2021 20:08:33 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B335F80134
 for <alsa-devel@alsa-project.org>; Tue,  6 Jul 2021 20:08:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B335F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Sz6rE6fI"
Received: by mail-ot1-x336.google.com with SMTP id
 d27-20020a05683018fbb02904ae64d1b56bso1741760otf.9
 for <alsa-devel@alsa-project.org>; Tue, 06 Jul 2021 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rFh4HQBpaw9ewOD7eKuJ7KI9YAzHhN8tlxJ6LopMKHs=;
 b=Sz6rE6fIxKghlltcLCE+UXPsQefAUgPvTMscjeRzq2kl6NTGV49umux5xM0XcDuF3f
 KuSKKfkZ8nSISGEXHz3w1v+CP9bxuRJkim+LBmkXAMBhskBSVWy4R8UYC7L1pwY+g7hz
 Zg3WKG3mRVhsusU5VFmdXh5UPocqhZf4lahEU95r9tDGNbsVfHF1Q4HkA+YZfm/i81fd
 v0xNi9dJEaEvf856OdG6fjSc31APYItT+IUiPzbg0w9QbfcYoXqLRo58SwLlUHuXr/Qb
 gjgu5RAVRwk/bKL57rYJjqGIxVt7qPeDusZUEamQ36NdV7/ZYwdc/uo7wSJkJLcpf0tD
 jOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rFh4HQBpaw9ewOD7eKuJ7KI9YAzHhN8tlxJ6LopMKHs=;
 b=IU+zkltxw05ETvglGsrndPor/0Ry19QhRYZKsQnm13JYyWMiE2kBEycNoPoJQ0Tsiq
 zZ1dkq6xd4oQsYwPqoHhxoe+v4z7pL6ZdzMkvXkdunCmqUWnziFWW0xYHx4cmuVMgiwN
 oX8uR7xrr0e6M49O8CWfqi06cclG9VwxvrNvcNHLqniRLsmSaiA4n3FxPvaq9zmFgast
 oZe6eRnUq+WiHDDCMseluB6r0xebOKwsk4O6dyjPy9+TVHQ7pWWDYhx2bnRKbNBj+/Vp
 VWsHlcB5Ly6nfqrDuBWq915FapyfS5uCknQJxaDnqly17vtybPqZH+A+aLtWFqGPzuYu
 kFww==
X-Gm-Message-State: AOAM530bzEkbok7ti66kFvdPfbHk678HIbUF40mU3p9jDVNtB5+5R8ck
 Rg4LnhutKVUfxWZ0Fhd7OIHvZw==
X-Google-Smtp-Source: ABdhPJwwC8pa+wbm0v5SSaX+DFJoQ7jJmXTjdD3iH0933Y2rw8Y2+zYlxp2w0qjcBNkHXGnjSvRJ6w==
X-Received: by 2002:a9d:3d3:: with SMTP id f77mr16276146otf.43.1625594902170; 
 Tue, 06 Jul 2021 11:08:22 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id 68sm497113otd.74.2021.07.06.11.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jul 2021 11:08:21 -0700 (PDT)
Date: Tue, 6 Jul 2021 13:08:18 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 4/4] bus: Make remove callback return void
Message-ID: <YOSb1+yeVeLxiSRc@yoga>
References: <20210706154803.1631813-1-u.kleine-koenig@pengutronix.de>
 <20210706154803.1631813-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706154803.1631813-5-u.kleine-koenig@pengutronix.de>
X-Mailman-Approved-At: Thu, 08 Jul 2021 12:04:25 +0200
Cc: nvdimm@lists.linux.dev, linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-cxl@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 target-devel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-i3c@lists.infradead.org, linux1394-devel@lists.sourceforge.net,
 linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-acpi@vger.kernel.org, industrypack-devel@lists.sourceforge.net,
 linux-input@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, greybus-dev@lists.linaro.org,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-spi@vger.kernel.org, kernel@pengutronix.de,
 dmaengine@vger.kernel.org, linux-ntb@googlegroups.com,
 linuxppc-dev@lists.ozlabs.org
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

On Tue 06 Jul 10:48 CDT 2021, Uwe Kleine-K?nig wrote:

> The driver core ignores the return value of this callback because there
> is only little it can do when a device disappears.
> 
> This is the final bit of a long lasting cleanup quest where several
> buses were converted to also return void from their remove callback.
> Additionally some resource leaks were fixed that were caused by drivers
> returning an error code in the expectation that the driver won't go
> away.
> 
> With struct bus_type::remove returning void it's prevented that newly
> implemented buses return an ignored error code and so don't anticipate
> wrong expectations for driver authors.
> 

Thanks for doing this!

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org> (rpmsg and apr)

[..]
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index c1404d3dae2c..7f6fac618ab2 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -530,7 +530,7 @@ static int rpmsg_dev_probe(struct device *dev)
>  	return err;
>  }
>  
> -static int rpmsg_dev_remove(struct device *dev)
> +static void rpmsg_dev_remove(struct device *dev)
>  {
>  	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
>  	struct rpmsg_driver *rpdrv = to_rpmsg_driver(rpdev->dev.driver);
> @@ -546,8 +546,6 @@ static int rpmsg_dev_remove(struct device *dev)
>  
>  	if (rpdev->ept)
>  		rpmsg_destroy_ept(rpdev->ept);
> -
> -	return err;

This leaves err assigned but never used, but I don't mind following up
with a patch cleaning that up after this has landed.

>  }
>  
>  static struct bus_type rpmsg_bus = {

Regards,
Bjorn
