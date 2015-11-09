From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 2/6] ASoC: hdac-hdmi: Add hdmi driver
Date: Mon, 9 Nov 2015 10:09:20 +0530
Message-ID: <20151109043919.GC22709@localhost>
References: <1445931737-30393-1-git-send-email-vinod.koul@intel.com>
 <1445931737-30393-3-git-send-email-vinod.koul@intel.com>
 <20151101030231.GB17819@sirena.org.uk>
 <20151102100642.GK21326@localhost>
 <20151104144845.GK1717@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7488266501864022562=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C5699260715
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 05:35:46 +0100 (CET)
In-Reply-To: <20151104144845.GK1717@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Yakir Yang <ykk@rock-chips.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7488266501864022562==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2015 at 02:48:45PM +0000, Mark Brown wrote:
> > > > +	/*
> > > > +	 * Currently on board only 1 pin and 1 converter enabled for
> > > > +	 * simplification, more will be added eventually
> > > > +	 * So using fixed map for dai_id:pin:cvt
> > > > +	 */
> > > > +	return hdac_hdmi_init_dai_map(edev, &hdmi->dai_map[0], hdmi->pin_=
nid[0],
> > > > +			hdmi->cvt_nid[0], 0);
>=20
> > > I'm not entirely sure I understand what this is all doing.  It looks
> > > like it's trying to translate the HDA widget map into a DAPM map which
> > > seems sensible but it appears it's making some simplifying assumptions
> > > about the device it's dealing with?
>=20
> > The device is actually quite simple and yes we simplified even further =
by
> > ignoring multiple pins for now. We will keep adding more features and a=
dding
> > stuff to map as we go along..
>=20
> That's not giving me a clear picture of what the code is doing or how
> we're working with the device - we've got some code parsing the HDA
> graph, some code hard coding things and I don't really know why or how
> anything fits together so I'm a bit nonplussed about what I'm reviewing
> here.

Sorry for late reply, somehow seemed to miss this earlier..

Here is the complete picture let me know if things are not clear

This code has below structure (from the specs).

			Root Node (0)
			     |
			   AFG  (1)
			     |
	Converter (2) ----------------	Pin Widget (5)
			     |
	Converter (3) ----------------	Pin Widget (6)
			     |
	Converter (4) ----------------	Pin Widget (7)
			     |
			Vendor Widget (8)

Numbers in braces indicated NID values for these nodes

Currently we are using only one pin which is used on our ref board and seems
to be default config.
After the base driver is done we will add code to enumerate all the nodes.
Based on node capability we will parse and add widgets for all the queried
nodes. So for this case will be 3 nodes and 3 widgets created

Since coding for each widget would not make sense so we created a generic
function hdac_hdmi_init_dai_map() based on the node passed which we will use
later for all the queried pins

Thanks
--=20
~Vinod

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWQCN3AAoJEHwUBw8lI4NH8/8P/ix8Yyuj94JSFh6jaK635pMs
iMfv46Pvx9KAIsBXa1IW/T/2KpLsZrQctlMpmHZGAyjkP5wGy2YBfjrroWDb0MBK
5473+vpOoLVr10Z5OaIWIH0+GILVX2tlDR8bxC2o3gsy6/j/OmDQ2ZIeqnNHqpFG
uvZUZsi9gMxzoumso+IkuEtKvKpg6KxKhParxaSQyRI50L5mU+lNKShz+EWZJvJZ
qA5+q6KGdBwlfLwVdxJwtj7BTqpHLf8x2CAnijD0H99JkJyEXcQvQ6kY8PE3VIcj
CphCO+8U9UWBBu5R7KxBaETStNlrX90MjlY0lUGsyVhiI0Kdxo1BwQx5jNvUi7jO
lFzQDSq/ehLKIhVFMnPYAT2rKd9ecHP8ZQjPbPnsagN0AIxDXIJbNo5wZEyv5xuq
+J0yaJ1vTahYce/OzZgj3We5MEG4XHaM+8MUWsGBiUkOSF5PPmtDdHHqb5boFN5h
DkLHn7wIeBkVQqJOM/i+Gvmp9R65oWlNPiWbWn8gIYt9wVPxGYG9ktHevg1EohoZ
r0FprzelJzw6J8qJn5Fb9cZIkxpK3h00kuP8gv/NK3RuG4Ud6tva9TgX7BKXBuiI
ayO5c7Th2MIB6Ul6VCOFViNTJlijqyQzRWETcxjtqC3ZPuibseFvoYpTgOzNq/eb
cPMZsKWNospR5tg3fWBv
=dlCA
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

--===============7488266501864022562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7488266501864022562==--
