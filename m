Return-Path: <SRS0=7Yh/=DV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D79C433E7
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:47:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9669B2173E
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AM/6zF0I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nostatic-org.20150623.gappssmtp.com header.i=@nostatic-org.20150623.gappssmtp.com header.b="YTOdCCH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9669B2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nostatic.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 077871736;
	Wed, 14 Oct 2020 18:46:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 077871736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602694044;
	bh=kHeYVqa926LDZLZJsRRKTDZUUSyJkko/4HH3dSXgof4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AM/6zF0IyR7666VAwD2VfJlrPYdM4gM7ZSq4R8F01ZXQf4SqDEL0K7oZuSma4K/VF
	 xBokmOyJ0+/+VtPThoI0Gp4Oo8kbGANtOCyx/iqLe/G/oUqg08DRkHkTEwe+rztWwl
	 1sH/K5JqKyRmXtF6rWUtYhwcW5SVH4ZNp7nGebCM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 729C2F8020D;
	Wed, 14 Oct 2020 18:46:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2995F80217; Wed, 14 Oct 2020 18:46:32 +0200 (CEST)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 378D6F80118
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2020 18:46:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 378D6F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nostatic-org.20150623.gappssmtp.com
 header.i=@nostatic-org.20150623.gappssmtp.com header.b="YTOdCCH0"
Received: by mail-yb1-xb44.google.com with SMTP id x20so3187662ybs.8
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2020 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nostatic-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YxmGDW8IPYCvYfdpYPLUhZGavOOcHktln/b3x9oeDNs=;
 b=YTOdCCH057FU9F4H3h1TftjfTrr4F+5jcFfJITa2Q8nw47OqoJ9n/z0kG5mOdAx8ZX
 4hvSA17OT1eN8IUf20Om2Il7DELZMH3LAo565KdyXNpJDoE+H/6yqTMtCgzcdHMfY14+
 bZy4oF8hDiC2RN3fp0P9kXWCAQ4KtOdDHRZX5zRmUIIK35Qr2G9iLboEkIoSIxGW5hUP
 zFF6r8/7kePqJ35nzUXaL53vvrq2d6VJOV7F4eRYAVKM27i53rg76Nkjl/a7XHsO0696
 /aew8mnt4lsQjaV3t4dnDEbnJv1fXBV+B9SQJV2jtBDEP5pRHv9gIFl3GVKzZB0AAZUm
 tbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YxmGDW8IPYCvYfdpYPLUhZGavOOcHktln/b3x9oeDNs=;
 b=XI6oWNqFnmy9BslEEjooERTqq+zwIzSutBvH0pRn02N/amD3JPwIwbzvhtxgO9tVTy
 SLvcAzCT1V8MmP3UC0cD5Iqku4bAImCDqoobL4WyRP753RaLTd9qw8xNDZe3P5EgTYSH
 78t3k0bn7RrIOoAV2IZytmky4n4t0IYKykEdbOml9Dg33L/IbaQD+/wHqvw3S21Wh9h/
 oQv+DUY+0xaSNA9LQRFVcBHFjZwjPzUr9n+drw+4zg3mj9U8BY6JzH6lk8TEwoYlUp1G
 NfMhxiMvA7mEMHY5X0511jaWWyw3nS48qc+XBU9gRzl6/Qw+7B5eRRhvgIVxQTmR2XdZ
 2BoQ==
X-Gm-Message-State: AOAM530gx805n/BqNmSmzuM3OBVq4ABKrXmWwdH5BFcqyEzkVIJeuP5V
 dyIEctAJv2p9Ip4YAZUyAIeicVCBP2RPi+f7rslaNA==
X-Google-Smtp-Source: ABdhPJyDYiJrSzpcE10SZbPYtAGUFhOoLXbYjCE4/HsOSHJ0DTln8MRK9nXEjw7tzkQBaJgrGw7283qJn6C3sbsjUv0=
X-Received: by 2002:a25:2e43:: with SMTP id b3mr400026ybn.144.1602693978860;
 Wed, 14 Oct 2020 09:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191011171937.8013-1-szszoke.code@gmail.com>
 <s5hftjriy1q.wl-tiwai@suse.de>
 <CAPMdQDmY7CdbrHyOwhJNFBREQ0EO1SKufRdN_YR6TG4zmJzXpA@mail.gmail.com>
 <CAHXb3bf+0uKS-+aEVsgebUbYPt1wCBZ7GLAjF57BrPDHcveuQQ@mail.gmail.com>
 <CAPMdQDmE3cgu2whqTxf7pFUoQusUYJKK7xLASev8JdWD-9oypQ@mail.gmail.com>
 <CAHXb3bdrPC_v0oAEkWDR-VH7NZ3uoFdSw-dzNo_Fwy8HzeTopA@mail.gmail.com>
 <CAPMdQDmiCDWTdfpbAwM7tJL+KiPApjd0jd46yPemw04-6CQWjg@mail.gmail.com>
In-Reply-To: <CAPMdQDmiCDWTdfpbAwM7tJL+KiPApjd0jd46yPemw04-6CQWjg@mail.gmail.com>
From: Mike Oliphant <oliphant@nostatic.org>
Date: Wed, 14 Oct 2020 09:46:10 -0700
Message-ID: <CAHXb3bfgfHDYfkYEZOKttvNkpe+frBeeogzcoA7UBT+=3wqy1g@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: usb-audio: Disable quirks for BOSS
 Katana amplifiers
To: Mailing Lists <maillist@superlative.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org
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

Hi Keith,

The lsusb output just shows that the endpoint is there, but not that it is
getting connected when the device is initialized. Can you check dmesg
output when you use the device for playback?

This is what I see from dmesg when the implicit feedback endpoint is being
used:

[   26.787360] usb 1-1.1: setting usb interface 1:1
[   26.787367] Creating new playback data endpoint #d
[   26.787375] Creating new capture data endpoint #8e
[   26.787678] usb 1-1.1: Setting params for ep #d (type 0, 12 urbs), ret=0
[   26.787685] usb 1-1.1: match_endpoint_audioformats: (fmt @6bc43c84)
score 2
[   26.787745] usb 1-1.1: Setting params for ep #8e (type 0, 12 urbs), ret=0
[   26.787751] usb 1-1.1: Starting data EP @a14130b5
[   26.788420] usb 1-1.1: Starting sync EP @720fb7cf

Note the "Starting sync EP".

Mike

On Wed, Oct 14, 2020 at 9:35 AM Mailing Lists <maillist@superlative.org>
wrote:

> On Wed, 14 Oct 2020 at 17:12, Mike Oliphant <oliphant@nostatic.org> wrote:
>
>> Keith - are you getting an implicit feedback endpoint created when you
>> run with the patch?
>>
>
> Hi Mike,
>
> It appears that I do. For reference I'm on kernel 5.4.0-51:
>
> Bus 001 Device 007: ID 0582:01d6 Roland Corp. GT-1
> Device Descriptor:
>  bLength                18
>  bDescriptorType         1
>  bcdUSB               2.00
>  bDeviceClass          255 Vendor Specific Class
>  bDeviceSubClass         0
>  bDeviceProtocol       255
>  bMaxPacketSize0        64
>  idVendor           0x0582 Roland Corp.
>  idProduct          0x01d6
>  bcdDevice            0.00
>  iManufacturer           1 BOSS
>  iProduct                2 GT-1
>  iSerial                 0
>  bNumConfigurations      1
>  Configuration Descriptor:
>    bLength                 9
>    bDescriptorType         2
>    wTotalLength       0x00bc
>    bNumInterfaces          4
>    bConfigurationValue     1
>    iConfiguration          0
>    bmAttributes         0xc0
>      Self Powered
>    MaxPower                0mA
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        0
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass       255 Vendor Specific Class
>      bInterfaceSubClass    255 Vendor Specific Subclass
>      bInterfaceProtocol      0
>      iInterface              0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        1
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass       255 Vendor Specific Class
>      bInterfaceSubClass      2
>      bInterfaceProtocol      2
>      iInterface              0
>      ** UNRECOGNIZED:  06 24 f1 01 00 00
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        1
>      bAlternateSetting       1
>      bNumEndpoints           1
>      bInterfaceClass       255 Vendor Specific Class
>      bInterfaceSubClass      2
>      bInterfaceProtocol      2
>      iInterface              0
>      ** UNRECOGNIZED:  07 24 01 01 00 01 00
>      ** UNRECOGNIZED:  0b 24 02 01 02 04 18 01 44 ac 00
>      ** UNRECOGNIZED:  06 24 f1 04 16 00
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x0d  EP 13 OUT
>        bmAttributes            5
>          Transfer Type            Isochronous
>          Synch Type               Asynchronous
>          Usage Type               Data
>        wMaxPacketSize     0x0038  1x 56 bytes
>        bInterval               1
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        2
>      bAlternateSetting       0
>      bNumEndpoints           0
>      bInterfaceClass       255 Vendor Specific Class
>      bInterfaceSubClass      2
>      bInterfaceProtocol      1
>      iInterface              0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        2
>      bAlternateSetting       1
>      bNumEndpoints           1
>      bInterfaceClass       255 Vendor Specific Class
>      bInterfaceSubClass      2
>      bInterfaceProtocol      1
>      iInterface              0
>      ** UNRECOGNIZED:  07 24 01 07 00 01 00
>      ** UNRECOGNIZED:  0b 24 02 01 02 04 18 01 44 ac 00
>      ** UNRECOGNIZED:  06 24 f1 04 16 00
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x8e  EP 14 IN
>        bmAttributes           37
>          Transfer Type            Isochronous
>          Synch Type               Asynchronous
>          Usage Type               Implicit feedback Data
>        wMaxPacketSize     0x0038  1x 56 bytes
>        bInterval               1
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        3
>      bAlternateSetting       0
>      bNumEndpoints           2
>      bInterfaceClass       255 Vendor Specific Class
>      bInterfaceSubClass      3
>      bInterfaceProtocol      0
>      iInterface              0
>      ** UNRECOGNIZED:  06 24 f1 02 01 01
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x03  EP 3 OUT
>        bmAttributes            2
>          Transfer Type            Bulk
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0200  1x 512 bytes
>        bInterval               1
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x84  EP 4 IN
>        bmAttributes            2
>          Transfer Type            Bulk
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0200  1x 512 bytes
>        bInterval               0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        3
>      bAlternateSetting       1
>      bNumEndpoints           2
>      bInterfaceClass       255 Vendor Specific Class
>      bInterfaceSubClass      3
>      bInterfaceProtocol      0
>      iInterface              0
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x03  EP 3 OUT
>        bmAttributes            3
>          Transfer Type            Interrupt
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0200  1x 512 bytes
>        bInterval               4
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x85  EP 5 IN
>        bmAttributes            3
>          Transfer Type            Interrupt
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0200  1x 512 bytes
>        bInterval               4
> Device Qualifier (for other device speed):
>  bLength                10
>  bDescriptorType         6
>  bcdUSB               2.00
>  bDeviceClass          255 Vendor Specific Class
>  bDeviceSubClass         0
>  bDeviceProtocol       255
>  bMaxPacketSize0        64
>  bNumConfigurations      1
> can't get debug descriptor: Resource temporarily unavailable
> Device Status:     0x0001
>  Self Powered
>
>
> --
> Keith A Milner
>
