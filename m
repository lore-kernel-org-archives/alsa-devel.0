Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBC7C433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 20:57:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD986100C
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 20:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD986100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B690216A0;
	Thu,  1 Apr 2021 22:56:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B690216A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617310668;
	bh=9T/IXqBtp+umSPMgidOSDUq4bIQY292EI+YBBoHkTlc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EKGOYk+WPU2limWF7BfGUi8zK6Nj8i8hWFUwLvBCZWYIRaphgeEhiDcYfqSFG5SDv
	 Lr07Q+AqpWTeUKNEHDaZLlOER31PwgZyTNxc2aZ3eSsFerxUMBIQtI9Yfb/XYCE4s6
	 /xEa1si4FZ7Gn/DiNylRQrwD3YnIwq6lE2lwPm+M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43D35F80240;
	Thu,  1 Apr 2021 22:56:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30C85F8026B; Thu,  1 Apr 2021 22:56:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D063F8013F
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 22:56:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D063F8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="ZTqDelDp"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6357D60BBB;
 Thu,  1 Apr 2021 20:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1617310610;
 bh=9T/IXqBtp+umSPMgidOSDUq4bIQY292EI+YBBoHkTlc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZTqDelDp/ufSmnejeQjZT0LOta51/UU2Qah0+yFRPxcRPELTf2IVLz7as8EMCryoQ
 Wbz8iHuAjFCAyYsctedDXXcEDnlYFfC+/gmNPk8MeYyRRquao9EpTNXfk1tx1IgzE2
 So7xHHEA957/FJgqkIH+sWjqjQfAMgjMcISsqw+4=
Date: Thu, 1 Apr 2021 22:56:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] soundwire: add macro to selectively change error
 levels
Message-ID: <YGYzjWOz076M3ZUq@kroah.com>
References: <20210331011355.14313-1-yung-chuan.liao@linux.intel.com>
 <20210331011355.14313-2-yung-chuan.liao@linux.intel.com>
 <YGV1HYL+XcVmxfQG@vkoul-mobl.Dlink>
 <0834b9fc-9b3a-1184-fed2-6f9c7e66c6fb@linux.intel.com>
 <YGX5AUQi41z52xk8@kroah.com>
 <81c6b53b-e3fb-32d0-1e99-365d87ab6524@linux.intel.com>
 <YGYQIJh8X2C8sW44@kroah.com>
 <28515962-6fb1-511d-fc6b-f1422b11e6ab@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28515962-6fb1-511d-fc6b-f1422b11e6ab@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 hui.wang@canonical.com, Vinod Koul <vkoul@kernel.org>, sanyog.r.kale@intel.com,
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

On Thu, Apr 01, 2021 at 01:43:53PM -0500, Pierre-Louis Bossart wrote:
> 
> > > > My bigger issue with this is that this macro is crazy.  Why do you need
> > > > debugging here at all for this type of thing?  That's what ftrace is
> > > > for, do not sprinkle code with "we got this return value from here!" all
> > > > over the place like what this does.
> > > 
> > > We are not sprinkling the code all over the place with any new logs, they
> > > exist already in the SoundWire code and this patch helps filter them out.
> > > See e.g. patch 2/2
> > > 
> > > -			dev_err(&slave->dev,
> > > -				"Clk Stop type =%d failed: %d\n", type, ret);
> > > +			sdw_dev_dbg_or_err(&slave->dev, ret != -ENODATA,
> > > +					   "Clk Stop mode %d type =%d failed: %d\n",
> > > +					   mode, type, ret);
> > 
> > You just added a debug log for no reason.
> 
> The number of logs is lower when dynamic debug is not enabled, and equal
> when it is. there's no addition.
> 
> The previous behavior was unconditional dev_err that everyone sees.
> 
> Now it's dev_err ONLY when the code is NOT -ENODATA, and dev_dgb otherwise,
> meaning it will seen ONLY be seen IF dynamic debug is enabled for
> drivers/soundwire/bus.c
> 
> Allow me to use another example from patch2:
> 
> -		if (ret == -ENODATA)
> -			dev_dbg(bus->dev,
> -				"ClockStopNow Broadcast msg ignored %d", ret);
> -		else
> -			dev_err(bus->dev,
> -				"ClockStopNow Broadcast msg failed %d", ret);
> +		sdw_dev_dbg_or_err(bus->dev, ret != -ENODATA,
> +				   "ClockStopNow Broadcast msg failed %d\n", ret);
> 
> There's no new log, is there?

No, but that is not what you showed above which was just an error
message being replaced with both a debug and an error message.

Just drop the debug messages, they are pointless, right?

thanks,

greg k-h
