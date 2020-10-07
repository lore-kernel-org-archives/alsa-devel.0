Return-Path: <SRS0=3CTx=DO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD8FC41604
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:59:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A162220789
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R7PC6t3y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtKaywzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A162220789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2560316DB;
	Wed,  7 Oct 2020 17:58:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2560316DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602086388;
	bh=Z2HLQ0krZP5LUxeUFsKXuMXqjCBMVQCbz6WLVBAKOgs=;
	h=Subject:References:To:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R7PC6t3yJnrcAWVDEG//2iiFqwLZTtXpjkgdNFWTPsxGcZ27IJKV0F5DQKqT4/RcT
	 0OUCT0Pk2lfHr9D5PorRii/72+XcW6PRPGpKsZIMXCOvwU7qh/vNmqqUn881HRjOpa
	 JXzYeuGg3T5VWrCOHBaOrQ7L24WunUZg+zisbXD0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C77EEF802D7;
	Wed,  7 Oct 2020 17:54:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31E98F80128; Wed,  7 Oct 2020 09:28:26 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF175F80090
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2020 09:28:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF175F80090
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="gtKaywzq"
Received: by mail-lf1-x12b.google.com with SMTP id r127so1104031lff.12
 for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2020 00:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:references:to:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=Ql+M7CkBVgu4+ZSBxhDzGyq0UmUz0P638VyiffXun2I=;
 b=gtKaywzqhY+DHBOLOA0ZCV9qfRFmBSFvo35fPlrgjfI6tFkR9X/6YdEB4lNqEC6yTa
 ogr3eEO0fFAVpfvch8UPNeFfpJgnGvAEuURt5TedJt8UC1e7wtDSvdq2IOSdN97tbeBP
 fAsp/1IPsHiCLw6EAmIeLKneyJLYrJsAVJIz7zez0MJ5bConBCI8TwQKi+kGWmPUSHWU
 wyUxHWScvF4AcM9NSB3btsPi/7PMF9Be/m8D20oej1PKAvTvqC0RhKRgP5mbO/gMuKcR
 Fg1MXI4xCVB1vKoRfE8YnYbDNcwaVpMHIJQEMvmOTxGmr6OYReTtdpmwl9jXzbsD/yRf
 7wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:references:to:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=Ql+M7CkBVgu4+ZSBxhDzGyq0UmUz0P638VyiffXun2I=;
 b=pxRsrHy3jlSN+KwryePMqVF5xG8Aju2k4cr5zMb8P1pp5EUOJuiRrj0R1DzrohJgkD
 GfhoOHQmK7FD6QjaZ6Wa/ie8lm2Vee7KIOiy3sGXoUcKqgdo9tVV8H3dTIJgdlmAvOIZ
 Xt1b+EOHPU53SOq6z71p5iPqmHPbo/IU3P4iprE2SX8cYEx1M+cjEuVO1ZYxcnuE/KdG
 VWD00+uhR/SqKb/lxpJdrmjompGwwtx3CJVSgB2yv6TNH3NeBbMLLMhwhAxtJKPSRagW
 V1/uaVmQFbht6Dy4Rn48g9L9wkfZFaD7hw/ss+Rp+1UxFNyGzyHWmhNqyF3PKLDHpr83
 CTlA==
X-Gm-Message-State: AOAM533otXWraLnNquJCFLunAjRc96FUVj1RNgVqz2LFEeCwW4sBB0IZ
 Eh/KX4ynobRKKUpnPjSfdXfxwUovS1OL8Q==
X-Google-Smtp-Source: ABdhPJxJV+zBv9WdGioBGEHVX98IKXUzVuW4jJVDUjjmO2TqOuTDvJWN+VwRaVFgtdtIIiqM1B+Yfg==
X-Received: by 2002:a19:cc4e:: with SMTP id c75mr580889lfg.364.1602055696793; 
 Wed, 07 Oct 2020 00:28:16 -0700 (PDT)
Received: from [192.168.100.249] ([156.67.88.205])
 by smtp.gmail.com with ESMTPSA id g11sm202514lfh.253.2020.10.07.00.28.15
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Oct 2020 00:28:16 -0700 (PDT)
Subject: Fwd: [alsa-devel] trying to get an eleven rack to work
References: <62fe062c-5355-d670-4cd0-4607bd3b6131@gmail.com>
To: alsa-devel@alsa-project.org
From: Jerzy Dubin <jerzydubin@gmail.com>
X-Forwarded-Message-Id: <62fe062c-5355-d670-4cd0-4607bd3b6131@gmail.com>
Message-ID: <79f53b54-0c3f-78e1-0f04-3ec4705f3f79@gmail.com>
Date: Wed, 7 Oct 2020 09:28:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <62fe062c-5355-d670-4cd0-4607bd3b6131@gmail.com>
Content-Language: pl
X-Mailman-Approved-At: Wed, 07 Oct 2020 17:54:46 +0200
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

Hello Clemens,

any news in this topics :

https://mailman.alsa-project.org/pipermail/alsa-devel/2012-April/050944.html

https://www.alsa-project.org/pipermail/alsa-devel/2012-March/050649.html


I tried to get it work and added in sound/usb/quirks-table.h

|USB_DEVICE_VENDOR_SPEC(0x0dba, 0xb011), .driver_info = (unsigned long) 
& (const struct snd_usb_audio_quirk) { .vendor_name = "Digidesign", 
.product_name = "Eleven Rack", .ifnum = QUIRK_ANY_INTERFACE, .type = 
QUIRK_COMPOSITE, .data = & (const struct snd_usb_audio_quirk[]) { { 
.ifnum = 1, .type = QUIRK_AUDIO_STANDARD_MIXER }, { .ifnum = 3, .type = 
QUIRK_AUDIO_STANDARD_INTERFACE }, { .ifnum = 4, .type = 
QUIRK_AUDIO_STANDARD_INTERFACE }, { .ifnum = -1 } } } } Then there was 
problem with sample rates(|||unable to retrieve number of sample rates| ) so i modified |sound/usb/format.c (i have checked sample rates on device):
|if (ret < 0) { switch (chip->usb_id) { case USB_ID(0x0dba, 0xb011): /* 
Eleven Rack */ dev_info(&dev->dev, "%s(): Eleven Rack: unable to 
retrieve number of sample rates. Set it to default value (clock 
%d).\n",__func__, clock); fp->nr_rates = 1; fp->rate_min = 44100; 
fp->rate_max = 44100; fp->rates = SNDRV_PCM_RATE_44100; fp->rate_table = 
kmalloc(sizeof(int), GFP_KERNEL); if (!fp->rate_table) { ret = -ENOMEM; 
goto err_free; } fp->rate_table[0] = 44100; return 0; default: 
dev_err(&dev->dev, "%s(): unable to retrieve number of sample rates 
(clock %d)\n", __func__, clock); goto err; } } Now im getting : ||[ 152.114655] usb 1-4: new high-speed USB device number 6 using 
xhci_hcd [ 152.268388] usb 1-4: New USB device found, idVendor=0dba, 
idProduct=b011, bcdDevice=20.01 [ 152.268393] usb 1-4: New USB device 
strings: Mfr=1, Product=2, SerialNumber=0 [ 152.268395] usb 1-4: 
Product: Eleven Rack [ 152.268397] usb 1-4: Manufacturer: Digidesign [ 
152.311112] usb 1-4: parse_audio_format_rates_v2v3(): Eleven Rack: 
unable to retrieve number of sample rates. Set it to default value 
(clock 129). [ 152.312918] usb 1-4: 4:1: cannot set enable PITCH (v2) [ 
152.316184] usbcore: registered new interface driver snd-usb-audio [ 
152.364920] usb 1-4: 4:1: cannot set enable PITCH (v2) [ 152.366262] usb 
1-4: 4:1: cannot set enable PITCH (v2) [ 152.366991] usb 1-4: 4:1: 
cannot set enable PITCH (v2) [ 152.367432] usb 1-4: 4:1: cannot set 
enable PITCH (v2) [ 152.368070] usb 1-4: 4:1: cannot set enable PITCH 
(v2) [ 152.371067] usb 1-4: 4:1: cannot set enable PITCH (v2) [ 
152.372155] usb 1-4: 4:1: cannot set enable PITCH (v2) [ 152.372496] usb 
1-4: 4:1: cannot set enable PITCH (v2) [ 152.373180] usb 1-4: 4:1: 
cannot set enable PITCH (v2) [ 152.373894] usb 1-4: 4:1: cannot set 
enable PITCH (v2) [ 152.376748] usb 1-4: 4:1: cannot set enable PITCH 
(v2) [ 152.377498] usb 1-4: 4:1: cannot set enable PITCH (v2) [ 
152.378690] usb 1-4: 4:1: cannot set enable PITCH (v2) Should i still 
wait for backend infrastructure ? Or there is something what i can do 
here ? Regards, Jurek |||||

