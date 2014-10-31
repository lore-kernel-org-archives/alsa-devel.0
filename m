From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Use specific r/w function
	for DSP mode
Date: Fri, 31 Oct 2014 17:52:26 +0000
Message-ID: <20141031175226.GN18557@sirena.org.uk>
References: <1414378351-2329-1-git-send-email-oder_chiou@realtek.com>
 <20141028222915.GG18557@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694F30527@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7220331625330519868=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B854E2606D9
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 18:53:00 +0100 (CET)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694F30527@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@google.com" <benzh@google.com>, "anatol@google.com" <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7220331625330519868==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FEdm0XgjV/iYH2EC"
Content-Disposition: inline


--FEdm0XgjV/iYH2EC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2014 at 01:44:57AM +0000, Oder Chiou wrote:

> > This looks like standard regmap stuff - what's different?

> They are not different with regmap stuff, but they are called by
> rt5677_dsp_mode_i2c_write_addr(), rt5677_dsp_mode_i2c_read_addr(),
> rt5677_read() and rt5677_write().

> The customize access function is implemented by rt5677_read() and
> rt5677_write() that are assigned to regmap_config "rt5677_regmap" for using
> between codec mode or DSP mode.

Sorry, I'm not quite following what you're saying here - if you're
saying that they're slightly different to the main register map I/O for
this device then it's OK to create two regmaps and only access the DSP
one through separate functions.

--FEdm0XgjV/iYH2EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU8xaAAoJECTWi3JdVIfQplwH/0PuVUmTxHe15+kVEK8bzFsR
D+k2Yr5dxBkU+VloLSQ8Hxf/px5N83XLunqp0VsJl8/YQp5erbVkXhyI+Q4L92xA
cQ4HD2Iap3EVX4nWzuVnBNWT8OSeRyRFi5spiVv54GAeLcX5FaAtw+MJQ/3nih2R
TavG4wucwrCQfn0rAaywOA8JCBWHincjxK8/TTRBWrA793SUZ+/g0hxG/pGqvcrh
Ne3mdHWOJMH/B9JWkU2j6HMWF6WCJdT/f9xGAG7jdT4ZzF5GbR5pU7alZMIT4tyL
w2mmveFp6i1X9k1ihDDBjdsUGN0f3hZeUIbuNqYpY21+PfR1LkfWTwu/LbULwOk=
=hE+Q
-----END PGP SIGNATURE-----

--FEdm0XgjV/iYH2EC--

--===============7220331625330519868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7220331625330519868==--
