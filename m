From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/6] ASoC: Intel: add BYTCR machine
	driver with RT5640
Date: Mon, 10 Nov 2014 10:03:29 +0000
Message-ID: <20141110100329.GH3815@sirena.org.uk>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-6-git-send-email-vinod.koul@intel.com>
 <20141106124854.GC8509@sirena.org.uk>
 <20141106131141.GD1870@intel.com>
 <20141106134559.GJ8509@sirena.org.uk>
 <20141110062056.GC18555@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5386982438794662233=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8318A260550
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 11:04:58 +0100 (CET)
In-Reply-To: <20141110062056.GC18555@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5386982438794662233==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FPT3HoKoCv7j0oWb"
Content-Disposition: inline


--FPT3HoKoCv7j0oWb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 11:50:56AM +0530, Vinod Koul wrote:
> On Thu, Nov 06, 2014 at 01:46:00PM +0000, Mark Brown wrote:

> > That doesn't sound right - this would affect almost all systems.
> > Deferred probe should ensure that the machine driver can't load until
> > after all the component devices (including the CODEC driver) are
> > instantiated and we should be suspending in the reverse order that we
> > probe the devices.

> Yes defer probe is the right solution here. But in machine driver loading
> how does it ensure that codec and platform are already loaded, should the
> sound card registration be treated as failure and deferred?

Yes, the sound card registration will give you an -EPROBE_DEFER if one
of the components isn't registered.

--FPT3HoKoCv7j0oWb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYI1xAAoJECTWi3JdVIfQyWMH/j08TYpTejK1jC8TB3c38Fhv
62mzT8IDM7sRu92ks9Sbvm1svTAtgGBQNJ8IxycVy+CZUFZagl9m/90vYHk2bp8Q
TfcxXIsvNLthgFTLibGZfGp4TgD+AZNZhfMZCKeW5FRt/EV9p4Dmp13Z1Mplm3bG
omKfmAYACMyxCX3BlZlez0VLTdEylB8GqWH6w9VD6C3Wm0AuJ4Dt1uzGANGOQIQu
jCm54a45b1zGdpwi+NGwndz9o3xYIA/gINwOL1180YKfiGheU1TMeC64dVcxSIjI
EmDxXmP4lFgAX92TD3L2CokzrfIYs4CrCTy1pU2qjPgGOegRb6gTLS4tJyaaTek=
=OqI5
-----END PGP SIGNATURE-----

--FPT3HoKoCv7j0oWb--

--===============5386982438794662233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5386982438794662233==--
