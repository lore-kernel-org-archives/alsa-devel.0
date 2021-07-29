Return-Path: <SRS0=Qkbk=MV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B623BC4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 20:35:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C35060F46
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 20:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C35060F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 016AB1B0F;
	Thu, 29 Jul 2021 22:34:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 016AB1B0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627590902;
	bh=YbX1dO3vRf+2FhIq8EhTn4HwJ21PpdNOc/d/LsC7oJE=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EDkB0ipNA3vgrDNW19zES25ckTkh52CV8RjRYF/nflt8SsVD3R73NE/v+qrmGDz5+
	 SBO4e62bSq2buT8f1skvCKyn0WMkxV5MGH4WErwXSUoNJ+tFA9goxJujbO02ybcwRP
	 j6lCetQ0FWw4AMZGenPJYEzjdbfhSuwh67c9CLs0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 773F6F80258;
	Thu, 29 Jul 2021 22:34:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 831C9F8026C; Thu, 29 Jul 2021 22:34:10 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64E3FF800E9
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 22:34:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64E3FF800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="EjsC/FvQ"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16TIlJoE027129; 
 Thu, 29 Jul 2021 15:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=7iV7+dZOWyu5AT7cDsE4G5QTLSecFihGRCTs9AQSrHk=;
 b=EjsC/FvQYtm3UAwkwrq6gwOT0xUa39aiZPNA3EVn3EZFQbqwvzaCr9htq/g2u7yzMS/H
 6lYSIaNDL48UC1Z85mkvLD2pH9iKAxq2Je+gtuovq8xEgM+KihHxWofxNdiUGbPJtSUQ
 6hWeiB6v9CHp23aaMnOEM5qW907acFLIkC1isoaM9RDo71DIjR3no2rNt+su8AmNRk28
 Nsm64QIb5QCmKFStyq00ahc7G6tE4707WLFQDscCkRl/v7lCiXHCA3/Bi5CtyETYMYbf
 oFVTxGmxHDUQuqswKQKh5bcbSekGqZmburyg3rl0thK74cKvIP4CER+u2w3SMh/Hoevc SQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 3a41wd03nu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 29 Jul 2021 15:34:02 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Jul
 2021 21:03:56 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Jul 2021 21:03:56 +0100
Received: from [192.168.99.238] (macC02XQ1DJJG5K.ad.cirrus.com [141.131.65.63])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7987A45D;
 Thu, 29 Jul 2021 20:03:54 +0000 (UTC)
Subject: Re: [PATCH v4 1/2] ASoC: cs35l41: CS35L41 Boosted Smart Amplifier
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 <broonie@kernel.org>, <robh@kernel.org>,
 <ckeepax@opensource.cirrus.com>, <brian.austin@cirrus.com>,
 <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
 <david.rhodes@cirrus.com>
References: <20210726223438.1464333-1-drhodes@opensource.cirrus.com>
 <20210726223438.1464333-2-drhodes@opensource.cirrus.com>
 <b6fd6522-3639-4452-1d8a-dc1b308cc846@linux.intel.com>
From: David Rhodes <drhodes@opensource.cirrus.com>
Message-ID: <d7314bfb-b545-75d7-65f7-dfacf050194d@opensource.cirrus.com>
Date: Thu, 29 Jul 2021 15:03:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b6fd6522-3639-4452-1d8a-dc1b308cc846@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: r622BQP15e1n9PLtK90MdGE86KNoHiHX
X-Proofpoint-ORIG-GUID: r622BQP15e1n9PLtK90MdGE86KNoHiHX
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=917 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107290125
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

On 7/26/21 6:14 PM, Pierre-Louis Bossart wrote:

OK. Will remove those unnecessary NULL inits and reverse xmas tree the 
declarations.

> so here you will disable regulators that have not been enabled, is it
> intentional?
> 
> mixing gotos and returns is confusing...
> 
> and in addition you will set the reset_gpio that you only get a couple
> of lines below, that will be a page fault?

Not intentional. I think regulator enable should be moved before 
handling pdata. (and every error after regulator enable will use goto 
instead of return)

The GPIO descriptor is validated so if it is not present or not yet 
requested gpiod_set_value should just return without any faults.

Thanks,
David
