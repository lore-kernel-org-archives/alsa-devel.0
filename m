Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F18C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 11:16:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8921264F0E
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 11:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8921264F0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8354816C7;
	Tue,  2 Mar 2021 12:15:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8354816C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614683798;
	bh=sL8tllz3lG9XKoN8B/9ooSEaq/7X7orhlrjPIYEUHDk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gOFPnZ3kIw1158mS1+aq8wHL0Rte01jMjWtEXqRNu8U09zp4fQKrw/22phiY+bcry
	 8B8Hsfu1+n9JJUb2cAZU1WpXwq89D6BbrH5uoNIrIYEqWmp2POcJLIT+RHdUAOL2Jz
	 alvQz7SXY7BoVYYyeJtyKumiHNrjmqmPKNYv/mjE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C208F80088;
	Tue,  2 Mar 2021 12:15:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A24DEF80269; Tue,  2 Mar 2021 12:15:46 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8820EF80088
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 12:15:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8820EF80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="ch+DiDGL"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 122B8bUg026898; Tue, 2 Mar 2021 05:15:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=QDkiboOLb89Ts9q2Ag7ZAK43M11OLKpJHEeRPp+1Y+s=;
 b=ch+DiDGLPG9lHmOArfKE+pQ2iP24WwcGSwhK70fqTwqOyBa15PeUOyupQevSlSGxIXO3
 W/ALocT+kNPUCiuM+VkgmwBku9j5qgeo2LEqMO/hEOyMYpNn3KDeN6bSHmTWguy/sMHV
 3e3DDYZzTjRZkrJrcPdo0lTJT4AdnKt5EV7pK+oO/MuQh1oAdQV4HillXPkVnDd/lGsD
 nPo8PlHhw1rB3UxujFiMB2UdfJlhs2zeheCwXkSLZj0+aXRsNonRuVD6oWWO+ek8ENg5
 dnYXucDH3pugd6pFVfiy6s6+Kx33eVu0p0O8YKQ7Fh5YpzFyIdoSYjOR1Lmb1SKlgSDG lQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 36ymc6u9hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 02 Mar 2021 05:15:37 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 2 Mar 2021
 11:15:35 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 2 Mar 2021 11:15:35 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DF20511D0;
 Tue,  2 Mar 2021 11:15:34 +0000 (UTC)
Date: Tue, 2 Mar 2021 11:15:34 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: wm8524: Do not print probe defer error
Message-ID: <20210302111534.GB106851@ediswmail.ad.cirrus.com>
References: <20210301193328.2123511-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210301193328.2123511-1-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1011 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=879 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020093
Cc: patches@opensource.cirrus.com, shengjiu.wang@nxp.com, broonie@kernel.org,
 alsa-devel@alsa-project.org, cphealy@gmail.com
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

On Mon, Mar 01, 2021 at 04:33:28PM -0300, Fabio Estevam wrote:
> On an imx8mq-evk the following error is seen:
> 
> [    1.375809] wm8524-codec audio-codec: Failed to get mute line: -517
> 
> It happens because the codec driver may probe prior to the imx gpio
> driver, which causes a probe defer.
> 
> Change to dev_err_probe() to avoid printing this error.
> 
> Reported-by: Chris Healy <cphealy@gmail.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
