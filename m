Return-Path: <SRS0=yD/C=LC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFD3C47082
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 12:16:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B201E6124C
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 12:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B201E6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FFEE16BD;
	Tue,  8 Jun 2021 14:15:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FFEE16BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623154559;
	bh=HRffsCU/XKxvwZDsyBaFc1G/xT5lZ3QpZINkqe/0m8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EXNd8PgpbqH5Ep/HWrdvzP3rrgvuPQnKCJuAg9yy0rDgz+Ej7tGc4FTo5LpBu2LDl
	 qsF+sa0rEKjfN+mWeNIgxEOlt6GWTdSNI1ANPIxsLmPYM2lRMcwEhw3lAwNgw8aiJG
	 J5lgrRDFdgG5svBoQHqpyqcTo6p7l9WVanbyZzDQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A23A1F80116;
	Tue,  8 Jun 2021 14:15:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8BDDF80218; Tue,  8 Jun 2021 14:15:06 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1732F80116
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 14:14:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1732F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="lPW4oQOy"
Received: by mail-lf1-x131.google.com with SMTP id a1so21997030lfr.12
 for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2021 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OVogO/XSWqLyDA2uHCRH9jeNUy1pXTLBmjf9ZIFrx7Q=;
 b=lPW4oQOyLZQGl/3orCkMp/ebF6pGBCGkRp12kRp6Al+e4Q07koOw2UicH0QJVJK53g
 +enqy/O+jQxO3jba8slsnZt3zyOnb/ShGI1Ly/AvNX4c6B/N57NTy6vHcy/s8x0ki5Ow
 LVX0Lz9+4fHQXZE4gMUT2jshb0mB3pGYq0DFv6p8bw4MKZolO7TYGvNq4xRxcU/mIGka
 coiSVPKwB6PeASv/Awh7tQ1euiVvzllour48lhOrJ7SjrpYMu6NRAlaefeWp0i3HDcOe
 kx/xc1CStbdE8WrHU2TsCQa+TKvVNyJr519gdbOLpqt3y3ctU2KBuhqyWIDWWLhcFyMv
 yqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OVogO/XSWqLyDA2uHCRH9jeNUy1pXTLBmjf9ZIFrx7Q=;
 b=rKVb1gL/SwsERqGM5esr67sVmwLWxvA4ZL69y+a9d6rOSPWEN+7gQlm2kN6IftNy/5
 lNIMQhKRWcIHRpEjPLcGR62x2h2wCWWnu/p3/zFXpc6Xh/ofX5+sAexF6r6s1xQzpZ/w
 v4cYzHmvMxYkyFpwA9r0+TzvELj7sAuYw8/5vUfqvxfsVCbpFOEDfELmTS5gZaCc/NXr
 vT0mAcIt0MhU06X7nz4jRWVb778AnP9Q2U3T3EVTyKlOITOPyk9SjW+cJA7VcSHcgy5P
 i7ECIKmlKGM+hFqFqXgdTjFv9Bs3bpAixqZQQLXy8oRDyTRXaVSGxYUvDStYsPCKZh0p
 OMdg==
X-Gm-Message-State: AOAM5328DmqghbdxYM442JnYcg172PVsai/ZMGy42im9uhrQpbZZ/a5Q
 GBEJj+UWqP43dQF0Cve+FTZgPfexgFrZAqBGgLA=
X-Google-Smtp-Source: ABdhPJz5oCxVu/kAh6Dt9iepZo0mZdaEvYTUdBRyvOHkaBqCnPMBsanmdbTTYI8apWu1oNIr91SPfsfQqjGPGpwJO5A=
X-Received: by 2002:a19:da12:: with SMTP id r18mr15118375lfg.549.1623154494912; 
 Tue, 08 Jun 2021 05:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+haTa8FJep+mokae4O7Gy9zzq2dbPk28fuEH5FO24uTzw@mail.gmail.com>
 <YL9RDBUsk23LvHV9@kroah.com>
In-Reply-To: <YL9RDBUsk23LvHV9@kroah.com>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Tue, 8 Jun 2021 17:44:42 +0530
Message-ID: <CAHhAz+gkm3EHE71PM4xzekC7Vsv3gksBd-M9_5iFe5AcNZbLOQ@mail.gmail.com>
Subject: Re: USB sound card issues
To: Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-usb@vger.kernel.org,
 linux-sound@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
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

On Tue, Jun 8, 2021 at 4:44 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 08, 2021 at 04:20:07PM +0530, Muni Sekhar wrote:
> > Hi all,
> >
> > I am using a USB sound card(snd-usb-audio), and it fails while doing
> > the audio recording "arecord: pcm_read:2032: read error: Input/output
> > error".
> >
> > What could be the problem? and is there a workaround for this?
> >
> > $ arecord -l
> > **** List of CAPTURE Hardware Devices ****
> > card 1: BT_AG [BT_002], device 0: USB Audio [USB Audio]
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
> >
> >
> > $ arecord --device hw:1,0 --channels 1 --format S16_LE --rate 32000_Hz
x.wav
> > Recording WAVE 'x.wav' : Signed 16 bit Little Endian, Rate 32000 Hz,
Mono
> > arecord: pcm_read:2032: read error: Input/output error
>
> What kernel version is this, and what other kernel messages are printed
> when you plug your device in?
[12932.016672] usb 2-1: USB disconnect, device number 5
[12932.016683] usb 2-1.1: USB disconnect, device number 6
[12962.085766] usb 2-1: new full-speed USB device number 7 using xhci_hcd
[12962.275849] usb 2-1: New USB device found, idVendor=0a12, idProduct=4010
[12962.275861] usb 2-1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[12962.276538] usb 2-1: ep 0x81 - rounding interval to 1024 microframes, ep
desc says 2040 microframes
[12962.279699] hub 2-1:1.0: USB hub found
[12962.280663] hub 2-1:1.0: 4 ports detected
[12962.875024] usb 2-1.1: new full-speed USB device number 8 using xhci_hcd
[12962.980977] usb 2-1.1: New USB device found, idVendor=0a12,
idProduct=4007
[12962.980991] usb 2-1.1: New USB device strings: Mfr=1, Product=2,
SerialNumber=5
[12962.981000] usb 2-1.1: Product: BT_002
[12962.981008] usb 2-1.1: Manufacturer: Qualcomm
[12962.981015] usb 2-1.1: SerialNumber: ABC4C25B
[12962.992667] input: Qualcomm BT_002 as
/devices/pci0000:00/0000:00:14.0/usb2/2-1/2-1.1/2-1.1:1.0/0003:0A12:4007.0003/input/input6
[12963.048083] hid-generic 0003:0A12:4007.0003: input,hiddev0,hidraw0: USB
HID v1.11 Device [Qualcomm BT_002] on usb-0000:00:14.0-1.1/input0
[12963.066910] hid-generic 0003:0A12:4007.0004: hiddev0,hidraw1: USB HID
v1.11 Device [Qualcomm BT_002] on usb-0000:00:14.0-1.1/input1

Same error (arecord: pcm_read:2032: read error: Input/output error)
observed on 4.4, 4.15 and 5.4 kernel version.
>
> thanks,
>
> greg k-h
