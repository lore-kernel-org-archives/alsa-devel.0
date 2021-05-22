Return-Path: <SRS0=REud=KR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F823C2B9F2
	for <alsa-devel@archiver.kernel.org>; Sat, 22 May 2021 18:22:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EDB61177
	for <alsa-devel@archiver.kernel.org>; Sat, 22 May 2021 18:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EDB61177
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D33561679;
	Sat, 22 May 2021 20:21:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D33561679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621707768;
	bh=78O92cOG8UkAgtNG1OJN7PFEgLmGLugUlL1Idsi8boI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BERD58IkZmjQlEbbEZmoyQ49gorD6SK1VCDPq75gOEMOQwr7WBoVMFyCN1XGCIPr0
	 VLXoWKxsB1MUNdtsbRVPWFA+W3p2CtvmYc9t6MZi3pGyP8V1NMZV8mEgImC6uQ58RB
	 /Fz9aTbCWObFLJzEFWGiLow6riZLoR6FH9Ao9lJ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E96DF800E5;
	Sat, 22 May 2021 20:21:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF90EF80217; Sat, 22 May 2021 20:21:56 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 231B5F800E5
 for <alsa-devel@alsa-project.org>; Sat, 22 May 2021 20:21:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 231B5F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="dPBSZfFf"
Received: by mail-pf1-x42f.google.com with SMTP id 22so17023787pfv.11
 for <alsa-devel@alsa-project.org>; Sat, 22 May 2021 11:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PXWQ1t29E0XjRw9NAMyNH5iQX/P2MVw0kTd+DcmsirM=;
 b=dPBSZfFfoyzIji1byaqF0iozfCg6aXGPro8s9ClOMQMyLQFB8nZsykbY6wpqzp6KnW
 25rR3InG3vjpjIxuj3mm8Aa5Q7/hn7F8ZztgRQaopLAFNS/hMKMN0X6EPdjHRaWYyDTT
 Y9uuwpvLoh8MvHd60c4o5Y4OncLfXznw9/tWQhSjxbNSKCIz/ybCH3zrWP559jqzBRfb
 Z9LGp98zDe5xdgVQB2xQah6BOIBFUcmoWRmiKyUqg3OxbnPTIwlo8114D1kKmwJ2wyrb
 vTgC1W1h0OB6kQWdohoKt9SYuwf2QxWMbhZvzwWKJ2xl9K9TVYv4o/Y8BXXWiL+Lhvwn
 8ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PXWQ1t29E0XjRw9NAMyNH5iQX/P2MVw0kTd+DcmsirM=;
 b=fZEt0WPdIKGeOYu84IP+3lyMD9kYm5Rj9UGpwfooe52m0EarIS2PsxC4KNlvzpBvN+
 2av+HjDni+P65qpFSNChsLFzCfaL9HmWO6fj2+rMinX1rPbQWCqU6uCWVLYii1AxSwwl
 qQTAVe2f0A25l2pdQr844t7hPwCaOivWJHSsGNe7yGZMRoEM4OuRtyx855lD6xV/NsNc
 F2u11urPhhhE1s3UMBvzRWy0G0+txUQo/iXOMD65Y/Y23WGXSejajUgGWKML3n0WQwcF
 ijUqKfH3RJKYTCPaBjA6Z5dK7HxNwbYb7Y/im5+35h6NvkR1w5VEC/V/owtPaeU+J+eP
 HPDg==
X-Gm-Message-State: AOAM531UlpeCciSQvSi8PvH9k3YgSl+xirQeoNLphVc9qMDNz+Nh+b0M
 7hv+POS2REkL2wdRiY+qQojz/AmJCqCvRTKjUGU=
X-Google-Smtp-Source: ABdhPJz/Hh0xprFoUQCAqWbFVzG5h5EFiU/D7hqUW8HfFPexcmPlnXFkBDHwoF/yaXN+sRCDCCbUonK0IQ8cM1idOV0=
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id
 p30-20020a056a000a1eb02902e289d85c87mr14623858pfh.73.1621707708151; Sat, 22
 May 2021 11:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210521171418.393871-1-hdegoede@redhat.com>
 <20210521171418.393871-8-hdegoede@redhat.com>
In-Reply-To: <20210521171418.393871-8-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 22 May 2021 21:21:31 +0300
Message-ID: <CAHp75VdAC9nP5EyCCMZ41vmSsZoV8gPOMxOkY=U4gVm5dQAXCg@mail.gmail.com>
Subject: Re: [PATCH 7/8] iio: accel: bmc150: Add support for DUAL250E ACPI DSM
 for setting the hinge angle
To: Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 linux-iio <linux-iio@vger.kernel.org>, patches@opensource.cirrus.com,
 Liam Girdwood <lgirdwood@gmail.com>, Jeremy Cline <jeremy@jcline.org>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>
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

On Fri, May 21, 2021 at 11:22 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some 360 degree hinges (yoga) style 2-in-1 devices use 2 bmc150 accels
> to allow the OS to determine the angle between the display and the base
> of the device, so that the OS can determine if the 2-in-1 is in laptop
> or in tablet-mode.
>
> On Windows both accelerometers are read (polled) by a special service
> and this service calls the DSM (Device Specific Method), which in turn
> translates the angles to one of laptop/tablet/tent/stand mode and then
> notifies the EC about the new mode and the EC then enables or disables
> the builtin keyboard and touchpad based in the mode.
>
> When the 2-in-1 is powered-on or resumed folded in tablet mode the
> EC senses this independent of the DSM by using a HALL effect sensor
> which senses that the keyboard has been folded away behind the display.
>
> At power-on or resume the EC disables the keyboard based on this and
> the only way to get the keyboard to work after this is to call the
> DSM to re-enable it.
>
> Call the DSM on probe() and resume() to fix the keyboard not working
> when powered-on / resumed in tablet-mode.
>
> This patch was developed and tested on a Lenovo Yoga 300-IBR.

...

> +       if (strcmp(acpi_device_hid(adev), "DUAL250E"))

Can we use like in the other case in this series the acpi_dev_hid_uid_match=
() ?

Because it's actually what you are doing here and it may be better to
see the same approach for this HID done in different places in the
code to recognize what it is about.

> +               return false;

...

> +       /*
> +        * The EC must see a change for it to re-enable the kbd, so first=
 set the
> +        * angle to 270=C2=B0 (tent/stand mode) and then change it to 90=
=C2=B0 (laptop mode).
> +        */
> +       if (!bmc150_acpi_set_angle_dsm(client, 0, 270))
> +               return false;

> +       /* The EC needs some time to notice the angle being changed */
> +       msleep(100);

I feel that you conducted a research and answer to the following will
be no, but...

Do we have any means of polling something (embedded controller / ASL /
etc) to actually see the ACK for the action?

> +       return bmc150_acpi_set_angle_dsm(client, 0, 90);

...

> +       schedule_delayed_work(&data->resume_work, msecs_to_jiffies(1000))=
;

Isn't it the same as 1 * HZ ?

--=20
With Best Regards,
Andy Shevchenko
