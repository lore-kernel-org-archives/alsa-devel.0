Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1ADC4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Nov 2022 09:36:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 657E81673;
	Wed, 23 Nov 2022 10:36:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 657E81673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669196215;
	bh=nzc00OMtZa6Jve1odhFgI0K35IZPAmoM1rXBfC6J74w=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SeJG+Mu0VZbGYWHO/LDuRJicYU9mL1VFuHISsWcN5v+0N7MSeT0t2JKGZAIHyfLLr
	 8cGM2AeisGrYpDYRHbkfah2XCmf6KvZwS/WqxFz42QPeidL1ZTWdP9jdjIK7x6qBC4
	 DMUSRbtS9JRzuIRM3R9MhZeYPncs5pkWGenI7q1g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11DA6F80249;
	Wed, 23 Nov 2022 10:36:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8337DF8025D; Wed, 23 Nov 2022 10:36:03 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FC5FF800BB
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 10:35:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FC5FF800BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="lMrWZLPD"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AN7bePZ029400; Wed, 23 Nov 2022 03:35:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=wHed+5qsoNRfgm5HzbV5rq5eqU2Eoij756sk0MFjYTc=;
 b=lMrWZLPDNBeOKrD9JKdE87iemvauRqrpbUbZsVfxThc2+2bdU2sVMDkmYSQ1Di9tYQ4i
 EPFHKea5tGRK9e3yJdv/Q9Z3lgIaR/GTmwFAYjrAimhB5QRbKf5da+UpJzvWswEEFcj7
 E+ynamyYDaRkR4ja5p4WofhRsY7q1JjTjaYh36nqNdmOdOF0K/Gv3KTHiOuBhXxp2qRG
 U8l1XCwOD8GQx7AiSHSHW13J/jDjlzALLaByAycm7glZvugxSmeHXo1bdsq/jZoY02Dr
 demBpFz0dZ8dJXCtGAfaGb5Kj99RjwdROrDiUFxU36WTL91SRqp9dELO0DkVsqsvEQGo jQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kxwe6vpa5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Nov 2022 03:35:55 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 23 Nov
 2022 03:35:47 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Wed, 23 Nov 2022 03:35:47 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6EE11477;
 Wed, 23 Nov 2022 09:35:47 +0000 (UTC)
Date: Wed, 23 Nov 2022 09:35:47 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] soundwire: bus_type: Avoid lockdep assert in
 sdw_drv_probe()
Message-ID: <20221123093547.GC105268@ediswmail.ad.cirrus.com>
References: <20221121162453.1834170-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221121162453.1834170-1-rf@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: iGXtesuZiytKFN4IDNvRloRAlC8H0Xi2
X-Proofpoint-GUID: iGXtesuZiytKFN4IDNvRloRAlC8H0Xi2
X-Proofpoint-Spam-Reason: safe
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 vkoul@kernel.org, sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
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

On Mon, Nov 21, 2022 at 04:24:52PM +0000, Richard Fitzgerald wrote:
> Don't hold sdw_dev_lock while calling the peripheral driver
> probe() and remove() callbacks.
> 
> Holding sdw_dev_lock around the probe() and remove() calls
> causes a theoretical mutex inversion which lockdep will
> assert on. The peripheral driver probe will probably register
> a soundcard, which will take ALSA and ASoC locks. During
> normal operation a runtime resume suspend can be triggered
> while these locks are held and will then take sdw_dev_lock.
> 
> It's not necessary to hold sdw_dev_lock when calling the
> probe() and remove(), it is only used to prevent the bus core
> calling the driver callbacks if there isn't a driver or the
> driver is removing.
> 
> If sdw_dev_lock is held while setting and clearing the
> 'probed' flag this is sufficient to guarantee the safety of
> callback functions.
> 
> The potential race of a bus event happening while probe() is
> executing is the same as the existing race of the bus event
> handler taking the mutex first and processing the event
> before probe() can run. In both cases the event has already
> happened before the driver is probed and ready to accept
> callbacks.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
