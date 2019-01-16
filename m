From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/14] ALSA: pci: Remove superfluous
 snd_pcm_suspend*() calls
Date: Wed, 16 Jan 2019 16:32:07 +0000
Message-ID: <20190116163207.GC7186@sirena.org.uk>
References: <20190115162155.6308-1-tiwai@suse.de>
 <20190115162155.6308-6-tiwai@suse.de>
 <f675ffaa-9966-a05b-7915-a4a16eefbfcb@linux.intel.com>
 <s5hpnsx26tc.wl-tiwai@suse.de> <s5hh8e9fyam.wl-tiwai@suse.de>
 <20190116155027.GB7186@sirena.org.uk>
 <s5h8szkzjje.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8819500542811523885=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 697332666B3
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2019 17:32:19 +0100 (CET)
In-Reply-To: <s5h8szkzjje.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============8819500542811523885==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 16, 2019 at 04:52:53PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > AFAICT it's just making sure that they're available ASAP so they look
> > always on to the rest of the system.

> Well, but PM prepare is called before PM suspend call.  And the whole
> ASoC suspend procedure (including PCM suspend, etc) is performed in
> the PM suspend callback; i.e. we stop sysclk before doing anything
> else...

Ah, got it the wrong way round...  in that case I frankly have no idea
and would expect it to break if we suspend with active audio - it's
possibly a bug.

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw/XIcACgkQJNaLcl1U
h9AXUgf+O7vMw53WFp6e3lNPG6GxdQVh+frIqZRoHcVsDezN5GiDXVfhrh9tvdhQ
YRhcMSod8DlehftDt+BHF9aVUzJkaKC769muMufyDQlgMeA2YY+odjkd9GnF9Ig9
9b5ZrRS3P/6XajeCmCis4za6FIYdVgen01x0MQ/Drzi22ESWP/Mli7cIWNCIgkLa
GPIm6iuob+2YcvjwaTZGR54ZyYypGc1FuNFUuPnHpblbyWnDKnzYS0bDKTuUE8gt
NRzIt/sDOC0u2hTb4S0H18q3BzZc3bdVpgTeQ++GHTmcXCdQrSAgysNzACQfGMcS
wUgR772CThTu52tp7ctMnH8pZm/dkw==
=2kUE
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--

--===============8819500542811523885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8819500542811523885==--
