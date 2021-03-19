Return-Path: <SRS0=UTIM=IR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88AAC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 13:31:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7DE64F4D
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 13:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7DE64F4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BB58167C;
	Fri, 19 Mar 2021 14:30:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BB58167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616160686;
	bh=rYpLM1dij1+YX1BYJDgYPhswQCx2UQnNiB8az7iBUDE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L7KK2s+eBfCSpNuMYPH1ZqzS1qRo/qDTMvOcUxaW1nnQaNW++i2Cr1KyT8GV8Fp9e
	 t0zrg4rm7mmzktXDAfnPhAQbTSDaX7bL8BLJ0ZbXGj5mNUmcb2Lzs1z+jxy0cpUWdU
	 mCUbCiaetKGNDtk0jpllv0707/pBPQPN42u9FJ2M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD03AF801F7;
	Fri, 19 Mar 2021 14:30:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28A90F8021C; Fri, 19 Mar 2021 14:30:31 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12BE6F800BB
 for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2021 14:30:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12BE6F800BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tHogu2SO"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7699264F8A;
 Fri, 19 Mar 2021 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616160615;
 bh=rYpLM1dij1+YX1BYJDgYPhswQCx2UQnNiB8az7iBUDE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tHogu2SOd+g1WuGf/k73WMEK8K68r4HKKgD9Nk76TxVr7R6JcPRXaHYILpVBFS0n1
 wEy9EFzunZxOZswfQ2GYABZ0+ggEVGkEuLflEgM1s1OUxjuEWtAqmwGoA9CHfKwQrt
 p1F6Uf9G8xUeqtUtZprXiFqJ4Tx49yX/4OmocBow1RhB/XVNn0NkuB0PTDVcrIKPhs
 HcBRrtGWUSwcY26oHRSKKkVymB7KjhtY+yXtzu6Yyk4v82A2KtEEBwYqhkPbWjkZ7p
 BrBOUowuf7ErwfDC5AykMiuDaNggZxARmxamunYLY6ff8HOimbXpHIVSSGpeyW4klj
 4zwt1Ib+QCnCQ==
Date: Fri, 19 Mar 2021 13:30:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v4 1/3] ASoC: Add Rockchip rk817 audio CODEC support
Message-ID: <20210319133010.GE5619@sirena.org.uk>
References: <SN6PR06MB534234153792718C0417BD52A5699@SN6PR06MB5342.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
In-Reply-To: <SN6PR06MB534234153792718C0417BD52A5699@SN6PR06MB5342.namprd06.prod.outlook.com>
X-Cookie: No purchase necessary.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com
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


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 18, 2021 at 05:19:34PM -0500, Chris Morgan wrote:

> The frequency of the MCLK (when it actually works) is 12MHz, though the
> Rockchip driver seems to want to run it at 12.288MHz and it works just fine
> as well.  When I move this clock to the main node for the MFD it starts running

12.288MHz would be a more normal audio clock, it's a nice multiple of
8kHz (though with a PLL it doesn't really matter unless the device on
the other end of the link is also clocking its audio stuff off it since
the PLL exists to transform the clock rate into one that's more useful).

> at 100MHz, and suffice to say it doesn't work right (high pitched sounds,
> screeching after the audio finishes playing until the hardware shuts down,

That's...  surprising.  :/  I can't think what'd cause that.

> etc.) According to the schematic of the implementation I'm working with (Odroid
> Go Advance) there is also an SCLK(SOC)/BCLK(PMIC) and an LRCLK. I assume these
> also run at ~12MHz since it seems they are tied to the parent clock rate in the
> clk-px30 driver, just as the MCLK is.  Likewise these also run at 100MHz when
> the clock is connected to the PMIC node directly instead of at the codec node
> level.

LRCLK should run at the sample rate, and BCLK at a rate fast enough to
clock out all the bits required for the data.  MCLK is usually faster
than those and intended to be a reference clock for them.

> > BTW looking at the driver there's a bunch of other registers so
> > shouldn't the regmap be done at the MFD level?

> I'm not sure honestly. If you think that's best I can figure out how. I'm
> trying to avoid a lot of changes to the mfd driver itself because the rk817
> is the only version of this that has a codec, all the other ones supported by
> this driver don't. Again though whatever you think is best I'll try to
> implement.

It's really what I'd expect, two regmaps for the same device is weird.
Looking at the MFD driver it seems to already have separate regmap
configs per device supported so it shouldn't be too intrusive, just more
detailed data for the device - the main difference is that you've
explicitly listed all the valid registers whereas the driver didn't
bother for anything so far.

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBUp2EACgkQJNaLcl1U
h9CrRwf/e8ucamUtZGdpC65W3gHGuRxZfHW4BaWwxhIw35tFP5REXT0eQpOnqMTn
myk+8yu+a04tb9/s2TzgMR9L3pi6lDdHYeGtiMOu/HvPpNTj7xQBT8ralIBY88lP
U7R28Z6naV1QLdxZz+9i9Psc5JH9hZAzSjwgR1YMM6HlHbmFgrSqye5Xs/nlUqrb
zZiVneO3AXjT0s4npg2MHl4QV1ktcu2F0tAhcGYCflJXn0EYlT0MszgTfkAjQKIk
6WsrdNCoWf0GGhFnKkUZtphcOoocPXwbRvSB/ak0NfUF2r2v0rfK4vFyM6WJid5B
m3GtrdHzbYyLG0/iJn9hmp24UfmVFw==
=IVLN
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
