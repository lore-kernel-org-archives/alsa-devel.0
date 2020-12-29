Return-Path: <SRS0=cglx=GB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9F9C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Dec 2020 12:13:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F042078D
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Dec 2020 12:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F042078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD407175A;
	Tue, 29 Dec 2020 13:12:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD407175A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609243998;
	bh=tloEVrmlAXWxH+Ai6sR7lJDJEoiX/hUAS5bEE9OKf4A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mifJJl0WL7PyUbEus5cEcOdPB/gotMbAPti2q9zm5hgOk3kZon5vcdP5OnjZKaPjv
	 +vGnnyq84c9dS4VVOSEnqBpHbYgYYnElGvF8JrKzFanrnmPef5dQUKedhbJ/O3ypuE
	 +0ZaadBcHClG41JWHvyGDeCkiySxis+bbvBWbFQo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DF90F8022B;
	Tue, 29 Dec 2020 13:12:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8B55F80274; Tue, 29 Dec 2020 13:12:26 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC573F80162
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2020 13:12:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC573F80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="kTXwCz3w"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0BTC65vq003360; Tue, 29 Dec 2020 06:12:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=XzSzeiMkz3xC8gN0V+6Id8JeJE8RFvkW97wanhq9H0s=;
 b=kTXwCz3wKD6hweKav7qzEV3dJ83/ZpHzh1k8JgafNAd6lQOAXYBp/xpcV0sDMFwM6qyd
 4JlB75Gm4Tm4u6MMrzO9DAwQed+scbuyguw7x6EKfqn4C2Dsb7oMjhARe28cTC4qztxt
 QsGYZ2wy7kbNoHk1ekPfGWc/AcGjV0LxtjSxmfIL19Md/sCP4UJ9DweY18erPkVQGugo
 58vGS/kXXx0WuwEvGWk3GWOm4yTAbZ/egEfVxzZvGGXRs+41p037lN2fpeH5RoUy+1vf
 1rhutGFp/JwXe0JdYkSF6S5aNYghGd4sPqX4wKA04jS7R0203ekgmPQYwcxa7TDGatiQ UA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 35p3f7a8xn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 29 Dec 2020 06:12:19 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 29 Dec
 2020 12:12:17 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 29 Dec 2020 12:12:17 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0743111CB;
 Tue, 29 Dec 2020 12:12:17 +0000 (UTC)
Date: Tue, 29 Dec 2020 12:12:17 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 08/14] extcon: arizona: Fix flags parameter to the
 gpiod_get("wlf,micd-pol") call
Message-ID: <20201229121217.GL9673@ediswmail.ad.cirrus.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-9-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201227211232.117801-9-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=648
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012290077
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Mark Brown <broonie@kernel.org>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
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

On Sun, Dec 27, 2020 at 10:12:26PM +0100, Hans de Goede wrote:
> The initial value of the GPIO should match the info->micd_modes[0].gpio
> value. arizona_extcon_probe() already stores the necessary flag in a
> mode variable, but instead of passing mode as flags to the gpiod_get()
> it was using a hardcoded GPIOD_OUT_LOW.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
