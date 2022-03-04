Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04AAC433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Mar 2022 15:06:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FBD81AD7;
	Fri,  4 Mar 2022 16:06:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FBD81AD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646406415;
	bh=wYmhrKY9ME4ch4c++D9q/6Pb0CkAf4cJnCgi5GqL+U8=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LD+6uSFtXhX3pAzgP5DFbEnwF5dlAIZbMz03q0EmlyiiP9+tuSDRWXB8XoIwBbVdk
	 8M/NN94JDXHyIzUsIUrjHLUyJYRL5yMj0uupHh8NwstVfV5iGaleBxxpafm/l+9QSd
	 mqFd0x3vm2gxCyO4nauIHZnyadJrC+hRYpOzm9JE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E4ECF800F2;
	Fri,  4 Mar 2022 16:06:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB057F801F5; Fri,  4 Mar 2022 16:06:02 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41B8EF80139
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2022 16:05:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41B8EF80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="IsJ8rhNc"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2247SMLb025160;
 Fri, 4 Mar 2022 09:05:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=hHITQXFDQDnRVWlkIt1+iWr/oKBoaKdy+qjH2sz4sAM=;
 b=IsJ8rhNcxyRTNptJtHGf/XKlRes2VmKvXjN4MiC3hXgjc+SCQAGlcP7wFPe5Qiu/cI/d
 lLT+tZo+wdUn+yZM8sTE0XtZBI71J5pJVBNUoIvQhgwFZAOFDZ0y6g0XLn7Nox3FWbsE
 4sDx6JOQH4xHyBsiUYnoKsyMK2yu9A+h41AcllIp3YGJDFC7AiVOOmYFMRJhO+BN/skR
 1f7XFo4WlzsCgJeC+Syi4Wt1UyNLeQBGYlAkTqjNMEkZoqyE5Z/526UyTGgQqfXw9ed7
 ZO5EewpTc/AlXUh3V7gE+UzYM6R7mbdAUB36kKMt1upplO/JrjgKJ3z+UhVIzgZUpAqw Dw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j1s3c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 04 Mar 2022 09:05:57 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 15:05:55 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via
 Frontend Transport; Fri, 4 Mar 2022 15:05:55 +0000
Received: from [198.61.65.198] (unknown [198.61.65.198])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 27CBE7C;
 Fri,  4 Mar 2022 15:05:55 +0000 (UTC)
Message-ID: <f4e04900-1451-0b6a-e4c1-cc51cafe9309@opensource.cirrus.com>
Date: Fri, 4 Mar 2022 15:05:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 15/20] hda: cs35l41: Remove unnecessary log
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
 <20220303173059.269657-16-tanureal@opensource.cirrus.com>
 <YiD/0ZMcSGVRTZxx@sirena.org.uk>
From: Lucas tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <YiD/0ZMcSGVRTZxx@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: g_vDq3ATg4q1fK_fIDlsb4DJAWr8jJmS
X-Proofpoint-ORIG-GUID: g_vDq3ATg4q1fK_fIDlsb4DJAWr8jJmS
X-Proofpoint-Spam-Reason: safe
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
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

On 3/3/22 17:50, Mark Brown wrote:
> On Thu, Mar 03, 2022 at 05:30:54PM +0000, Lucas Tanure wrote:
> 
>> If regmap fails would fail during probe of the device.
> 
> I'm pretty sure circumstances could arise which would break things at
> runtime.
Yes, so instead of not logging that, we can log the last regmap access 
per switch case, instead of all of them.
