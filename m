Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A65CC43334
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jun 2022 15:51:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8BB71F3E;
	Fri, 17 Jun 2022 17:50:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8BB71F3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655481089;
	bh=PX10u2r1x25L3XuK8Y1bSpiKJbAjv6U3nATdOhWRAVA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oPsoY6vr9/SM+LQWgF7texnb7QAmvZYBQXJPnY+WmMLe/uvpdkvz3hN/fWZWceSUm
	 TLH2NNx01R18K01rnVTISKKSgxUIPe2TUq3ym2dpt7AYfie/r+y2KBRzP1XwxCLaBl
	 8mnB0mbjhwWSHGl34z5alueXrRplQ85Qrs0r0+40=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 182DDF8051F;
	Fri, 17 Jun 2022 17:50:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3B7EF8028B; Fri, 17 Jun 2022 17:50:37 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8BED5F8028B
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2022 17:50:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BED5F8028B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="llf4ZdqG"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25H3eJxo019085;
 Fri, 17 Jun 2022 10:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Ahdx8sBoxSV39mhILpNiLucN5DgFPfJrpifEXjQFb5c=;
 b=llf4ZdqGNcKfhg9Pn3WEVdHkpS8YZ9snRyfeGtLSYu4lDBwll/0pi83nXYwpGgWKaTvI
 3WS/q7CY1X48Kmi7hKQoEzEctAmQQwoo4XS0ngJB1ZqtN7Yz19z8wfAlRKcEQBza6jjd
 a3pZxfhdahX+UNezO3WvwjF1QYlXmq8PdvUBr+zUb1BJ+SNOWg2thye8/4DcPlnrSuFe
 cUok9y/1F+v14F/KYW5ev9KKb7qZ+IRqE+3MaCeCRCXsQ4IToiAzbWEc2zevdowrJ4KV
 8hwJ/zdLXHloBLWGt+aTjLJ+35xomMW8iG8/MjzUD1xFaDHyXyQuCG90DD4VuBJDLaHY iA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gmqfq79r8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 17 Jun 2022 10:50:29 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 16:50:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 17 Jun 2022 16:50:28 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3D454468;
 Fri, 17 Jun 2022 15:50:17 +0000 (UTC)
Date: Fri, 17 Jun 2022 15:50:17 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v1] ASoC: ops: Fix integer detection for when max
 possible values > 1
Message-ID: <20220617155017.GF38351@ediswmail.ad.cirrus.com>
References: <20220617153606.2619457-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220617153606.2619457-1-sbinding@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: UpVMj3PBZs9Q-zpD-1y79KJr-yYNuJjg
X-Proofpoint-GUID: UpVMj3PBZs9Q-zpD-1y79KJr-yYNuJjg
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
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

On Fri, Jun 17, 2022 at 04:36:06PM +0100, Stefan Binding wrote:
> The standard snd_soc_info_volsw() allows a two value control to be
> defined as an integer control only if the control name ends in
> "Volume". It achieves this by creating a substring if it contains
> " Volume", and ensuring this exists at the end of the name. The
> volume substring is then used to decide whether the type is a
> SNDRV_CTL_ELEM_TYPE_INTEGER or SNDRV_CTL_ELEM_TYPE_BOOLEAN.
> However this volume substring is only computed for a two value
> control.
> This means for controls where there are more than two possible
> values, the substring is never created, so in this case the
> substring remains NULL, and the condition yields
> SNDRV_CTL_ELEM_TYPE_BOOLEAN, even though there are more than 2
> possible values.
> If there are more than 2 possible values for the control,
> then it should always be an integer control.
> 
> Fixes: aa2a4b897132 ("ASoC: ops: Fix boolean/integer detection for simple controls")
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
