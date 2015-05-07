From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: rt5645: add device tree support
Date: Thu, 7 May 2015 19:36:29 +0100
Message-ID: <20150507183629.GM22845@sirena.org.uk>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
 <1430833322-13531-3-git-send-email-bardliao@realtek.com>
 <1430837158.8043.61.camel@loki>
 <ABFD875FF5FB574BA706497D987D48D701067CC7@RTITMBSV03.realtek.com.tw>
 <20150507125142.GW15510@sirena.org.uk>
 <554BAED7.4080705@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4156928233298309438=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E537A265A08
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 20:36:39 +0200 (CEST)
In-Reply-To: <554BAED7.4080705@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4156928233298309438==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/VI5GRl9Ubh0uBiQ"
Content-Disposition: inline


--/VI5GRl9Ubh0uBiQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 01:28:39PM -0500, Pierre-Louis Bossart wrote:
> On 5/7/15 7:51 AM, Mark Brown wrote:

> >You shouldn't be using of_get_named_gpio() for DT stuff either, use
> >gpiod_get() which follows the usual pattern of taking a string which is
> >used to do the lookup with whatever firmware is in use.

> But to Bard's credit the use of_get_named_gpio() is pretty common - i see 18
> occurrences in soc/codecs alone, others will have the same problem...
> we talked internally (RafaelW, Darren Hart, LiamG and me) about reaching out
> to gpio and audio maintainers and aligning some sort of coordinated change
> to the gpiod framework w/ guidance to developers, did that thread start?

I'm not sure there's any particular need for coordination here, the APIs
are in place already - the gpiod_ APIs will already transparently look
up both ACPI and DT (see __gpiod_get_index() for the implementation) and
new drivers should really be using gpiod_ anyway regardless of trying to
do both ACPI and DT.

--/VI5GRl9Ubh0uBiQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS7CsAAoJECTWi3JdVIfQv2gH+wV8nLDq9ODflx8ZWUBQA/iO
9JA0SmtwuPOsctTVkJVlYr8hfkZLn2SqSvX0U9R37mwMlU764Gg6RaDHWQmc5oKc
RalYSPn0qbsOYV1SemIAr2W8e44P6wUl1Bex7oIJylFF6Op9AnPxMjeG4w8K2cwk
BAjRqLKp7yjWCjVJuRDcgqRvEQBa+tUGMmJYSpJz+421JZOmDTuvk802w6qvXCas
b7iJvac6+ViuieKIUYnNMDIIPzMA4aTSH+BAm57p+XUrwpvm9xX5U+0n9Kaa/TEJ
+pF1O01MOmgChVDCUN4vbSXhvWI2SA0WjM1nSK4VF3PkWjefSRtGeCHpidKvpCk=
=4T9h
-----END PGP SIGNATURE-----

--/VI5GRl9Ubh0uBiQ--

--===============4156928233298309438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4156928233298309438==--
