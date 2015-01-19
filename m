From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/20] ASoC: rsnd: add Synchronous SRC and
 U/O error salvage support
Date: Mon, 19 Jan 2015 20:49:21 +0000
Message-ID: <20150119204921.GJ2809@sirena.org.uk>
References: <877fyh9ilx.wl%kuninori.morimoto.gx@renesas.com>
 <87h9wl7qlb.wl%kuninori.morimoto.gx@renesas.com>
 <20141230171032.GQ17800@sirena.org.uk>
 <874ms6rraj.wl%kuninori.morimoto.gx@renesas.com>
 <20150106183319.GS2634@sirena.org.uk>
 <87a91vp6s8.wl%kuninori.morimoto.gx@renesas.com>
 <54AEC20C.90706@linux.intel.com>
 <20150110113216.GC4160@sirena.org.uk>
 <87vbkap3n2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8428010059055460257=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A13C261528
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 21:49:30 +0100 (CET)
In-Reply-To: <87vbkap3n2.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Tim Cussins <timcussins@eml.cc>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8428010059055460257==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2fjX3cMESU3XgGmZ"
Content-Disposition: inline


--2fjX3cMESU3XgGmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 14, 2015 at 01:11:11AM +0000, Kuninori Morimoto wrote:

> I asked our use case to customer Team.
> According to them, they are using this rate converter in Digital TV.
> Digital TV is including its sampling rate, and exchanges it sometimes.
> Our SoC can exchange sampling rate in SRC, but other SoC needs
> external circuit (?)

> This means my 1st explain (= 48kHz can be 48001 or 47999) seems wrong.
> They doesn't care about real audio clock.

> And, this system (= Digital TV software) is implemented as middleware.
> So, this is Renesas specific feature, can't be big task (?)

OK, that's more what I thought this was originally.  It sounds like a
fairly standard ASRC deployment where the goal is to match the rate the
system wants to play audio at to the rate that the target hardware
needs.  That's not too different to the telephony cases where the system
is in one clock domain (possibly at a very different sample rate) and
the baseband another and definitely the sort of thing that DPCM is
intended to support.

This really would be better done with DPCM with the userspace control
being provided by the driver for the tuner or the machine driver and
passed through to set the rate of the back end.  Do you think that's
achieveable (even if it's just a mostly dummy DAI here)?  That way if
this is used in a system with a CODEC with a real driver on the end of
the link things should just work.

--2fjX3cMESU3XgGmZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUvW3QAAoJECTWi3JdVIfQ+SgIAIDgfkTEO5PjevFJrT2MthkE
pqYjUfiSDEaTPcAaIDBxyjqpRG4o1MzP4GYv8bzOhMGp99dEpwBIZVNucv22qYvz
ST5DPj5BLcjfE/jcOo/jB5roq/eWr+FCvA/BvKN+SUIv7HzVAQ7NmqSGeyma4c1V
Ouqj/9Ogr4OraN/nGbD7LJ+Qbe3HILZoKeEvrY6KMZUMjGKb1kFYFuy7RMGoll/Y
LiinglLCAS59ufVfSDkZ5KKUOWf9RVk+CTE5xAHTEMN4CkR8RlZXYSXPJPDh0LSe
d1ur2uMmtiJPqYSdKo68nOj1WBcAGOvdxViErLSKF74lBZ1MFgYW8BHJOGmz2NM=
=B6yq
-----END PGP SIGNATURE-----

--2fjX3cMESU3XgGmZ--

--===============8428010059055460257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8428010059055460257==--
