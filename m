Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0CCC433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 10:04:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52562332B
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 10:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52562332B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB5791841;
	Wed, 20 Jan 2021 11:03:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB5791841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611137037;
	bh=UM/Q2grqGnIapierNb1yYfNEHQvSJMGUuvNA3cJd9+M=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FE89Zyl+kXgyNoOrnjSIkOTNkNCYL22OoQz2yu4JSqpd3E5tcn4d2XtchjqGmDJhU
	 3Fc9pKF0Zr+4xhn7kEJre6gaHhQFKhxNR03cBeWDyTnEdrBYh2nF4lE+gIg+MNhMnY
	 IxCXerUqKJe9v+TF9RRXKJ2vUc4dmIhI0sEMuiXU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57BAEF80166;
	Wed, 20 Jan 2021 11:03:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07044F8016E; Wed, 20 Jan 2021 11:03:06 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84DC2F80164
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 11:02:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84DC2F80164
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="eP2mmFyM"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10K9voSf022653; Wed, 20 Jan 2021 04:02:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=3cMPXgGKn9KcSz1orpznqtODBy5qNer/ihVn8Z7C4bU=;
 b=eP2mmFyMdNKz+7w5BAOD6hIfBQ/4n08GaWSnkNEN5zoDKLurzm2xqv5+ZnJPAYaK1/3v
 8G8U+OdfOYTpI2lD7abf1aRFYyzjL/9s3YGRAYs3eBqf7To7RcEPjhpXxToe0f+YbWR1
 JC/qUUR71k3OdtnRczL5eIz4qb5kJqcm2LX9+WLO57HeR7/Vk1o3Pxw9vb2IOgzFznG9
 hEVq/O8qtrw8TXiRkda2hT2GR1NmKs1Eqd+fudWAz1+9IoXqfebAHCx5ao0d8Y3kIiOQ
 GpFruTEd3rKMapFPImUWZwQYA9Bb1KuSTB6MN44TUkqIo0uErOIEQ+6miATtlbgLQAnc rA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 36692r8gfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 20 Jan 2021 04:02:53 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 20 Jan
 2021 10:02:51 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 20 Jan 2021 10:02:51 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 907C045;
 Wed, 20 Jan 2021 10:02:51 +0000 (UTC)
Date: Wed, 20 Jan 2021 10:02:51 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 2/5] mfd: arizona: Replace arizona_of_get_type() with
 device_get_match_data()
Message-ID: <20210120100251.GC106851@ediswmail.ad.cirrus.com>
References: <20210117212252.206115-1-hdegoede@redhat.com>
 <20210117212252.206115-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210117212252.206115-3-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=743 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200056
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

On Sun, Jan 17, 2021 at 10:22:49PM +0100, Hans de Goede wrote:
> Replace the custom arizona_of_get_type() function with the generic
> device_get_match_data() helper. Besides being a nice cleanup this
> also makes it easier to add support for binding to ACPI enumerated
> devices.
> 
> While at it also fix a possible NULL pointer deref of the id
> argument to the probe functions (this could happen on e.g. manual
> driver binding through sysfs).
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
