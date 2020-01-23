Return-Path: <SRS0=22TH=3O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C78DC2D0DB
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Jan 2020 10:06:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D962071E
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Jan 2020 10:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N/6pBnZD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=calica-com.20150623.gappssmtp.com header.i=@calica-com.20150623.gappssmtp.com header.b="VRGb1/Vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D962071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=calica.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6E1A1667;
	Sat, 25 Jan 2020 11:05:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6E1A1667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579946797;
	bh=G2azsVPa4U+K6+opsFSBe0bPrVde6kE+OSYdRqzA0h8=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N/6pBnZDDuL4IERk96VIGwOuZSls++/U81gL3INfwLqM0tky/PyZQHYavE1Z/bw16
	 dnktCwq+GGFzPgKb+B1a3dsn7s/Ue2kLBUOqEGSMl2r8RmcVEWeaJLyW4g2fnDcSQ+
	 7Aev/fBBCtFwxhDUGKwRiaU0YAy9b8tOoFpDsl5c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4ABF8F801D9;
	Sat, 25 Jan 2020 11:05:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79793F801D9; Fri, 24 Jan 2020 00:08:09 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9E78F80112
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2020 00:08:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9E78F80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=calica-com.20150623.gappssmtp.com
 header.i=@calica-com.20150623.gappssmtp.com header.b="VRGb1/Vf"
Received: by mail-il1-x135.google.com with SMTP id x5so226373ila.6
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2020 15:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=calica-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OKdhyt07YYmM1Hs1xGDw412X89yICoC4btSeJz/RwQY=;
 b=VRGb1/VfLBy33zakKhxG4qlv+08WeqrBJrHK3F+yzyWz0iHNLBhZtF+4JuDV7Bctkx
 X9wrAuG/4LUPO4p8xL0mxhNWPK2KtxuV0SGRs8bVl2R78UPTfm8bLgtGhW95AGQZ/kcD
 A8y+eyGaVGix29t4dsVvdUf0Hn9teRi2aY1UdGIwZP9y+IRc7SpNBsVC9LXvddW3n/0E
 ibq0nbKDIXBd2fl0xN/ojKjLaqU80b656rxUAjmi+On2m23JAz/avkx7fjU0cngIyWCP
 5hYVpYk1CU/hQTMa+s8AZD4Cx3s8aaRClNzqeX1EbrSJSXX8yuxTRBO9jAlnfaeIe3/P
 /pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OKdhyt07YYmM1Hs1xGDw412X89yICoC4btSeJz/RwQY=;
 b=MiyXRtHwSPsGza2e51799i32kKsL/mwVxa6DgrpgfXWWFR3X7zMP9S0tT7Hr+VKDDO
 bWhUhRnp7U4JuUiwX+ha+JXMkNNIJhLmz+OUHdEPHL2WGz1RfZXUL3K67NsuKLRXY/9K
 2iLq4vgQbWh9rn/6nmAUkr1Asn1FITXaLIcvY6Fbzz7RkutElC+tAk04sQIDeY27mqTx
 Z5Y37WWq9KjrV5LaDt2ZZ11GrCO1+71VnNdvvncjlo+/9YmXCEwqymbPb48kPrkfXK7W
 Rdag91/eYNQmq3gZdqhmYW4rVlRoHZsv9sy8e2smxV+wOxuLg7l0SZ5UilsoHlkSLpqs
 bp+g==
X-Gm-Message-State: APjAAAWwJSA/stEfpLcNNBTgI7XdmxKDs6mlI4G2GmIrwQIz59f6Y8fD
 B3GDWbOB4QYFiHmHPZRpql62sMuLhMsul4FG77/WaQ==
X-Google-Smtp-Source: APXvYqwN+EHa1jBifP+4Orz1kGb1rt83h7QbRM1ooqOK3M1RNNOy2Jm0egYgLbdyZdQ1vQgIl+2MemgVzBAFzrdvJmA=
X-Received: by 2002:a92:2907:: with SMTP id l7mr615184ilg.140.1579820882783;
 Thu, 23 Jan 2020 15:08:02 -0800 (PST)
MIME-Version: 1.0
References: <CAGnrtESNwneRXqKOnp-_gfkPDu11g+-M4s5dOs+pOMD30Wp8uw@mail.gmail.com>
 <CABPh3UOig4HS5=sKB0bk+wtWJoshTbMGA6L18w14i1QNF6TsxA@mail.gmail.com>
In-Reply-To: <CABPh3UOig4HS5=sKB0bk+wtWJoshTbMGA6L18w14i1QNF6TsxA@mail.gmail.com>
From: Carlo Calica <carlo@calica.com>
Date: Thu, 23 Jan 2020 15:07:55 -0800
Message-ID: <CAGnrtESQ2h0dGTRtaE1JREgADnx3uEkuHdsAtjPkk9wVcCGR_Q@mail.gmail.com>
To: nick83ola <nick83ola@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008743bc059cd6b656"
X-Mailman-Approved-At: Sat, 25 Jan 2020 11:05:46 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Line 6 Helix quirks
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

--0000000000008743bc059cd6b656
Content-Type: text/plain; charset="UTF-8"

Sorry, I didn't have time to compile a kernel until yesterday.  I built the
attached patch against 5.4.12 and it is working great with JACK.  I have a
Helix Floor running the 2.82 firmware.





On Sun, Oct 20, 2019 at 6:51 AM nick83ola <nick83ola@gmail.com> wrote:

> Hi
> I verified on my hx_stomp with the latest driver and I can confirm tha
> the quirks works here
> Sadly I don't have an helix to verify it
>
> What model it is?
> you can try to recompile the kernel adding the line with you usb device to
> the
>
> see my patch
>
> https://lkml.org/lkml/2019/7/1/850
>
> + case USB_ID(0x0E41, 0x4244): /* HELIX */
> + case USB_ID(0x0E41, 0x4246): /* HX STOMP */
> + case USB_ID(0x0E41, 0x4248): /* what kind of HELIX ???????? */
>
> Cheers
> Nicola Lunghi
>
>
> On Sat, 19 Oct 2019 at 06:34, Carlo Calica <carlo@calica.com> wrote:
> >
> > Hi,
> >
> > I'm attempting to use my Helix with the newish 5.3.x kernel.  It isn't
> working.  Looks like the quirk isn't enabled for the idProduct (4248) of my
> Helix.  My Helix's firmware is 2.81.0.  I have yet to compile the kernel to
> see if adding the id is enough.  Thanks.  If you need any more info, please
> let me know.
> >
> > dmesg gives:
> >
> > [89014.296954] usb 3-2: new high-speed USB device number 2 using xhci_hcd
> > [89014.521720] usb 3-2: New USB device found, idVendor=0e41,
> idProduct=4248, bcdDevice= 2.00
> > [89014.521723] usb 3-2: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> > [89014.521724] usb 3-2: Product: HELIX
> > [89014.521726] usb 3-2: Manufacturer: LINE 6
> > [89014.521727] usb 3-2: SerialNumber:    2796112
> > [89014.555715] usb 3-2: parse_audio_format_rates_v2v3(): unable to
> retrieve number of sample rates (clock 16)
> > [89014.559724] usb 3-2: parse_audio_format_rates_v2v3(): unable to
> retrieve number of sample rates (clock 16)
> > [89014.575990] input: LINE 6 HELIX    as
> /devices/pci0000:00/0000:00:01.3/0000:03:00.2/0000:16:08.0/0000:1c:00.0/usb3/3-2/3-2:1.5/0003:0E41:4248.000C/input/input50
> > [89014.628069] hid-generic 0003:0E41:4248.000C: input,hidraw8: USB HID
> v1.11 Keyboard [LINE 6 HELIX   ] on usb-0000:1c:00.0-2/input5
> >
> >
> > --
> > Carlo J. Calica
>


-- 
Carlo J. Calica

--0000000000008743bc059cd6b656
Content-Type: application/octet-stream; name="helix_floor_28.patch"
Content-Disposition: attachment; filename="helix_floor_28.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k5rcgj120>
X-Attachment-Id: f_k5rcgj120

ZGlmZiAtciAtLXVuaWZpZWQgbGludXgtNS40LjEyL3NvdW5kL3VzYi9mb3JtYXQuYyBsaW51eC01
LjQuMTItaGVsaXhwYXRjaC9zb3VuZC91c2IvZm9ybWF0LmMKLS0tIGxpbnV4LTUuNC4xMi9zb3Vu
ZC91c2IvZm9ybWF0LmMJMjAxOS0xMS0yNCAxNjozMjowMS4wMDAwMDAwMDAgLTA4MDAKKysrIGxp
bnV4LTUuNC4xMi1oZWxpeHBhdGNoL3NvdW5kL3VzYi9mb3JtYXQuYwkyMDIwLTAxLTIyIDIyOjUw
OjA5LjY0Mjg0MTk2MCAtMDgwMApAQCAtMjk2LDYgKzI5Niw3IEBACiAJY2FzZSBVU0JfSUQoMHgw
RTQxLCAweDQyNDIpOiAvKiBMaW5lNiBIZWxpeCBSYWNrICovCiAJY2FzZSBVU0JfSUQoMHgwRTQx
LCAweDQyNDQpOiAvKiBMaW5lNiBIZWxpeCBMVCAqLwogCWNhc2UgVVNCX0lEKDB4MEU0MSwgMHg0
MjQ2KTogLyogTGluZTYgSFgtU3RvbXAgKi8KKwljYXNlIFVTQl9JRCgweDBFNDEsIDB4NDI0OCk6
IC8qIExpbmU2IEhlbGl4IC0gZmlybXdhcmUgPj0gMi44ICovCiAJCS8qIHN1cHBvcnRlZCByYXRl
czogNDhLaHogKi8KIAkJa2ZyZWUoZnAtPnJhdGVfdGFibGUpOwogCQlmcC0+cmF0ZV90YWJsZSA9
IGttYWxsb2Moc2l6ZW9mKGludCksIEdGUF9LRVJORUwpOwo=
--0000000000008743bc059cd6b656
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0000000000008743bc059cd6b656--
