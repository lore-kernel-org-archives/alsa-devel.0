Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABECC433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  9 May 2022 12:47:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6721218D0;
	Mon,  9 May 2022 14:46:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6721218D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652100447;
	bh=73006YAek/pDrh/7GSGT49e3I7Kw2LXzcH1tYSzyxJI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JxNI5bKDIjsC3q5L9jLuEhLMU8m42qS72livxV1fLlvRdBPTCb2qtFuK4vip8teUI
	 WRLiM+aGAFQOXTAFRexMkFd9QvZht57i/aNmbvnAgZ2C1QKwEQ6BAlaaDKUV7LCxkm
	 5vyUzjsfR2bByXI7sjV86WE/Tu5k5Zfr8uGXjZ7Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D06BF80237;
	Mon,  9 May 2022 14:46:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51E10F80237; Mon,  9 May 2022 14:46:35 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94C44F8011C
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2022 14:46:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94C44F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="kNGL7WGU"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2495nB4D024549;
 Mon, 9 May 2022 07:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=bOh5Ji8B4GU9h4s7zw/DlZwR/sozi0c8V7IoILKwY3M=;
 b=kNGL7WGUtufHa41XNhd94qqO+wiCXV6Y3l/jpJ+NJcqJjomHqrK0SWVKuPXktFjV3lfA
 Eo0IRCM+BFUioItu/uCBRFPfiLX5bU2Otk8s6LVvwFyfU/L0fOqbCsesXJLspNDUx+3r
 FKSOioXWISoU6Pct8Qo390zfRV6Hx4FBp4ri64ypsx9U9mvoaoV0WPTOANsO5mJ3DDmD
 S/YLgbmi7+XZKSevHJlSg8aKVQbJqAUfbvgw3QkUAc0ZjDVuGE382oy1nfUxjLLMeWXr
 3YJ/z8XwfN7uxNMGGSECZJns9l6kQk3pbOav8XTGyrcDWgHfb0bYLI37TCx0CLILhb7o 8g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fwn6ntmxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 09 May 2022 07:46:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 13:46:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Mon, 9 May 2022 13:46:24 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DE303B10;
 Mon,  9 May 2022 12:46:24 +0000 (UTC)
Date: Mon, 9 May 2022 12:46:24 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 1/2] ASoC: wm8940: add devicetree support
Message-ID: <20220509124624.GY38351@ediswmail.ad.cirrus.com>
References: <20220509121055.31103-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220509121055.31103-1-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: R1cmXhlaFtSl-FIBReia7xV4zkfsE-F7
X-Proofpoint-GUID: R1cmXhlaFtSl-FIBReia7xV4zkfsE-F7
X-Proofpoint-Spam-Reason: safe
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
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

On Mon, May 09, 2022 at 02:10:55PM +0200, Lukasz Majewski wrote:
> This adds devicetree support to the wm8940 codec driver.
> With a DT-based kernel, there is no board-specific setting
> to select the driver so allow it to be manually chosen.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
