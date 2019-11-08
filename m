Return-Path: <SRS0=0Fuw=ZA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899ABC5DF60
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:08:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CC221D6C
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I6dnOu+B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Wowt4+gy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CC221D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 359451666;
	Fri,  8 Nov 2019 17:07:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 359451666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573229285;
	bh=1R8poenKnQtu1Kcq8P+jqjFohZmWvXa6NZCFDu160Hg=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I6dnOu+Be04sXK4Pi438fkRP2hURFEkeUcFSBiciTkkDHmrKjBx44j5uUiXluvaCC
	 KnePgyq4zPYYQGQ7IJgA2UH7n91Oj6WzoxRFH0n2NkIrZOw3T9oZjgNNR7So56K7go
	 Oywn9NxMw7GV/1mQLZnTBBQRyzw8/FUrTVCa8igU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9551EF80321;
	Fri,  8 Nov 2019 17:07:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D124AF803D0; Fri,  8 Nov 2019 17:07:12 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF093F800F3
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 17:07:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF093F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Wowt4+gy"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xA8G4LnJ006738; Fri, 8 Nov 2019 10:07:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=8sfSVCnGboedt/b1ZhqJ7bI2jbmOSniGz207iomPpS4=;
 b=Wowt4+gy6hEErv+Hrv/3ESKn9QBAXk4FtrZigukHe5fLSbLoIkUkAvcXg29t5BoJX2nB
 6SgSxUQDIAaYndZIKvVXS8yWXNhm+2qyNj2yIIyBg5zI8DQusVOhUYm/13ITXvzw569Q
 co+uuMb6y42zWICCo9yhVfjT5djMr2CiP7AMEBnMhVFoUq7viwkBKU9X0NEkjE7H3Lm/
 n2TAkKcVOqLUdACAJjwrHkSPPAKB6Fc4b2fAvzzcItljtNlSToprwBp7VCvun68Iiqfr
 +qHJ9dZUGTEJk0JHGezzGu7KfNvKkrLnt5hU80I+/g9QjHnx+EkVRFzoomWfqlsKx1mj 4A== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 2w41w6udan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 08 Nov 2019 10:07:06 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 8 Nov
 2019 16:07:04 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Fri, 8 Nov 2019 16:07:04 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7C5B92A1;
 Fri,  8 Nov 2019 16:07:04 +0000 (UTC)
Date: Fri, 8 Nov 2019 16:07:04 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Michael Walle <michael@walle.cc>
Message-ID: <20191108160704.GA10439@ediswmail.ad.cirrus.com>
References: <20191107231548.17454-1-michael@walle.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191107231548.17454-1-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=805
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911080160
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8904: configure sysclk/FLL
	automatically
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

On Fri, Nov 08, 2019 at 12:15:48AM +0100, Michael Walle wrote:
> This adds a new mode WM8904_CLK_AUTO which automatically enables the FLL
> if a frequency different than the MCLK is set.
> 
> These additions make the codec work with the simple-card driver in
> general and especially in systems where the MCLK doesn't match the
> requested clock.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> +static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> +			     unsigned int freq, int dir)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct wm8904_priv *priv = snd_soc_component_get_drvdata(component);
> +	unsigned long mclk_freq;
> +	int ret;
> +
> +	switch (clk_id) {
> +	case WM8904_CLK_AUTO:
> +		mclk_freq = clk_get_rate(priv->mclk);
> +		/* enable FLL if a different sysclk is desired */
> +		if (mclk_freq != freq) {
> +			priv->sysclk_src = WM8904_CLK_FLL;
> +			ret = wm8904_set_fll(dai, WM8904_FLL_MCLK,
> +					     WM8904_FLL_MCLK,
> +					     clk_get_rate(priv->mclk), freq);

minor nit, might as well use mclk_freq rather than calling
clk_get_rate again, other than that though I think this looks
good.

Thanks,
Charles
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
