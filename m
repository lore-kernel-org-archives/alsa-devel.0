Return-Path: <SRS0=8+EQ=IJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC69AC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 09:24:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A6864FB0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 09:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A6864FB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B09A41730;
	Thu, 11 Mar 2021 10:23:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B09A41730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615454654;
	bh=FVCssB8SEYNrVY8ay1I5oxZmjTJK+CUFySJvnfUsC/8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K9C9MAKTW36N/w6DBfs0IiKmZFVAe1d6KCn5clssY744EILZ3rqxLT5u7Nb/Q2auF
	 sjsPDyaQMZBT3ZGl9jkKIBNBxhOdncIqAZtXd3tErEaviqmTtkEhNcoa2IH3yc659R
	 6DJvfv2eqKmAdHf0FnoJSTiusPSh+HA08vjXlIqQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFF64F8025A;
	Thu, 11 Mar 2021 10:22:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 368BCF80275; Thu, 11 Mar 2021 10:22:38 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BF9EF800BF
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 10:22:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BF9EF800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Z1QjuvYX"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12B9BHg1004441; Thu, 11 Mar 2021 03:22:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=uVFWPkLD77nKXzA5gCRB6VKKun8nHT4AjxrUF8psGwQ=;
 b=Z1QjuvYXy7jb9UxUPa/ctGatSLzJdJxP+Rc8C7oi677+Xzo/b1X8K4Ah7yLuxU6S5jpZ
 th8zFP8eVkZK7RyKnXhC7g/mPqi8rlt7cuK3yWYSHDXxoIqpmpnnZNppDhwE8yDdvUBE
 UqNFfBd9w0uAc+W16DGUHdB4PsgK/VEq7gxROFsKWQ/JDAS7CNzYMiQLQGmOiOcpuadX
 CPHcgNIK1Q/9anjJ/+j7AWS0YsDfwCcVys20v5o10p4135I4JciG5Helg+ZUg0UOtLeJ
 /sbxX3qSOkyLjSEoldw+pXTHjD0FmekUZr61S5E/zAT5fWmoYbJj62ejdoZyB17Us9u9 3A== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 374819e29n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 11 Mar 2021 03:22:24 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 11 Mar
 2021 09:22:22 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 11 Mar 2021 09:22:22 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 14EFA11CF;
 Thu, 11 Mar 2021 09:22:22 +0000 (UTC)
Date: Thu, 11 Mar 2021 09:22:22 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 02/10] ASoC: madera: align function prototype
Message-ID: <20210311092222.GJ106851@ediswmail.ad.cirrus.com>
References: <20210311004332.120901-1-pierre-louis.bossart@linux.intel.com>
 <20210311004332.120901-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210311004332.120901-3-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110050
Cc: tiwai@suse.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 broonie@kernel.org
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

On Wed, Mar 10, 2021 at 06:43:24PM -0600, Pierre-Louis Bossart wrote:
> cppcheck warning:
> 
> sound/soc/codecs/madera.c:3372:51: style:inconclusive: Function
> 'madera_init_dai' argument 2 names different: declaration 'dai'
> definition 'id'. [funcArgNamesDifferent]
> int madera_init_dai(struct madera_priv *priv, int id)
>                                                   ^
> sound/soc/codecs/madera.h:433:51: note: Function 'madera_init_dai'
> argument 2 names different: declaration 'dai' definition 'id'.
> int madera_init_dai(struct madera_priv *priv, int dai);
>                                                   ^
> sound/soc/codecs/madera.c:3372:51: note: Function 'madera_init_dai'
> argument 2 names different: declaration 'dai' definition 'id'.
> int madera_init_dai(struct madera_priv *priv, int id)
>                                                   ^
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
