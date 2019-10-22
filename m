Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65406CA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 04:54:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAB1214B2
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 04:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TpSO62i8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+OarvDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAB1214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06DF184C;
	Tue, 22 Oct 2019 06:53:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06DF184C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571720070;
	bh=txvpl2Cno2aHMFBEuA8EflL7gbSRRWn25ngR4JF5VdA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TpSO62i8E/svs9Ne/EdHAsP+TI8nRnPC9NKQlvT5z618XnXLO0X5h3wkz47rBU8xP
	 Wpm1/q264/Br+c+NpBh+0iYN166mWjX4EXTSJj3YyxsIefzOKy8Mt8DiIQi5f4A1Ft
	 Q7Qv9cvSp3ebcsgkXEyXegnD3SOfWuhmcQx3Qqoc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7AB72F80112;
	Tue, 22 Oct 2019 06:53:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7ADEF800C0; Tue, 22 Oct 2019 06:53:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFC74F800C0
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 06:53:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFC74F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="q+OarvDz"
Received: from localhost (unknown [122.181.223.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 64974214B2;
 Tue, 22 Oct 2019 04:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571720009;
 bh=pBTQ0YOEOQnzuYUb+FHQ4FBCyJ82lfDZHeeN8yBIiFw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q+OarvDzZbllVYVz8+gParOTzlzJoIHeghSRJUKIkjv5hWxaJdcM8ErWSazWiq13t
 HL7/yOC0TixjBbbwqMYUzp8kqC0WqWG4GQ+FpGZeTvLgb+DYCf7/t39ZPajRSuBQve
 m6Rd/HFCIPCIW82dDHW7zkP2PwJvAXwnlWaW88rI=
Date: Tue, 22 Oct 2019 10:23:24 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20191022045324.GI2654@vkoul-mobl>
References: <20190916190952.32388-1-pierre-louis.bossart@linux.intel.com>
 <20190916190952.32388-3-pierre-louis.bossart@linux.intel.com>
 <20191021040458.GX2654@vkoul-mobl>
 <96f5b446-ae02-afd6-9e5c-12e3507567f3@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <96f5b446-ae02-afd6-9e5c-12e3507567f3@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 2/5] soundwire: cadence_master: add
 hw_reset capability in debugfs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 21-10-19, 05:20, Pierre-Louis Bossart wrote:
> On 10/20/19 11:04 PM, Vinod Koul wrote:
> > On 16-09-19, 14:09, Pierre-Louis Bossart wrote:
> > > Provide debugfs capability to kick link and devices into hard-reset
> > > (as defined by MIPI). This capability is really useful when some
> > > devices are no longer responsive and/or to check the software handling
> > > of resynchronization.
> > > 
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > >   drivers/soundwire/cadence_master.c | 20 ++++++++++++++++++++
> > >   1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> > > index e3d06330d125..5f900cf2acb9 100644
> > > --- a/drivers/soundwire/cadence_master.c
> > > +++ b/drivers/soundwire/cadence_master.c
> > > @@ -340,6 +340,23 @@ static int cdns_reg_show(struct seq_file *s, void *data)
> > >   }
> > >   DEFINE_SHOW_ATTRIBUTE(cdns_reg);
> > > +static int cdns_hw_reset(void *data, u64 value)
> > > +{
> > > +	struct sdw_cdns *cdns = data;
> > > +	int ret;
> > > +
> > > +	if (value != 1)
> > > +		return -EINVAL;
> > > +
> > > +	ret = sdw_cdns_exit_reset(cdns);
> > 
> > So we are performing reset of the device behind the kernel, so I think
> > it makes sense to mark the kernel as tainted.
> 
> This is a bit ironic. This reset is the only way to prove that the
> enumeration is done right and that all the subsystem fully recovers, and yet
> we'd mark the kernel as 'untrustworthy' and all bug reports would be
> ignored.

Nope you dont expect this would be done on a production system and for
you own testing you can choose not to ignore the reports!

> I don't mind doing this but we'd have to agree on a code. The only one I see
> relevant is "taint requested by userspace application", which is not exactly
> super useful.

But it does tell you that userspace did something so watch out!

> > > +	dev_dbg(cdns->dev, "link hw_reset done: %d\n", ret);
> > > +
> > > +	return ret;
> > 
> > We may want to get rid of the debug and do:
> >          return sdw_cdns_exit_reset();
> 
> this debug line is useful, it marks the start of the reset sequence and
> that's valuable information. Remove it and you've lost the ability to
> analyze the dmesg logs. It's even more useful if we mark the kernel as
> tainted as you suggested above.

ok

> 
> > 
> > > +}
> > > +
> > > +DEFINE_DEBUGFS_ATTRIBUTE(cdns_hw_reset_fops, NULL, cdns_hw_reset, "%llu\n");
> > > +
> > >   /**
> > >    * sdw_cdns_debugfs_init() - Cadence debugfs init
> > >    * @cdns: Cadence instance
> > > @@ -348,6 +365,9 @@ DEFINE_SHOW_ATTRIBUTE(cdns_reg);
> > >   void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
> > >   {
> > >   	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
> > > +
> > > +	debugfs_create_file("cdns-hw-reset", 0200, root, cdns,
> > > +			    &cdns_hw_reset_fops);
> > >   }
> > >   EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
> > > -- 
> > > 2.20.1
> > 

-- 
~Vinod
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
