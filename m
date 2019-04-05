From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/3] ASoC: core: do not unload topology
 in unregister_component()
Date: Fri, 5 Apr 2019 09:36:43 +0700
Message-ID: <20190405023643.GD2803@sirena.org.uk>
References: <20190405003040.8709-1-ranjani.sridharan@linux.intel.com>
 <20190405003040.8709-2-ranjani.sridharan@linux.intel.com>
 <20190405021729.GB2803@sirena.org.uk>
 <c99769e7a08a7402add146e27ee7dc191b119232.camel@linux.intel.com>
 <20190405022821.GC2803@sirena.org.uk>
 <858c15b872265c0031c27164fb1cb5466a73a12a.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7092683094833792900=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00D51F80792
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 04:36:49 +0200 (CEST)
In-Reply-To: <858c15b872265c0031c27164fb1cb5466a73a12a.camel@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============7092683094833792900==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2019 at 07:33:33PM -0700, Ranjani Sridharan wrote:

> But I really need some feedback from you on the third patch. I think
> that's the most invasive and I'm not sure about how to go about
> removing the topology before the snd_card is freed without removing
> the link components while unbinding the card.

It seemed reasonable enough, I've applied it.

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlymvzoACgkQJNaLcl1U
h9ASIwf/VxHNFE3I4rplsIIj8RWyxtINDAC5gIC/iEV7QSLy2Ot2K+SOdPCmzs36
XI0pws0LpyI17NDXdc+lcOAwaeHsscHq0gzw4P3lXSrE1qLoaVwSAOaEUhwDAXb6
zzXyDyVgIUaNcpqxYiaFjijveHxPZmGoVQINR87dWGKjHLE6rU30lTS6LBezMKm0
A5Ujef/FreCk7llpAXc+O5OgOxKgpfHNB1eT+OlyKA7Sbubc16J37bsFkXn8yT1T
5WMJAe3cBv2xyL4yT2fHhcf7HezC+GKZcE+xOwNdm940IPSqqLLHgfOHxlH2NulK
s76luJbxmYJhc4oO5lHSk4hMQT+FJw==
=EMC+
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--

--===============7092683094833792900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7092683094833792900==--
