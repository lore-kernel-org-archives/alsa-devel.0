Return-Path: <SRS0=8nxE=IM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9751C433E6
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Mar 2021 10:20:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6397264DE3
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Mar 2021 10:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6397264DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 476F51715;
	Sun, 14 Mar 2021 11:19:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 476F51715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615717197;
	bh=Z7mAbizrUoQdevfwkeTfFVXItQdkOIHI6niteURpDMw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zz2CCtC1/+RPmaoFjH9Qy0ly0+cktvLdYMfJeuqQ5lUE+J/wzm5nrXfox/ytU/ENl
	 fZ/k4dE+T/MHkLIpkdI1EGh2ZMe9fad5y/WsQTHTxd5NpKvVfIv1uxHlYYSzN294NX
	 E3pmY5MhEvOKa6ijl7REwJhCNxuPCVFknFEsgvpQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE0B1F80148;
	Sun, 14 Mar 2021 11:19:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E2B4F80218; Sun, 14 Mar 2021 11:19:05 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB840F8010D
 for <alsa-devel@alsa-project.org>; Sun, 14 Mar 2021 11:18:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB840F8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="HOmxilYK"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12EAIqRf000371; Sun, 14 Mar 2021 05:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=UyEKzuzXX6Bk054SMR2fNK/9VqqSA0lao6vxZ6vCYfU=;
 b=HOmxilYKKnz5YElDny6N5x27VXkSYKzOSoyMYCwGrIoOc3IMfidZPmndZEoe/2jvntF5
 sOshVujfRt4fkLzRJKz1eBqn1eUWfpwLvE88TtmHFX1qVTBidBPnl4CL5Tv9qbmUkQmD
 GmKr5ReOcIVkmlLyfh+FkgIbs+nX/nm9Z2ZB1lx9irMsT1aq23dcyRc3BvR6pQLQofsC
 4ss2wLcDNd69Qgca1NtGD9xU1kWWTomP85LBupC48bvLcVc2F/HYFcKIyI0GBmugAbuy
 1J5KvigLfHr6w8ZpAuoAkhexU6b7G5UzwrOnrDD3uID422etgKCB9YfcYoHVgiB7dNNU 0A== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 378tpv161p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Sun, 14 Mar 2021 05:18:52 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sun, 14 Mar
 2021 10:18:51 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sun, 14 Mar 2021 10:18:51 +0000
Received: from [198.90.238.45] (unknown [198.90.238.45])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1BA1711CB;
 Sun, 14 Mar 2021 10:18:51 +0000 (UTC)
Subject: Re: [PATCH v1 0/4] ALSA: hda/cirrus: Make CS8409 driver more generic
 by using fixups
To: Takashi Iwai <tiwai@suse.de>
References: <20210313113410.90088-1-vitalyr@opensource.cirrus.com>
 <s5h1rcirv2a.wl-tiwai@suse.de>
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <0e3a2304-7945-0d80-91cc-b6b551f7c3f4@opensource.cirrus.com>
Date: Sun, 14 Mar 2021 10:18:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <s5h1rcirv2a.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=555 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103140076
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
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

On 14/03/2021 8:36 am, Takashi Iwai wrote:
> On Sat, 13 Mar 2021 12:34:06 +0100,
> Vitaly Rodionov wrote:
>> This series of patches will address comments by Pierre-Louis Bossart,
>> cleans up patch_cirrus.c source, reducing checkpatch.pl warnings from 19 to 0,
>> fixing an issue reported by Canonical: BugLink: https://bugs.launchpad.net/bugs/1918378,
>> and makes the CS8409 patch more generic by using fixups.
>>
>> Stefan Binding (4):
>>    ALSA: hda/cirrus: Add error handling into CS8409 I2C functions
>>    ALSA: hda/cirrus: Cleanup patch_cirrus.c code.
>>    ALSA: hda/cirrus: Fix CS42L42 Headset Mic volume control name
>>    ALSA: hda/cirrus: Make CS8409 driver more generic by using fixups.
> Is this the same content as the series you've already submitted in
> 20210312184452.3288-1-vitalyr@opensource.cirrus.com ?

Hi Takashi,

Yes, this is second version of same series, where we have fixed warnings 
from 0-day bot.

Thanks,

Vitaly

>
>
> thanks,
>
> Takashi


