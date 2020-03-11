Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CCDC10F27
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:32:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E605021D7E
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SpLfcpqH";
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USusKr2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E605021D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3366D846;
	Wed, 11 Mar 2020 12:31:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3366D846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583926318;
	bh=qmA1kkrXALFqyx4RS71+mwWOKBvmJq12cEouL5IqI90=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SpLfcpqHM4gpoQLkCwNrEqgEobNy4rKEpSMUp/kxtgMSvWwvJTL1/hG14nmQd6PjG
	 bC8YXVFZS0bwvr4V5KFjSbhowWsGZBeAbF9ZjwIF+fv7/MSGEWQ3TcRz8OdAhwWoIt
	 7lpE6BQXOqlRFzm8mXjxJoBFU9SOFryKDsCk8GR4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93A9CF800B5;
	Wed, 11 Mar 2020 12:31:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA0ADF801EB; Wed, 11 Mar 2020 12:31:04 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4ED67F800B5
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 12:31:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4ED67F800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="USusKr2+"
Received: by mail-wm1-x343.google.com with SMTP id 11so1679169wmo.2
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+qi8Gsy+phH8WfKkqtpOwo0DUN440dJfBPdiDNKzZv0=;
 b=USusKr2+/LjqIljnqjUN7DohKHee85EjKx+StCQUGw7AqB1NylzxED+zXCPiFtcmu+
 QsaYzsXP6As1w78W81uzKwVSIfx+BiJuxH0nmYRflHGoR4iim5IFwealghWlYXNSFPWC
 AlUpFUsNRYrFg3g5899YGHoxrGl2xBzDZ9LqxfvmYhn3ai5PjbkCtqh9wzRCC6wjGbh0
 ACBnkce2FcS6nb8vwgmUxGun68fmRwpBjQjeCBhqwSh0u5MkSAY9t34GLsIMJBLJsB0P
 dq6GZpIRj/eSTPacBH+l4Co6EFwpgYAx9uVWbYn2DhgVmC4Lx2xmvZWDY2ZD3Hsb8g3Z
 /B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+qi8Gsy+phH8WfKkqtpOwo0DUN440dJfBPdiDNKzZv0=;
 b=F1NbPa7pIYGp8V+2D/TP5mNcifqW6akzqd0IKi5AcySH44Ixv+HoMmQBQcXYM1f9Z4
 Gk1iZFP2KQTsv9u9Z3UyVPWldc/pMPFNYScGZetnzGSF0+WiDYBGBLKGvbQu9vfp7Dfg
 IY6B9EnBCX91KAdoQr8euHD8B7oqAu0M9bd8tLsvOvvUATXqdWFTmwxe4BZ3bCh8wlb2
 AG5qAqzH9mDtacy6bO1WrJxtMiA/u5sF7cknm59XhDu8dYcaahDwZG83cqBDw+QtdoA7
 BZ/sWTx3N1fxkh0iv3Weu3xhTLXFgSJhqRixfORIPATJyZhRk5LVHa57TLLoBDjpmOU+
 ZUXg==
X-Gm-Message-State: ANhLgQ3pGxESUCGJX8fEcvzroNM9/ZFGtYKbrEhnshfZCSAxHIN4bJJk
 Mj+aMWRS4U9XnLskQ16HyIPYJw==
X-Google-Smtp-Source: ADFU+vu8yQwphkn83vEuD1GGYen9Zs60Do+28oOVyU/sJjeCMep301H0NxJVRU99RGuiKzeLl72aJQ==
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr3399437wmf.100.1583926260082; 
 Wed, 11 Mar 2020 04:31:00 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id f2sm10373193wrv.48.2020.03.11.04.30.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Mar 2020 04:30:59 -0700 (PDT)
Subject: Re: [RFC PATCH] soundwire: bus: Add flag to mark DPN_BlockCtrl1 as
 readonly
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 vkoul@kernel.org
References: <20200309173755.955-1-srinivas.kandagatla@linaro.org>
 <d94fca16-ed61-632a-6f8c-84e3a97869c7@linux.intel.com>
 <92d3ae1b-bace-1d20-ef99-82f7e1a0a644@linaro.org>
 <a2b24f84-0f9a-29ab-8748-dc5a26c05ffa@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <dec47c3a-08e9-e9a0-707c-2610cb10fe64@linaro.org>
Date: Wed, 11 Mar 2020 11:30:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a2b24f84-0f9a-29ab-8748-dc5a26c05ffa@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

Thanks for the inputs

On 10/03/2020 15:53, Pierre-Louis Bossart wrote:
> Hi Srinivas,
> 
>>>  > My recommendation would be to add a DisCo property stating the
>>> WordLength value can be used by the bus code but not written to the 
>>> Slave device registers.
>>
>> Does something like "mipi-sdw-read-only-wordlength" as slave property, 
>> make sense?
> 
> The properties can be handled at two levels.
> 
> First, you'd want to change include/linux/soundwire/sdw.h, and add a new 
> field in
> 
> struct sdw_dpn_prop {
>      u32 num;
>      u32 max_word;
>      u32 min_word;
>      u32 num_words;
>      u32 *words;
> +       bool read_only_wordlength;
> 
> Once this is added, along with the code that bypasses the programming of 
> DPn_BlockCtrl1, the implementation has two choices:
> 
> a) hard-code the field value in the codec driver.

This totally works for me.

> 
> b) read the property from firmware with the DisCo helpers.
> 

I would defer adding this for now till there is a real users for this.

> There is no requirement that all properties be read from firmware, and 
> if you look at existing code base sdw_slave_read_prop() is currently 
> unused, each codec implements its own .read_prop() callback.
> 
> We really wanted to be pragmatic, and give the possibility to either 
> override bad firmware or extend incomplete firmware to avoid coupling OS 
> and firmware too much. If you foresee cases where this implementation 
> might vary and firmware distribution is not a problem, then a property 
> read would make sense.
> 
> Just once procedural reminder that all 'mipi-sdw' properties are handled 
> by the MIPI software WG, so we'd need to have this property added in a 
> formal MIPI document update.
> 
> I suggest you talk with Lior first on this.

Sure, I will talk to him.

> 
> Hope this helps
> -Pierre
