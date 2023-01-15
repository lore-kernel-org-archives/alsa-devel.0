Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD7FC63797
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Jan 2023 07:53:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C209462A;
	Sun, 15 Jan 2023 08:53:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C209462A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673769234;
	bh=ULnSzZi7Fcy6i2z1/K2SY0sm86j8JuNp+7N6nuMX2YA=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=F3Oq4pYcUJFplr2se5wcfap0SmRtZNnZ/kv/Z4FlPzWebLHbVq3l1eJ1l0Iu7l7Qk
	 lC2IU7WKBH1beSLtwShDax/vaiundmLYZRsW47/iVJIkvCQ2yoC3d2pMPolTNIjpe+
	 HbfwiN+PLSPbISz1E6su4OoXgr6NPSdTgLqb/gJo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E9ACF805C2;
	Sun, 15 Jan 2023 08:48:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBAC3F804C1; Sun, 15 Jan 2023 01:43:31 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71B9BF8025F
 for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2023 01:43:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71B9BF8025F
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=landley-net.20210112.gappssmtp.com
 header.i=@landley-net.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=AWOVJoTR
Received: by mail-oi1-x22e.google.com with SMTP id i5so2333561oih.11
 for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2023 16:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VA+b6ERucM0SVhgS+CxkVoqDPdylXXEER7Oavou/n5c=;
 b=AWOVJoTRCZIzDDPEVrLicc1SKpwl7KTn8Ol48utvExDUblpnjljkkxvHgz5x7ZXre+
 8m1djuSOUoerjvNlDkOsvOoru5Slmn51JdtG4yWzqApm65GcAawUt0a4970Ve8qE/PbE
 WIpzUe/igEignY6RXJsMefYQMCJguWlv4sRLkistNu2yHDIEgQ5le/hWruMQxtCBR8qR
 R0Xe1ZeaqdcCUIm6QnssL2hDeKkpiOJ4cANGy/HkgZiIyg5h2uIoq1Znienu3k+LNYC0
 mG/pqdest+Z0kWbWIAyWD+qrcbh4pkalGKoAU1Y3Z3G0iffow+5qADIIMc/6gwB/2uWn
 mYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VA+b6ERucM0SVhgS+CxkVoqDPdylXXEER7Oavou/n5c=;
 b=cov0J/2+Lw+0N/+Z8Pe36Zoz0uo/jkDDn+ClAzI2cnXDPqM9qbCRJoI2jM3WuBiUhP
 6I9rmD1KePjc5Fw45VFkIOKG2mkJI+ON9qVI6ySI42Pda3r6eX90qsQLqe1SBuvLkNWe
 wjIhrKrek29+fS84SVqZQoHhR84IVOrdnMUyt8BZsl0IjToq1rmRVSQ2AWmyWQuf/FVk
 hale0DDRsieP8IsjAbizReyFGldMDxBTV+GiCK+iSn1+07ekoEUEH/GVeQroSsf7CxEF
 mjGRDAdJ3tlpfFIT3zuuppnKFMVtHFM2SGaTVU0/1O9w2jC5q+QqHY6zX3fJfsC2i+Tt
 +nTg==
X-Gm-Message-State: AFqh2kryBxlRK6G0wwlne7Y5UGuOnJ22KEMoxW4+n45afaVY+U8M3AVG
 ehef2GPVOU4dG6Kv/HwrN2Lu1A==
X-Google-Smtp-Source: AMrXdXtmlbzCnjvw02a750r61CcJJIRVFXhgi7CC+Te697GM+nVvImU+iajKPZiIXIE5Si7tn9Lk3Q==
X-Received: by 2002:aca:c189:0:b0:35a:6005:3dc5 with SMTP id
 r131-20020acac189000000b0035a60053dc5mr35396207oif.51.1673743401843; 
 Sat, 14 Jan 2023 16:43:21 -0800 (PST)
Received: from [192.168.86.224] ([136.62.38.22])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a056808020a00b00360e46a1edasm10935583oie.22.2023.01.14.16.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Jan 2023 16:43:21 -0800 (PST)
Message-ID: <fe206345-9445-f1be-02c1-b3cc39a533ef@landley.net>
Date: Sat, 14 Jan 2023 18:55:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 02/22] usb: remove the dead USB_OHCI_SH option
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>
References: <20230113062339.1909087-1-hch@lst.de>
 <20230113062339.1909087-3-hch@lst.de> <Y8EEbCP6PRMzWP5y@kroah.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <Y8EEbCP6PRMzWP5y@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 15 Jan 2023 08:48:19 +0100
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: linux-fbdev@vger.kernel.org, Rich Felker <dalias@libc.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org,
 linux-rtc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 1/13/23 01:12, Greg Kroah-Hartman wrote:
> On Fri, Jan 13, 2023 at 07:23:19AM +0100, Christoph Hellwig wrote:
>> USB_OHCI_SH is a dummy option that never builds any code, remove it.
>> 
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  drivers/usb/host/Kconfig | 11 -----------
>>  1 file changed, 11 deletions(-)
>> 
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index 8d799d23c476e1..ca5f657c092cf4 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -548,17 +548,6 @@ config USB_OHCI_HCD_SSB
>>  
>>  	  If unsure, say N.
>>  
>> -config USB_OHCI_SH
>> -	bool "OHCI support for SuperH USB controller (DEPRECATED)"
>> -	depends on SUPERH || COMPILE_TEST
>> -	select USB_OHCI_HCD_PLATFORM
>> -	help
>> -	  This option is deprecated now and the driver was removed, use
>> -	  USB_OHCI_HCD_PLATFORM instead.
>> -
>> -	  Enables support for the on-chip OHCI controller on the SuperH.
>> -	  If you use the PCI OHCI controller, this option is not necessary.
>> -
>>  config USB_OHCI_EXYNOS
>>  	tristate "OHCI support for Samsung S5P/Exynos SoC Series"
>>  	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>> -- 
>> 2.39.0
>> 
> 
> Do you want all of these to go through a single tree, or can they go
> through the different driver subsystem trees?

Neither please. Multiple people are objecting.

Rob
