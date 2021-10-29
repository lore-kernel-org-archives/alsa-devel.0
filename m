Return-Path: <SRS0=puNT=PR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2CBC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 02:21:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E76261075
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 02:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E76261075
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2240516D3;
	Fri, 29 Oct 2021 04:21:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2240516D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635474111;
	bh=q/GkHknTFVy8p0Ym2Z9iyJNDs4qUZaNW2gBn5oJb+yE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uoAdbLET5tMqKTfM+/2MkRpCX6jIxqxkcLUkS7BmU1XPisWnkVNldbmivlZsSmlkv
	 6As/rCQUUmWm7EKFDnFGuPM3z+8IlC77M+h65EyJedoBjQ2FiW5Ha48KTM3Z9hnuEw
	 zN0TFDOBW8Qo7gjh0ZqZE+1d0MKhybFz0LxUUoAk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E4BDF801EC;
	Fri, 29 Oct 2021 04:21:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEDCCF801EC; Fri, 29 Oct 2021 04:20:56 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E145F8010A
 for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2021 04:20:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E145F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="jlVG+VO1"
Received: by mail-pf1-x42c.google.com with SMTP id p40so2978868pfh.8
 for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2021 19:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mhB6LkCbsKUbE+bUIvR/Nrpsu2M4JaioKKngIejiLhc=;
 b=jlVG+VO1wHjL5B0Hkj2SEVVcUAGh7PrcbCyhNPcuXTVpP/NRyZrpYh2RlHOO6oYrTW
 PbR1GOeMbg8NcIQgJRX5w78F9Knr93d2yQFXq2kJM0zWiWhnU9TgrsBNd9bFt+d6Nk2r
 GjFs3JECWpH3fOdXFBWqqYTy/2L2M2iH/srfKEogAcW+JqlnBw8bFWlF5HgnlTIy44Wy
 YFfHhdrDo4URqFGKHh0fb3WB2p3WUxS0Nk9QTXO4kNy3r2hmmJixp8x2tDyOhL1bPYfD
 epKiICmzzvtTja91yNZDRFSpqL4TrY3h3VbVAcFNy1UHxrZUIbzek9ezqph5ss7aJmGj
 vKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mhB6LkCbsKUbE+bUIvR/Nrpsu2M4JaioKKngIejiLhc=;
 b=QrFHpdsFHhtYGSkoWS8NLsnZhONoeewveJnSkow3qLs7eQyos6plZ1xNheostzBRFX
 LMl9VoxWea8pjSMgFVZEkmIVXcXQ8CTFH/y6X9e3lwInxNP5q28h0qMfU4sfdZz/n/09
 haPU/9i89/jy/WKg13N9yS3hO6sWgsP+jv8mfjDu3EMbFslabmdvHfqzNdnIfHCKYusU
 U8SQvGuRWModnzOYQZNV60gA9wO5RYh0K9kXccsi0z4KhJc9dN3Hp4Oa0yZb/gbGewLo
 vR1sU5q52XLUZjTFIUxoCHmxI5mEvcJMVjY+kGi05qcQuOOp2+8kg03Feo0l24MSa0vq
 LenQ==
X-Gm-Message-State: AOAM533os6JEZUW0zhdRATEVqZ2g1znYHMFb1WXdqiZx87YI7gAPUwDU
 d3ik+cwuy2VciPZLSOwb1HUCAZpQUocZVUzmQXIIXQ==
X-Google-Smtp-Source: ABdhPJwRHndRNkI7bhtBce/eYA5HiHNlGa+O3E5HB7Z9RmPlWNKvOeozIVu/Q5CdowIzhda3z/o19UtPjQ3coB7P6Gk=
X-Received: by 2002:a63:7418:: with SMTP id p24mr6095486pgc.204.1635474044247; 
 Thu, 28 Oct 2021 19:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211029001225.27218-1-julianbraha@gmail.com>
In-Reply-To: <20211029001225.27218-1-julianbraha@gmail.com>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 29 Oct 2021 10:20:33 +0800
Message-ID: <CA+Px+wUi6t3n64EPWqX0Q3vMUkBw7UrRBK_5RwnVtNsa-ZuLGw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fix unmet dependencies on GPIOLIB for
 SND_SOC_RT1015P
To: Julian Braha <julianbraha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
 fazilyildiran@gmail.com, tiwai@suse.com, Jiaxin.Yu@mediatek.com,
 lgirdwood@gmail.com, broonie@kernel.org, linux-mediatek@lists.infradead.org,
 trevor.wu@mediatek.com, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Oct 29, 2021 at 8:12 AM Julian Braha <julianbraha@gmail.com> wrote:
> WARNING: unmet direct dependencies detected for SND_SOC_DMIC
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
>   Selected by [y]:
>   - SND_SOC_MT8192_MT6359_RT1015_RT5682 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8192 [=y] && MTK_PMIC_WRAP [=y]
The block is not for RT1015P but it can also be fixed by the patch.

[...]

> This is because these config options select SND_SOC_RT1015P
> without selecting or depending on GPIOLIB, despite
> SND_SOC_RT1015P depending on GPIOLIB.
>
> These unmet dependency bugs were detected by Kismet,
> a static analysis tool for Kconfig. Please advise if this
> is not the appropriate solution.
>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
Acked-by: Tzung-Bi Shih <tzungbi@google.com>
