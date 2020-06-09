Return-Path: <SRS0=1fsy=7W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094A5C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:32:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ADEA20691
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H81gKuKm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcmALxhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADEA20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DABDF1660;
	Tue,  9 Jun 2020 19:31:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DABDF1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591723962;
	bh=K0BGTYODR/iV0wXVelqhnKL30cXjlfOcm9U6wurUmVk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H81gKuKmZvhoj3K39I31pZV9oWBgS79EpeOOsc2L4qN6t8L+22ydaunr7w4n3Aeun
	 iHQLKrOEcj/2B2xirhHHsKkP+2PMzrx7g1LNfZpRxIGW+6ZcBFJzW8kcHQcnKH8LAe
	 JIi7Sdl/jZ+IA/lWLrblJ4jhLu+Pf0pgnbkfqr4o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80399F80278;
	Tue,  9 Jun 2020 19:31:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE814F8028C; Tue,  9 Jun 2020 19:31:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47312F80124
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 19:31:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47312F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QcmALxhA"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2B35E20774;
 Tue,  9 Jun 2020 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591723905;
 bh=K0BGTYODR/iV0wXVelqhnKL30cXjlfOcm9U6wurUmVk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QcmALxhAjslUXnR6YC7eg8kryfNAJrhmSweugHk354NYxFsktyjtrsT4HD1rk4dsQ
 3Xegf9abdCNTeo8ST5RgTYxBtK/l7h8TBi7Yc+O2qwb3pwHDDS3Eum+Wgt4XvB4eVk
 w2Ll9jFjOhQHwgavtiCkF4P5PDyOgcBaq8D0Nqjg=
Date: Tue, 9 Jun 2020 18:31:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: tas2562: Add firmware support for
 tas2563
Message-ID: <20200609173143.GN4583@sirena.org.uk>
References: <20200609172841.22541-1-dmurphy@ti.com>
 <20200609172841.22541-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nRwNdQxTdQ7rZk9A"
Content-Disposition: inline
In-Reply-To: <20200609172841.22541-2-dmurphy@ti.com>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com
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


--nRwNdQxTdQ7rZk9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2020 at 12:28:40PM -0500, Dan Murphy wrote:
> Add a property called firmware-name that will be the name of the
> firmware that will reside in the file system or built into the kernel.

Why not just use a standard name for the firmware?  If the firmwares
vary per-board then building it using the machine compatible (or DMI
info) could handle that, with a fallback to a standard name for a
default setup.

--nRwNdQxTdQ7rZk9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fx34ACgkQJNaLcl1U
h9B4Pgf/ehxijrs0I1XM6a7jjZd7I2o0Qr+iNYOZ2FZzlvfc/ctItyP+oleKNvu0
Z+7bX/9Qz0KlfxABFmoUxik3859oNIASDdnZ9uPC7damLes7HkxLmixASJRcEyJT
cMUPqPVVu2SYP8g5Zl4wDJKFBdg9vpsm7yUT/DJWEgwOS9MRXfM72rnxl5mgqN27
mF77C5XHmIJu/kUg1g+KMjEBpwY7iTBWfDXLecGikn+egcUdRnx2NMDQegDN9AuI
51ClUyGEYBsKX4KN1i4S1VdVA9db0Sd/Bsfkv2AS431i435xbfJSRZ40AUYFyWPJ
kasHwah+rBUXN1Ue9hukXgdCrO3T3w==
=JKgl
-----END PGP SIGNATURE-----

--nRwNdQxTdQ7rZk9A--
