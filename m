Return-Path: <SRS0=Jips=PI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3047BC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 12:31:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECAAF61372
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 12:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECAAF61372
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A66516CB;
	Wed, 20 Oct 2021 14:30:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A66516CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634733108;
	bh=JT2SkvtAggztd5vBpXOy3KiUBY0PoFlXIX09DB3XnHs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ve8LcNrSAH4NXwD0CBFDzTUnTTI9wdhwWiSVG7cyslZkwEJcBqguJmC3IGzV4vZ5L
	 l71PxOdIpKZlGoIvo8LgeOzD8ABdwCnBzqUmGnVwlJ/QLQItxYwvHTnfbtXAm4fHDb
	 jxUmWsfDrrYI5SOS3Ypyz9pSlLLsOoVxxtZqLOyk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73081F80224;
	Wed, 20 Oct 2021 14:30:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0FD0F80229; Wed, 20 Oct 2021 14:30:52 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07A71F800ED
 for <alsa-devel@alsa-project.org>; Wed, 20 Oct 2021 14:30:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07A71F800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZnIUPEIq"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F4366135E;
 Wed, 20 Oct 2021 12:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634733039;
 bh=JT2SkvtAggztd5vBpXOy3KiUBY0PoFlXIX09DB3XnHs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZnIUPEIq+hvzCl00QYwDpobI4iFUDxYE/SkDXuEed4ZxhuhfToaA8W8535LPjTRTY
 4W7zXSOZRKO7ExURf/LBK31wWDQOsDIIQammx1x/wgABht7VUahDLfta3lxOXRPzZR
 2RhU5xPdjYWSra4E0GiEO92nr76GHsp78fNqFyAGz247M8mPITA+6u64wn/7aG7r7r
 2/8HgafaK3ZzaWpVOzC/jmrVZEUpe0rpCJw6Yje7Kx8V9HLKY97UnB744PlD+7nxCY
 SDk9MZX+hq5fxOapESfk4jEQ2tqLQP+6g7o+e3EXjov0ma1NF3sgnHaNCIquEdkL3G
 lz+XCHRQJROww==
Date: Wed, 20 Oct 2021 13:30:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [RFC PATCH v2 1/3] sound: cs35l41: Allow HDA systems to use
 CS35l41 ASoC driver
Message-ID: <YXAL7Gc/wGR0Ce3g@sirena.org.uk>
References: <20211020085944.17577-1-tanureal@opensource.cirrus.com>
 <20211020085944.17577-2-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="105KrfQZCqU/K4pU"
Content-Disposition: inline
In-Reply-To: <20211020085944.17577-2-tanureal@opensource.cirrus.com>
X-Cookie: I program, therefore I am.
Cc: alsa-devel@alsa-project.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, David Rhodes <david.rhodes@cirrus.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Len Brown <lenb@kernel.org>
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


--105KrfQZCqU/K4pU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 20, 2021 at 09:59:42AM +0100, Lucas Tanure wrote:

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.

> Re-use ASoC driver for supporting for Legion 7 16ACHg6
> laptop.
> HDA machine driver will find the registered dais for the
> Amp and use snd_soc_dai_ops to configure it.

It will find the registered DAIs in what way exactly?

This patch is doing a whole bunch of stuff which isn't described at all
in the changelog which makes it very hard to review, I can't tell what
it's supposed to do.

--105KrfQZCqU/K4pU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFwC+sACgkQJNaLcl1U
h9BpGgf8C7Znyvqsj/ydwkf+M2pPLh07ukHK6c4VRUmxiuxT4/WUeecjcnTvo4El
J+dqhOnejW1i0PiJ8C/j2sz9Z/W0+asGY4+UcGy9VWUMQ0mUNt46UbEJPYR573ae
1WJVSy3Gzrx0FC/U/kRFlFplxPnq1VHITlm2oviYhrlqsvHP+9Xd+lBNmZB4H4Bx
JeEc7rfpHd7uiftVfhrVVNtgKjb+kvPiB4f1NTnwr4ZkDsF9ydULy5Ytq5qvEx7Q
AQ7MgwVpvdj14Jbmg1Abz4SNNVwwte9M9nc99X+aajfW9Shg77XxjUb90qoTb3iZ
nOkeqR9aXbE2RBNQZW3HIDaPLkwkEg==
=WUeG
-----END PGP SIGNATURE-----

--105KrfQZCqU/K4pU--
