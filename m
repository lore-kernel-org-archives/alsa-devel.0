Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A891EC4708E
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Dec 2022 13:05:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D747F18CA;
	Tue, 13 Dec 2022 14:04:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D747F18CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670936712;
	bh=FfQO4SlngeVMvXO/uPM9wXPdAL35DSlgBW0f1vtUb9U=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=V15KuGVtP1I0dI/ypW8A5WMSdcecHjmqpssUADInyOV/34SLwshsWlQCLW0S3Yb2G
	 l5Xh+u2yQqivKGKROI6PvTyjxVtfdMGl9/2ECq8uaTYpyyMDUQWHDDwyQ2VTGKg5Rw
	 a3js3PuUpz23TZjikxZukE0ClHHrUc/jKwHvoj98=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 415CBF804ED;
	Tue, 13 Dec 2022 14:03:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82169F80073; Tue, 13 Dec 2022 14:03:58 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7CB6F80073
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2022 14:03:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7CB6F80073
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=kd3//lpc
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0D812B810DE;
 Tue, 13 Dec 2022 13:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6825EC433D2;
 Tue, 13 Dec 2022 13:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670936634;
 bh=FfQO4SlngeVMvXO/uPM9wXPdAL35DSlgBW0f1vtUb9U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kd3//lpcOfmqJ3/1Nf73JN7lIx7Vj0g/ZAcLFMwckaNYdYDby/UqhVfXLj0GA7ghx
 LAvfR9HUkIJMKcWoZkQZwE2q1eiM/EImf/EZiaQaMzQ365PtpXaa3PthAgDjoNgj2Y
 p/DZ3yZrq7nfzW2WNYdQMdW1HDj5jtZwJNNnNh3GLpGUeSdyiiR9rfiltSU9SvHD5p
 XukccjOrQn/4HKuHccDJcr5NKER+elUkospLzJQcR7TqyZ0Ci8xOjqPGT6bD7xrYTe
 OE3t6J5HviuvUiElddhUBnjOmetoBpo92/PKxbISnGKFB+1L/NdQLDlE6qgrvSCMYW
 rtlyBXEW5h4ww==
Date: Tue, 13 Dec 2022 13:03:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH] ASoC: rt5670: Remove unbalanced pm_runtime_put()
Message-ID: <Y5h4NQ+tq+k3UMLm@sirena.org.uk>
References: <20221213123319.11285-1-hdegoede@redhat.com>
 <c490d006-20f2-bf47-fe4e-61d9ba29b6a7@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5O+CDvpEhBLk0/5t"
Content-Disposition: inline
In-Reply-To: <c490d006-20f2-bf47-fe4e-61d9ba29b6a7@intel.com>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--5O+CDvpEhBLk0/5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 13, 2022 at 01:55:50PM +0100, Cezary Rojewski wrote:

> From i2s (non-sdw) Realtek codec drivers found in sound/soc/codecs it seems
> that only rt9120.c defines PM ops and configures the PM for the device.
> OTOH, there are several which define suspend/resume on ASoC component level

> Thus, voting for a complete revert.

Note that with ACPI you can have runtime PM things happening at the ACPI
level so even if a driver does nothing when suspended there can be some
benefit from using runtime PM.  No idea if this applies to any systems
using these devices or not though.

--5O+CDvpEhBLk0/5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOYeDUACgkQJNaLcl1U
h9Ca0wf/WvNL0uHnfKr70rDbDQI3v3vJzaRH7vIDBFo/bzoeW0pSZNbjyZsCLR6S
5suTxQ6CkWa49KWZhnnmHPi/jWqWdXMEFt1XfyNob/u0nQlTjQzEHzcfCK6nl5Eh
Iamkvgq9DPtWm/Hmj8ghPPajHrfWgCZdgXhPqmDN6+x3sB/Q7ooqu05ylHdBEAbg
4odCw081dJxEnZRKULN6IeJjhPs5y0dCabfibSCxqVVC3S44osGeuO/+IANv2z7f
ttG4je4q2wLlUqr9ZUm9/ywCh8175KMBeKjJmXQdMp8i7FWalsrziCd4sWYzFwfL
AeZ5br+oPeezgbF4+dwaQU5tqAEMBA==
=S4LW
-----END PGP SIGNATURE-----

--5O+CDvpEhBLk0/5t--
