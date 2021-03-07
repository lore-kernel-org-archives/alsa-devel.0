Return-Path: <SRS0=dfEF=IF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F632C433E0
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Mar 2021 17:22:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB6D650E5
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Mar 2021 17:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB6D650E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEFAF1916;
	Sun,  7 Mar 2021 18:21:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEFAF1916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615137748;
	bh=1KRF+QdmKBgN/dGjfMYZMayYommFcELzOtAraoM/GK4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y8jQHzrVAal8AVcVXEU1BzIwVuWyb9Kd4SMPOGiOnDl75fBr3r+AvAOogtlL3I7AF
	 JlEaiU/7ILKLGzJ3YJDHEuMTm/ojRYGeBAIWEWWlezXFoLif7rNVRy4Lb05I/5zCUt
	 czh08171CBNmApfvOcFybL7fJ2NaqdYDxEA1PH64=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43749F8019B;
	Sun,  7 Mar 2021 18:21:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1464DF80227; Sun,  7 Mar 2021 18:21:37 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86289F800ED
 for <alsa-devel@alsa-project.org>; Sun,  7 Mar 2021 18:21:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86289F800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="RkgTxl9/"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 127HHE0O004818; Sun, 7 Mar 2021 11:21:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=0aiXOOSfs2+Dss6qwMhy0OdxOoHU59kxrpWFaQIHoUY=;
 b=RkgTxl9/9jBylzhl0ZDZKM2h6J/mgy4lri1k7iO0WEswzlqXsvsdalp8LO41f7ZdJNSi
 jQpV92xJ5WMBydr70K1ucEYkD4sJRAI7cuqibVX1ljfq1p4zbyR/gm9J1ZM3Q9ee8yFi
 5/F+wUOJ9txiGOsqtDKKR/fp31Wds+eVVRGgxoRAbPA63R7hJtvxPp8VDl9jkvL1EBvg
 ZUchxHC0y6J3rfuForsvpfl4TZRlNftTfePsiClL6YoWIzbjQHml4+ViundqL9UZhxrU
 yWx7e/OZ89qqFz4IqvPH9K8oRVcJpBZvvKDVhzQQ91hjTbr5ydkbtZtrt7UfM5uQCe6C qw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 37471vs4ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Sun, 07 Mar 2021 11:21:26 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sun, 7 Mar 2021
 17:21:25 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sun, 7 Mar 2021 17:21:25 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 26EFD11D6;
 Sun,  7 Mar 2021 17:21:25 +0000 (UTC)
Date: Sun, 7 Mar 2021 17:21:25 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: wm8960: Remove bitclk relax condition in
 wm8960_configure_sysclk
Message-ID: <20210307172125.GF106851@ediswmail.ad.cirrus.com>
References: <1614740862-30196-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1614740862-30196-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 adultscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103070095
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 gustavoars@kernel.org, kuninori.morimoto.gx@renesas.com,
 patches@opensource.cirrus.com, tiwai@suse.com, lgirdwood@gmail.com,
 peter.ujfalusi@ti.com, broonie@kernel.org, daniel.baluta@nxp.com,
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

On Wed, Mar 03, 2021 at 11:07:42AM +0800, Shengjiu Wang wrote:
> The call sequence in wm8960_configure_clocking is
> 
>    ret = wm8960_configure_sysclk();
>    if (ret >= 0)
>         goto configure_clock;
> 
>    ....
> 
>    ret = wm8960_configure_pll();
> 
> configure_clock:
>    ...
> 
> wm8960_configure_sysclk is called before wm8960_configure_pll, as
> there is bitclk relax on both functions, so wm8960_configure_sysclk
> always return success, then wm8960_configure_pll() never be called.
> 
> With this case:
> aplay -Dhw:0,0 -d 5 -r 48000 -f S24_LE -c 2 audio48k24b2c.wav
> the required bitclk is 48000 * 24 * 2 = 2304000, bitclk got from
> wm8960_configure_sysclk is 3072000, but if go to wm8960_configure_pll.
> it can get correct bitclk 2304000.
> 
> So bitclk relax condition should be removed in wm8960_configure_sysclk,
> then wm8960_configure_pll can be called, and there is also bitclk relax
> function in wm8960_configure_pll.
> 
> Fixes: 3c01b9ee2ab9 ("ASoC: codec: wm8960: Relax bit clock computation")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
