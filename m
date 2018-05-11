From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/19] ASoC: rt5640: Remove unused
	rt5640_platform_data
Date: Fri, 11 May 2018 11:16:31 +0900
Message-ID: <20180511021631.GF949@sirena.org.uk>
References: <20180508153604.23711-1-hdegoede@redhat.com>
 <20180508153604.23711-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4707610785445537436=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 58868267790
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 04:26:25 +0200 (CEST)
In-Reply-To: <20180508153604.23711-4-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4707610785445537436==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Content-Disposition: inline


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2018 at 05:35:48PM +0200, Hans de Goede wrote:

> There are no in tree users of platform-data for the rt5640 codec driver,
> so lets remove support for it.

Like we went through last time this is not a strong reason for removing
support for platform data, it's not a positive reason for removing
things when not everything uses DT or ACPI.

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr0/PwACgkQJNaLcl1U
h9AsBgf/ZagQNy7w8yguxkksKC081hZCnr2C2iUyC2SsvycvFFo17Gbi1QQQ8EFE
1GqfwbjcTTFoHNZTgM+D39trNhrYa17vjUT+pmJ8WeI+V8NrHx4i/XV42V0YZc8N
rewGUmQUf6unXUTpTXwh3jGlfT+WefHl0lx+PwHqiciDZwL/HcN9wT03JETd8rX9
hIJf2NpyPo1m7IHrjfdlN30QcrxpnEJxFeLE3aO7A9LvpyXWEY33GzeWgp8lkR4m
5ZlqWtRyjbtg0g4fAUIvPcw7Sn8HaASLA59hAMv91DVdVkUsXLX/oms8BcKz3dfq
9IRvELAhFQRZuPO4vRdQaN8l4JOSrw==
=eVH1
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--

--===============4707610785445537436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4707610785445537436==--
