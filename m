From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: Intel: Skylake: Add functions
 for DSP module configuration
Date: Wed, 29 Jul 2015 18:56:31 +0100
Message-ID: <20150729175631.GK11162@sirena.org.uk>
References: <1437503040-7392-4-git-send-email-vinod.koul@intel.com>
 <20150729123323.GC20130@sirena.org.uk>
 <20150729165029.GG29916@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9077429809427083730=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F6012605E4
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 19:56:39 +0200 (CEST)
In-Reply-To: <20150729165029.GG29916@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============9077429809427083730==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Sk6zGo8BBXAtkcRm"
Content-Disposition: inline


--Sk6zGo8BBXAtkcRm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 29, 2015 at 10:20:29PM +0530, Vinod Koul wrote:
> On Wed, Jul 29, 2015 at 01:33:23PM +0100, Mark Brown wrote:

> > > +static int skl_alloc_queue(struct skl_module_pin *mpin,
> > > +			struct skl_module_inst_id id, int max)
> > > +{
> > > +	struct skl_module_pin m_pin = skl_get_queue(mpin, id, max);
> > > +
> > > +	if (m_pin.pin_index < 0)
> > > +		return -EINVAL;
> > > +
> > > +	if (m_pin.is_dynamic) {
> > > +			m_pin.in_use = true;
> > > +			m_pin.id.module_id = id.module_id;
> > > +			m_pin.id.instance_id = id.instance_id;
> > > +	}

> > Double indentation here.  It's really unclear to me why a static pin
> > doesn't need to get merked as in use?

> Oops, will fix

> In static pin case, the pins come from topology binary where these are fixed
> for a configuration, so don't need to be allocated thus marked and hence
> freed.

But isn't this also protecting against attempts to use the resource
multiple times within the configuration (or shouldn't we be doing that)?

Please bear in mind that this stuff has basically zero documentation or
explanation so I'm kind of guessing as to what this is supposed to do.

--Sk6zGo8BBXAtkcRm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVuRPOAAoJECTWi3JdVIfQstEH/3Gntnrc5Sp/5PnXpKBCIuC7
cGsIFRBM9U4BB2wpjLwhRSmnKfHHFzo2F1gW1kKLL8aRc18eM3uqf6Ttv5YUNL2/
BkkIJy7kMJX07IbzydUWVpdhv+eLtIqQpQsTSyzsGzPHyugafjG4OMqup3Zhe7yR
WMn9L8MmhEQyes6fLRB8aRQ2dW7Fi79KAf5//f4zmih8XvPGvO9O27CEI2UemCO3
gSpthdB+Gt38WiMDV91SJcUJ8qYUAXMzA3YmuI4hHO/spW8t/2V/1XhFbl+IBP7+
LGsaBaTol00Wh2uyQEK2w4tyBYpCj+Jc1JgGDXx7A4Hk8Qtz5urSgCWXKseB6fw=
=qPbc
-----END PGP SIGNATURE-----

--Sk6zGo8BBXAtkcRm--

--===============9077429809427083730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9077429809427083730==--
