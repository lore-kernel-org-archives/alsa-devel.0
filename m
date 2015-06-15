From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 3/4] ASoC: Intel - add makefile support
	for SKL driver
Date: Mon, 15 Jun 2015 19:54:05 +0100
Message-ID: <20150615185405.GA18309@sirena.org.uk>
References: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
 <1434040438-14535-4-git-send-email-vinod.koul@intel.com>
 <20150615155752.GV18309@sirena.org.uk>
 <s5hmw00gby8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7629534666960705769=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79AAA265756
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 20:54:18 +0200 (CEST)
In-Reply-To: <s5hmw00gby8.wl-tiwai@suse.de>
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


--===============7629534666960705769==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wRyyN4gAPkNkeCwp"
Content-Disposition: inline


--wRyyN4gAPkNkeCwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2015 at 06:42:39PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Thu, Jun 11, 2015 at 10:03:57PM +0530, Vinod Koul wrote:

> > > +	  HD-audio driver.  A larger buffer (e.g. 2048) is preferred
> > > +	  for systems using PulseAudio.  The default 64 is chosen just
> > > +	  for compatibility reasons.

> > What are those compatibility reasons - why should users have to worry
> > about this?

> ... if a user wants to reduce the memory foot print.
> 2MB buffers for each stream are significant size, supposing that it
> can have 16 streams.

That doesn't sound like a compatibility thing though?  Compatibility
makes it sound like things will break rather than we'll just use too
much RAM.  Is there anything else going on?

> > Should this be a module parameter or something?

> The buffers can be reallocated dynamically via procfs in general, but
> it's not practical and intuitive.  That's why the similar option was
> provided for HDA legacy driver.  It was the time when PA started
> accepted slowly.  I don't know whether it makes sense for SKL ASoC
> driver, though -- it's up to you guys.

I'm not against having configuration, I just want it to be configuration
that people can understand and it seems better to make the default be
that for PulseAudio given how much of the common case it is now.
Something like "make this smaller to reduce the default memory
footprint" for example.

--wRyyN4gAPkNkeCwp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfx9NAAoJECTWi3JdVIfQ2l0H/jfPnHk+JOowuzCSTYg32Exk
klOshg1KdKNQUlsYPdfDAjq+AW0H8H5Tgp7JWyPAnmpImQuJF2Mp0eb9mvoyxeWz
qAgxj0T95iHjM6NtxmXtXAHgUWevhRuoX9wzB+q0bG6D6zXao/JKbibPzhl44sYP
u+YnpESAQwTmCCzPBh7hhnkQZQ6EKg0aMl9tpKmvh3fM95FvrZxlfGz/LHPpUOi0
A5cwnjRmHA4a51vg3Xh33/r/Vxb1x8ez37wJTexAqlmzkD8wKt0wr9y3/L6AFpUB
65atr86uMuhkdMuxjN/DHK0ygFza8sQ4nZP5gctTv8SttC4NKmWWLRLYdifhufE=
=vSQm
-----END PGP SIGNATURE-----

--wRyyN4gAPkNkeCwp--

--===============7629534666960705769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7629534666960705769==--
