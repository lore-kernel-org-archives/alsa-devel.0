Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F332ECAAD8
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Sep 2022 08:01:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9C3474C;
	Wed, 21 Sep 2022 10:00:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9C3474C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663747302;
	bh=5x8j4sKsvm34OKdlSlCAqSUx3q9nMz+vXVKQRcxBnuw=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=svdHAsHtB6Oh1A2SRqTL5OjTUShos8gWBoJaM00n7j9dCecUaig1k4QTKtpD+lDC6
	 mUXd4Utb0xOIhy1Lv2hf+lwquGtDhxWEsSmo81K7zOumm+5RcBOcUu42HA2ijXmx+c
	 r11NhL8Lao1nvEJvFvRQrq9jSSmV+SA0EU3rPdSw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FF9BF80169;
	Wed, 21 Sep 2022 10:00:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 329FFF80256; Wed, 21 Sep 2022 10:00:50 +0200 (CEST)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C44CF80107
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2022 10:00:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C44CF80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="JRqY3a9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1663747247;
 x=1695283247;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=eQ9kdscepu/ZIW6IjLVX0T4gfipwtAWzN3YK8J7p8n0=;
 b=JRqY3a9NqFpZbuu80w0+UJ7ebPXfS2kEsrFJPszDKxKsXntGVdzjJcPS
 qZGUAI31Qq/xVw9h49xG02bgMKdbOzeeKUXdFsHNDY08oGLz0SKnIcBk/
 Uk5W2zdG1HO6E01aEMP2zwmjNtBpWmAYnbsX9ILMS4ciwsa6JvvoOorPe
 l9LehykoaU9ZZal/yV409IpYpxz1ME67y9n5KI3LsLdBQQFYWO4LCPKxC
 xkPYfBXuzMnFYv+RB5mdmigulZDI9M7bAMCNCS1skz+Ms8c2td8Ogg9TB
 MvAU+SjltdrVSyOY7FCtZ6ew2oHkdYlVEqTp2UVaguqkw/utA6FTG0+Zf A==;
Message-ID: <9074bb0e-5490-ebe4-6518-1efd7416aa5c@axis.com>
Date: Wed, 21 Sep 2022 10:00:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 2/3] dt-bindings: sound: ti,s3a227e: add control of
 debounce
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Astrid Rost
 <Astrid.Rost@axis.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, Dylan
 Reid <dgreid@chromium.org>
References: <20220919111258.3774-1-astrid.rost@axis.com>
 <20220919111258.3774-3-astrid.rost@axis.com>
 <79658ad6-fd1c-68aa-88e0-6ad5274bea9d@linaro.org>
From: Astrid Rost <astridr@axis.com>
In-Reply-To: <79658ad6-fd1c-68aa-88e0-6ad5274bea9d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail06w.axis.com (10.20.40.12) To se-mail05w.axis.com
 (10.20.40.11)
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 kernel <kernel@axis.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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


>> +  ti,debounce-release-ms:
>> +    description: key release debounce time in ms (datasheet section 9.6.7).
>> +    enum:
>> +      - 0  #  0 ms
>> +      - 20 # 20 ms
> 
> I don't see any improvements here.

Sorry, I miss understood. I have now just kept the enum values.

Astrid
