Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBFBCAC587
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:06:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23F2860216;
	Thu, 11 Sep 2025 18:05:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23F2860216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1757606764;
	bh=EtjA6KHz4f0Bo0AftpsmVvKJGgrz5xR0jEkqXVkrxIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dR9YkdmJDm/IeuLlqOYpXlhb0OwJE5/NVjZ1tcI1yJkWAZaQTS/NVr8YMcBnldlEH
	 OdJIGEGzKUXXu5fBWZwYnpQrnr47ipqXchv7/sV9/bENkxVYMfIzBO4/g3N+SV0jpH
	 68rWjVJ7VR7Ue+6AGheoP60Koptf4ZapuxpAO2PM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D6B8F805D2; Thu, 11 Sep 2025 18:05:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B88D8F805CA;
	Thu, 11 Sep 2025 18:05:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A7A99F80518; Thu, 11 Sep 2025 18:04:15 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 03279F802DB
	for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2025 18:04:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03279F802DB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dfol2yeD
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CEFB44422D;
	Thu, 11 Sep 2025 16:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC1CC4CEF0;
	Thu, 11 Sep 2025 16:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757606648;
	bh=EtjA6KHz4f0Bo0AftpsmVvKJGgrz5xR0jEkqXVkrxIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfol2yeDwJdsswn7tIhCL4q+6Nk/h4fy4ANGM3mjK4JWOWt23MFqTcMje0eO9mXUS
	 zZJAqwbz0h0csUFH9J4iWCsI1cRX6t7ZxygTJN/Rsdb6hAdW1gI7r/lMK6FFZMy8dE
	 6hbX0NNFgrrOANy2vv50v6oTgiKMI1Ey7y4Pbz80MMLNaZq3uUoKxVjbQCsYD3+a47
	 ivQhnlufx+4rd20Xdq6T1cAD/qJL/OQo6V+981+tMGblL3/SW14FSt2iFiw5KydfRM
	 PNA+pJPtY7fq9paWo+7jMz2h/9e0UR/Qg2tax9tLZKcqiHNc6+2GFA3ZA1tdG2i9OC
	 rnnvYJHHBcqaQ==
Date: Thu, 11 Sep 2025 17:04:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Niranjan H Y <niranjan.hy@ti.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	yung-chuan.liao@linux.intel.com, cezary.rojewski@intel.com,
	peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.dev,
	navada@ti.com, shenghao-ding@ti.com, v-hampiholi@ti.com,
	baojun.xu@ti.com
Subject: Re: [PATCH v4 2/6] ASoC: ops: add snd_soc_get_volsw_clamped
Message-ID: <652726cc-b286-4ba0-b49c-8b981d6d0244@sirena.org.uk>
References: <20250911155704.2236-1-niranjan.hy@ti.com>
 <20250911155704.2236-2-niranjan.hy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nudhPraOH89YU/Jv"
Content-Disposition: inline
In-Reply-To: <20250911155704.2236-2-niranjan.hy@ti.com>
X-Cookie: Your domestic life may be harmonious.
Message-ID-Hash: RSKJLGDATMNR64L3EHYBTLIQYJFMBP4T
X-Message-ID-Hash: RSKJLGDATMNR64L3EHYBTLIQYJFMBP4T
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RSKJLGDATMNR64L3EHYBTLIQYJFMBP4T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--nudhPraOH89YU/Jv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 11, 2025 at 09:26:59PM +0530, Niranjan H Y wrote:
>   Add API snd_soc_get_volsw_clamped to read
>   the volume from device. This similar to
>   existing API snd_soc_get_volsw. But has
>   additional step to clamp the value to max value
>   if the register value is larger than max value.

Why is this a separate API, what is the situation where we would want to
report an invalid value from a control?  I was thinking of just adding
this to the existing operations rather than adding separate ones that
need to be explicitly set.

--nudhPraOH89YU/Jv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjC8vIACgkQJNaLcl1U
h9BMggf+PmjIfR2DMy732zUgzi5xKsl2VNVltZ+Oe0qN2R0ZwvHFR4D197ZnYp1E
q187MsFCKImr2yZnjIPFxVkuTPE78cRK0fUcGtRLTttUe0LWV0n0QbHFZjr5vQH0
hs+buZkW6Cci4gHJ5W6g6ci4ALZtnamqo706n45wSJO3q0txT3Qa1jriX6fM+V14
mY9fTQpXgizbn4PAsInR0u7M6OcnRE/fyWYvX5wunLnLYJKhGZH1+khUedMTWF5N
UryXBwnvk4l9e2TFcKUdgluTudXd+qsy2Lw/JJWIxDQgH+XVlTKIehGqoCwDSzop
RK6hw/zKIB5wvaf9AzVu7H6H2XPMuQ==
=34f5
-----END PGP SIGNATURE-----

--nudhPraOH89YU/Jv--
