Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F2EC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 15:36:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33EBC23888
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 15:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EBC23888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D1CC17EA;
	Fri, 15 Jan 2021 16:35:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D1CC17EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610724981;
	bh=ArKJGWkfwv/90bfz6gMSVwhjIGQuOXJUt3RepUJkScY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hj2n9QoAuEadong2PTgnkK/xPNcSzvZyXtAGoV4bQqT3ntkla2fAFySfc0VvDdyCY
	 71XxMl7ITgUMCalW6/BnLne3LA5AV/v4ftjrZT6fYZmCHV6ODQjR5OLPXzabhZ4Hl6
	 12kqgPkJRFnSOHtSCxJob1oojgaaZuOx5+Xkj3jw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58148F8016D;
	Fri, 15 Jan 2021 16:35:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6F98F801ED; Fri, 15 Jan 2021 16:35:20 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82DB6F80113
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 16:35:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82DB6F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="FKX7N3zP"
Received: by mail-wr1-x433.google.com with SMTP id a9so6241853wrt.5
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 07:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ESX6noLsCkIO+iwpxKWPA2ym8CNQ0B0VrfopXTaNMvE=;
 b=FKX7N3zPinoMooJcVVc0Sul+W4MuG3BE0bFE6iGvHrfIiOqkaREXyINpMin1far4Id
 E04bd3N5MYIdx6u8wDKioAevVfC3CvXnTJHsha8bOmtKvjrKlyvzEBpLkie0yoXzeHaL
 w0CV0nBGKymAWXZZQ90gTHGyiwdnAe17/+rAAHKUVkPjN4luBy42B6HAz+1mba5Pn0EQ
 gY5jTM+y/PWCPX4Ex1nS7DDHk4zHyJTVTWJRP9czrQiW7WR3CQuic/cRSl+x9WAXjbrA
 ZdlFr+CO2VKtvapR/Mmgt3Z4YegfYZ2x3GtRD9zDMtK7n6j1oixFpJdfVklhyDlPZMkO
 RN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ESX6noLsCkIO+iwpxKWPA2ym8CNQ0B0VrfopXTaNMvE=;
 b=YvrRQT79pP86tdCvXwItaghvYDsMVcbj/C7K4EYec3mG4Z5+qGyGP10fjI6eBH5cOb
 F+Ha+wzDrFD3+wJqWMJY/LLd8lg3mVbWBPfkDVeKA+cd+Qr47usju8n24O09FfWwPPkA
 D8PWGCDOL3yrwSYoGC1Wp55CSm8Q9esslm7Y49UG8sLK5yyEyBwV38w55gwsmFOA1Eyl
 xgeS+G5yrcsJQHUBFXO5EDatkj8YfaaC4vOsos8QQNlQj2MAu5yxv23a/RLptsrHNHgQ
 +1mH49qIOH63+Vda3hBVw5HUINFsQr4bl6LDJ0897u4AHMblcSxMhPjFFxZPGvrV9yhT
 AFLA==
X-Gm-Message-State: AOAM5317G0fnnolfxCj10P9fdW/fVtFp6M/RZmI1wH2Fyo62LEy+b6Vs
 /xFMBrZjgMMJ+L3mDB7cmK4=
X-Google-Smtp-Source: ABdhPJz/Wu7xnv0xzKek8K70k69xs98gJ80/O6x3djJk4M+rXGYYY30sfdUBjoGV41dBshMXS9edJw==
X-Received: by 2002:adf:fad0:: with SMTP id a16mr14302085wrs.390.1610724910415; 
 Fri, 15 Jan 2021 07:35:10 -0800 (PST)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id w13sm14787841wrt.52.2021.01.15.07.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 07:35:09 -0800 (PST)
Date: Fri, 15 Jan 2021 16:35:07 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 2/5] ALSA: hda/tegra: Reset hardware
Message-ID: <YAG2K4CjtCdSs6P2@ulmo>
References: <20210112125834.21545-1-digetx@gmail.com>
 <20210112125834.21545-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uOznnLuw98Lbh+eo"
Content-Disposition: inline
In-Reply-To: <20210112125834.21545-3-digetx@gmail.com>
User-Agent: Mutt/2.0.4 (26f41dd1) (2020-12-30)
Cc: alsa-devel@alsa-project.org, Nicolas Chauvet <kwizart@gmail.com>,
 linux-kernel@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
 Takashi Iwai <tiwai@suse.com>, Peter Geis <pgwipeout@gmail.com>,
 linux-tegra@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>
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


--uOznnLuw98Lbh+eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2021 at 03:58:31PM +0300, Dmitry Osipenko wrote:
> Reset hardware in order to bring it into a predictable state.
>=20
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  sound/pci/hda/hda_tegra.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
> index 4c799661c2f6..e406b7980f31 100644
> --- a/sound/pci/hda/hda_tegra.c
> +++ b/sound/pci/hda/hda_tegra.c
> @@ -17,6 +17,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/mutex.h>
>  #include <linux/of_device.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/time.h>
>  #include <linux/string.h>
> @@ -70,6 +71,7 @@
>  struct hda_tegra {
>  	struct azx chip;
>  	struct device *dev;
> +	struct reset_control *reset;
>  	struct clk_bulk_data clocks[3];
>  	unsigned int nclocks;
>  	void __iomem *regs;
> @@ -167,6 +169,12 @@ static int __maybe_unused hda_tegra_runtime_resume(s=
truct device *dev)
>  	struct hda_tegra *hda =3D container_of(chip, struct hda_tegra, chip);
>  	int rc;
> =20
> +	if (!(chip && chip->running)) {

Isn't that check for !chip a bit redundant? If that pointer isn't valid,
we're just going to go crash when dereferencing hda later on, so I think
this can simply be:

	if (!chip->running)

I guess you took this from the inverse check below, but I think we can
also drop it from there, perhaps in a separate patch.

> +		rc =3D reset_control_assert(hda->reset);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	rc =3D clk_bulk_prepare_enable(hda->nclocks, hda->clocks);
>  	if (rc !=3D 0)
>  		return rc;
> @@ -176,6 +184,10 @@ static int __maybe_unused hda_tegra_runtime_resume(s=
truct device *dev)
>  		/* disable controller wake up event*/
>  		azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
>  			   ~STATESTS_INT_MASK);
> +	} else {
> +		rc =3D reset_control_reset(hda->reset);

The "if (chip)" part definitely doesn't make sense after this anymore
because now if chip =3D=3D NULL, then we end up in here and dereference an
invalid "hda" pointer.

Also, why reset_control_reset() here? We'll reach this if we ran
reset_control_assert() above, so this should just be
reset_control_deassert() to undo that, right? I suppose it wouldn't hurt
to put throw that standard usleep_range() in there as well that we use
to wait between reset assert and deassert to make sure the clocks have
stabilized and the reset has indeed propagated through the whole IP.

Thierry

--uOznnLuw98Lbh+eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmABtigACgkQ3SOs138+
s6FeaRAAsz1n0eikp0rj/uwYC3OvRDA8cLTe9YBU9D16waXKHN4oJ+gx0zWhCVj1
9yQQOfnF335Xke/RTeCrv+9Powa81YgGqPdveTuj3MmaP58PsHvIC/22XFnjw2zK
ott21GlSMITx0JMrGjYI3dTSq6rSzRWMAr7YADDgahbpoN/AMnI7Dxh6Inqmu8F0
NdGSS6WPqZ6rDf+ICY0nSd06BjQB5sPuqUleMIK1RGxGWYH7rq5gj51Ovc98z+B4
NfCMZHB1LFI9v/soLABPeTbCRn6SXOyfaLeZFn3a/H34xPF0BZw9CCYWzJq8PWBH
j89p364+whgu210XuppIcGL58u/T2BtjayTJSr1H4YgP2MbUZw1rw5ZvX+KxYdhf
fYr/lkmUvSha4VjBJOM+kymJaVHNWwheHwX9VJtJRiAzet7oKqto4p0X2wWFjztn
mi8ZUngUTKYczi0gXP3Mvy/+95/HVwmW+9qmJQ1gBA9IrWvENmhimH3qa8kQP2/5
1yns9vqGx/N+IAdANR7gzBfyf2rjQxIo1ritAlPiHa0/U+fSPjwp8IeHdJgtpziV
bWRfvo0emWaj8cbZsB4/inTPyiCfhk+hQeYtpYRp9HJodO/1LbE1n/fvwATlMIdA
epFJUgIuI4OlFQ5vGY5Cl73pxHnrJOJjLmOBj/CNjZmgoHoQT9g=
=bc5e
-----END PGP SIGNATURE-----

--uOznnLuw98Lbh+eo--
