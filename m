Return-Path: <SRS0=4A4t=HB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6840C433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Jan 2021 15:31:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3094B64E13
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Jan 2021 15:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3094B64E13
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67EED1734;
	Sat, 30 Jan 2021 16:30:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67EED1734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612020696;
	bh=lCBjHmEWrNYZ6fGx+GBh6UXGB/maenGE8DdPNNi7QEM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BaO5bF43uetdD6FY+7I+TGTeDqoLCedlsbz4URaBciDV56nut+2e5ex+n8ZQd2pJz
	 Re5EmaI3i1jdaPkIPVyGbTvBHI5PBWAut4wS/IMrqpZSfoMB5w57N/6Z0yLbJCrdK6
	 vVccPcd3aZHlqUyCExN+wDwIplDb4ULmxv7yK2hE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EDE75F80158;
	Sat, 30 Jan 2021 16:30:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9E57F801ED; Sat, 30 Jan 2021 16:30:44 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E14D7F800BE
 for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2021 16:30:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E14D7F800BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Gyu2Xm2Q"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10UFOuav015946; Sat, 30 Jan 2021 09:30:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=SV9cWaItWuRlt+zqqFYUknlNBZMx1WFXf/zpxaytK0E=;
 b=Gyu2Xm2QAC/Y6pTMh9MqJk1rdYCLmjumkTPa8XG78MrBKhPW9wx955hllVVHXIURaifO
 HZeedcR5W76Y/63RrkxMLbWMtNV9kaL9D/EO7vR68FXgDKHYuuvF49M7CZKtTHiT/7eQ
 dSoVSjDLAVq5KtOlLoiVxI4W/qOYiR6Ay8lnTcXfN9y2mM+0Y9b7VqFZpFJCxphHyEFS
 CWBRC4KxduAUeP3vYHVVjGC+WkgbvUeSxGzZa6RdAwVAl+Gj01OUAJ0F2dQynI72xfc7
 ikGZ0JE9tWw3NhL2Q/XBoIxg0ENBQu5Rw2qdeNGyNYhCXZQgF21aJu+eZjtT7UpEma63 6w== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 36d5r6855b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Sat, 30 Jan 2021 09:30:35 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Sat, 30 Jan
 2021 15:30:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Sat, 30 Jan 2021 15:30:33 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3DCB345;
 Sat, 30 Jan 2021 15:30:33 +0000 (UTC)
Date: Sat, 30 Jan 2021 15:30:33 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 11/13] ASoC: arizona-jack: Cleanup logging
Message-ID: <20210130153033.GV106851@ediswmail.ad.cirrus.com>
References: <20210123121313.79530-1-hdegoede@redhat.com>
 <20210123121720.79863-1-hdegoede@redhat.com>
 <20210123121720.79863-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210123121720.79863-2-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=830 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101300085
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>,
 Lee Jones <lee.jones@linaro.org>
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

On Sat, Jan 23, 2021 at 01:17:18PM +0100, Hans de Goede wrote:
> Cleanup the use of dev_foo functions used for logging:
> 
> 1. Many of these are unnecessarily split over multiple lines
> 2. Use dev_err_probe() in cases where we might get a -EPROBE_DEFER
>    return value
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
