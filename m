Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9CDC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 13:23:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBC7418AF;
	Tue, 12 Apr 2022 15:22:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBC7418AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649769790;
	bh=6MhtNDR77Uk9x4Ncl/TgZ0K/BInAvzJDofHfnatbD04=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jyDKZZJLMPdogdTSCdo8Yh/7aHKILdP9qQDevurLoaYvSmTwqflkfC6s/iZBn58UB
	 4wV/1amBLh3yClk0qhfz3HqPt6xN6O+IcWTjxfpS0ZVF+jbkZY/Zfnv0QOloWOis6D
	 vzEvG9Hd042CZWzXUpKmmBwN0k9fMjZ+m36uZEzM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6112EF80134;
	Tue, 12 Apr 2022 15:22:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24C50F80154; Tue, 12 Apr 2022 15:22:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA9CAF8011C
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 15:22:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA9CAF8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tVOqaeQ/"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4378B61A11;
 Tue, 12 Apr 2022 13:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53F1C385A1;
 Tue, 12 Apr 2022 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649769730;
 bh=6MhtNDR77Uk9x4Ncl/TgZ0K/BInAvzJDofHfnatbD04=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tVOqaeQ/W+eDm/Y22r40LIR65+/PNZqjaal7DaWcnWH769nA8uOB+yqCl9/mgJsYL
 avn3gVwF5wVZQsdBFFljHdtLRotjQ45CMndTHE/X/eardekI2sSD/AKqAjFZQxnhwu
 5xrrfxuC2WtHXo/aBoo6f+Ie/6ZzPMdH3hqdzfA+eFQxClJmqHhSi0wsymg4iPJm9o
 rB+te/DKTVzbZ6S5S59YVnb83104hx5zcKcEjyqdcIITYnyPXzFx7Lp1mov8B6BQpC
 8dtTgUBhkp14kW2LoebmRNHm9EZVA4xqGIfYdGyZCcn2kNytab1xYcIQ4+TS9Nvypc
 r+o/L8w24DizA==
Date: Tue, 12 Apr 2022 14:22:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH] ASoC: wm8524: remove rate constraint for FE-BE case
Message-ID: <YlV8/dJeyFFDf/v/@sirena.org.uk>
References: <1649754826-2651-1-git-send-email-shengjiu.wang@nxp.com>
 <YlVy6tAPMw+MHq/f@sirena.org.uk>
 <CAA+D8AP=ydd6f9su=JR1q9NVWTg2tHoTF1OGHQGmFN+gZhAcHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GWZv1Nn8Ww4evgM0"
Content-Disposition: inline
In-Reply-To: <CAA+D8AP=ydd6f9su=JR1q9NVWTg2tHoTF1OGHQGmFN+gZhAcHQ@mail.gmail.com>
X-Cookie: Approved for veterans.
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
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


--GWZv1Nn8Ww4evgM0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 12, 2022 at 09:18:16PM +0800, Shengjiu Wang wrote:
> On Tue, Apr 12, 2022 at 8:39 PM Mark Brown <broonie@kernel.org> wrote:

> > nor is having to open code it into the driver.  I already had it in the
> > back of my head to generalise the set constraints based on sysclk
> > pattern into the core, that might be productive here.

> I also hesitate to add this in the codec driver. I agree that it is better
> to be put in the core.

> When will you have a patch for this?

Dunno, no fixed plans - it partly depends on how gummed up other stuff
I'm doing is waiting for review.

--GWZv1Nn8Ww4evgM0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJVfPwACgkQJNaLcl1U
h9DdDQf/SMZuRMaZ9bCrIvYAiyEfrE/pIxlufwWik0/9voMm3EjRV7tepL47OWve
fgJtDTfj/dDVRpDJHcY9inUS3RCaWloLpo9m0IBRDMaf8iF6TYbY28BxRGJhXmiJ
cLXy5r8Q3oH3VP7u7SaWcISIOx9ETgruHs2sjS5Mf340njtgwZuo1eYT+zHmqTA4
NusMZ/We6OLXHKilgjYBXLAhrtpkFrP8GuNm45Ms3OsUTZnDVC25tdmOTjJtRezg
dx59yb1FMBJng5ZY1OCMrZMB8NPN+rQCTnwX//Mm+xQyjE2SiLBfahCLyvtHDHF8
mnd5ESVkI5BDL3Q8x4doiCZ5FZqg9Q==
=dheu
-----END PGP SIGNATURE-----

--GWZv1Nn8Ww4evgM0--
