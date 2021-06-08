Return-Path: <SRS0=yD/C=LC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDD1C47082
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 17:54:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949C06135A
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 17:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949C06135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A4AB1796;
	Tue,  8 Jun 2021 19:54:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A4AB1796
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623174894;
	bh=ITwXB9giPF5jSY2D2zvQCe1SRv87ilaRjhho/ktL6+E=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aWROEHtc9zFtnMp9BKJlaYljwJ+tL/YwYzxGMVZj9b5VbbCNC6gfmdjUe3JjzGEjG
	 ZRzgxGf3tJ2Vf/U/L5l0pCB+VrBQqXHsHvcApTgyZ70lcO8o6CJRpUiCxIwRNewgCv
	 nGB4M3chdjp/mYYDMbvQARHwuaCk+QFjno4mm32Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B64E1F80116;
	Tue,  8 Jun 2021 19:54:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0062CF80218; Tue,  8 Jun 2021 19:54:02 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F428F80116
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 19:53:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F428F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="GOpHFHjq"
Received: by mail-il1-x12a.google.com with SMTP id i13so14572255ilk.3
 for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2021 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b2ZwLtaT9Q1Li35z2T9QbYenVB5lzMrQ7040SY2fh2I=;
 b=GOpHFHjq+iHvZnub1fX7MDT5uUpRAF8FXVU8N9EvJTT+oCBBKKiIIzw+/s+uUEuTPT
 Zwr4SOlT/uuOze2oskkhdK5WhjxM+OEafB+6PWXnoGzPkUibWw4ANLejdSA3Ry26f7Qr
 gBYUPM+lf1N2umiqQdz0Gvs+v7ICo2esIp2lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b2ZwLtaT9Q1Li35z2T9QbYenVB5lzMrQ7040SY2fh2I=;
 b=Vre+6c48MM0CWKlXTD+adaGsK2mzzJ0vIV40/y0hJLAK9cIafUCDEoG6qQnhyFjKDH
 nfm6gm5ilBz21Mm6bHBXifvr9E8j+n/Yjs+efcDkqW1z5RfBnMeSNeb4GAS/Lmwddy8y
 AMQpr2C+RQ2vaRa/UMdYpnml7Fok8X+iAO3FqZ/CzU3/jO8s6R4FhUTHrY7jZgWrfgRY
 E/egLMEuzWEcULL6234j3EFHMH6Tdo8jhPFAvupA0ueW3EYTFtoMTTEgoLiwNj6XsIeq
 eQ1qtXSNxb7esc4vhNJOMIULCtM114yPFp4aDCvYAx31I7WBC5mBODgyu3pnKm6PEAFy
 TPlg==
X-Gm-Message-State: AOAM533UrEj++vHfH9Z4lWCcExnFtVACquCcObbWs9OYJovyltJcNRpJ
 MGtJsTpcwY5yZErsD2hWrfusog==
X-Google-Smtp-Source: ABdhPJzw+QH5RNrgBfY6VDioZfH02jeyPkErnJSVADuI6BpMUANu6uU/3RabvnbRNLeUR6VTGcBzzg==
X-Received: by 2002:a92:d944:: with SMTP id l4mr21640928ilq.244.1623174833999; 
 Tue, 08 Jun 2021 10:53:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id s23sm180076iol.49.2021.06.08.10.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 10:53:53 -0700 (PDT)
Subject: Re: [bug report] media: sound/usb: Use Media Controller API to share
 media resources
To: Dan Carpenter <dan.carpenter@oracle.com>, shuah@kernel.org
References: <YLeAvT+R22FQ/Eyw@mwanda>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3c0f6858-ca94-3cd9-7398-20073dfff7b0@linuxfoundation.org>
Date: Tue, 8 Jun 2021 11:53:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLeAvT+R22FQ/Eyw@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Shuah Khan <skhan@linuxfoundation.org>
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

On 6/2/21 6:59 AM, Dan Carpenter wrote:
> Hello Shuah Khan,
> 
> The patch 66354f18fe5f: "media: sound/usb: Use Media Controller API
> to share media resources" from Apr 1, 2019, leads to the following
> static checker warning:
> 
> 	sound/usb/media.c:287 snd_media_device_create()
> 	warn: 'mdev' can also be NULL
> 
> sound/usb/media.c
>     270
>     271          mdev = media_device_usb_allocate(usbdev, KBUILD_MODNAME, THIS_MODULE);
>                  ^^^^
> 
> If CONFIG_MEDIA_CONTROLLER is disabled then "mdev" is NULL.

If CONFIG_MEDIA_CONTROLLER is disabled, this file won't be compiled.
Please see below clause in the Makefile.

sound/usb/Makefile:
snd-usb-audio-$(CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER) += media.o

Also, this select in sound/usb/Kconfig selects appropriate
configs.

select SND_USB_AUDIO_USE_MEDIA_CONTROLLER if MEDIA_CONTROLLER && 
(MEDIA_SUPPORT=y || MEDIA_SUPPORT=SND_USB_AUDIO)

We are good here with the above in place to make sure media.c
code isn't in play when CONFIG_MEDIA_CONTROLLER is disabled.

thanks,
-- Shuah
