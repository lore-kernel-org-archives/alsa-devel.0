Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FAECA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 22:50:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE3E214E0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 22:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="anRgCVq4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PgPUNmQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE3E214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D20D0215C;
	Mon, 28 Oct 2019 23:49:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D20D0215C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572303036;
	bh=hq49TGWfFpqpI2ZgopbcEdjNNRwyQp4Wk9hZEfgm3NQ=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=anRgCVq40c8tJms8xKnWIZmIzR+OuoDUSSaPxzcG1gGK94dlGFuXWPeWGc/TTcApG
	 kfiTj5dQwQ2wPy6hkebRoji/pWDxd2qJVD2f7eYZGJkzndcFTM5U9V2ZtMp6kbjTyC
	 QHYYOzOsCumFqryLfQMG5GoZBcUJ8nDbbdpeBfKg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54C37F802BD;
	Mon, 28 Oct 2019 23:49:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63E98F80361; Mon, 28 Oct 2019 23:49:44 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B944BF8011D
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 23:49:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B944BF8011D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="PgPUNmQQ"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 x9SMnaSJ019032; Mon, 28 Oct 2019 17:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=IFecliWA9QaRIAcpDtl4EiZnFMOn8cj+STwr1hb9PXU=;
 b=PgPUNmQQ1SsZDyWJzsFtT9T4kWe1vkNbOjZNMcaWa4TMJUXUaOhLLLCPQA1KwYB8zJld
 R7bjs4buiklw+z+6UhBVz7rhWTbmYvKWL+UTGU3ST9vboATowobrDIbXmxSp1HpRtPaV
 QjJkdMXAQU2vYDZgRkN/Z6M4GHa6xevBnLoK5PY8r5r0X+w8jhNBbsvgauVvCLh5pHKn
 ezkekuMvAdKr4NPOqRWZmusRbqCQQ7aOuKfM/OlxWgW87Df83kk0ZStR0j0M6H/X1XRs
 +9XMZtjDKg2BC0XQnMYubakfu2dfJZJhpq0yQSMitbb30PEIr9GAcOQ0LVLWMcELZ/r0 DQ== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 2vvkj2u2tx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 28 Oct 2019 17:49:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 28 Oct
 2019 22:49:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Mon, 28 Oct 2019 22:49:33 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6BB6B2C6;
 Mon, 28 Oct 2019 22:49:33 +0000 (UTC)
Date: Mon, 28 Oct 2019 22:49:33 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Message-ID: <20191028224933.GF31391@ediswmail.ad.cirrus.com>
References: <87a79nqnkd.fsf@belgarion.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a79nqnkd.fsf@belgarion.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=911
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910280213
Cc: patches@opensource.cirrus.com,
 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] wm9713 regression on pxa platforms
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

On Sat, Oct 26, 2019 at 10:06:10PM +0200, Robert Jarzmik wrote:
> Hi Wolfson maintainers, hi Mark,
> 
> Recently, the wm9713 support broke on my platforms. I'm pretty sure that a
> previous harmless warning became an error preventing the probe of my driver
> (sound/soc/pxa/mioa701_wm9713.c) : the error is shown in [1] ("Control not
> supported").
> 
> The warning "ASoC: no dapm match for Mic B Source" has be there as far as I'm
> aware for ages, and it never prevented the probe before.
> 
> Now, if I apply the ugly patch in [2], everything works as expected ... but
> that's definitely not the right fix.
> 
> Would any of you be able to figure out a fix please ?
> 

I suspect the patch that turned this into a fatal error was this
one:

daa480bde6b3 ("ASoC: soc-core: tidyup for snd_soc_dapm_add_routes()")

That said the error is clearly valid and the driver should be
fixed. The routes make no sense and are clearly wrong. I strongly
suspect the routes should look like this:

{"Mic B Pre Amp", NULL, "Mic B Source"},
{"Mic B Source", "MPB", "MIC2B"},

I am travelling this week, and would need to do a bit more
datasheet diving to be sure. But be worth checking if that fixes
it and I can fire out a real patch start of next week.

Thanks,
Charles

> [2] Ugly test
> diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
> index 6497c1ea6228..ec140ccbab0b 100644
> --- a/sound/soc/codecs/wm9713.c
> +++ b/sound/soc/codecs/wm9713.c
> @@ -630,8 +630,8 @@ static const struct snd_soc_dapm_route wm9713_audio_map[] = {
>         {"Mic A Source", "Mic 1", "MIC1"},
>         {"Mic A Source", "Mic 2 A", "MIC2A"},
>         {"Mic A Source", "Mic 2 B", "Mic B Source"},
> -       {"Mic B Pre Amp", "MPB", "Mic B Source"},
> -       {"Mic B Source", NULL, "MIC2B"},
> +       /* {"Mic B Pre Amp", "MPB", "Mic B Source"}, */
> +       /* {"Mic B Source", NULL, "MIC2B"}, */
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
