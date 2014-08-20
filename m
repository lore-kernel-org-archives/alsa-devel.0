From: Mark Brown <broonie@kernel.org>
Subject: Re: Audio mini conference 2014?
Date: Wed, 20 Aug 2014 12:03:14 -0500
Message-ID: <20140820170314.GE24407@sirena.org.uk>
References: <s5hbnropcvd.wl-tiwai@suse.de>
 <20140813165517.GB17528@sirena.org.uk>
 <20140817231021.GQ14537@sirena.org.uk>
 <s5hha1aw6we.wl-tiwai@suse.de> <20140819172948.GX13288@intel.com>
 <alpine.DEB.2.00.1408191451550.10517@phandrigan-desktop>
 <20140820042109.GY13288@intel.com> <s5hy4ujhfta.wl-tiwai@suse.de>
 <20140820070236.GC13288@intel.com> <s5hr40bhaz2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7684985065642987250=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4550426535E
 for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2014 20:58:27 +0200 (CEST)
In-Reply-To: <s5hr40bhaz2.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Tanu Kaskinen <tanu.kaskinen@linux.jf.intel.com>, Paul Handrigan <paul.handrigan@cirrus.com>, Daniel Mack <daniel@zonque.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============7684985065642987250==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L5xhH6lUAPIS347H"
Content-Disposition: inline


--L5xhH6lUAPIS347H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 20, 2014 at 09:33:05AM +0200, Takashi Iwai wrote:
> Vinod Koul wrote:

> > Configuration convergence:
> > >From the OS side, we have Desktop OSes relying on PA, Chrome using CRAS,
> > Android using flinger. With DSPs and tons of configuration it doesn't bode
> > well to have multiple configuration for same stuff for the sound cards. Can
> > we talk about unifying the configuration at least. Sure OSes will have their
> > own ways to use, but from ALSA can we standardize configurations which
> > can be reused across.

> I thought UCM was targeted to this, but not widely used as expected?

Right, the problems with alsa-lib licensing and the changes in the
configuration format have been a bit of a blocker - there are actually
some substantial deployments of the pre-merge configuration file format.

--L5xhH6lUAPIS347H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9NTPAAoJELSic+t+oim9qNMP/RF5PTAH/4yGksi6tvMW9loP
2zgQJcZ89QHgr1co+SfoRBBhuGhrhM6nw7+expY68r54DGcrHsysb7nntwEWDjry
e0dNtKhrebNktZp1vKaLZ/jmfUNhLtKPravdcjoMg6KWydvep9B8BcdPox90YSeS
zMeXTRVcHpcfoJOCSBfNiTlz9mc60oYoYZJclSRGuaawBO1Roxf0WFu/ardpVe8v
RJ9GFiVV5BlFAU2S/2jn6bNykhm25JGoFiWLCVyzdB7s2tiqLCAOSpg/CMFCmJKx
M8gZwKWxIm7kGYOI58aDYpZ6DPzYAQxPfSvmsvCRAesWMJkR6sMp/KUsJDRMp39h
FAMXanvSSJFI+kYvpbffPQFOHJwoJ2dnPYctQUNnV2ncW/yR+a2Sb8nhEYPj7HNj
qi8DZdHF/HtUMZawmr7ASsbjcf/cAdUSxdoExUaEAwQj/fdia0wG4MiDGEmFACKi
GwB2iq07XdG1nzEi/ASRX39q823uxOT/OGRogrg6I8ZtF8Ui9Vlgr0wbzy/OQlzf
lfNYmIXs4CGPHrPwunftgciCbPFbccTmaZe92p9OsL8UR9mDp3kQoZqYiIH5Uy6P
Jsfl4qEVR98mGg3ykQ2jpeDCCuDzLwydJjuobtntfdNLzYqNaAjFok+5JztCehcF
w6j7bR0unN7ez6IlI2e2
=sepo
-----END PGP SIGNATURE-----

--L5xhH6lUAPIS347H--

--===============7684985065642987250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7684985065642987250==--
