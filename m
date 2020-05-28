Return-Path: <SRS0=Hwg1=7K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65121C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2020 10:03:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F9E208B8
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2020 10:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NDbElLYP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJpSZTSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F9E208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 423F3176B;
	Thu, 28 May 2020 12:03:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 423F3176B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590660231;
	bh=fXSocfTm3yw99S3IGKnf7I3Cdhbz/cy68M5rE7V9gKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NDbElLYPlMinVcp93NxQ6vbLt4As1MMtN7u61WkY6snYc4nzfMtskvg8BGWo5Ai0U
	 RxwgK7gpkQUfik0RZUBSsM8Iu93dBwF6csXxrNLBFYjxzBCupv73KMzRZJl5bJWMMh
	 gLBDQhqW9v2IydDuTmzQvHbXLdNXSmChJsGCYg3E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74A54F8014A;
	Thu, 28 May 2020 12:03:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4FF3F80150; Thu, 28 May 2020 12:02:58 +0200 (CEST)
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2900F800FF
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2020 12:02:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2900F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="WJpSZTSo"
Received: by mail-lj1-x242.google.com with SMTP id z13so22949340ljn.7
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2020 03:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I/h3gNMyb53kQmKAThGHtCMjDN3Ct7BvAp2TJgMXdZA=;
 b=WJpSZTSoXxOoQNFiNdn06UQLrPFVP7QspnEg1drKRgsC5f8Nx1hiN8zz9Z2vyNHKdn
 ITNwk3XNuaSbSVUe0EXZEmi7i50HofTw9v+2R5yRgBMmXkDGFGCMvvHubV4yBLyR16GL
 FP4oUpJVYVMfaKfVW8+s4LSpLZlmjsY8fgCxYYsOVDlHHl9nLEQxbl4830z8gHZMMJv/
 AWxk6I60V+gGP8EmM9PChMkBxBbWXuPoaOksra8i9XEzslhMxoX0mhOsZ0a/xgKQEGXx
 P0yYH6cE97WBgGOyrLTF+pXyBYBnlbUWi/+LV910wzbJzzhssmqPUjOrMmj2oIlNc0z9
 nTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I/h3gNMyb53kQmKAThGHtCMjDN3Ct7BvAp2TJgMXdZA=;
 b=LbIxQldaq1IXdfhCGcJXslXIzWVL61bVl3pFPJgN6BxswNJ2YQEq6MXj5fxVbPIztQ
 /+FiowVedQNZ1B57IlAFPRiLYfWlFPbi9i+Nuk6U2alzMyhPKezIO5Hkatphfft3T5US
 07ZxSShaXjWkODY1tHAZAcXc/PaVDDvOWWhHQr+mKHNTXHn4kMBg0yFLQPZ7BW2rOjzK
 i/p5KC/SEH4J1RtjrnP0gIOi4mlfW8emTACxh+EZ0jx6ox2LF0l+Zk7v600dG2RaBboI
 7v/9mwrQKwxe+sRKfex8XYTH66cxuIgOSSQYbtwChUfl1SyUcPjmU8hPgv0f0lCfzJbs
 j3fw==
X-Gm-Message-State: AOAM531gaCXn1Fpe054d9yew9DjrgHHYq35lR2Urss2BXtna7QA1srPO
 DLCzZeL/g00CV7B/V5VlWGq21AHGYKU55cDaa6g=
X-Google-Smtp-Source: ABdhPJyZid/lyuqY1E3XF3MpNA5pp/s7NOjWjcLahYBAhDGX3VlzICBAygFi9yx1WwgtsGZ7kz96rCT/FdXyTiDgFzo=
X-Received: by 2002:a2e:711c:: with SMTP id m28mr1088182ljc.104.1590660171385; 
 Thu, 28 May 2020 03:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200518004930.20973-1-steves.lee@maximintegrated.com>
 <20200526223642.GA506893@bogus>
In-Reply-To: <20200526223642.GA506893@bogus>
From: Steve Lee <steves.lee.maxim@gmail.com>
Date: Thu, 28 May 2020 19:02:38 +0900
Message-ID: <CABff4NR7MJM8VmM_gXnspEh2h+MEwv9WDW_Ra6t_Tv2SjrHSFQ@mail.gmail.com>
Subject: Re: [RESEND][V5 PATCH 1/2] dt-bindings: Added device tree binding for
 max98390
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>,
 ryan.lee.maxim@gmail.com, Steve Lee <steves.lee@maximintegrated.com>,
 ryans.lee@maximintegrated.com, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>
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

On Wed, May 27, 2020 at 7:36 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, May 18, 2020 at 09:49:30AM +0900, Steve Lee wrote:
> > Add documentation for DT binding of max98390 amplifier driver.
> >
> > Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
> > ---
> >
> >
> > Changed since V4:
> >       * No changes.
> > Changed since V3:
> >       * No changes.
> > Changed since V2:
> >       * No changes.
> > Changed since V1:
> >       * Modified sample text in example
>
> You are obviously sending patches too quickly. Give folks a chance to
> review.

 Thanks for your feedback !.

>
> >
> >  .../devicetree/bindings/sound/max98390.txt    | 26 +++++++++++++++++++
>
> Bindings are now in DT schema format. Please convert this. See
> Documentation/devicetree/writing-schema.rst

 Thanks for review. I will change txt to yaml version.

>
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/max98390.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/max98390.txt b/Documentation/devicetree/bindings/sound/max98390.txt
> > new file mode 100644
> > index 000000000000..0ddd4c6ae55e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/max98390.txt
> > @@ -0,0 +1,26 @@
> > +Maxim Integrated MAX98390 Speaker Amplifier
> > +
> > +This device supports I2C.
> > +
> > +Required properties:
> > +
> > + - compatible : "maxim,max98390"
> > +
> > + - reg : the I2C address of the device.
> > +
> > +Optional properties:
> > +
> > +- maxim,temperature_calib
> > +  u32. The calculated temperature data was measured while doing the calibration. Data : Temp / 100 * 2^12
> > +
> > +- maxim,r0_calib
> > +  u32. This is r0 calibration data which was measured in factory mode.
>
> Unless these are shared already with other Maxim chips, s/_/-/.
>
> > +
> > +Example:
> > +
> > +codec: max98390@38 {
>
> amplifier@38

 I will change example as you advise.

>
> > +     compatible = "maxim,max98390";
> > +     reg = <0x38>;
> > +     maxim,temperature_calib = <1024>;
> > +     maxim,r0_calib = <100232>;
> > +};
> > --
> > 2.17.1
> >
