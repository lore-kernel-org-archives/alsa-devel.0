Return-Path: <SRS0=/2j+=HM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD6C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 19:59:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC9464EE9
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 19:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC9464EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F381F16D2;
	Wed, 10 Feb 2021 20:58:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F381F16D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612987170;
	bh=uXsdHRudlt30/rf8TC5oPx2prLpjvAc0fxd+6KxQlyA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N90SJXferPMRYUDXT63xNtOP84ZTKmHOoK8OBkSgVYPyAS12jRZ55m1B6ZXqwtEgw
	 ygowBc098LAFpbzWdBamyUfVdGIcqFhsAUPSdwl5KYxDIySKcyR7EevdYqQpKn8kCU
	 k/vonpw4wIUX1HRREgsrsVJdBFhX5CE/Me5tAWvE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E907F80169;
	Wed, 10 Feb 2021 20:58:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22ED0F8022B; Wed, 10 Feb 2021 20:57:59 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81036F8010D
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 20:57:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81036F8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gYmVaXnz"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2AEF64EDC;
 Wed, 10 Feb 2021 19:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612987073;
 bh=uXsdHRudlt30/rf8TC5oPx2prLpjvAc0fxd+6KxQlyA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gYmVaXnzh3cXpUvmggxxro5R5JrS2isourfy6gOZLXt2tz9e66fABoZ5PmAwXRzQO
 5AYwh/WKCEr6LRWGFUT8i92gvs9m5JTR+XApJTqEtdDDIIItlY1hINGn7+GVVW2twP
 7hzYeiVekifb3OEH+6+wULT+E17R4jrK4OV2Jk2lq7xgfuEBscvEtpZSLUvtmmfSHc
 TPk6RpB/MyLFD6qYbdbjerhdJl8qN6KdNq+Fv+7ak2S3LUwzVbGCOjrQSTGN4MNz0u
 otacXcQg+s5XXxi40nzCK4ZU3mHOamdndISV4ZuKe7THMpbLYYjuDM8WtfkGh9zuIV
 E20+o+RIyFqhw==
Date: Wed, 10 Feb 2021 19:57:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
Message-ID: <20210210195700.GG4748@sirena.org.uk>
References: <20210204112502.88362-1-hdegoede@redhat.com>
 <ba9c1add-8ac0-766b-4577-1c2769c0e5e6@redhat.com>
 <20210209141420.GE4766@dell>
 <c0b4c612-7f60-5126-4c4d-b7085bd356d0@redhat.com>
 <20210209154511.GC220368@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <20210209154511.GC220368@dell>
X-Cookie: Are we live or on tape?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, alsa-devel@alsa-project.org,
 Chanwoo Choi <cw00.choi@samsung.com>, patches@opensource.cirrus.com,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>
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


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 09, 2021 at 03:45:11PM +0000, Lee Jones wrote:
> On Tue, 09 Feb 2021, Hans de Goede wrote:

> > The alternative is Mark doing a PR from ASoC to MFD to get 5/5 from the previous set
> > in MFD first, which seems less then ideal.

> Well this set isn't likely to go in this cycle anyway, so actually the
> problem should just go away.  Best to let the first set get sucked
> into v5.12, then send this one up subsequently for v5.13.

Yeah, that's probably easiest at this point.  the only other option that
looks viable would be to add the MFD and extcon parts to the branch you
already have, me to pull that in and then apply the ASoC bits in ASoC.

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAkOosACgkQJNaLcl1U
h9BVMQf+PDB5T4KOnJZ++lK/k50W3hv+2FbDKIYBpiYodByRhgKZ54s+NJ8u/HBi
SZiNYUR2j5uFjU1qIFVWLyHW+V+v790MXFB3j6ucarjXjeIp/2aPqfGRW6MwXnvL
IZqeVniPhIjVI5roUuMGZUjglbrRTfx0Sb3vXqO0CyhRHm/5tc7/jxBQ0+pbm361
f30bL2rQq4wXYh8R2Jdk5MpcE2k4gnQ4DmYdxczC/aW6ZpTEoZIsHMUNkiK+QGZ9
t0qmvvuXKkQaQeUvNxt0um3lfCZGxzoUeUrh4PdAB9gTZQikR5vjvnqs6COqQkG0
3Qvg83HX1BGiJjnuj+nzQv53C0njUQ==
=WffB
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
