Return-Path: <SRS0=M4Y+=24=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872D8C33C99
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:18:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967272077B
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kSB+aLfp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="taUrxPZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967272077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BB251815;
	Tue,  7 Jan 2020 11:17:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BB251815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578392282;
	bh=/fIB15s3JEd8A7MFcmzZdE9Xtz4ujrUmDUm9hAPGBPI=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kSB+aLfpQ+ApxSbPb7LgxqVgrepO++I8xcn320MnPica7fDWOnsneFe7O6g1HCPJ0
	 5ka+0qPazHyFHd/Vzwd6jmNBATg1H6E6xdmnqQfO05ERdneHTgoELyttDymT31e+Vi
	 RFmqrwQgdcZHk0+Lug18VcKhut3QYCg4BshUa2X8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A51E8F8014A;
	Tue,  7 Jan 2020 11:17:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51813F80172; Tue,  7 Jan 2020 11:17:10 +0100 (CET)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9C73F8010D
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2020 11:17:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9C73F8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="taUrxPZT"
Received: by mail-wr1-x443.google.com with SMTP id j42so53212265wrj.12
 for <alsa-devel@alsa-project.org>; Tue, 07 Jan 2020 02:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fwzh5B1nXt/sAEFF4P6VGTRMD6n6bfO44NTRH3RJWZ4=;
 b=taUrxPZTGVzzuvL7T0lvDMjjDK8lWEumcMo06rflm+YVYxsAK4JOpHgrsuAfS9cWXI
 G41MsZHjP/iu0AGNtOm4RB+dnO/BlbvD6PqTU2RzKIaoKHNOTimtY1JJkFNR4ViAi44p
 bQfKDKrRFnorlrTOwWLpMu4a12R/xRFUrN6hUtUHkzTgobNonMUqEtmROPxp0Y7ldrp7
 P8SKMT8N1cWBfXuQWuAhAXgcL+n/MeAI86J59ta9lgyoQ0GiYcuCF0pDGqp3O5kR7WKY
 tU91FqNkCDxKwj/tG4ZzIzefo7Xul6TH6UYN1zmSjtQupZzVTC06qKPvsKuD5VykiP/Y
 Ii6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fwzh5B1nXt/sAEFF4P6VGTRMD6n6bfO44NTRH3RJWZ4=;
 b=bVsnixS4J3l0EWlK3MU/ddN7zusax2GdG2HuKNOJSNyj8IqCnviVw+ize7Iu2SYPkt
 q704dA0FyEojS7YEuPT6Cl9vP32larCcJwL+8c62lQWkURVE3VfKllHjodLrFPuH/gGu
 +eAAROnYnd79jVKtAlpgKSlAeiS3k+NxPdALVGFdm6uQhBN2DvWKkUJXXbqkQ2HAAR1/
 4MSHbt14c103TJDetAJ9fBGIVB1ncTyvmjI+zrioqQGS8UmfrxV1ROdHqacNKTles2k9
 aYZjt9B3a7ZxslmLhspU+GE+jxF4HdW5vXOQx4pGl2Yu7UZO8Kr8D+Jqs4cTNZ3gYQE/
 thWA==
X-Gm-Message-State: APjAAAVKg/pzKatCjPxpjpYXu7NEa6afuxlyKNT7fE3W02J6xRBbrJ15
 /MAlIJLJ90wQ4WN2bVMK1xVN3A==
X-Google-Smtp-Source: APXvYqx96FNnTE7Wcke6NICz9bHsU0YLHTjGvRQKQMsnCyEMLoYLSpwbGJRwJxjIiek++9x0xqV8nQ==
X-Received: by 2002:a05:6000:149:: with SMTP id
 r9mr99505691wrx.147.1578392226736; 
 Tue, 07 Jan 2020 02:17:06 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id b17sm73177393wrx.15.2020.01.07.02.17.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:17:05 -0800 (PST)
To: Linus Walleij <linus.walleij@linaro.org>
References: <20191219103153.14875-1-srinivas.kandagatla@linaro.org>
 <20191219103153.14875-9-srinivas.kandagatla@linaro.org>
 <CACRpkdYc-kB4Kx690FnU=3CwnjFdQhdxofGguFAAs_j==C=nmQ@mail.gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1a027d45-6082-1697-ccf2-4a5be9a3591a@linaro.org>
Date: Tue, 7 Jan 2020 10:17:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYc-kB4Kx690FnU=3CwnjFdQhdxofGguFAAs_j==C=nmQ@mail.gmail.com>
Content-Language: en-US
Cc: Rob Herring <robh@kernel.org>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, bgoswami@codeaurora.org,
 Vinod Koul <vinod.koul@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, spapothi@codeaurora.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH v6 08/11] dt-bindings: gpio: wcd934x: Add
 bindings for gpio
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 07/01/2020 09:47, Linus Walleij wrote:
> On Thu, Dec 19, 2019 at 11:33 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
> 
>> Qualcomm Technologies Inc WCD9340/WCD9341 Audio Codec has integrated
>> gpio controller to control 5 gpios on the chip. This patch adds
>> required device tree bindings for it.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Tell me if you want me to merge this patch through the GPIO tree.
> 
Yes that would be great!. gpio bindings and gpio driver can go via gpio 
tree as there is no compile time dependency. Also Mark has already 
merged the audio codec side of it.

I will address the comments on the driver and send new version of these 
2 patches.

Thanks,
srini
> Yours,
> Linus Walleij
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
