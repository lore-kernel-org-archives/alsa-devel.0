Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD555FA373D
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Nov 2022 09:40:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB1CC1682;
	Tue,  1 Nov 2022 10:39:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB1CC1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667295605;
	bh=5k3x0Vz8WJqTa6uyMJvi+b8f3ph0HHWRAo98dfB5Oek=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BjvBE7Nkk0Ayfqf0sngO066HMZLxoLcVlA2zixfUJpIdgiv5XQ1XsGsPG+JGx3/yH
	 F26lnETtw6bS2G74ZdBCTqhw2dndPG63gDV+C5LnzTxvgr4c9ivmklXzKCvIpKXZLb
	 Sapmy3KroUbN/ewUu2qz97X5n41f5UoUlBBeNI/U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77007F8028D;
	Tue,  1 Nov 2022 10:39:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BFD4F80423; Tue,  1 Nov 2022 10:39:12 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20ECAF800F3
 for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2022 10:39:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20ECAF800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="AhDSKoU+"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2A14vYJZ031601; Tue, 1 Nov 2022 04:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=kr6z9lQxoGcTz2dnir8DYxHyHWTDYYd2mshXwPWC9qY=;
 b=AhDSKoU+eCTbc65qY3gE6zuf1pmJVkNnrWtRCKScimXiWUZd5ZCmURJu1meJ/xnAtox/
 QiHiwz7+9cBWgibaKYg9sH00pq1UmrcP5FMe6isbos7vlQDBReW7d5FMpysiKc4ks382
 RvBaK8oFu6WLN3cTopi5ioJPCQbv+oQ6sYEgHpTlQlPYMXBIT67mmcwN9WaZjeTaZfcJ
 wvxCLEJ0d7HLVdBZcMY6AjXeBHsyOqwmw2rn2mMpKuolMnRIBvCUDpZ83zORdzeSeuyT
 8mvHHXPaXDIBvnJWbm40xZSnA/uQQt8jjNGOT6PVRWTiGFXTCKdawFIq5XdfZqoSQpZt kQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kh0kpk5uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Nov 2022 04:39:03 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Tue, 1 Nov
 2022 04:39:02 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Tue, 1 Nov 2022 04:39:02 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1168DB06;
 Tue,  1 Nov 2022 09:39:02 +0000 (UTC)
Date: Tue, 1 Nov 2022 09:39:02 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Peter Bergin <peter@berginkonsult.se>
Subject: Re: [PATCH v3] ASoC: cs42xx8-i2c.c: add module device table for of
Message-ID: <20221101093902.GH92394@ediswmail.ad.cirrus.com>
References: <20221031203723.168177-1-peter@berginkonsult.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221031203723.168177-1-peter@berginkonsult.se>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: d0wAoJWUuyBJYk_gULEmugXMUaF8Kiyq
X-Proofpoint-GUID: d0wAoJWUuyBJYk_gULEmugXMUaF8Kiyq
X-Proofpoint-Spam-Reason: safe
Cc: alsa-devel@alsa-project.org, tanureal@opensource.cirrus.com,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, david.rhodes@cirrus.com,
 rf@opensource.cirrus.com, broonie@kernel.org, james.schulman@cirrus.com,
 linux-kernel@vger.kernel.org
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

On Mon, Oct 31, 2022 at 09:37:23PM +0100, Peter Bergin wrote:
> When trying to connect the device with the driver through
> device-tree it is not working. The of_device_id is defined in
> cs42xx8.c but is not correctly included in cs42xx8-i2c.c.
> 
> Move of_device_id table to cs42xx8-i2c.c. Get cs42xx8_driver_data
> in cs42xx8_i2c_probe() and pass as argument to cs42xx8_probe(). Move
> error check if no driver data found to cs42xx8_i2c_probe().
> 
> Signed-off-by: Peter Bergin <peter@berginkonsult.se>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
