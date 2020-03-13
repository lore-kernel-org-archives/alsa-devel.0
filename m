Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841B6C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:41:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E14F206B7
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rtGZSGfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E14F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D8AC1805;
	Fri, 13 Mar 2020 15:40:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D8AC1805
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584110471;
	bh=Eg0Ul9jFmy9VBUvjOSt8zc09fFc3exjXpFtlFuXNsD8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rtGZSGfldLircjYSZy8W8DfwuJcdxH2YG39wcx2r5TjqdaS+4FWQym9/KZtpr9AIG
	 J77eVMLqxgMR0jHCw1WevXPbUAfUsj7MJHFiDLKbNAgdK53f6ZvrlUI84qcATFv28D
	 AmOTDbD5IYmiSjyMK+i72vCdBGp9jnAtP+71rBnk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 930CCF80086;
	Fri, 13 Mar 2020 15:40:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71203F801EB; Fri, 13 Mar 2020 15:40:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 3D28CF80086;
 Fri, 13 Mar 2020 15:39:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D28CF80086
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 491C430E;
 Fri, 13 Mar 2020 07:39:58 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C16A23F67D;
 Fri, 13 Mar 2020 07:39:57 -0700 (PDT)
Date: Fri, 13 Mar 2020 14:39:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH 06/14] ASoC: SOF: add a power status IPC
Message-ID: <20200313143956.GJ5528@sirena.org.uk>
References: <20200312144429.17959-1-guennadi.liakhovetski@linux.intel.com>
 <20200312144429.17959-7-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZG+WKzXzVby2T9Ro"
Content-Disposition: inline
In-Reply-To: <20200312144429.17959-7-guennadi.liakhovetski@linux.intel.com>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org
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


--ZG+WKzXzVby2T9Ro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2020 at 03:44:21PM +0100, Guennadi Liakhovetski wrote:

>  #endif
> +	atomic_set(&sdev->reset_count, 0);
>  	dev_set_drvdata(dev, sdev);

Do we really need to use atomics for this?  They are hard to use
correctly.

>  #include "ops.h"
> @@ -617,6 +618,9 @@ int snd_sof_run_firmware(struct snd_sof_dev *sdev)
>  	/* fw boot is complete. Update the active cores mask */
>  	sdev->enabled_cores_mask =3D init_core_mask;
> =20
> +	/* increment reset count */
> +	atomic_add(1, &sdev->reset_count);
> +

We at no point seem to read from this reset counter?  I can't figure out
=66rom this commit what it's doing.

--ZG+WKzXzVby2T9Ro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5rmzsACgkQJNaLcl1U
h9AyxAf9H2ehXHG2BsCs+PkV8scPzE7Jg2CQOaQf/kGTv0YxUeOgU63SDzi+Gi0d
OUV+UxEuXqEEw1EMRTOfCkNir99YtFJN/bMIzBi4v4xjydoHTO0+H2qpNcNYjZEk
EhiDBi7y8tAQHbb/mDXBaUUX4JyUMyuJfE/0YGqqa0afjGY8k4XhUbIv/PgBAwIY
JkAxww4U8NKVAqUsyeq58/LPx0KVc7QT0uFU21aVjvxOS2U3HAjjVZHNeWdU7lkp
51RzY5TgOeDR2nnSmCSqQxN39qUTGpYmY5Ixh7hmKI8H9IIjmclpA6Awq0EAa9ln
B2N9uSK5dY2YpeD5z5QBJJ8gIHATyA==
=09t7
-----END PGP SIGNATURE-----

--ZG+WKzXzVby2T9Ro--
