Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB70C79F82
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:41:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5B6D6030F;
	Tue,  8 Sep 2026 20:41:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5B6D6030F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788892890;
	bh=6jmWJK61/SjCyFrb3g0NExISI2RjY7LO/yDYliJAQ/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=s3c82jju4u2tpNBpk9SCh+9B4zmTe+f7ADEQ+y8idrKw5+8sLXU0DOUXyBaoqZAPo
	 LMtX78INssf73D3MY5va76A2GW6pWS3z+i1/FRtqv9qS9681frJW4zWRo0aOuu0MI6
	 TO5gYVA0frCanZNKt92rJEIleUXVIRWYF3GHOlEI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3BC0CF8973E; Tue,  8 Sep 2026 20:36:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73CA4F89739;
	Tue,  8 Sep 2026 20:36:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B52C9F80571; Mon,  7 Sep 2026 05:47:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788752848;
	b=dLSwpT0xcqUlEFT9KYoCHPB/pmUwYP4uoxubQQ3XXzDoJwXgcmUsHZgdhFVIJP1jgNW6
	 Rds/NRFv7AJKlxWMYil7Ba9E67PbBmZCpcFhKkLz30bbL0qp7xpRpe+6qDZ1gghRL7vBD
	 c6OOjkxPUG420leAL2GW4aZ21F4/A0dICh8/Uog1xHjnhmVBiIYS48rTcTR7JD5PkAaPY
	 /D7P6sYtdg8CDRNMf/Ps5nzn0wRk5BgdP5IjVFEt712kiGk7Sv0gkVDoNWUWB0ukG8W0/
	 9MGNB/boHw/pJlxFKPWSDPMzATJ2hACHj1dgVXdcm16FdLAtJKSu+qZC164goxPKLIg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788752848;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=6jmWJK61/SjCyFrb3g0NExISI2RjY7LO/yDYliJAQ/U=;
	b=LI/yz2ftjePYLFEZPvb8efgyO66mTBYkDlck0VdNi5AVItVLgBYKJ/4sHS4QsG3VB2iG
	 oGy5+B+zYxiAtX+9iOrxXkurFKQoer7bdKu5FXBBe1ji5dRMYG9iFbHCdKsXg3ic0fC62
	 GHcaLn5lqyDryEJ7CHHNaLPqpbZB4SIttfQBTUfzVmy6u5KcpT3dEhds50fSp3E/Vi6m8
	 AJydVjUX9UWCjJxFxfVeUycwHSMgNCjJSlcw/dYt/5obdlMbGjWzcsjjQuuqbHVQWVqA3
	 cNrdGaSZ27flfTW+WExgV8JkBJ3hSzyRsg05KW0/bM2r+Zb64Mb/TZuy8sMV3x+vBjQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=H6vvPIR2;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F20C6F800BD
	for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2026 05:47:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F20C6F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=H6vvPIR2
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8520161fdb9so3336565b3a.3
        for <alsa-devel@alsa-project.org>;
 Sun, 06 Sep 2026 20:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788752845; x=1789357645;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vljcaDx2KvDeXjmIWLAHTkvLtKLMiyvxJX3Uoaq3r8g=;
        b=H6vvPIR2ivvZ2FVJm4/ONM+WAvQ9g/350GEaYbGgHbdeWgg5Yi92PUbj7QQPE03fL3
         9hOSEotTnq/rFQCjkwTy+K4+8H/DciPFMTJIfRgMribCMzig3RrA99TUVFXMdH9pO7EP
         zd3zGnRuvC0eAPSQfyWp10wJ5D+qCeWMN8Q9RuUB9PgMtQSMDEYBvOxdomdyGixT/0nU
         C3CX2k7oh3DSRytf7LQNtVc9wqcWGL6fJQWuv2Jh3J6uRGb0Pnyq45nggRra2vgaqulZ
         JbAnJ2InyQs9AGaCf6/VCjyKeZNMIw6aj3dxvVft+ESq79RCLuRaW/HTK6LbLjD4kXGO
         4Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788752845; x=1789357645;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vljcaDx2KvDeXjmIWLAHTkvLtKLMiyvxJX3Uoaq3r8g=;
        b=I4OcOJy9wefMSG+E3sba42XqiwjuVrIqhbYgvXGjoqsUYfGj4C4inClWUc9bfYNPpl
         oGyywc6DcDOgtyqy0hL717wM38SoYaINLn0/V1b42zcdG/NzYJmepLAR1PrDtNaH0oF0
         Ym7eKgbd3VUf1+sypl9rk9MaGgZoBXQJMo7fHd0MQGh3gJlHFBhqIj+lJ1gIC86YiCQc
         vztLi3zsex88r6OaG94e333iY3hGIW5ZqzH1PJDq08eug80xObokt6LAn02bh+pKiHDd
         jZ8UkWVYaj/1J6U/9IKTZs5LfdM+Bj2lYt6iUCcn2VGXqAcIN9x9pqmqxJrJRpuF17IF
         8RpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwK/2khxNacKmXnMQqQW7xU6tXqHOn7jQWuiIAnsbUlcfmGuQ8n8ik1plHRaZNWX5yuZZArUMmBIVX@alsa-project.org
X-Gm-Message-State: AFuF++lTlITQqvjUOTurXiUy8ko39/4X2OpNi8wFBZPXhG+F0J50e342
	oJcUrksZPUBkbu5NfH70KtAnygvd7wqj1YqN4XmKe/v2V7pLGg93cIwN
X-Gm-Gg: AYBFou3m61hpdoxmaYHO/L91Q+mb6PfQx3/xAsQQMjdNXREEGJLoaoQRy/koISzeOHn
	gf9mdZoOyRQts5IAYi5B5DzyD/haFH7DwZpzlPcE/gx0LrT3vmRhq+3xGnLhw2yJP7pGiCPmKiw
	9UvYcnCUansHofFgud9ry+TlVtdHe+5d3Lfkumzi51FAmS7cg4uc4S2u3IbnCQiiwEr37xlnC2u
	KQs3/7fQNIC0ubDP6YCKJceIO2004bDc0m6jWfw4lm3jovXWgA1DDr75sMcA6oHPvJ8+b8i9pQG
	hP56tlnXBDJ3oP15suIar08gw6sH0HnYRqrwslBmDQoAjB1Zg1wpgea1CV35/tBZBz1qLT70wuD
	VCxDS/Qn/TRqCIMwq3o9WQCeMHFGjLDdmnZcqDjRdysQ7wNi0LzGxZIWJsPy6MxeTJFyMo8SYU+
	Pvb4MmwOhV/DoPG4QrXBpj0ZDPypim/QCGtkRs4YSG2dDo+PngstB6mT0to8alXXNRJCnHNlAZy
	09YDwjo4pzMB3mFlY5Qy7fFOM0=
X-Received: by 2002:aa7:888b:0:b0:84f:dfce:966b with SMTP id
 d2e1a72fcca58-8616a06b9eamr25052174b3a.8.1788752844486;
        Sun, 06 Sep 2026 20:47:24 -0700 (PDT)
Received: from [172.20.10.2] (114-137-107-99.emome-ip.hinet.net.
 [114.137.107.99])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152a358a2sm3690281b3a.29.2026.09.06.20.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 20:47:23 -0700 (PDT)
Message-ID: <a5a983de-44f2-45ed-9a71-0839f5349d46@gmail.com>
Date: Mon, 7 Sep 2026 11:45:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ASoC: codecs: nau8360: Set DAC path to bypass mode
 when DSP firmware load fails
To: Mark Brown <broonie@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org, krzk+dt@kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com
References: <20260904060035.196399-1-YLCHANG2@nuvoton.com>
 <20260904060035.196399-2-YLCHANG2@nuvoton.com>
 <apsEO6K6Qo1ADH-y@sirena.co.uk>
Content-Language: en-US
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <apsEO6K6Qo1ADH-y@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: XLQQJI7K5HYA5SJRMQ2T64BPEGTUQHK2
X-Message-ID-Hash: XLQQJI7K5HYA5SJRMQ2T64BPEGTUQHK2
X-Mailman-Approved-At: Tue, 08 Sep 2026 18:35:33 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XLQQJI7K5HYA5SJRMQ2T64BPEGTUQHK2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 9/5/26 01:47, Mark Brown wrote:
> On Fri, Sep 04, 2026 at 02:00:34PM +0800, Neo Chang wrote:
>> Automatically route the DAC path to bypass mode if DSP firmware fails
>> to load, ensuring basic audio playback remains functional.
>> @@ -1702,6 +1702,8 @@ static void nau8360_load_fw_work(struct work_struct *work)
>>   	if (ret) {
>>   		dev_err(nau8360->dev, "Failed to initialize DSP: %d\n", ret);
>>   		nau8360_dsp_enable(nau8360->regmap, false);
>> +		snd_soc_component_update_bits(cp, NAU8360_R12_PATH_CTRL,
>> +			NAU8360_DAC_SEL_MASK, NAU8360_DAC_SEL_BYP);
>>   		return;
> We don't generally do things like this, we rely on the user to fix up
> their configuration, but equally we don't have a good mechanism to flag
> problems with firmware download to the user.  It's not something we
> really expect to go wrong.
>
> Since the register being updated here is a user visible control if this
> does kick in we should also generate an event on the DAC Source control
> so userspace knows something happened.
Hi Mark,
Thank you for your review and suggestion.
I will remove the register update (NAU8360_DAC_SEL_BYP) during firmware 
loading.
Instead, I will add the following check in nau8360_dac_mux_put_enum() to 
warn the user and block the path switch
if the DSP firmware is not ready:

int ret = 0;
//....
mutex_lock(&nau8360->lock);

if (item[0] == NAU8360_DAC_SRC_DSP && !nau8360->load_fw_done) {
     dev_warn(nau8360->dev, "Cannot enable DSP: Firmware not ready or 
disabled\n");
     mutex_unlock(&nau8360->lock);
     return ret;
}
