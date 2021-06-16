Return-Path: <SRS0=Vkr5=LK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97803C48BE5
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 13:54:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0AF6128B
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 13:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0AF6128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFBB51671;
	Wed, 16 Jun 2021 15:53:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFBB51671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623851655;
	bh=nAlhBTJ5WNXiBOFd3SMW4AHUHqQda21ll8hjEvTqz7A=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U/hxBMRtu6x/cm/9Xj0ZAgtgnjvrKoRNKerNZo0WoIptEvC8qC7wSnYQKarK9qYm3
	 PY2WcFlOF1oVwDRNzJ5b1H4cUeY3NFclEYDy7yPGlSHQyJ4IwGE0ZsdH0Aw8a2nqU7
	 8q1154bDVTPz48GkOu1U18l3s6DvF5xNVn+aBWI8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DCC4F802E8;
	Wed, 16 Jun 2021 15:53:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 512DEF80423; Wed, 16 Jun 2021 15:53:23 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 453DAF80148
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 15:53:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 453DAF80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="QU9EeEZh"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15GDltpi024548; Wed, 16 Jun 2021 08:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=P1WujvQE+NtHwNgCvwnkCF5Q6AbVqrKUioWg92EBLi0=;
 b=QU9EeEZhLPtzEqRPYDK16RuZVtUA3FS1Tfc8BckkQg82sXV45IeOa8yiOAJwybIZDPy9
 Vf0JSpS2HyKac764Gwwl+MLCe+Ym9rURmto2cnXifUIcMFcxfSTTRb2zVxiM9z+BE1z4
 KV8vFZ+JGaA5A6igAgOnHKed5aERpwzumOQTslmYb1vUq3cTkcSsGQg6hgozEK5tL6pG
 BsjUujnXPbTySDgPIX3Q+YgeMYoprfm1Ej5ZE50kJGSa0YZQg/Pq3mtFepljGipOxBE/
 hSbdYcVVWVOwmfOByVtCw39XPdDpLY3BOvV/scldyiFRFXVfKkVReBVrAFXDG/V/EN92 jw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 397ab2gn29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 16 Jun 2021 08:53:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 16 Jun
 2021 14:53:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 16 Jun 2021 14:53:07 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.68])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0025F2B2;
 Wed, 16 Jun 2021 13:53:06 +0000 (UTC)
Subject: Re: [PATCH 02/10] ASoC: Intel: sof_sdw: remove hdac-hdmi support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 <alsa-devel@alsa-project.org>
References: <20210607224638.585486-1-pierre-louis.bossart@linux.intel.com>
 <20210607224638.585486-3-pierre-louis.bossart@linux.intel.com>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <57962c10-5c0a-cbaf-098a-d1f41c575f80@opensource.cirrus.com>
Date: Wed, 16 Jun 2021 14:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210607224638.585486-3-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2YXO4p3K-V54iUguzY8IzwVMWa7BZlHn
X-Proofpoint-GUID: 2YXO4p3K-V54iUguzY8IzwVMWa7BZlHn
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0
 spamscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106160080
Cc: tiwai@suse.de, Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

On 07/06/2021 23:46, Pierre-Louis Bossart wrote:
> From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> 
> Remove support for using hdac_hdmi codec driver. No known products use
> this configuration and hdac_hdmi cannot support all the platforms
> sof_sdw does.
> 
> This change also fixes a bug in Kconfig rules.
> SND_SOC_INTEL_SOUNDWIRE_SOF_MACH did not have a select SND_SOC_HDAC_HDMI
> and this could cause build failures.
> 
> Reported-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---

Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
