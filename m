Return-Path: <SRS0=4A4t=HB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B401C433DB
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Jan 2021 15:26:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD2D64E0E
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Jan 2021 15:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD2D64E0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03CB716F7;
	Sat, 30 Jan 2021 16:25:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03CB716F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612020390;
	bh=RgOT3hp3yonrlk2TV97rvLSQ8E78jTsHuwdDBFYns2w=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GwA6GLgpksZOmyX2uyWRGgQaRmaTPupimM0rv8eHx3f9V67u6h1XJlISxd1V+vmc+
	 goB8xyKzmxkdB66bmT1kiISItTs5MPWGuAnjF8p88Ex3gci9adRYS1pHOWMi8LwAE3
	 6dCLpEpFgcvFAvasoip/NuCAPTm8ZwO/CEqrzsIQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6106EF80158;
	Sat, 30 Jan 2021 16:25:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84E36F8015B; Sat, 30 Jan 2021 16:25:37 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A11BF80143
 for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2021 16:25:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A11BF80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="EiiRDOX5"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10UFHhtL024362; Sat, 30 Jan 2021 09:25:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=wu2BmKAmJwuH5eUZiZFTsmcq0Qh2USc2IKxpS+55d3Q=;
 b=EiiRDOX530k6BHXWcBXOjmX5bHYfFf1Sdx4m2EGmgCVSQ37rLSlGujVAEaR/MnFjk9np
 i8EUVoQeTMsd/+pnwG0ZP1jYnaJT2V+QUwi8WglsaZaLxa3/A7dZh3NOwn87Rrvd2PE5
 dDzzRNBfbADP0GrkvkOJcpZC99WH2mBglu9p17ZqimT2OQkRdY0yVjlIEWPuw0LTksfb
 RCW7khwoZwFeDqEGR+zlNJqHAddQ560ne5dj8S39lAGB/VfI1hVP3YbynvH0QkKaE/Ii
 JSobgJYIcugxWdGHCZE3AtXuBip8KB0W9PhnIxdXVv8Vz4HGMeFfEs4pWq/GiBOAYxXl vA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 36d4rtg63q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Sat, 30 Jan 2021 09:25:29 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Sat, 30 Jan
 2021 15:25:28 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Sat, 30 Jan 2021 15:25:28 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5D15245;
 Sat, 30 Jan 2021 15:25:28 +0000 (UTC)
Date: Sat, 30 Jan 2021 15:25:28 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 09/13] ASoC: arizona-jack: convert into a helper
 library for codec drivers
Message-ID: <20210130152528.GT106851@ediswmail.ad.cirrus.com>
References: <20210123121313.79530-1-hdegoede@redhat.com>
 <20210123121313.79530-10-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210123121313.79530-10-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 mlxscore=0
 mlxlogscore=908 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300085
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

On Sat, Jan 23, 2021 at 01:13:09PM +0100, Hans de Goede wrote:
> Convert the arizona extcon driver into a helper library for direct use
> from the arizona codec-drivers, rather then being bound to a separate
> MFD cell.
> 
> Note the probe (and remove) sequence is split into 2 parts:
> 
> 1. The arizona_jack_codec_dev_probe() function inits a bunch of
> jack-detect specific variables in struct arizona_priv and tries to get
> a number of resources where getting them may fail with -EPROBE_DEFER.
> 
> 2. Then once the machine driver has create a snd_sock_jack through
> snd_soc_card_jack_new() it calls snd_soc_component_set_jack() on
> the codec component, which will call the new arizona_jack_set_jack(),
> which sets up jack-detection and requests the IRQs.
> 
> This split is necessary, because the IRQ handlers need access to the
> arizona->dapm pointer and the snd_sock_jack which are not available
> when the codec-driver's probe function runs.
> 
> Note this requires that machine-drivers for codecs which are converted
> to use the new helper functions from arizona-jack.c are modified to
> create a snd_soc_jack through snd_soc_card_jack_new() and register
> this jack with the codec through snd_soc_component_set_jack().
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
