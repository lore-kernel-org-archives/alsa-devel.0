Return-Path: <SRS0=ShlF=ZN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E105C432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:50:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A652067D
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pg4dv2VH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="aC38smAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A652067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 553041711;
	Thu, 21 Nov 2019 17:49:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 553041711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574355030;
	bh=em1pABitX/al5wC/0y2jlrlatb+amKihv7EioTSVHa0=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pg4dv2VHHdQxYBgO/26X9wVkvNz3d8wIQ4OfDtA5kAOy3qPXMumUNIZV60nmrkpAs
	 PNDzvu/T2a7ERpZngYHiTmHwCIhKxfWzJn+MZcMoYYNSajO6AhepktkkQuH6ZS9V4M
	 po5x0HoPCHvM4btBMttA63bT0CWMNOWwY7qgsXUI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C56FEF80145;
	Thu, 21 Nov 2019 17:49:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED6FAF80146; Thu, 21 Nov 2019 17:49:37 +0100 (CET)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E64FF800F0
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 17:49:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E64FF800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="aC38smAD"
Received: by mail-io1-xd44.google.com with SMTP id k13so4185728ioa.9
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 08:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VuiqNlqxCPlorbsrGi1yhXT0MtAsa4ftAIokDYkACTc=;
 b=aC38smADwZ5v7rOLINrOiprT6+U0xCW2LcroVIVmqYbdr2OXt48dGUmQDC/7Q7OPHR
 dbSs7avP8NkcMf0JjjvhJI/0GRD/8umT15zas6XSWyDQKdyaXvpfy48XUC6NwkDvqN/2
 oS5a830yNzsoZjDxUg0U8J4EZmAIsyWI3s+RRi11cakotLpvxNDbLNKS920kiF68h9eK
 XIGHOv9C0ZrBox4oSKU36C+qoL2NanRfc/JVnEmd96dr433iNTRHyIYffV6XjBzHnqpr
 k9bJ3zXV+TrRToeiW4bM6csTMT3VuGCJicsJkkJQ7TZz4/uYGW7OssX4t9+xSq+lErmJ
 KiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VuiqNlqxCPlorbsrGi1yhXT0MtAsa4ftAIokDYkACTc=;
 b=LBoalKfKcnlTrRbG8kILopW5YkF2Pk5RSOwkVLXsvFXf7S3kCG8L51nXhZM+FqoOxG
 alGeQTKj7rxSY/OAXWu70Hh2rhyZGzyt36ex4kcaSmGXKk9IPNcDvV9PiKhQGNH+1jdr
 vZzStr8A1f8pIas8g+sj2WG4FA031DSfR0hcQXuP7TjJnpmLXJNDlPcy2hErhjZT1DWu
 WAKHcYVfjWk+KdnBDWiDUjpUY2ERHnI/AohK1KbSf3swE0ufvg6syER+ugR3JiL5gP5A
 ADkSyE8e/oQU1FDD3vttjXxw2+Skdh61Sqr8pNTfUaxk+BtzR0/sbIxZoaYsWe+bq7ZP
 bMhQ==
X-Gm-Message-State: APjAAAX4YMRhgxRMc+qVFiN/RNtsEl2ITd5EVRcxkeOwayqCrviZDsDe
 8o6lyx7p1pCguQvDj2Su6NqiX2E93huYYL6o6br6wQ==
X-Google-Smtp-Source: APXvYqxoPr4dK8VzUJfmUnE3D22UXbW3cX5TzMBzu0D55OUyexM10SryDwHyxX+BNpc2jEuPMAXiD5uaQDJkvNeh9QY=
X-Received: by 2002:a6b:38c5:: with SMTP id f188mr8691941ioa.235.1574354972648; 
 Thu, 21 Nov 2019 08:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20191120060256.212818-1-tzungbi@google.com>
 <20191120060256.212818-4-tzungbi@google.com>
 <8273f728-3d4b-b0dc-03b7-6276c5ae4460@linux.intel.com>
 <CA+Px+wWSajOFXwLAS+jrO9XUBeKaxjZaEOqng0YO9VmL3VXaSQ@mail.gmail.com>
 <7f055263-01a6-e1cd-8085-1790222bb808@linux.intel.com>
 <CA+Px+wX2UtU3As-3Bf4rWn1kzqDMPw60xk508gDDaOPk6Q5dgw@mail.gmail.com>
 <d97b9724-27d0-f157-ce5d-ed6c75bafae8@linux.intel.com>
In-Reply-To: <d97b9724-27d0-f157-ce5d-ed6c75bafae8@linux.intel.com>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 22 Nov 2019 00:49:20 +0800
Message-ID: <CA+Px+wUSpYibKbOdj-XCXCnH9QN8=OtbeYMkhbj4ZREMj7V6Sg@mail.gmail.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, Dylan Reid <dgreid@google.com>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>
Subject: Re: [alsa-devel] [PATCH 3/3] ASoC: max98090: fix possible race
	conditions
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, Nov 21, 2019 at 11:41 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 11/21/19 12:17 AM, Tzung-Bi Shih wrote:
> > On Thu, Nov 21, 2019 at 11:20 AM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >> Still you may want to clarify your second point and the commit message.
> >> The first race condition was clear, the second one not so much.
> >>
> >> what did you mean with 'assert ULK == 0' and what does this map to in
> >> pll_work
> >
> > The case (2) race condition is based on the previous patch:
> > https://mailman.alsa-project.org/pipermail/alsa-devel/2019-November/158852.html
>
> ah, ok, so that's a race you introduced :-)
>
> >
> > After applying the patch, the code would be something like: (in the
> > case, two threads read 0x01.)
> > static void max98090_pll_work(struct work_struct *work)
> > {
> > [snip]
> >          snd_soc_component_update_bits(component, M98090_REG_DEVICE_SHUTDOWN,
> >                              M98090_SHDNN_MASK, 0);
> >          snd_soc_component_update_bits(component, M98090_REG_DEVICE_SHUTDOWN,
> >                              M98090_SHDNN_MASK, M98090_SHDNN_MASK);
> >
> >          for (i = 0; i < 10; ++i) {
> >                  /* Check lock status */
> >                  pll = snd_soc_component_read32(
> >                                  component, M98090_REG_DEVICE_STATUS);
> >                  if (!(pll & M98090_ULK_MASK))
> >                          break;
> >
> >                  /* Give PLL time to lock */
> >                  usleep_range(1000, 1200);
> >          }
> > }
>
> Sorry, I don't see at what point the race happens.
>
> if your interrupt sees an ULK status, it will schedule the pll_work.
> You only test the status again *after* switching the device on/off, so
> what is the side effect?

Both interrupt thread and pll_work thread access the status register.
The side effect is: interrupt thread could read the status register
right before pll_work thread's read.

> I am also wondering if you shouldn't sleep first in the loop, then check
> the status?

ACK, "sleep first and check the status" makes more sense.

> And in case you do have a side effect due to the clear on read, maybe
> you could save the status in a context and retest in the workqueue, that
> way you'd have a trace of the ULK event even if the register was cleared.

I think cache the status couldn't be a good idea.  We couldn't make
sure the freshness of the cache.


Can we suppose CPUs always get ULK=1 if PLL is unlocked so that we can
simply ignore the case (2)?  Since we know the register is volatile
and read the register via I2C should be much slower than hardware
raise the bit.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
