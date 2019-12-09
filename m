Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03276C43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:26:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750E72077B
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nw3V/Xlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750E72077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 487911664;
	Mon,  9 Dec 2019 17:25:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 487911664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575908771;
	bh=NffLSKOJWWxFwnzNpKdnP14p/00V8ue2l1V+ztUax6M=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nw3V/XltnAcu1DF+cVGbXB48bj4cFOOmLF4QpuYD1S2vSIYt2DiC56nEiAjwegVEq
	 kt8Hq41xbWS0bZofZG3VhKN+rtqQi+I3LWAWo9DDNB79u2xXuBxxdQllRJROYsq0Or
	 irq10gW84cAnTAyiSYg0WIonygBWwYNdVlTjt/Rw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98574F8011E;
	Mon,  9 Dec 2019 17:25:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB847F8011E; Mon,  9 Dec 2019 17:25:10 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id C5A99F8011E
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 17:25:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5A99F8011E
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 627321FB;
 Mon,  9 Dec 2019 08:25:06 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D73783F718;
 Mon,  9 Dec 2019 08:25:05 -0800 (PST)
Date: Mon, 9 Dec 2019 16:25:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Chuhong Yuan <hslester96@gmail.com>
Message-ID: <20191209162504.GE5483@sirena.org.uk>
References: <20191206075239.18125-1-hslester96@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191206075239.18125-1-hslester96@gmail.com>
X-Cookie: We read to say that we have read.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: tas2552: add missed
 regulator_bulk_disable in remove
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
Content-Type: multipart/mixed; boundary="===============0917802419759842077=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============0917802419759842077==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 06, 2019 at 03:52:39PM +0800, Chuhong Yuan wrote:
> The driver forgets to call regulator_bulk_disable() in remove like that
> in probe failure.
> Add the missed call to fix it.

Another runtime PM interaction here.

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3udV8ACgkQJNaLcl1U
h9C0oAf7Bcr/KwDFz16ZGoRZQwalSCIYDkriphNjueah8hpKRCYaRMf4czOgFyiS
U7qICXScZ/vId7Fo6DYTIXtGVJKWAwMwiOC7nK2ZXdXZx8WMEhjb2KTyKX7Xnu2c
VcPJtml9iR0uzb9VZKUO3tOMTRXCDmhtVV/DwYQljgCEuL+cn77eMBIUkqFDieRM
rYP8Lvuxcrr8nyLXFs4MUupBTJoyRyTTyy4ShyXWndSL/ZbcfihvJbMCF3d0wTe1
PTKK/rjPqtCpkve3ogT+niLty0w1LVyWA8XglaNtHsN48n/nRjEPjUOciJISsobK
CLvOieHHXYcbemR9R044Yt/7k0qKZg==
=gdxw
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--

--===============0917802419759842077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0917802419759842077==--
