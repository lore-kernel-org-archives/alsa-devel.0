Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA45DC433E6
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 07:28:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB9E208CA
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 07:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cJkhW90v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNN/QFPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB9E208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E908E186D;
	Fri, 28 Aug 2020 09:27:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E908E186D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598599696;
	bh=5VtJwAIqjRo8m3/A3PqgyBtUrnGNzj2MdnY7GmNZzkk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cJkhW90vV2biTOG4mOV1qbZEmI6K0kf4dM+7ieIgMfewJGtGrpD541IaZoIzK0/jZ
	 8cycUvLeN6s79ZqCBwGGv8b+yyAkSjVsmxr+Pckkb5VEeWbdYuIQzq0k+smBwrtAnX
	 HZH+oZXuYnUod9Hf+H919HNeQLd5ONQMl6W4tu4c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41080F80143;
	Fri, 28 Aug 2020 09:23:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A990DF801D9; Fri, 28 Aug 2020 09:23:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B309F80143
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 09:23:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B309F80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TNN/QFPj"
Received: from localhost (unknown [122.171.38.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 18A4420DD4;
 Fri, 28 Aug 2020 07:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598599426;
 bh=5VtJwAIqjRo8m3/A3PqgyBtUrnGNzj2MdnY7GmNZzkk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TNN/QFPjKawKCVc1KEdQSFVrMU+dMWopIxw033y4WIIekyPMNFmP4dpLBZxDDSvqF
 ImIyBpxdq0uwaKkQZa4wc44w7bvUwxHKOB5iILNl4enoLGHfOPqc+5x6N3TUKF6CDN
 fgnH294NFFT9jv6tZ1f30CiUxDEmjFCX2U1U7F5w=
Date: Fri, 28 Aug 2020 12:53:42 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 4/4] regmap: sdw: add support for SoundWire 1.2 MBQ
Message-ID: <20200828072342.GK2639@vkoul-mobl>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
 <20200825171656.75836-5-pierre-louis.bossart@linux.intel.com>
 <20200826090542.GZ2639@vkoul-mobl>
 <c5119781-bee0-f11b-eb73-cd2da6ab09f5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5119781-bee0-f11b-eb73-cd2da6ab09f5@linux.intel.com>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

On 26-08-20, 11:57, Pierre-Louis Bossart wrote:
> 
> > > +#include <linux/device.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/mod_devicetable.h>
> > 
> > Curious why do you need this header?
> 
> I'll return the question back to you, since you added this header for
> regmap-sdw.c:
> 
> 7c22ce6e21840 (Vinod Koul           2018-01-08 15:50:59 +0530  6) #include
> <linux/mod_devicetable.h>

Looks like it should be removed :)

I could compile it without any issues on few archs I do. let me push the
patch on my tree and see if bots are happy, will send the patch

> 
> so I assumed it was needed here as well.
> 
> > > +MODULE_DESCRIPTION("Regmap SoundWire Module");
> > 
> > This is same of sdw module, pls make this one a bit different.
> 
> yes, fixed.

-- 
~Vinod
