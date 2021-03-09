Return-Path: <SRS0=OWbI=IH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AECC433E6
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 13:42:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E136D651C7
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 13:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E136D651C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D746117DD;
	Tue,  9 Mar 2021 14:41:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D746117DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615297368;
	bh=/ySw+zWAXmpDBSxsmqcY38f6x1UKg0nOJKNJDwYSagI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SLN2V0363qM11IIW4vzcIn4ZNvRKP9/RkjXCto2jcpd4u21BV6DA/smFwYGk9/Iu6
	 KQHCOAm7YHuSfABl6karvH8RQZUS8OaTQGJ2O/GbrQlEFIFDL+dRb6V5AQuEHBZYRh
	 ywRwX2YLePRktWxsD1ORX/6sO+bLa7bS0ymgN6Oo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C17BF8019B;
	Tue,  9 Mar 2021 14:41:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B48CF80227; Tue,  9 Mar 2021 14:41:56 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 896A5F8014E
 for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2021 14:41:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 896A5F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Vl8Ohgwk"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 129DbMJr024533; Tue, 9 Mar 2021 07:41:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=texA9NDJALCUe6j3oIFUZZLHkRFvVH330/+VJwmvh0g=;
 b=Vl8OhgwkjozwUC2zl7zu5B4g5d4Vb0KM3bFkHuGnYX1z99mPQFx5n66Ppp6Rvo3irUd5
 l8zDU2eAdrXUqOI/uG2TeOCFClbph5Lw8/ComLV7q/yAqnvyfEAxKIn3ugfGDBu/bq02
 1woBrWJ5YTko5wkLRNZUDuzw/mN5Rb9++T5Ol2KSs2zrpX3+WAOo36UD69KxZyFX8muK
 fmiYf9japTCVhTojwM5oAlKlXimejd3YdD9iKxxZG3PNkflXq7EuImg52LQMVxXGMb3O
 elhri9DPTcoMHXMuk+hWyVO8U7SWyw6hPbbcAGKACnMKVz1sVb0csj3T4a1mcSAfx0CU Qg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 37471vud9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 09 Mar 2021 07:41:50 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 9 Mar 2021
 13:41:48 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 9 Mar 2021 13:41:48 +0000
Received: from [198.90.238.45] (unknown [198.90.238.45])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AEDD411CF;
 Tue,  9 Mar 2021 13:41:48 +0000 (UTC)
Subject: Re: [PATCH v3 3/4] ALSA: hda/cirrus: Add jack detect interrupt
 support from CS42L42 companion codec.
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20210306111934.4832-1-vitalyr@opensource.cirrus.com>
 <20210306111934.4832-4-vitalyr@opensource.cirrus.com>
 <3ddc27d5-7d6d-e244-51fa-6ac17ee9779a@linux.intel.com>
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <00537bf3-926c-eb2f-98ed-3d0242ecd8fd@opensource.cirrus.com>
Date: Tue, 9 Mar 2021 13:41:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3ddc27d5-7d6d-e244-51fa-6ac17ee9779a@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 adultscore=0
 malwarescore=0 mlxlogscore=518 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090068
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
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

On 08/03/2021 3:35 pm, Pierre-Louis Bossart wrote:
>
>
>
>> @@ -38,6 +39,15 @@ struct cs_spec {
>>       /* for MBP SPDIF control */
>>       int (*spdif_sw_put)(struct snd_kcontrol *kcontrol,
>>                   struct snd_ctl_elem_value *ucontrol);
>> +
>> +    unsigned int cs42l42_hp_jack_in:1;
>> +    unsigned int cs42l42_mic_jack_in:1;
>> +
>> +    struct mutex cs8409_i2c_mux;
>
> what does this protect? there isn't any comment or explanations in the 
> commit message.
>
>
we are protecting sequences of i2c transactions.

for example,  when we are writing sequence to activate jack detect, as a 
result of interrupt via gpio4

unsolicited response can be called by framework at the same time. we 
want to finish first sequence.

