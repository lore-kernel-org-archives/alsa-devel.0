From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 3/4] ASoC: Intel - add makefile support
	for SKL driver
Date: Tue, 16 Jun 2015 11:52:04 +0100
Message-ID: <20150616105204.GH18309@sirena.org.uk>
References: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
 <1434040438-14535-4-git-send-email-vinod.koul@intel.com>
 <20150615155752.GV18309@sirena.org.uk>
 <s5hmw00gby8.wl-tiwai@suse.de>
 <20150615185405.GA18309@sirena.org.uk>
 <s5hmw00456h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8523011199389764522=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 572AA2651B4
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 12:52:16 +0200 (CEST)
In-Reply-To: <s5hmw00456h.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8523011199389764522==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4/KhLkEx1OUQso4T"
Content-Disposition: inline


--4/KhLkEx1OUQso4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2015 at 07:01:58AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > That doesn't sound like a compatibility thing though?  Compatibility
> > makes it sound like things will break rather than we'll just use too
> > much RAM.  Is there anything else going on?

> Before the parameter was introduced, the allocation was fixed to
> 64kB.  Thus if you really want to make the driver behaving compatible
> as before, it should be 64kB -- not only reducing the memory
> footprint, it also keeps the same behavior.

Sure, but given that this is per driver applications really ought to be
able to cope with random values.

> > I'm not against having configuration, I just want it to be configuration
> > that people can understand and it seems better to make the default be
> > that for PulseAudio given how much of the common case it is now.
> > Something like "make this smaller to reduce the default memory
> > footprint" for example.

> We have no consensus how much size should be given here; e.g. I myself
> am not so convinced by a merit of so big buffer allocation like 2MB.

That's fair enough, though we do have to pick a default and like I say
the text should reflect this.

--4/KhLkEx1OUQso4T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVf//SAAoJECTWi3JdVIfQ1soH/11G85HgMjUfuwdqqRtNM1mG
R2l0dRO6rYDJXsSI/mJaW0TkQI6+gbs0c8zZKyK/aAG3Y0veNQhW9ODPhdzl6F06
xk6S9z/3axUa6Q3XsyebEd8hTnioBZFfOmCxCeRNXF6h8lXX+6IgurscDgbK7mvy
ua39/Q3wQL3ipWtMo5Mo4p/kXL9ELQBVx1QOGzI7UfWprx4kHg4QRGcyDiIl00BC
T0HL9+jXjuR0G3TXNFoq8CieC6mAT735XaGdoEiVbMsH+aWCTHyWNHuQ0DZQ24jX
76Q7MIKxgrX+0O91dgPrhgzw6MCbdhyWA9tOIz4PHV9dVda89NkASgl1Y6sb+2Q=
=Kbf3
-----END PGP SIGNATURE-----

--4/KhLkEx1OUQso4T--

--===============8523011199389764522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8523011199389764522==--
