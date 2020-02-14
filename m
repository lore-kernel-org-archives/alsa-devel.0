Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532C0C35242
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:03:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C589E206D7
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R28P2LhD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcAQT7b3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C589E206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 258D283A;
	Fri, 14 Feb 2020 21:02:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 258D283A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581710623;
	bh=cokPICcsu0DktKj6FijT6i7hbl4ZQ9B0gKijjltp12A=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R28P2LhD1A/QxmavlhLimc+IuoMYLzIKt5nlBZY2f+d9Wjwy0mikzWAzgWT9E+ZHI
	 kFWgGjqUPqSOApVPMe5mz23i40zGqBlljwPydy+6P30xqDP7JE7CQsybsrn9wExYyk
	 pUu1adzFJfUW9ytw5pmz6X0yOPWCBteSzSQAu3fU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DC8AF8013E;
	Fri, 14 Feb 2020 21:02:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A4C6F8014F; Fri, 14 Feb 2020 21:02:51 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6AD6F800F0
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 21:02:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6AD6F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="BcAQT7b3"
Received: from localhost (unknown [12.246.51.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EE68B22314;
 Fri, 14 Feb 2020 20:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581710564;
 bh=QcIJ80cSrTLbc0ijPcYyAEl69PScjRPdVxZgDXvJ9xc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BcAQT7b3UsozO8tgtKaqo0+sV/Y3pR/4in8pvPvVbfeyVmmGtiURftnAz3sPr0ADO
 ubEZXiZVhn4f/gAdDv5P9tSLslG6flQmBhk/2bmHUxK65O6y7mKiZjppO0tRApp+0C
 AK1LIajBj0wi4Mzq5Uy5O3d4BI9UqXf+PHT/T/28=
Date: Fri, 14 Feb 2020 08:49:19 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20200214164919.GB4016987@kroah.com>
References: <20200201042011.5781-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200201042011.5781-1-pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 0/2] soundwire: add
	master_device/driver support
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

On Fri, Jan 31, 2020 at 10:20:09PM -0600, Pierre-Louis Bossart wrote:
> The SoundWire master representation needs to evolve to take into account:
> 
> a) a May 2019 recommendation from Greg KH to remove platform devices
> 
> b) the need on Intel platforms to support hardware startup only once
> the power rail dependencies are settled. The SoundWire master is not
> an independent IP at all.
> 
> c) the need to deal with external wakes handled by the PCI subsystem
> in specific low-power modes
> 
> In case it wasn't clear, the SoundWire subsystem is currently unusable
> with v5.5 on devices hitting the shelves very soon (race conditions,
> power management, suspend/resume, etc). v5.6 will only provide
> interface changes and no functional improvement. We've circled on the
> same concepts since September 2019, and I hope this direction is now
> aligned with the suggestions from Vinod Koul and that we can target
> v5.7 as the 'SoundWire just works(tm)' version.
> 
> This series is provided as an RFC since it depends on patches already
> for review.

Both of these look sane to me, nice work!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
