Return-Path: <SRS0=Jk6f=YA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208BAC47404
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:04:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8382133F
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="g3FZD7yl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="H+qGvGlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8382133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC676857;
	Mon,  7 Oct 2019 10:03:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC676857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570435475;
	bh=JfFx+J757dP7jUyo7oz+/mD1OZnmppfiRqFhLLTj7w0=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g3FZD7yl3E4jdy8Y8202lS9aB6DEXDHSjO4XMxQ8QxBiL47pdic1LRTyZnsns9VU1
	 rj+kEF72qkXb5MO+coPP2WKJflnvgAECveWONmpnPltwVIXQEKSVKj72mpHaVN1h5g
	 dax3MVpWeskXuqRCvXc8aIW2mr+mkwvW7+q02M+Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69AC1F802BD;
	Mon,  7 Oct 2019 10:03:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21987F802BE; Mon,  7 Oct 2019 10:03:43 +0200 (CEST)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26820F80273
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2019 10:03:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26820F80273
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="H+qGvGlE"
Received: by mail-oi1-x243.google.com with SMTP id w144so10866894oia.6
 for <alsa-devel@alsa-project.org>; Mon, 07 Oct 2019 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u8VJVRDT3OUyLjgNXAgYtCNyTR8O6tuL+6GMwd0XRpk=;
 b=H+qGvGlEcaQ+IHSaoAsaQZbUszEa1otR3hOTR7ftfNmWzFYDGduMcgUMPUKsWZNSJ5
 3Fnw5ij962RVc8pyahylWZ9SAvgpp7/pQuGAsZsWMulWcs9Z0iRt6R0jCTIpGrYacYS+
 LBMz19RIy6gjh8l19t0LTCuKqpwBqNKE0V7A2HvDxQab5KrXAkpfQJaen8xzK0ay1/BJ
 6kw/qthdKxrLxBxe5aCb48ENorlxg5+SyxB5qsbgLj4epEyjN4nm8xlGXTzHoocjlWpo
 1glbHjIG2bdxjI0m1DhrDA5lqjwddhALaZQnu0sF3CVeeMu6bNm52YTyWbSIKRObyFPd
 sseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u8VJVRDT3OUyLjgNXAgYtCNyTR8O6tuL+6GMwd0XRpk=;
 b=lN5a2RWMhtVhTX6/TIhH9CZFUUXPs6DinFXx2+1Cy81zSPukCX5eC7WsFxku4zhqgF
 B6iXjc/IvjncfOoTOg3bFu333YREpIaCbahFaWMXlhK81nPI2C/0KJLxvFzM5NEIqAa0
 k7kjuJqwAoxhggs7zr3Zr71B7mJc9XeRxAVene0nmvahDXw0nyRt4DdcIFXpHSF3z8Xf
 WxsS9Ga/bZjJpKnsrQ1lJwdW4nkEWZuDftN0r8V7h4QYF7JquCfK/RAI6XZoOoySxaOy
 O34ohuKCzilJtzjoHXwtPXoNRjE6hEIORt+GGDnNbmzFRHckLkY5EM9yMTPR7EkIgazT
 s2FQ==
X-Gm-Message-State: APjAAAUwGc5l/1RnGvuSW3m0UQv1mHnoLEoh4S/t4E53iamG2FrPnLtK
 rSSzYnsa1X+il9Yl9CCpq/qkUiWT5nH/YL0m+xO2ug==
X-Google-Smtp-Source: APXvYqxrk4oSwQNbx4cUVbslaxhQDxOfVuNNMC5RyNTNeaNvN1uU067TDZ4r53WKZPoLTRzbKIOJfVloYi9/iWye3FI=
X-Received: by 2002:aca:1308:: with SMTP id e8mr17564514oii.145.1570435417434; 
 Mon, 07 Oct 2019 01:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191007071610.65714-1-cychiang@chromium.org>
In-Reply-To: <20191007071610.65714-1-cychiang@chromium.org>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Mon, 7 Oct 2019 16:03:26 +0800
Message-ID: <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com>
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Tzung-Bi Shih <tzungbi@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stephen Boyd <swboyd@chromium.org>, Hung-Te Lin <hungte@chromium.org>,
 Mark Brown <broonie@kernel.org>, Sean Paul <seanpaul@chromium.org>,
 dgreid@chromium.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [alsa-devel] [PATCH] firmware: vpd: Add an interface to read
	VPD value
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

On Mon, Oct 7, 2019 at 3:16 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> Add an interface for other driver to query VPD value.
> This will be used for ASoC machine driver to query calibration
> data stored in VPD for smart amplifier speaker resistor
> calibration.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  drivers/firmware/google/vpd.c              | 16 ++++++++++++++++
>  include/linux/firmware/google/google_vpd.h | 18 ++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 include/linux/firmware/google/google_vpd.h
>
> diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
> index db0812263d46..71e9d2da63be 100644
> --- a/drivers/firmware/google/vpd.c
> +++ b/drivers/firmware/google/vpd.c
> @@ -65,6 +65,22 @@ static ssize_t vpd_attrib_read(struct file *filp, struct kobject *kobp,
>                                        info->bin_attr.size);
>  }
>
> +int vpd_attribute_read_value(bool ro, const char *key,
> +                            char **value, u32 value_len)
> +{
> +       struct vpd_attrib_info *info;
> +       struct vpd_section *sec = ro ? &ro_vpd : &rw_vpd;
> +
> +       list_for_each_entry(info, &sec->attribs, list) {
> +               if (strcmp(info->key, key) == 0) {
> +                       *value = kstrndup(info->value, value_len, GFP_KERNEL);

Value is not necessary a NULL-terminated string.
kmalloc(info->bin_attr.size) and memcpy(...) would make the most
sense.

The value_len parameter makes less sense.  It seems the caller knows
the length of the value in advance.
Suggest to change the value_len to report the length of value.  I.e.
*value_len = info->bin_attr.size;

Also please check the return value for memory allocation-like
functions (e.g. kstrndup, kmalloc) so that *value won't be NULL but
the function returned 0.

> +                       return 0;
> +               }
> +       }
> +       return -EINVAL;
> +}
> +EXPORT_SYMBOL(vpd_attribute_read_value);
> +
>  /*
>   * vpd_section_check_key_name()
>   *
> diff --git a/include/linux/firmware/google/google_vpd.h b/include/linux/firmware/google/google_vpd.h
> new file mode 100644
> index 000000000000..6f1160f28af8
> --- /dev/null
> +++ b/include/linux/firmware/google/google_vpd.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Google VPD interface.
> + *
> + * Copyright 2019 Google Inc.
> + */
> +
> +/* Interface for reading VPD value on Chrome platform. */
> +
> +#ifndef __GOOGLE_VPD_H
> +#define __GOOGLE_VPD_H
> +
> +#include <linux/types.h>
> +
> +int vpd_attribute_read_value(bool ro, const char *key,
> +                            char **value, u32 value_len);
> +
> +#endif  /* __GOOGLE_VPD_H */
> --
> 2.23.0.581.g78d2f28ef7-goog
>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
