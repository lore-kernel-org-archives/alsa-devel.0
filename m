Return-Path: <SRS0=iUFt=IV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DCDC433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 07:39:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F446191F
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 07:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F446191F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ECF001607;
	Tue, 23 Mar 2021 08:38:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ECF001607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616485172;
	bh=eJD7MkMG7NvGUc4AsQ76v4Rl/p1aebxzY1jJ29gQGu0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ce6WpOzJ9XFbclIy09uMObALAzx35aYKvMPX7ESDTfWHziKxslm4BKT36u1p6kOGf
	 lhtJwRcOnOMV7/vCAdi9YDndn75sz1thkNSz5f4g6XInVuSvmyc4PdnAih5N5CP3I0
	 n9ZjfdD5VSg7Y+WNJodbndpwxpjqYbadHBWEjeGI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E1FDF8026D;
	Tue, 23 Mar 2021 08:38:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D5ACF80279; Tue, 23 Mar 2021 08:38:10 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 052FFF80268
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 08:38:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 052FFF80268
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="yr3/V827"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1FD1619BD;
 Tue, 23 Mar 2021 07:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1616485079;
 bh=eJD7MkMG7NvGUc4AsQ76v4Rl/p1aebxzY1jJ29gQGu0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yr3/V827tTXRCgJPvBNjMw164mvK31A6S3uBlyW/qc4i/7xZYi/6W6cUkl0BvVcp7
 fmOave11vFP0Lnh+mj/zGv9xtCef9VO3aiSVZR8yFggqs/rjNFS5q2Yj/aMkkuDCJU
 oNNejvC7GJCy+nvo/rtm/95dGUDr9Xi1pL3IHzhI=
Date: Tue, 23 Mar 2021 08:37:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] soundwire: intel: move to auxiliary bus
Message-ID: <YFma1ClahDe2bZhR@kroah.com>
References: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
 <YFmPTkNkX6QPWiCa@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFmPTkNkX6QPWiCa@vkoul-mobl.Dlink>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, hui.wang@canonical.com,
 srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, rander.wang@linux.intel.com,
 bard.liao@intel.com
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

On Tue, Mar 23, 2021 at 12:18:46PM +0530, Vinod Koul wrote:
> On 23-03-21, 08:43, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > 
> > Now that the auxiliary_bus exists, there's no reason to use platform
> > devices as children of a PCI device any longer.
> > 
> > This patch refactors the code by extending a basic auxiliary device
> > with Intel link-specific structures that need to be passed between
> > controller and link levels. This refactoring is much cleaner with no
> > need for cross-pointers between device and link structures.
> > 
> > Note that the auxiliary bus API has separate init and add steps, which
> > requires more attention in the error unwinding paths. The main loop
> > needs to deal with kfree() and auxiliary_device_uninit() for the
> > current iteration before jumping to the common label which releases
> > everything allocated in prior iterations.
> > 
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > ---
> >  drivers/soundwire/Kconfig           |   1 +
> >  drivers/soundwire/intel.c           |  52 ++++----
> >  drivers/soundwire/intel.h           |  14 +-
> >  drivers/soundwire/intel_init.c      | 190 +++++++++++++++++++---------
> >  include/linux/soundwire/sdw_intel.h |   6 +-
> >  5 files changed, 175 insertions(+), 88 deletions(-)
> > 
> > diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> > index 016e74230bb7..2b7795233282 100644
> > --- a/drivers/soundwire/Kconfig
> > +++ b/drivers/soundwire/Kconfig
> > @@ -25,6 +25,7 @@ config SOUNDWIRE_INTEL
> >  	tristate "Intel SoundWire Master driver"
> >  	select SOUNDWIRE_CADENCE
> >  	select SOUNDWIRE_GENERIC_ALLOCATION
> > +	select AUXILIARY_BUS
> >  	depends on ACPI && SND_SOC
> >  	help
> >  	  SoundWire Intel Master driver.
> > diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> > index d2254ee2fee2..039a101982c9 100644
> > --- a/drivers/soundwire/intel.c
> > +++ b/drivers/soundwire/intel.c
> > @@ -11,7 +11,7 @@
> >  #include <linux/module.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > -#include <linux/platform_device.h>
> > +#include <linux/auxiliary_bus.h>
> >  #include <sound/pcm_params.h>
> >  #include <linux/pm_runtime.h>
> >  #include <sound/soc.h>
> > @@ -1331,9 +1331,10 @@ static int intel_init(struct sdw_intel *sdw)
> >  /*
> >   * probe and init
> >   */
> > -static int intel_master_probe(struct platform_device *pdev)
> > +static int intel_link_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
> >  {
> > -	struct device *dev = &pdev->dev;
> > +	struct device *dev = &auxdev->dev;
> > +	struct sdw_intel_link_dev *ldev = auxiliary_dev_to_sdw_intel_link_dev(auxdev);
> 
> Do we need another abstractions for resources here, why not aux dev
> creation set the resources required and we skip this step...
> 
> >  	struct sdw_intel *sdw;
> >  	struct sdw_cdns *cdns;
> >  	struct sdw_bus *bus;
> > @@ -1346,14 +1347,14 @@ static int intel_master_probe(struct platform_device *pdev)
> >  	cdns = &sdw->cdns;
> >  	bus = &cdns->bus;
> >  
> > -	sdw->instance = pdev->id;
> > -	sdw->link_res = dev_get_platdata(dev);
> > +	sdw->instance = auxdev->id;
> 
> so auxdev has id and still we pass id as argument :( Not sure if folks
> can fix this now

That's odd, yeah, it should be fixed.

greg k-h
