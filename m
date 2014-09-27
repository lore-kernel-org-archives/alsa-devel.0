From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 3/7] ASoC: Intel: mrfld: add DSP core
	controls
Date: Sat, 27 Sep 2014 12:13:33 +0100
Message-ID: <20140927111333.GH27755@sirena.org.uk>
References: <1411125368-5836-1-git-send-email-subhransu.s.prusty@intel.com>
 <1411125368-5836-4-git-send-email-subhransu.s.prusty@intel.com>
 <20140925150813.GU27755@sirena.org.uk>
 <20140925160853.GB1638@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4570807472827091894=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E607826044D
 for <alsa-devel@alsa-project.org>; Sat, 27 Sep 2014 13:13:57 +0200 (CEST)
In-Reply-To: <20140925160853.GB1638@intel.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4570807472827091894==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ov6R7U0hl+EAcYoD"
Content-Disposition: inline


--ov6R7U0hl+EAcYoD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 09:38:53PM +0530, Vinod Koul wrote:
> On Thu, Sep 25, 2014 at 04:08:13PM +0100, Mark Brown wrote:
> > On Fri, Sep 19, 2014 at 04:46:04PM +0530, Subhransu S. Prusty wrote:

> > > +       u8 *map =3D is_tx ? sst_ssp_channel_map : sst_ssp_slot_map;

> > So the "channel" map is for transmit and the "slot" map is for receive?
> > That naming doesn't seem at all obvious, I'd expect some confusion and
> > resulting bugs there. =20

> yes as multiple channels get interleaved to slot while transmitting and on
> recive side various lots get de-interleaved to channels :)
> These controls allow you to route stuff.

I can tell what they're supposed to do given the above code, what I'm
saying is that when I see the above code I'm expecting to find bugs
elsewhere since it's not going to be clear if you see either variable in
isolation.  Better naming please, for example use the direction.

> The DSP has the bitmap for interlever as explained in sst_send_slot_map()

> /*
>  * channel map value is a bitfield where each bit represents a slot
>  *
>  *                        76543210      # 0 =3D slot 0, 1 =3D slot 1
>  *
>  * e.g. codec1_0 tx map =3D 00000101b -> data from codec_out1_0 goes into=
 slot
>  * 0, 2
>  */

> so based on the channel selected here we will set the map and send to DSP.
> For none case we don't need to do anything. Yes this bit need this
> explanation so will add up

But why not - why is the effect of clearing all the bits to do nothing?

> > > +			 !strncmp(kctl->id.name, w->name, index)) {
> > > +			struct sst_enum *e =3D (void *)kctl->private_value;
> > > +
> > > +			e->w =3D w;
> > > +
> > > +		} else if (strstr(kctl->id.name, "deinterleaver") &&
> > > +			 !strncmp(kctl->id.name, w->name, index)) {
> > > +
> > > +			struct sst_enum *e =3D (void *)kctl->private_value;
> > > +
> > > +			e->w =3D w;
> > > +		}

> > Again no fallthrough case.

> would that be valid. We have only volume, params, mute, interlevaer and
> deinterleaver controls only :)
> Can add fall thru for therotical if you feel that is right thing to do.

Yes, it's better.  This is part of the whole thing about the code
setting off alarm bells - things look fragile and the missing error
checking does nothing to dispel that.

--ov6R7U0hl+EAcYoD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJpvcAAoJECTWi3JdVIfQRiQH/RRHtJoEzFQjhPPPx/0oh5A0
didMf+lXmjRvWBOq4P7ngnOjPTAyb58ztojrfH5H4qNDaqgFHxsgFzXdWo9HHA7I
EAp8XpaCouMxRCBp6ZH1wk9LCy4ya4k9/qtQwB7+MUCZPpt/UJbVwUmyFm5q8wmR
K9YU3k2kW1efCjE/OSifmReBzvTvTmyEoPTFZe6ligqDsBSUKNacCv25Vc1DfuZx
SH9p00UqoniaBtvS06p222PIL1UXoMhm+ivoXRJX2mwTUVdBIJ33GjTDjKAhYZTp
jKeELi6AlkNCuHBXgLpVKyJTZW2Z3IbNpcb9WpuXO28v21zoZfBzB+np1JUR+8A=
=KatU
-----END PGP SIGNATURE-----

--ov6R7U0hl+EAcYoD--

--===============4570807472827091894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4570807472827091894==--
