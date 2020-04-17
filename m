Return-Path: <SRS0=YLi8=6B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DB9C352BE
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:37:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80CAA208E4
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QQqqsvvB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoXFNKZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CAA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D79C41686;
	Fri, 17 Apr 2020 11:36:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D79C41686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587116260;
	bh=cy52+61wCiiQeJYITX/JREbmFN1m0TRJUIhWs1IdT1A=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QQqqsvvBv8Ugwcb6Pb/Mv4Ib3egQ6xDyCiccnEeWhe9SHYbm7q+X+3CtMKecUrCJa
	 v2ml5LG0H6I+lf0VOLWX5PAeXEa1+Ha3PZ0LvP78rLjYSGy2+sdvy+TFGTUaiK/uKj
	 PO8tD98VFiZIHJeo4kw+LrDXA7mv884HZIuyW9pU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 249D0F8028C;
	Fri, 17 Apr 2020 11:36:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33F78F8028D; Fri, 17 Apr 2020 11:36:02 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C82BF8026A
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2020 11:35:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C82BF8026A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="zoXFNKZC"
Received: by mail-wm1-x341.google.com with SMTP id v8so4487590wma.0
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2020 02:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=f50Rp9fX0B6RGwIPtYeIoasFyg69G1qVoaejlKsFhjU=;
 b=zoXFNKZCD083C8bPzbEhJ8UQr7lCBAyG0ZEkzPv2iA4Ul0JJx73+cvp/+DXem679/p
 93Gu5BANNidBCAkmlTONFFSnBJHvQ6wlQ4n2OpiCL120Sl5GD1YcKJ2/L6z//iBoXh97
 Y3evIlrwENOIE7aSBojUH1IIT3Zwbmu6nNJxz3JNx0rXgsmhN3hY1xNJdCJ4ytV4atzx
 Ne7GSJlbcG7vRJcTlYrN6/0bCyG92hpioGBLXlHnX2j/aC0vTyKzFIoRL3o1Hyr8NDiB
 xNKbMEqczafeBvrQyf+Rk8L+XEMbRa0y8oHdshJ3OezJkwEdsrgtgdaN0dkFBGrDgkh7
 aEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f50Rp9fX0B6RGwIPtYeIoasFyg69G1qVoaejlKsFhjU=;
 b=dIIlgFEM2RPK9N3T0HefqAcL6p/bTrxPIrtIb9vCf4y1zb7wXdV5Y4bl22IsDbvLW0
 VvG8gvlBFRyP5UP1Uy5lTPKhq33h8pFgFCkV+BB9bL+DlA7KXad1QoRQmr7U3A8GwPOK
 W+v4U50uoyg2/JQS36q1stKdCkhNqxniF+1cQ+BIOTT4m75YZR/X0gFlb0R3UnzT/lrm
 Ihud5oOzb4BeLRbQcCuO3Ip+uIFuiMJQEATc203T+Rdii58tDOkQeCDQLuDmU2XQoFZt
 +HROFs6sZu0sijEKUw3p+6g+yCDU345nXDrUI1Wub+8sa87RN3MFxQeExmxdklJuV7iV
 vVWw==
X-Gm-Message-State: AGi0Pua/aVurj9kmUJaNvr8eykb/cldtIxeJXBzSKDzHJTPULvY0Y4+Z
 RL6MAxyDVyux36lthmIgSqa+cQ==
X-Google-Smtp-Source: APiQypK8pqAGTMRV3NBuqhRZc4DeFWddMOR6owMH2wbsZ4oYS+Q35xyiKr9C8Llsffkt6HeUqy+uCw==
X-Received: by 2002:a1c:3986:: with SMTP id g128mr2441087wma.8.1587116149452; 
 Fri, 17 Apr 2020 02:35:49 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id y63sm7112981wmg.21.2020.04.17.02.35.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Apr 2020 02:35:48 -0700 (PDT)
Subject: Re: [PATCH v2] slimbus: core: Set fwnode for a device when setting
 of_node
To: Saravana Kannan <saravanak@google.com>
References: <20200326172457.205493-1-saravanak@google.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1da61e5c-7a8b-8c38-bba4-6f4043f50ecf@linaro.org>
Date: Fri, 17 Apr 2020 10:35:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200326172457.205493-1-saravanak@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, kernel-team@android.com,
 John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org
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



On 26/03/2020 17:24, Saravana Kannan wrote:
> When setting the of_node for a newly created device, also set the
> fwnode. This allows fw_devlink feature to work for slimbus devices.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Applied Thanks,
--srini
> ---
>   drivers/slimbus/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index 526e3215d8fe..44228a5b246d 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -163,8 +163,10 @@ static int slim_add_device(struct slim_controller *ctrl,
>   	INIT_LIST_HEAD(&sbdev->stream_list);
>   	spin_lock_init(&sbdev->stream_list_lock);
>   
> -	if (node)
> +	if (node) {
>   		sbdev->dev.of_node = of_node_get(node);
> +		sbdev->dev.fwnode = of_fwnode_handle(node);
> +	}
>   
>   	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
>   				  sbdev->e_addr.manf_id,
> 
