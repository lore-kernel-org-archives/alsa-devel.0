Return-Path: <SRS0=L/cl=FI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F11BC433FE
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 02:57:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9377B224F4
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 02:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9377B224F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7D85184D;
	Fri,  4 Dec 2020 03:56:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7D85184D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607050639;
	bh=7mCJs8mugeaB34o7v5UgJLkjOi2AVLnaXUNNG+16jIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OnzFzf5XzLgzi82woOQF+k49D5AC9HAjILqiZVc0eViYkyolpLk7rNtRS0TijmvQc
	 e9VrRHX+WZcKwZ7Kf4OxMhAupWBGcnCsg+1LjLDzTz4KprKh5gMALwVpHaYX4kPe6E
	 UuF0AioKyjI2d99GQW/iWCyBU/OhM8YkbeWRgva0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4413FF80273;
	Fri,  4 Dec 2020 03:56:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5BB75F80278; Fri,  4 Dec 2020 03:56:28 +0100 (CET)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62F6EF8012A
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2020 03:56:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62F6EF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="qX3Q4DkR"
Received: by mail-io1-xd42.google.com with SMTP id i9so4347195ioo.2
 for <alsa-devel@alsa-project.org>; Thu, 03 Dec 2020 18:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=isfeZ3kfKrYZjXvIfFGvKabQ5iROwvaOtPW6IFcmmAs=;
 b=qX3Q4DkRG4IPc+DXuwx7/KQaCd5Nwuqfesx4SdKjhFwC4QymWb8VnQb6HO3gnDaWw0
 Xhh5RWi9G/5bzChEsQrukG8vcxujHoPG49w+0qhEYXgUxLb3tQfFJ6bCQ12FzUQ3Sibf
 4Vdjl48BpJGw2nV4VVdl+FVlReXKpHE3j82G0VNTw+hSfbFqtmfeQbDRJBmxaBVdmdBf
 akQ7m/3uQUVxY+EFvU4qy3Mn7QQaimgixdFoFy0ztsCG/sl6VNBPFwwk2RI1+moNT9fT
 zhocNE6DFpWeMR9LEbmUSQEo6e2PhzeomPDM0qmQ2QKNckOFoc97OZE2Uuwx/IMadF1W
 +L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=isfeZ3kfKrYZjXvIfFGvKabQ5iROwvaOtPW6IFcmmAs=;
 b=JTjly5DWUu2XA2rFGu6+4G0VyBOnP8YhogpW40ywC5aZ6zTQ1zSlgJZvRHBziZ12UV
 PlM3EUYp7L6Cw+FLEJ4urGYklcv+YP1ZU+wXP02+AGkihc8ytvLhXKseTIIrS6mr2pGe
 niEuGjSRh7+pa9CPy+qJCkzt+ZlSQUaKuY2jy0/bDluHQzC4WLxF6Ja9znA57996VrQH
 1sLB2y5018/rNUwkngdr9qrahcViLy71gz69k5Kq2BVSHTfWl4u4+MECsNnatlILHLhO
 YTZ/jQ8QsZM45wOkQ9UKgZqIiKAxxAybamr4++OKqYjL3B5Z7yK1GW5hRtcFTbtItspC
 wDEw==
X-Gm-Message-State: AOAM530KfM3BNmV2+G9jyPQjW1BwfrMfG2r2oRgP91G/6msiJxCGQ2ej
 PIyg0ul1PeJ+ugf1874AcCX8bfL4XUlNAxCjo9PKfg==
X-Google-Smtp-Source: ABdhPJxTr4JbkKHUEG1/9DIqVju9MZyNFzKYSjbwMrnw7cRRwoFQFlLrKA+Mn/8qkobkdeHunXJNXanaye0EQP+iUIo=
X-Received: by 2002:a02:c804:: with SMTP id p4mr3166234jao.110.1607050577866; 
 Thu, 03 Dec 2020 18:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20201203225458.1477830-1-arnd@kernel.org>
In-Reply-To: <20201203225458.1477830-1-arnd@kernel.org>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 4 Dec 2020 10:56:06 +0800
Message-ID: <CA+Px+wWmJrS46TzWgKWiufJH7ryB+mOH7H4xfGZex2j=NutfLA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: cros_ec_codec: fix uninitialized memory read
To: Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Guenter Roeck <groeck@chromium.org>,
 Mark Brown <broonie@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Benson Leung <bleung@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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

On Fri, Dec 4, 2020 at 6:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc points out a memory area that is copied to a device
> but not initialized:
>
> sound/soc/codecs/cros_ec_codec.c: In function 'i2s_rx_event':
> arch/x86/include/asm/string_32.h:83:20: error: '*((void *)&p+4)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    83 |   *((int *)to + 1) = *((int *)from + 1);
>
> Initialize all the unused fields to zero.
>
> Fixes: 727f1c71c780 ("ASoC: cros_ec_codec: refactor I2S RX")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tzung-Bi Shih <tzungbi@google.com>

In the case in i2s_rx_event(), only the "cmd" member is used.  But it
is fine to please the compiler.

struct __ec_align4 ec_param_ec_codec_i2s_rx {
        uint8_t cmd; /* enum ec_codec_i2s_rx_subcmd */
        uint8_t reserved[3];

        union {
            ...
        };
};

I am a bit curious about, in other use cases of
ec_param_ec_codec_i2s_rx, why the compiler doesn't complain about
uninitialization of the "reserved" member?
