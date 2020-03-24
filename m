Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B239FC41621
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:42:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A87920775
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mkZNmc7h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJBjrMd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A87920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84F2B1607;
	Tue, 24 Mar 2020 14:41:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84F2B1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585057365;
	bh=LT9OOt7loNFZ0WXNkY2WYMSvtaGpiLRY+zkIGnsRH9Q=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mkZNmc7hsZost1G0Y66iV1LUo+UoW651Kboj7cOMIqecvkHpgiSS5SZP1CbUtdysP
	 Agvq2WOCCO8h9LkNj7z9pi+rxiCke/CNO6ScBYueAvdgMYk6gwjLjh3ba7sl3BaCRF
	 yd/L5Y2OCfkbDM9VZOh5Cehzd5bOUB2nTeoomFiE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DD137F801F8;
	Tue, 24 Mar 2020 14:41:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C320F801F9; Tue, 24 Mar 2020 14:41:53 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C296F800B9
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 14:41:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C296F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="AJBjrMd/"
Received: by mail-wm1-x344.google.com with SMTP id c81so3235383wmd.4
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 06:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uAuhnpcorA/aoHo7Ikv4cyMAQQ+803f7lVgbulzW1FA=;
 b=AJBjrMd/1WefHvD9tC2VIx2ZOHNAhs5ei/dRqGhoQ+xHhEWFzRtAPXIF+2EQSCNsil
 IYP+NCFB54M8Siyg2oE1SZncCp/zDRSKgZd3BgdVOrJxkbaZ9LzI+YF2VBPXuQXGirKP
 d1hV0URs2NnrTFFCiZdmR/XvsyJiQefUroToumZlA1Ovq/lxiGOY9gm1kUNxTPAQ/Ble
 hEKrfSfcVL6rJg65U9dShGBKaFs/OCfBjQoq0Zv/bOTU1ornTJspd7nlkZTDr6TL38mx
 fl6miirZIwnVmc/f2+hMuFa7bxRd9GzqCWXxy3XfkZQjkcZEoZGhJmgttRXQejYnJYTI
 roHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uAuhnpcorA/aoHo7Ikv4cyMAQQ+803f7lVgbulzW1FA=;
 b=pM40YSdfimPptg+I3Re7wflW3+gUa5v1SLvlvOW9On85GRNpBeUwh6Oaz1fXpUiOD2
 O4CdBnmD6a/lSihP8CBc+26V41Yt+pn19/W9OstaA/27ndS5L+66CKdPXN2aeSVa4ykv
 vsLDMKyhE+hSst6qDfjXgYbdcLuly4cSoru9KhsK7R+uwih6Qe1cRfe86T4dk0J/lkF3
 DayFhiz+IAbiLacNuFUl4AfijXR6RmZuZ1ll5K+KNU8v8rBumtH+QUCxxjhclbqXQF18
 ISfmHy8RcMhoOVDUNoLhgJVa8m4tjPx8ryBqQLqlTUMKl6Qj/j9jD5VifuSW/6F/xuQQ
 S2Zw==
X-Gm-Message-State: ANhLgQ1EsHESNWHryQWOAMWkZuU2xlOsV3PQGJleBi6o2DfNhIJ6KhDd
 MVYgtr/guFrct14r0PtNzo8=
X-Google-Smtp-Source: ADFU+vvFoLChVg+kcqF5i+tj7Rhdcb7vjdP06Fu8Z1e/SDrcul0CpOiMUPThAQcr3KXGQ/qMa93EEA==
X-Received: by 2002:a1c:ba06:: with SMTP id k6mr5507351wmf.136.1585057308561; 
 Tue, 24 Mar 2020 06:41:48 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id f9sm29768962wro.47.2020.03.24.06.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 06:41:47 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: convert rockchip spdif
 bindings to yaml
To: Mark Brown <broonie@kernel.org>
References: <20200324123155.11858-1-jbx6244@gmail.com>
 <20200324133506.GC7039@sirena.org.uk>
From: Johan Jonker <jbx6244@gmail.com>
Message-ID: <d1225b12-b3d1-3cc7-be0b-8f834e8b08ce@gmail.com>
Date: Tue, 24 Mar 2020 14:41:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324133506.GC7039@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Hi Mark,

Today I send 2 sets. One for I2S and one for SPDIF.
'power-domains' is added in respons to robh answer to rockchip,vop.txt
conversion.

>> Hi,
>>
>> Question for robh:
>>
>> In the old txt situation we add/describe only properties that are used
>> by the driver/hardware itself. With yaml it also filters things in a
>> node that are used by other drivers like:
>>
>> assigned-clocks:
>> assigned-clock-rates:
>> power-domains:
>>
>> Should we add or not?
> 
> Yes, only pinctrl properties are automatically added.
> 
> We could change 'assigned-clocks', but for now I think they should be 
> added.
> 
> Rob


On 3/24/20 2:35 PM, Mark Brown wrote:
> On Tue, Mar 24, 2020 at 01:31:53PM +0100, Johan Jonker wrote:
>> Current dts files with 'spdif' nodes are manually verified.
>> In order to automate this process rockchip-spdif.txt
>> has to be converted to yaml.
> 
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>> Changed V2:
>>   dmas and dma-names layout
> 
> This is the second v2 you've sent of this today - it adds these but
> drops Rob's ack?
> 

