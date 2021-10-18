Return-Path: <SRS0=JS7s=PG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C190C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 15:05:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49474610A1
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 15:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 49474610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8EB0317B2;
	Mon, 18 Oct 2021 17:04:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8EB0317B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634569529;
	bh=AyHaPS06HnF20JoxJwLr9L1ALKIj3h47c6CPgVQkpCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p3DbsPWQ+PPvGbt0NQwEJBbnnzye25HmxsKdPCDZDOzVAJJjhum8k2yUmhassdXdT
	 c61VmkloTyABDaAUJp90+HzWLWW4c4wCFYMf2Pm87rXoihwrrlpn+ebnGkZ4Tx6l5o
	 V6c/b4IimwMbku9ItAmhS9g6VNGwjMzseQUhH/PM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33398F80217;
	Mon, 18 Oct 2021 17:04:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 666A5F80224; Mon, 18 Oct 2021 17:04:38 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3C67F80159
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 17:04:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3C67F80159
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="nkBu+K1I"
Received: by mail-ed1-x530.google.com with SMTP id ec8so332695edb.6
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 08:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0EoNkAsRbOrEvWzKDHBUYgcF1HioS2sQFMJGO4X0WEY=;
 b=nkBu+K1IBFyS2v0cOqSVIiKofX7iomeXuHBoIAWeaN0cw1gsCLPxA7ElV175msvijv
 JlYwDlEFmqBGZ0aJhqQ6Mw2NEiTU31Sq3SwU+L39wmCznJ+3oITUaNA7tsThdIN6XDGz
 wlJZcHttlDEeAHkX8W1mQg2H5dZv/9kHz4eO0P/Z9Jf2DEwT9E7E4L4/+2sLplE4QuyX
 o+qVeQpc/0BTuJj/YoYqv8yEV3+U/NeTMg3LEWosREQVnJdUebc1VSZML4665bpD9PcI
 Ny53/vLXj72mVWyBN8y48RmyyhMUWhXTKTAZhr3/SlfhVOWKJsxxCkiBkl0X/hBol4jQ
 0I8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0EoNkAsRbOrEvWzKDHBUYgcF1HioS2sQFMJGO4X0WEY=;
 b=7gedrbh3UjCcuG4+4LmRsammuKKHF/HM5blKE62u8Y/Hqi5psg6MU7ri0U214Ruv+G
 iTZ+HEEubscWyHmWWHVW8lw+bwOi9SinCjbsCd0hHG7uTQrNstGSxwiXH6Q2ts6H3w08
 jc3uEBUmm6vUFyXKUWPaQ/LCR8DQrp6xfGygeI1pvC8PjV6lHpeeWZsc3T8Y2w0Xu55c
 W2uUZbRTFkB7bNyW/uwsRFKohBgYd9q55jWlPSg4edToBQLG+Qyi7rZbH50aEF50Qwij
 7/wlEwAcNDEf0aNBHn1A8VBc/npV2AHVO/2PBmfe/1uWiwO56zyuJBmVGtS/VYOkwLtN
 t4bA==
X-Gm-Message-State: AOAM533QjR91CM8gAqRY7j4TF0Z2xAvD1rQ+KAombYTEHa9G2XivZlMv
 W/z/Y7h8gqmGuaN6OAZ5vFuDkKQTW/YZZxjQyo8=
X-Google-Smtp-Source: ABdhPJzbZXNPcv61uQq2QUa5n4xq8FkHa4q8cyf+rDGmsW/py/6AxuvMev6HiHzFdiKuP6r+n/pL30fIkZVepbN/s6w=
X-Received: by 2002:a17:906:eb86:: with SMTP id
 mh6mr30733082ejb.141.1634569463133; 
 Mon, 18 Oct 2021 08:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211018143324.296961-1-hdegoede@redhat.com>
 <20211018143324.296961-3-hdegoede@redhat.com>
In-Reply-To: <20211018143324.296961-3-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 18 Oct 2021 18:03:31 +0300
Message-ID: <CAHp75VeG=RLXY16pMzNQbB9GR7GUsRTZu9Rx9yB0u3hzmhGELA@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform/x86: intel_int0002_vgpio: Use the new
 soc_intel_is_byt/cht helpers
To: Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Gross <markgross@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-input <linux-input@vger.kernel.org>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Andy Shevchenko <andy@infradead.org>
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

On Mon, Oct 18, 2021 at 5:33 PM Hans de Goede <hdegoede@redhat.com> wrote:

Couple of nit-picks below (may be ignored).

> Use the new soc_intel_is_byt/cht helpers to clean things up a bit.

soc_intel_is_byt()/soc_intel_is_cht() (or anything alike to show that
these are functions / macros).

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/intel/int0002_vgpio.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/int0002_vgpio.c b/drivers/platform/x86/intel/int0002_vgpio.c
> index 569342aa8926..617dbf98980e 100644
> --- a/drivers/platform/x86/intel/int0002_vgpio.c
> +++ b/drivers/platform/x86/intel/int0002_vgpio.c
> @@ -34,13 +34,11 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/platform_data/x86/soc.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>
> -#include <asm/cpu_device_id.h>
> -#include <asm/intel-family.h>
> -
>  #define DRV_NAME                       "INT0002 Virtual GPIO"
>
>  /* For some reason the virtual GPIO pin tied to the GPE is numbered pin 2 */
> @@ -151,12 +149,6 @@ static struct irq_chip int0002_irqchip = {
>         .irq_set_wake           = int0002_irq_set_wake,
>  };
>
> -static const struct x86_cpu_id int0002_cpu_ids[] = {
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT, NULL),
> -       X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT, NULL),
> -       {}
> -};
> -
>  static void int0002_init_irq_valid_mask(struct gpio_chip *chip,
>                                         unsigned long *valid_mask,
>                                         unsigned int ngpios)
> @@ -167,15 +159,13 @@ static void int0002_init_irq_valid_mask(struct gpio_chip *chip,
>  static int int0002_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> -       const struct x86_cpu_id *cpu_id;
>         struct int0002_data *int0002;
>         struct gpio_irq_chip *girq;
>         struct gpio_chip *chip;
>         int irq, ret;
>
>         /* Menlow has a different INT0002 device? <sigh> */
> -       cpu_id = x86_match_cpu(int0002_cpu_ids);
> -       if (!cpu_id)

> +       if (!soc_intel_is_byt() && !soc_intel_is_cht())

  if (!(soc_intel_is_byt() || soc_intel_is_cht()))

?

>                 return -ENODEV;
>
>         irq = platform_get_irq(pdev, 0);
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
