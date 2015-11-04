From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/6] ASoC: hdac-hdmi: Add hdmi driver
Date: Wed, 4 Nov 2015 14:48:45 +0000
Message-ID: <20151104144845.GK1717@sirena.org.uk>
References: <1445931737-30393-1-git-send-email-vinod.koul@intel.com>
 <1445931737-30393-3-git-send-email-vinod.koul@intel.com>
 <20151101030231.GB17819@sirena.org.uk>
 <20151102100642.GK21326@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3740987462390091495=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A58C260522
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:49:09 +0100 (CET)
In-Reply-To: <20151102100642.GK21326@localhost>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Yakir Yang <ykk@rock-chips.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3740987462390091495==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YQEH9CATo+4lan7A"
Content-Disposition: inline


--YQEH9CATo+4lan7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2015 at 03:36:42PM +0530, Vinod Koul wrote:
> On Sun, Nov 01, 2015 at 12:02:31PM +0900, Mark Brown wrote:
> > On Tue, Oct 27, 2015 at 04:42:13PM +0900, Vinod Koul wrote:

> > > +	if (err < 0)
> > > +		dev_err(&hdac->dev, "Failed to query pcm params for nid: %d\n", cvt->nid);

> > That looks like the NID is being printed as an error code.

> No this prints the NID for which query fails, but agree we should print the
> error code too, that might be very helpful :)

No, it's also the format for the message - normally we do "message:
code".

> > > +	/*
> > > +	 * Currently on board only 1 pin and 1 converter enabled for
> > > +	 * simplification, more will be added eventually
> > > +	 * So using fixed map for dai_id:pin:cvt
> > > +	 */
> > > +	return hdac_hdmi_init_dai_map(edev, &hdmi->dai_map[0], hdmi->pin_nid[0],
> > > +			hdmi->cvt_nid[0], 0);

> > I'm not entirely sure I understand what this is all doing.  It looks
> > like it's trying to translate the HDA widget map into a DAPM map which
> > seems sensible but it appears it's making some simplifying assumptions
> > about the device it's dealing with?

> The device is actually quite simple and yes we simplified even further by
> ignoring multiple pins for now. We will keep adding more features and adding
> stuff to map as we go along..

That's not giving me a clear picture of what the code is doing or how
we're working with the device - we've got some code parsing the HDA
graph, some code hard coding things and I don't really know why or how
anything fits together so I'm a bit nonplussed about what I'm reviewing
here.

--YQEH9CATo+4lan7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOhrMAAoJECTWi3JdVIfQ3Y0H/1ofQayQYY+jkZ5h3FZ/VHbZ
H6c1DrELmYpbeWtev0lhxGfAvM4blXszM5Kuy05mMnQRAheQ1fuhRkn+DMf0OiTr
Iu9gDavaxNqDS4kJYifPq1zDUpio8SWQkBU1UjWhv/oxuh8zu5mBV4XZRj46cAEg
Fc/xTKUrYEw8z+RDZLhdHeuQg0ZvGQAle/skHyZZfPxSPYEFgJX4WP5tFSEI7CEp
OmxwhtqYlNDzcw/gi6E4UxSacVnzQNHlt1yybUBgXEbSwx1YOsAPDJ9Sst2WBDY7
9szdYc+EOxmcjHGdxHPVLiB9JXaMFiYjpNwr9G9qozpfevMv1tLgS2ezVQYjtl4=
=Xf90
-----END PGP SIGNATURE-----

--YQEH9CATo+4lan7A--

--===============3740987462390091495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3740987462390091495==--
