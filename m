Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D450BC3DA7F
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:56:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B48D1908;
	Wed, 31 Jul 2024 10:56:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B48D1908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722416198;
	bh=tAC3ug/LGqAdm2YEhAedFZNCwyk2NGSC0+F1U6scVTk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=G/tUY3yu2rWd1Lw/NbHy3NN7Ks/w6G8RQVFwrkktXEuvJIAKiR/XcU7zMQC8laASz
	 eiUooVGeJChmHrXJKI+SN1v34N2b5d07/+5f6AUP0bnE/4H1DPaXs1QqDNCTyetfsM
	 rGz9bH3Rx8kyc7HugBh4h6ubgGkC+zxXi8h3OrRo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C76EF89732; Wed, 31 Jul 2024 10:50:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8ABEBF89751;
	Wed, 31 Jul 2024 10:50:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16C4CF802DB; Wed, 31 Jul 2024 10:26:14 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AA917F800C9
	for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2024 10:26:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA917F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=timesys-com.20230601.gappssmtp.com
 header.i=@timesys-com.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=zmy6QIPS
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-492aae5fd78so1431532137.2
        for <alsa-devel@alsa-project.org>;
 Wed, 31 Jul 2024 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1722414362;
 x=1723019162; darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFjJ7n63paZS6uSG42PXEZWs1JHtvlpu1J7pCHV1MaA=;
        b=zmy6QIPSYdtLC+TZHg1tAlo2tEYv5swdIZci3M4yceEvuwYfuAErFJNod6+o/L+br0
         byq6kya+L2aeczwW5id0ayYkmfDNukhtJ1/2FncbdwqcVFSitdfcrI8C0oziAUBhYdky
         gY9DyVhnCr1lbDgQxKjT/uR6GWd0ns/F9MnbTkpMxUuXSvvveXIcw9EMFdyvkG1OilV7
         LXxOSOq4czMH1BlSX5HFqI9uTx0Zy09jMaSyhPk+/3YIAqtXL3xRmlxVsJOrlKazGRmv
         6e3vS20DnIiXfyNxQlOHoCIIefPjE49Ob3g32dVMH8otFawHH45dkPVZ/ijzOGfncKLZ
         Zd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722414362; x=1723019162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFjJ7n63paZS6uSG42PXEZWs1JHtvlpu1J7pCHV1MaA=;
        b=DfRwat56V/eoi1EfcTuyRZKwhViWXCFCXb6Ayu6X/xoWc5sTkLBoZlpX2MPyJjF/S3
         6zmpTUG8UhmxOp1mpHCht+ePeWmYHzRO+Rfu0x8gSQUdNNngb+DttE81zJ3A6ctV25K+
         3aZOtf86IWimWdVOZEBoZKawP6Akv+gkNzCJ6nEneboRnreKQfQ8G5Wil9N9cQZpPGKe
         3vx4q0J6NmRhHw1BcF8gx3lp9PcgstcGQ3GPc8P2aYOvAqHhYrjw32zw4o1+FsFWQeUl
         9r07W/HM2YsoVc8GCguOTcjaif0o/qMpnlo27PUwW6r6NbQoyFjw/12UHf3G9NcJl4U7
         Z2XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXTMiJ6rm5Uv3rjAzxvD1Wh7+FLmPGu/6yuRhODZkTjYTfEjk1ZKwef3JLW3EdGZkTjW8PIUQRGJzl+MCEqbBoKlHiWkhCTIuONlE=
X-Gm-Message-State: AOJu0YzCG8hQr4TflTcTGf6p1FCKVmlyz7okDyGIM1uevp97MWZvZS6b
	5Fx32IfHdEK3VwukETk0gQ0cUfWa5TmY1GTs2hvWN8VJpeD0XMmopmvxhqxpdr2oF16zTysFnFX
	fVKQXgv2SSpBuXzZSQ+44rr3ofh2C1cqyh/druw==
X-Google-Smtp-Source: 
 AGHT+IEZQxKOD7qrEVQxXh0yoroOagYvbnV14lRkkP0QqCJaL1USQW1bT0weUmb2OMtTj4zK11JciNIw6TA8x5ATMzI=
X-Received: by 2002:a05:6102:390b:b0:492:a7e5:df9 with SMTP id
 ada2fe7eead31-493faa417bfmr15098391137.17.1722414362030; Wed, 31 Jul 2024
 01:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240731022949.135016-1-yuehaibing@huawei.com>
In-Reply-To: <20240731022949.135016-1-yuehaibing@huawei.com>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Wed, 31 Jul 2024 10:25:51 +0200
Message-ID: 
 <CAG+cZ05LGBsNODyAaApS1uoPXPh7Cchp8utm_AAWoM09HZzOzw@mail.gmail.com>
Subject: Re: [PATCH -next] ASoC: fsl: lpc3xxx-i2s: Remove set but not used
 variable 'savedbitclkrate'
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jonathan.downing@nautel.com, vz@mleia.com, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: piotr.wojtaszczyk@timesys.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: GHTHNBLNREPG4DGPSBOJU3NFPHYF7DXK
X-Message-ID-Hash: GHTHNBLNREPG4DGPSBOJU3NFPHYF7DXK
X-Mailman-Approved-At: Wed, 31 Jul 2024 08:50:21 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GHTHNBLNREPG4DGPSBOJU3NFPHYF7DXK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Jul 31, 2024 at 4:39=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> The variable savedbitclkrate is assigned and never used, so can be remove=
d.
>
> sound/soc/fsl/lpc3xxx-i2s.c:42:13: warning: variable =E2=80=98savedbitclk=
rate=E2=80=99 set but not used [-Wunused-but-set-variable]
>
> Fixes: 0959de657a10 ("ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs=
")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  sound/soc/fsl/lpc3xxx-i2s.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/fsl/lpc3xxx-i2s.c b/sound/soc/fsl/lpc3xxx-i2s.c
> index af995ca081a3..62ef624d6dd4 100644
> --- a/sound/soc/fsl/lpc3xxx-i2s.c
> +++ b/sound/soc/fsl/lpc3xxx-i2s.c
> @@ -39,7 +39,7 @@ static void __lpc3xxx_find_clkdiv(u32 *clkx, u32 *clky,=
 int freq, int xbytes, u3
>  {
>         u32 i2srate;
>         u32 idxx, idyy;
> -       u32 savedbitclkrate, diff, trate, baseclk;
> +       u32 diff, trate, baseclk;
>
>         /* Adjust rate for sample size (bits) and 2 channels and offset f=
or
>          * divider in clock output
> @@ -53,14 +53,12 @@ static void __lpc3xxx_find_clkdiv(u32 *clkx, u32 *clk=
y, int freq, int xbytes, u3
>
>         /* Find the best divider */
>         *clkx =3D *clky =3D 0;
> -       savedbitclkrate =3D 0;
>         diff =3D ~0;
>         for (idxx =3D 1; idxx < 0xFF; idxx++) {
>                 for (idyy =3D 1; idyy < 0xFF; idyy++) {
>                         trate =3D (baseclk * idxx) / idyy;
>                         if (abs(trate - i2srate) < diff) {
>                                 diff =3D abs(trate - i2srate);
> -                               savedbitclkrate =3D trate;
>                                 *clkx =3D idxx;
>                                 *clky =3D idyy;
>                         }
> --
> 2.34.1
>

Looks good, thanks.

--=20
Piotr Wojtaszczyk
Timesys
