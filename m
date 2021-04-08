Return-Path: <SRS0=iyFA=JF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5A4C433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 18:21:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69FFA61130
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 18:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FFA61130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4860F84D;
	Thu,  8 Apr 2021 20:21:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4860F84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617906111;
	bh=zUjpT5AnxnuO6JplTQOBN5CFaVK7rZwQtBatwkRomxs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S1XsrqwQIPb6S8vy6LqY6XFzBJPYSF4HS1Y1WT/lh2VU+r7cQ/G58EHvzKNfA95xZ
	 FsA+GBavdaXGyvCWtaT34q3xf8zbnDoc5o8RFchbWaOHUgV5Smaw8+oilSv0E5DbS0
	 DdQicRzRRp/nmycY8hfvvwBGYCGno3KWEORjA4oI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4D19F80169;
	Thu,  8 Apr 2021 20:21:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69E63F8020B; Thu,  8 Apr 2021 20:20:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F145CF800BD
 for <alsa-devel@alsa-project.org>; Thu,  8 Apr 2021 20:20:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F145CF800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Clx/D+vo"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8727A61108;
 Thu,  8 Apr 2021 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617906051;
 bh=zUjpT5AnxnuO6JplTQOBN5CFaVK7rZwQtBatwkRomxs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Clx/D+vozcjnj3iB6kb3G4C+7Zc8aOab+MeRSZolzbneR0vhP+k/QMvjGNCbnsLdv
 U9Kmrh0y69+Bp2kn0qyFM9Dwm6nJLbCg9+S0hvfmCZfWhuO7X4tXI+HQ/I3Y4l5duN
 e/igeDmWmJigBRVNLwDdkMS3pb2AwW3A3ukNAPjz2BUkXIS+Yvg2KT5vy35b/tFugb
 y6C3A2Yata6tIqQ8+c+ueeo5KeKLcPpFJ3wIUS4QPlL0a2c+Jkx1nOhhC16iRpr+lV
 N6r7nIQz8od30D4hLdcXDUqVl6YdrJpqA5Ne9Vq1I4SkYabNQXu9ThcA7KLyqE99YH
 l01OrYcHEkCZA==
Date: Thu, 8 Apr 2021 19:20:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: core - add more card sysfs entries
Message-ID: <20210408182033.GT4516@sirena.org.uk>
References: <20210408094314.1322802-1-perex@perex.cz>
 <20210408103819.GA40407@workstation> <s5h35w182a5.wl-tiwai@suse.de>
 <45acc908-3603-3479-9fb2-5206339a9ace@perex.cz>
 <20210408120502.GA4516@sirena.org.uk>
 <s5hpmz47w3i.wl-tiwai@suse.de>
 <56c874ae-e801-63df-19fa-a1325f6104ca@perex.cz>
 <20210408162250.GN4516@sirena.org.uk>
 <da26eb5e-aaa6-8170-1e75-c53c7bbcda60@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FJ0JV+AOCbvjFtNn"
Content-Disposition: inline
In-Reply-To: <da26eb5e-aaa6-8170-1e75-c53c7bbcda60@linux.intel.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>
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


--FJ0JV+AOCbvjFtNn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 08, 2021 at 11:50:08AM -0500, Pierre-Louis Bossart wrote:

> Even in the DT case, you may be able to set a specific path for DSP firmware
> and topology but would you really have enough information to describe what
> the DSP firmware and topology actually do? That information is part of the
> DSP firmware manifest and topology.

I'd have hoped that for information on firmware we'd be keying off
descriptive information included in the firmware/topology itself,
ideally the kernel would be able to do that itself.

> In addition, the firmware/topology are typically located on the file system,
> it'd be a hassle to have to edit DT properties every time you have a new
> distribution update, wouldn't it?

You definitely shouldn't be doing that, but I'd also not expect us to
have to update anything that isn't the firmware itself.

--FJ0JV+AOCbvjFtNn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBvSXAACgkQJNaLcl1U
h9DYlwf+OhNxjgX/yn8VDiZuC0tIJadMo7AiP6yHaE0eTHvx/4Ki7Sef7vXEDpya
SvsexM41WqC9rKFsY+0GUtrazyYrzxzJMuUSuU4LQgRnGxnDFB9qeYsaVvPwIO4B
82CgWs+zkHLLpZ/d7zlOb4f3ZXVfwge9HIb/C5Y9HnHlKHiwx9CBzoruKmzUYqFW
hTaLJqm2BLlSmyOC7JUPbr8aFVHbK6VqlZDjmJjp6RQNMABMgjWCaay/m9TfTFSI
7C2UQkizSjUv/7XDOfgKA+8IBXP1shh+LUYacE+iMilMSiNdroqe2wm344u1RBA0
NwPxDQPCIVujsEcOc/pcb0TvOacekw==
=nElm
-----END PGP SIGNATURE-----

--FJ0JV+AOCbvjFtNn--
