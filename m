Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5725DC433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Feb 2022 10:06:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80AEE16D3;
	Thu,  3 Feb 2022 11:05:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80AEE16D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643882787;
	bh=cObdtJR7qcnaShgi+odDzChY9+0lzPQ0kzfV8z3Ik0w=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XNTjxPCxFHX3OwYTuupUIelgen2TfUl18szFOL4PfXvAsWoHp+TDJyKA2ByHcXqeE
	 Q9lnk4H8GqcywUj7QS/mKcYZw/7F81hqaTf8EIwCGwC4mjgn9xZyh4xIbIMYYsmTSv
	 U5Qvz27Mbt6JH+3GtyMgatU/bjpdUlPa/g4SWErM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17C55F80171;
	Thu,  3 Feb 2022 11:05:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0F8DF8027C; Thu,  3 Feb 2022 11:05:31 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB477F80163
 for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2022 11:05:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB477F80163
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="JxU8otjs"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2138u7ML029786;
 Thu, 3 Feb 2022 04:05:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=OsBt+0A1cjsarHc9V7PNMpsX7PVVQxXl5QpailKk7BY=;
 b=JxU8otjsEaCyv0ghwDUhklMQflm0CpVkG58U+9UBp77sgD1Yw3bpJNAs63f4qJPI+qAm
 T7W41xvvgq39dy9+y6yozYaii3g/cm0is9yxURwudEam8EyySHfNnZWiQpvaAlWPcFX2
 vwOR+unnR6WyYXI5t4NnztZha6bGxMC6vypgZQjkRI9KDAErkwAOpZCuH1FBX7S8T9UK
 NwdVa61Gl8IDU1KFssovQFLJA3wgTEIo4CcrhQZEkQhr+kv1NomjUmZhW/OnLYVVex3X
 y2A8i/bn+8tit4/sWAxn8HSnGRElRDyZqDBv6Ku500VU8uzn3dbkPQJQvCtz+3BDxE7b sg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dyw8cgtd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 03 Feb 2022 04:05:24 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 10:05:22 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via
 Frontend Transport; Thu, 3 Feb 2022 10:05:22 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A9B677C;
 Thu,  3 Feb 2022 10:05:22 +0000 (UTC)
Date: Thu, 3 Feb 2022 10:05:22 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs47l15: Ensure regmap_irq is built
Message-ID: <20220203100522.GE18506@ediswmail.ad.cirrus.com>
References: <20220202191700.3654382-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220202191700.3654382-1-broonie@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: mL84_SkPR7FGO7Xe6wXJ97AhPbMY5nh1
X-Proofpoint-ORIG-GUID: mL84_SkPR7FGO7Xe6wXJ97AhPbMY5nh1
X-Proofpoint-Spam-Reason: safe
Cc: alsa-devel@alsa-project.org, Lucas
 Tanure <tanureal@opensource.cirrus.com>, patches@opensource.cirrus.com,
 Liam Girdwood <lgirdwood@gmail.com>, David Rhodes <david.rhodes@cirrus.com>,
 James Schulman <james.schulman@cirrus.com>
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

On Wed, Feb 02, 2022 at 07:17:00PM +0000, Mark Brown wrote:
> The cs47l15 driver uses regmap_irq but does not ensure that it is built,
> causing build failures if nothing else being build requires the helpers.
> Add the appropriate select.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/codecs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 2fd21004688c..69fd11b2b046 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -733,6 +733,7 @@ config SND_SOC_CS4349
>  
>  config SND_SOC_CS47L15
>  	tristate
> +	select REGMAP_IRQ
>  

Would it be better to have depends on MFD_CS47L15 instead,
that way the other dependencies would be covered as well? I think
these were added before implies was a thing, and thus
dependencies didn't matter, since they could only be selected
which ignored deps anyway.

I would expect L35, L85, L90, L92 to be affected as well. Happy
to do a patch to fix this up, if you prefer?

Thanks,
Charles
