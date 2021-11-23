Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF29C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Nov 2021 07:14:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F3021771;
	Wed, 24 Nov 2021 08:13:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F3021771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637738032;
	bh=E+dBwomnzyWKIhT2whg5UaMBKOluRqPTO6X6XW8z7mo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q9MDhPxKSU9BeQn9WdT0UQR/t7k305j8paB5sAEhzqLzUqHDfYrNWVxfD/Ikt+1Bt
	 gj+2lENzhsejt3tZ1a7rvQzcZ2Dz+G1awAJq/ZcK5pT7AiFK0tiJ9rlXGwIlbOZtIP
	 IRme9iSUYxsEtQUFr/+PbCFPIp8l402KDTYJkXLY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 106BAF805B2;
	Wed, 24 Nov 2021 08:06:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B8ABF8049E; Tue, 23 Nov 2021 18:16:10 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6525F80154
 for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2021 18:15:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6525F80154
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="EQ0v6Pbh"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EF0660F6F;
 Tue, 23 Nov 2021 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637687756;
 bh=E+dBwomnzyWKIhT2whg5UaMBKOluRqPTO6X6XW8z7mo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EQ0v6PbhOwWl3NzftqVi/qVreHqLCe2Upzbc8LBBCLaqvAkfHvWaeaVYcG86soJDv
 waw5UnGNjUSVqWsFKSQ4RgKVHNW1GPPpGbP2HHTpP5iDxt1QrGWgz066mZIoyV7Ygd
 yuTl1w/2oU0xFoqDSQD4gnbf59mZyzSz0JT68ieCwb6T8hR0OM/u+Of9Upt8WfgMcW
 LpC7MduSgPBiujgcd51rS4INUZgwPj0w4VG1exRe1u7juh9v3ciVenmZH7qPV9VooU
 fLWRB1p/gJqMuZ6E4G0stRXL7+uevtMly5WlKSz+dAQRMmPPwMK5DFXJdHAX4aE8tB
 DKOhO8PbkFq6A==
Date: Tue, 23 Nov 2021 17:15:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH 10/11] hda: cs35l41: Add support for CS35L41 in HDA systems
Message-ID: <YZ0hxCcP5h1eU63A@sirena.org.uk>
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-11-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KmAEv/XYU5I1OTsL"
Content-Disposition: inline
In-Reply-To: <20211123163149.1530535-11-tanureal@opensource.cirrus.com>
X-Cookie: A closed mouth gathers no foot.
X-Mailman-Approved-At: Wed, 24 Nov 2021 08:05:53 +0100
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Elia Devito <eliadevito@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 alsa-devel@alsa-project.org, Werner Sembach <wse@tuxedocomputers.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Shuming Fan <shumingf@realtek.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
 Jeremy Szu <jeremy.szu@canonical.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
 Sami Loone <sami@loone.fi>, Len Brown <lenb@kernel.org>,
 platform-driver-x86@vger.kernel.org, Chris Chiu <chris.chiu@canonical.com>,
 Arnd Bergmann <arnd@arndb.de>, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Cameron Berkenpas <cam@neo-zeon.de>,
 Jack Yu <jack.yu@realtek.com>, Kailang Yang <kailang@realtek.com>,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, David Rhodes <david.rhodes@cirrus.com>
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


--KmAEv/XYU5I1OTsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 23, 2021 at 04:31:48PM +0000, Lucas Tanure wrote:

>  S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/cirrus,cs*
> +F:	sound/pci/hda/cs35l41*
>  F:	sound/soc/codecs/cs*

Perhaps just match anything starting with cs rather than just this part
number rather than needing to churn in future?

BTW I notice that the CC list for this series is *huge* and it's hard to
see why some of the people on CC are included - please think carefully
about who you're sending things to and why.  People get a lot of mail
but there's no need to add to the flood, it makes it more likely that
things that are important will end up getting missed.

--KmAEv/XYU5I1OTsL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGdIcMACgkQJNaLcl1U
h9D3OAf/Z1nxuLACsgmmsSOKL+iZyyHgNx1SqNSpwS2Absxs1WIEk8peLn5AM24+
9Tj7Yv5qhscn5ogvyquAVxMTbhs/VI4eqsy9z37/cfiHZozMQPz2lxobwxIztyqy
yLf2YLnHIlenI9gqvj3Ixi7wCm9U7agT/UOhwNWd9IRQDBUSTgjl53owul0Rt0Fv
uS8EI9cvmZEIyH8vcpA5gWnICVEbq/cBzPkoOvvWwkI4qd2JeAK8s1jO/0Q3vzs9
X8qgHigt1fLG4768Q4InEvkB8WWBBQ214xT+r4lenjcSqY9KfQwYBxYImuWXZSUZ
p4EnMrqi1jXMhnPbP46pP/ruPueQ5Q==
=6Fhl
-----END PGP SIGNATURE-----

--KmAEv/XYU5I1OTsL--
