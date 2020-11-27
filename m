Return-Path: <SRS0=aYR+=FB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DFCC2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 06:19:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7751221FF
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 06:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f9jOb/oU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/HoHHKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7751221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EC9E1807;
	Fri, 27 Nov 2020 07:18:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EC9E1807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606457951;
	bh=Rdoi629DjicvHoCKKgi6+NxG/4/rdjkHZDIAQJ5MAJA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f9jOb/oUUrtA0yg0l52IvYPzKQbiU5hUuNSgykNun2IWYm6ZbPpr1ckO1/LdSyJkX
	 E8p8TvpDWYkoXEWnF5d1SQBpQ/KetrIjKKWknuFf/QSG7Au5/pWwUFGa36cQS6x+6d
	 6TdT8M6G1XvZQ6pTpSpeCKfbxlCm0aABFHi3M9hA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46412F8015F;
	Fri, 27 Nov 2020 07:18:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8D5FF8019D; Fri, 27 Nov 2020 07:18:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B218F800EA
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2020 07:18:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B218F800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Z/HoHHKF"
Received: from localhost (unknown [122.167.146.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2ECBE221FD;
 Fri, 27 Nov 2020 06:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606457888;
 bh=Rdoi629DjicvHoCKKgi6+NxG/4/rdjkHZDIAQJ5MAJA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z/HoHHKFJX74NRjz9J8FtFtn84vPzICi+RbaYQdzpvSUqgbHYwOxh+oz1TQdL1Adn
 TZI3vXKLc0HpZkba6veJrNtrtHL+8WIwPUBFm4aYFTUuToZg7lZL2ZHGpZAScxv8Xh
 8WCY65V8QV7qgA+Yrj0CyoqHDtsjcPXrumrTjp3Q=
Date: Fri, 27 Nov 2020 11:47:58 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Liao, Bard" <bard.liao@intel.com>
Subject: Re: [PATCH] soundwire: master: use pm_runtime_set_active() on add
Message-ID: <20201127061758.GK8403@vkoul-mobl>
References: <20201124130742.10986-1-yung-chuan.liao@linux.intel.com>
 <20201125050528.GC8403@vkoul-mobl>
 <DM6PR11MB4074BC35644527BA45C1CB3CFFF90@DM6PR11MB4074.namprd11.prod.outlook.com>
 <20201126042222.GG8403@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126042222.GG8403@vkoul-mobl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
 "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
 "hui.wang@canonical.com" <hui.wang@canonical.com>,
 "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
 "jank@cadence.com" <jank@cadence.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On 26-11-20, 09:52, Vinod Koul wrote:

> > > > @@ -154,7 +163,12 @@ int sdw_master_device_add(struct sdw_bus *bus,
> > > struct device *parent,
> > > >  	bus->dev = &md->dev;
> > > >  	bus->md = md;
> > > >
> > > > +	pm_runtime_set_autosuspend_delay(&bus->md->dev,
> > > SDW_MASTER_SUSPEND_DELAY_MS);
> > > > +	pm_runtime_use_autosuspend(&bus->md->dev);
> > > > +	pm_runtime_mark_last_busy(&bus->md->dev);
> > > > +	pm_runtime_set_active(&bus->md->dev);
> > > >  	pm_runtime_enable(&bus->md->dev);
> > > > +	pm_runtime_idle(&bus->md->dev);
> > > 
> > > I understand that this needs to be done somewhere but is the core the right
> > > place. In intel case it maybe a dummy device but other controllers are real
> > > devices and may not support pm.
> > > 
> > > I think better idea would be to do this in respective driver.. that way it
> > > would be an opt-in for device supporting pm.
> > 
> > Should it be put in the same place as pm_runtime_enable?
> > IMHO, pm_runtime_enable is in the core already and it seems to be harmless
> > for devices which don't support pm. And pm can still be optional on md's
> > parent device.
> 
> For intel case yes, but world is not only intel, there are md which do
> not have a parent like sof. they are real sdw controller devices

Sorry I confused md with real master device ;-) I guess this patch
should be okay then.. As the real parent will control.

Thanks
-- 
~Vinod
