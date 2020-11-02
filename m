Return-Path: <SRS0=b8gG=EI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6377CC00A89
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:42:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4F4223BD
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y8xKy3lH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdmctRcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4F4223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22A901700;
	Mon,  2 Nov 2020 16:41:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22A901700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604331734;
	bh=lGfpuWt896WyU2UnPY+Vx+xbwT1aF4vSkVfK4JElVKQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y8xKy3lHcy5jS47Or0TiqflbT3t+fYIbRt/FE73UcY9uTI2X2eLkmf9lrBnPYDbjz
	 Vg6vZ/fq30lgjyQbTjVPZFCOI1YZ15DocmFEGye8KfcpzhQ+6K7XmH5yCGgvM6uBOC
	 adSIlyjxj+Obec4y+7sC+tmIOtLQL6Y2eOpZzwBc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3AF6F80229;
	Mon,  2 Nov 2020 16:41:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6E89F80232; Mon,  2 Nov 2020 16:41:21 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49BD1F8012B
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2020 16:41:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49BD1F8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="sdmctRcp"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8DB3022275;
 Mon,  2 Nov 2020 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604331676;
 bh=lGfpuWt896WyU2UnPY+Vx+xbwT1aF4vSkVfK4JElVKQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sdmctRcpsr1PbMJPIbuIQ5mY1qaZ9dYaGVywlfd9JWJyIq9Ram510GyHCzDAwrPsm
 BhqcGH8CPOToPslD2SajMCBrsPVGokW2m+2/iS1bLmLe3c7+PZ9n8erHr3t/BlqKV7
 17FZOSf8td64kGQFDsD+tkMQbGnU4WLBWWYuQSVc=
Date: Mon, 2 Nov 2020 15:41:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt1015: add delay to fix pop noise from speaker
Message-ID: <20201102154107.GB5014@sirena.org.uk>
References: <20201102052840.21590-1-jack.yu@realtek.com>
 <d9e0f0af-ddce-788e-8f4d-ad1f828d48e8@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <d9e0f0af-ddce-788e-8f4d-ad1f828d48e8@linux.intel.com>
X-Cookie: I've only got 12 cards.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, kent_chen@realtek.com, kenny_chen@realtek.com,
 lgirdwood@gmail.com, tzungbi@google.com, derek.fang@realtek.com,
 shumingf@realtek.com, flove@realtek.com
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


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2020 at 08:45:33AM -0600, Pierre-Louis Bossart wrote:

> > +static void rt1015_parse_dt(struct rt1015_priv *rt1015, struct device *dev)
> > +{
> > +	device_property_read_u32(dev, "realtek,power-up-delay",
> > +		&rt1015->pdata.power_up_delay);
> > +}

> Don't you need a DT binding description? And use delay-ms maybe?

Yes, any new bindings need to be documented and things should have their
units as a suffix.

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+gKJIACgkQJNaLcl1U
h9ApDwf7BqC3QNY0aqEdO+hH2NHkYfB8Jm2VqvOsxdsqNxTK4tlLfUtGh3H+xyn/
GDj4CTZ2OnWaYTMhYXpw3u2ExTWr6MEtBHkJCZzq8Nl/81bNxN5YYitglq+B+5y4
XzW9bjGnnKBPC4guGOrq55t+xCnbSPkRPhpTFGzCuEpBrFtmULyCfKvvvpkmrN2o
BeZqy8kMNCrkbWmHFwRmmeFkI8yMFQld0zzgW9eN2TxLj1Fl9LHcwMJC4juUBmUz
rPRROD49msLxt4jnncLSfJ3sXvpIVGIy9UVNdK8Q0Nh7/ckrcaFQ6vQOEwS7jOlM
6aRz0odF+sfRVo9aAjrahOroBreJtw==
=4UT+
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
