Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FB8C433B4
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 14:06:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FEBC613A7
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 14:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FEBC613A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aksignal.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34AF784D;
	Tue,  6 Apr 2021 16:05:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34AF784D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617717988;
	bh=62Tl9hR+aT9adrPry1AfVh3c24Izej41mSI8GpXXknI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=idV3LFCFVfPCO+yhedQ8JP4MdaJjo+lhF7zPEhMfE2riltZq6kglgxRnLEY+vvcTl
	 ia62/FWTryzqAyknTGEBYpxUqRAKbWqtOZHb9/02IdSr6PfbitjBk/8HOyulBATKjB
	 G9FMQQYdfE0rizqMmN2rJpgei/AyHX2NDuOTTQi4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3D2EF80124;
	Tue,  6 Apr 2021 16:05:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D2D2F8020B; Tue,  6 Apr 2021 16:05:36 +0200 (CEST)
Received: from router.aksignal.cz (router.aksignal.cz [62.44.4.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 973BDF80124
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 16:05:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 973BDF80124
Received: from localhost (localhost [127.0.0.1])
 by router.aksignal.cz (Postfix) with ESMTP id 940F93FA2B;
 Tue,  6 Apr 2021 16:05:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
 by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id hrt50nqC0q5k; Tue,  6 Apr 2021 16:05:22 +0200 (CEST)
Received: from [172.25.161.36] (unknown [83.240.30.185])
 (Authenticated sender: jiri.prchal@aksignal.cz)
 by router.aksignal.cz (Postfix) with ESMTPSA id EFDEA3FA29;
 Tue,  6 Apr 2021 16:05:21 +0200 (CEST)
Subject: Re: [PATCH 3/5] SOC Codecs: TLV320AIC3X add SPI: I2C code
To: Mark Brown <broonie@kernel.org>
References: <20210406105018.59463-1-jiri.prchal@aksignal.cz>
 <20210406105018.59463-4-jiri.prchal@aksignal.cz>
 <20210406121326.GG6443@sirena.org.uk>
From: =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Message-ID: <888ec87b-d79c-163b-ffa2-899362dec9e3@aksignal.cz>
Date: Tue, 6 Apr 2021 16:05:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210406121326.GG6443@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>
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



On 06. 04. 21 14:13, Mark Brown wrote:
> On Tue, Apr 06, 2021 at 12:50:16PM +0200, Jiri Prchal wrote:
>> +++ b/sound/soc/codecs/tlv320aic3x-i2c.c
>> @@ -0,0 +1,72 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * ALSA SoC TLV320AIC3x codec driver I2C interface
> 
> Please make the entire comment a C++ one so things look more
> intentional.
> 
OK,
but coding style checker complains:
WARNING: Improper SPDX comment style for 
'sound/soc/codecs/tlv320aic3x-i2c.c', please use '//' instead
#64: FILE: sound/soc/codecs/tlv320aic3x-i2c.c:1:
+/* SPDX-License-Identifier: GPL-2.0-only
