Return-Path: <SRS0=FWLr=6Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428BFC47255
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 09:01:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF868207DD
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 09:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YgcECk/b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLBdAK19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF868207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D30786F;
	Mon, 11 May 2020 11:00:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D30786F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589187673;
	bh=BDYB2489D6y/f/ZLmWPRkC7M2YYCV1n5uByAKeQ1lak=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YgcECk/b0AulOLwDnuba/pKYvJlALtkJ5d6ArzVLFGLjGJkjuaLxpP5vH+cyQ1RBa
	 hOpIKXLVBQE0AHpSbOO8dJzu3A4XelkGQTLnA9eAqcpIdU0nZ0Nh1Jud8I4Mz6L0I/
	 suoxsAGS4IghM83uM4NCo5Pov0y9R8nLAOFCkycU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E9CDF800E3;
	Mon, 11 May 2020 11:00:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D07FEF801F2; Mon, 11 May 2020 11:00:19 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C7B8F800E3
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 11:00:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C7B8F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jLBdAK19"
Received: from localhost (unknown [122.167.117.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BFE4F2075E;
 Mon, 11 May 2020 09:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589187609;
 bh=BDYB2489D6y/f/ZLmWPRkC7M2YYCV1n5uByAKeQ1lak=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jLBdAK19I74250GJZYTRbU0zbhZgyxAOQ42dCYU6JbS+EY5737tpc3LSyKYc5YPRJ
 wSAEVi0RqbQcr2o4XhzD9yy/RbG5SJ/Wz17QKiqal+TW3FYZ9c4QPPUmNr+Yp5Q+iu
 GGklh++PYduMuCsxriXuFrOXAcbsiBKRsY4+GpTY=
Date: Mon, 11 May 2020 14:30:03 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Liao, Bard" <bard.liao@intel.com>
Subject: Re: [PATCH 3/3] soundwire: bus_type: add sdw_master_device support
Message-ID: <20200511090003.GT1375924@vkoul-mobl>
References: <20200429185145.12891-1-yung-chuan.liao@linux.intel.com>
 <20200429185145.12891-4-yung-chuan.liao@linux.intel.com>
 <20200511063227.GS1375924@vkoul-mobl>
 <DM6PR11MB40748EA6346831A67BD218C7FFA10@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB40748EA6346831A67BD218C7FFA10@DM6PR11MB4074.namprd11.prod.outlook.com>
Cc: "pierre-louis.bossart@linux.intel.com"
 <pierre-louis.bossart@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
 "hui.wang@canonical.com" <hui.wang@canonical.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
 "jank@cadence.com" <jank@cadence.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "Blauciak,
 Slawomir" <slawomir.blauciak@intel.com>, "Kale,
 Sanyog R" <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>
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

On 11-05-20, 08:04, Liao, Bard wrote:
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Monday, May 11, 2020 2:32 PM
> > To: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; tiwai@suse.de;
> > broonie@kernel.org; gregkh@linuxfoundation.org; jank@cadence.com;
> > srinivas.kandagatla@linaro.org; rander.wang@linux.intel.com;
> > ranjani.sridharan@linux.intel.com; hui.wang@canonical.com; pierre-
> > louis.bossart@linux.intel.com; Kale, Sanyog R <sanyog.r.kale@intel.com>;
> > Blauciak, Slawomir <slawomir.blauciak@intel.com>; Lin, Mengdong
> > <mengdong.lin@intel.com>; Liao, Bard <bard.liao@intel.com>
> > Subject: Re: [PATCH 3/3] soundwire: bus_type: add sdw_master_device support
> > 
> > On 30-04-20, 02:51, Bard Liao wrote:
> > > @@ -24,9 +24,14 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct
> > device *parent,
> > >  	struct sdw_master_prop *prop = NULL;
> > >  	int ret;
> > >
> > > -	if (!bus->dev) {
> > > -		pr_err("SoundWire bus has no device\n");
> > > -		return -ENODEV;
> > 
> > This check is removed and not moved into sdw_master_device_add() either, can
> > you add here or in patch 1 and keep checking the parent device please
> 
> We will set bus->dev = &md->dev in the end of sdw_master_device_add().

We need to test if this is valid or not :)

> That's why we remove the test. But now I am wandering does it make sense
> to set bus->dev = &md->dev? Maybe it makes more sense to set bus->dev =
> sdw control device. 
> A follow up question is that should slave device a child of bus device or
> master device? I would prefer bus device if it makes sense. 
> I will check bus->dev and parent and remove bus->dev = &md->dev in the
> next version.

the parent is bus->dev and sdw_master_device created would be child of
this and should be set as such. You can remove it from bus object and
keep in sdw_master_device object, that is fine by me.

The sdw_slave is child of sdw_master_device now and looks to be set
correct.

-- 
~Vinod
