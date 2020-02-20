Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BD3C11D20
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:58:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C8620679
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DRnHsWt7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OYHA4x0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C8620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B574B1683;
	Thu, 20 Feb 2020 21:57:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B574B1683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582232296;
	bh=X3B9YA+HYhbDjiSSV/KXZjKFnfL2uUR1R1CMQRV6xKY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DRnHsWt72BWRRlf7Xmdv8VFjosEZ8LSSQNsTEgUnnKkcluohgYuR4zRx1gVg63ADd
	 KYL7nIwLJ1TNldNgpXQkqgEkWHa1O5IUcxqAF681N/+tzFF07Yn93v9YdzhIVXzQ2U
	 3gISVCdVTFml0Y8FQ2B2JpEipK20f/atIkiySmPI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FA4EF80148;
	Thu, 20 Feb 2020 21:57:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7629BF80150; Thu, 20 Feb 2020 21:57:24 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBABBF80114
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 21:57:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBABBF80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OYHA4x0D"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01KKvHCJ105285;
 Thu, 20 Feb 2020 14:57:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1582232237;
 bh=X3B9YA+HYhbDjiSSV/KXZjKFnfL2uUR1R1CMQRV6xKY=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=OYHA4x0D26SlRwGDGIj8aJfbnmqoeMHwKR4skopT1AfW+u2sKc/6xYJ+O44JYmtQ0
 DWV+Iy4harNp+BjgtGGrSsAJ5fwltvqqGLYV004p+iTC1RQcB/m3zAdvj0JLWrCAEO
 +SJr00Es+7fIfV6dXDZqxDQNlOYCS6bNqr4rkEjk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01KKvHjO108341
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Feb 2020 14:57:17 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 20
 Feb 2020 14:57:16 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 20 Feb 2020 14:57:16 -0600
Received: from [128.247.59.107] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01KKvGIT014192;
 Thu, 20 Feb 2020 14:57:16 -0600
Subject: Re: [PATCH v3 2/2] ASoC: tlv320adcx140: Add the tlv320adcx140 codec
 driver family
To: Mark Brown <broonie@kernel.org>
References: <20200219125942.22013-1-dmurphy@ti.com>
 <20200219125942.22013-3-dmurphy@ti.com>
 <20200220204834.GA20618@sirena.org.uk>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <5cc47587-eae1-0b41-e91d-f9885a69d75e@ti.com>
Date: Thu, 20 Feb 2020 14:52:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220204834.GA20618@sirena.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 lgirdwood@gmail.com
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

Mark

On 2/20/20 2:48 PM, Mark Brown wrote:
> On Wed, Feb 19, 2020 at 06:59:42AM -0600, Dan Murphy wrote:
>> Add the tlv320adcx140 codec driver family.
>>
>> The TLV320ADCx140 is a Burr-Brown™ highperformance, audio analog-to-digital
>> converter (ADC) that supports simultaneous sampling of up to four analog
>> channels or eight digital channels for the pulse density modulation (PDM)
> This doesn't apply against current code, please check and resend.

Ok this is against linux master should this be against your for-next branch?

Dan

