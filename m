From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/6] ASoC: Intel: Add helper to poll
 register for DSP status
Date: Thu, 9 Jul 2015 11:48:55 +0100
Message-ID: <20150709104855.GJ11162@sirena.org.uk>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
 <1435919647-14049-2-git-send-email-vinod.koul@intel.com>
 <20150708183621.GZ11162@sirena.org.uk>
 <20150709042741.GF836@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6641156424181063730=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 95E76261498
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 12:49:06 +0200 (CEST)
In-Reply-To: <20150709042741.GF836@localhost>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, "Kp, Jeeja" <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6641156424181063730==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0OkqknLvuh6i3jtt"
Content-Disposition: inline


--0OkqknLvuh6i3jtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2015 at 09:57:41AM +0530, Vinod Koul wrote:
> On Wed, Jul 08, 2015 at 07:36:21PM +0100, Mark Brown wrote:

> > > +	for (time = 0; time < timeout; time++) {
> > > +		if ((sst_dsp_shim_read_unlocked(ctx, offset) & mask) == expected_value)
> > > +			break;
> > > +
> > > +		mdelay(1);
> > > +	}

> > mdelay() not msleep()?  If we're waiting for multiple miliseconds that
> > could be lots of busy waiting.

> Usually this should get reflected in 1st iteration as the register update
> would get updated farrily quickly. msleep will add up lots of latency to
> this.

A common approach for that is to do a busy wait for say the first
milisecond (perhaps polling more often too) and then fall back to
something sleepy if things are slow.

--0OkqknLvuh6i3jtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnlGXAAoJECTWi3JdVIfQs9kH/0FWIjSCymTX4Qha46ufYAir
S7zFVG+OlVByCfEGZP9i8PgscRvKBU7gQw0f0Gcj7nk3rAxbWrHo9YX+dQWwOZFS
SM7NijGRjeAN/3hs4qxSWJQlRV+63QbkvoEi3AtPdWXkXQ9TwFVUgc1E56hGtQkM
3Adp6cMcA8u7yuBk2Zg1K7rksbUVZE2BNKU0UuVmrZ/wgLYHASt8xdlhVOkC+OFb
Brdm3U5SJyJvhJIkyxHU6Xa/P6RsuePr+mJqL7WQvPj1YK/8eWNM7Wr5yn39w+C+
KSzX9xWFdv7yVXENfTJFFx6k07F8gyffXjyJ6K+aqbI/536K42+B0mX4OaqjICg=
=oad0
-----END PGP SIGNATURE-----

--0OkqknLvuh6i3jtt--

--===============6641156424181063730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6641156424181063730==--
