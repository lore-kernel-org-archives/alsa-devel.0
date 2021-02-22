Return-Path: <SRS0=rOcL=HY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55965C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 13:41:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E1E64DD0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 13:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E1E64DD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19C381662;
	Mon, 22 Feb 2021 14:41:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19C381662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614001315;
	bh=43TH+SqeDzT6oMkVYWV+EFmR3iSbHqr3fSeZxtR10zo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X7n8kOM4XsWZuw/YCQeLHyiqstpw8J1lkMELYEgff2cCf6btm7UJ5w+0wBNQNArH5
	 iVUXxP+7Vpb1aKDKDap74yOAWLuHi2fbrDz/XOf3usRJXWMErnEoyAA9fjZPrtPmnd
	 kl99KNkDLrrSm3T+SOxbUwMv270uDO+sWZ22/0Gs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97DF0F80082;
	Mon, 22 Feb 2021 14:41:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE82CF8025E; Mon, 22 Feb 2021 14:41:02 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 594EFF80082
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 14:40:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 594EFF80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Mh/2qaQt"
Received: by mail-wr1-x434.google.com with SMTP id v14so19109120wro.7
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 05:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5qOMDXlKwKGSMV0dlhtm+r1Bnt4FJ+MlLzZVDJ1zkEc=;
 b=Mh/2qaQtNuQNMCkbqq+geipvjRWb70c42leZ19DU69VpYCGyx+NjV+iDpvYSFqciCK
 c2zHjXAVfUPW24qBAycBSICjQqrSfvU0IKGRf/sV5RuT1uX+h89hD7lRg8Sj4vvFVg8S
 lcbkCuLCIY682aZOxEUv7AYmH6VUadI1w6pYcMzfioD487441I/pQA9YwlDxCShXsKlz
 NUIJ9w6r42gf+UclKwVHqRGksoyRm5Bdd6EpKLzfXtCssNoiAqjKJ8zPQCkPKijfdERd
 vQOcjga4fRrCfcAoh21BDrSHSx/I1sJddbw291w5G+bnnMGvh7CU1jVUB2pqhKCMi4GD
 F6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5qOMDXlKwKGSMV0dlhtm+r1Bnt4FJ+MlLzZVDJ1zkEc=;
 b=ePeCw65BS8e0JShbCpa487Yel10QIavwDnzitibnHq/iGzt6BIdU8QP/FW6ZkQsUYT
 afDd2TXA6T+LUv5xg2DVh6xdVV0DvlnMDbh2xM9S696bxQeVCFnzYnUwGNV+O6yP30LY
 SMJmqsXs1qaH4GqdTtgNcehofTBS+BkbeToMud7nI75VO9va2XLbUGDXLVLYOpGHTt0Y
 gJrXPap3eYg2Je4Uaaj9bJ1Yx+G4c86GU71lbf7Ze4wGAQY8tki/IZ6kBPglQDUYTnfK
 dW5wvSId1QkfVdkfNaFO/HcshQflwYfftjQz2ESEP5LW60HRm4UrFUm+w4t305ahL+ea
 jKnQ==
X-Gm-Message-State: AOAM531hvhoODYII6LW57js4x8fup0cAHsWwKtqVs5Zr8t30kouC5mZS
 8WEG883dc9vxlrQfWCsw10a/Qw==
X-Google-Smtp-Source: ABdhPJw9RcE06nyg386pAnlKMsKfG97+mTmnmPYASTXN9C7glWlOgfek2esNfIW4y98mzcQ/Yw+TcA==
X-Received: by 2002:adf:8b0d:: with SMTP id n13mr22007529wra.94.1614001254340; 
 Mon, 22 Feb 2021 05:40:54 -0800 (PST)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id n10sm2189077wrt.83.2021.02.22.05.40.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Feb 2021 05:40:53 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] soundwire: add support for static port mapping
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>
References: <9a688b02-80a6-fb1f-d6fa-36ba2d88d3b9@linux.intel.com>
 <c6278763-57d9-2631-7b43-829259a9ea1f@linaro.org>
 <3ee60ad9-9635-649e-ba67-d40a96b25256@linux.intel.com>
 <487c91f9-f6ea-75c2-9150-52db2de42a3a@linaro.org>
 <eaf13d70-86fe-3e18-7a5a-4043f2d8a22d@linux.intel.com>
 <aaf34f07-5eed-3045-e4c6-dc9416689b20@linaro.org>
 <f960757f-ec8b-6d3f-f00e-27242c687926@linux.intel.com>
 <e962caa8-89c3-4a22-5932-4498c406e8f8@linaro.org>
 <adb91730-35db-db7a-75b3-4771723de945@linux.intel.com>
 <31ff9d2b-760a-374e-5b37-45d8e8116f7b@linaro.org>
 <20210201102709.GT2771@vkoul-mobl>
 <c8bb718d-c06d-2942-9c0b-2a6f97031e10@linaro.org>
 <64d2537a-bd60-e0a3-c4aa-4f802c34102b@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <caaca3cb-77b2-7137-3319-b0af887f563e@linaro.org>
Date: Mon, 22 Feb 2021 13:40:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <64d2537a-bd60-e0a3-c4aa-4f802c34102b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com
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



On 19/02/2021 19:52, Pierre-Louis Bossart wrote:
> 
> 
>>>>> It seems you are in a different solution-space, where the codec driver
>>>>> needs to notify the master of which ports it needs to use?
>>>> Correct! As Codec is the place where we have mixer controls ant it can
>>>> clearly tell which master ports should be used for that particular
>>>> configuration.
>>> And that should come from firmware (DT etc) and driver should pass on
>>> this info
>>
>> Are you okay with the patch as it is, provided this information is 
>> populated from DT?
> 
> I am fine with the direction at a high-level. The premise for SoundWire 
> is that the bus is simple enough that it can be used in different 
> contexts and architectures, so if Qualcomm need something that differs 
> from what is needed for Intel we are really not in a position to object.
> 
> That said, I could use more explanations on how the mapping is defined: 
> I don't think we have the same definition of 'static port mapping'. For 
> SDCA integration, we plan to have a static mapping in some sort of ACPI 
> table that will describe which port on the Manager side is connected to 
> which ports on Peripheral XYZ. That's static as in set in stone in 
> platform firmware. I understand the reference to DT settings as the same 
> idea.

Yes, we are talking about the same static mapping here!

> 
> But if the mapping depends on the value of mixer controls as you 
> describe it, then it's not static and defined by DT settings, but 
> run-time defined.
I think there is some miss understanding here, the mapping is static but 
the port selection is based on the mixer controls!

> 
> Also maybe we'd want to have a more opaque way of passing the 
> information, maybe with a stream private data or a callback, instead of 
> hard-coding fields that are only used by Qualcomm.

Let me try the callback way and see how it will endup!

thanks,
srini

> 
> 
