Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708BDC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 20:50:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE282075A
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 20:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GyLKtFMy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv6PRslf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE282075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B11A1797;
	Wed, 27 May 2020 22:49:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B11A1797
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590612645;
	bh=G4uWVqfm77mh0HU7OO3eKN4lt9pL3KlrbLMpJgGVbus=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GyLKtFMyHyiCFC+fMCJ/NvCJQK+inWCY+rS6SxqRubxx5GwvdEQ2l19Zs7aumnfe9
	 PI6vH0sh6/55gckb4FnypxsQCHzW+B/DLp1wELvLdfowKjzf2udN+m7C5TKPqYqn/X
	 9FyTGS7I9w/u/1j6WYsoxhLBbVPoJckF9tZ1a1Js=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3A50F80149;
	Wed, 27 May 2020 22:49:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51119F8014E; Wed, 27 May 2020 22:49:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E370F80146
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 22:49:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E370F80146
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Rv6PRslf"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5AA7220835;
 Wed, 27 May 2020 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590612586;
 bh=G4uWVqfm77mh0HU7OO3eKN4lt9pL3KlrbLMpJgGVbus=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rv6PRslfDt/yScS1zhsKb+vU9TEic/7vzM6AGKQRBBMkwgCOIVsmLejnfXdpp8K1s
 rUPYZ8RdkKJjfp6v8Y8i8GsQDiEAL449eZEywafyK6bgi2KpxN44Gbi7KHhci116NE
 17xHcEFpV/dzOHVZukuL86fcVHz+AQT/6M/0yB8k=
Date: Wed, 27 May 2020 21:49:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/4] Kconfig updates for DMIC and SOF HDMI support
Message-ID: <20200527204944.GL5308@sirena.org.uk>
References: <20200427165211.23463-1-ranjani.sridharan@linux.intel.com>
 <00d4ea9242cad11b7aab10326b7430f6106d63e3.camel@linux.intel.com>
 <d9931fc5-56a2-5626-5cee-aeadc7cc976a@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oOpJzULQ70+PGW7h"
Content-Disposition: inline
In-Reply-To: <d9931fc5-56a2-5626-5cee-aeadc7cc976a@linux.intel.com>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 kai.vehmanen@linux.intel.com
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


--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2020 at 03:17:27PM -0500, Pierre-Louis Bossart wrote:

> Mark, is there any issue with this patchset? This series posted last month
> will conflict with Arnd's RT5682 cleanups (just tried, see below). I don't
> mind re-sending the patches on top of Arnd's, please let us know what's
> easiest for you. Thanks!

I don't know what's going on with this patch set is any more, I was
expecting Ranjani to resend it if things had got lost (like my "no
pings, please resend" form letter says).

--oOpJzULQ70+PGW7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7O0mcACgkQJNaLcl1U
h9ByoAf/VMzAnVjWUuaHaG96R4SLybmvlX3F4RRFO4CAsWIk9zIozbTyDXyvI4Gh
Hi5ywQ6OHUoa0gqJQrlqJb9RMDS60h3G1hiVU+RD/0hZeKDaMGaIeFMUNC1ZczGF
EDhRV8IuA6mBp4rsPa/8RrFY+AS3o7/9qKANVHhH/g50j+rajFBSTAmnKrxvLlnk
DLO4Cwch1eXwhwTQum/e6DpkPG5Ks6PeGcsXgqr/HN/4nxtLSBJZB+kY0m3X5V99
u6wa7D1LKHyw7WLi2evXT5hf9f7F4KdjRwEWK4O99WwUfBgX84lx/TAb5xdKmHvw
KuJ2xCm9LpYCmuN9qQf8hy+w30ECsQ==
=Bnfz
-----END PGP SIGNATURE-----

--oOpJzULQ70+PGW7h--
