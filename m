From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 3/7] ASoC: Intel: mrfld: add DSP core
	controls
Date: Mon, 29 Sep 2014 11:30:09 +0530
Message-ID: <20140929060008.GM1638@intel.com>
References: <1411125368-5836-1-git-send-email-subhransu.s.prusty@intel.com>
 <1411125368-5836-4-git-send-email-subhransu.s.prusty@intel.com>
 <20140925150813.GU27755@sirena.org.uk>
 <20140925160853.GB1638@intel.com>
 <20140927111333.GH27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5311277383062848929=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 45D4E26058B
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 08:30:04 +0200 (CEST)
In-Reply-To: <20140927111333.GH27755@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5311277383062848929==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Content-Disposition: inline


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2014 at 12:13:33PM +0100, Mark Brown wrote:
> On Thu, Sep 25, 2014 at 09:38:53PM +0530, Vinod Koul wrote:
> > On Thu, Sep 25, 2014 at 04:08:13PM +0100, Mark Brown wrote:
> > > On Fri, Sep 19, 2014 at 04:46:04PM +0530, Subhransu S. Prusty wrote:
>=20
> > > > +       u8 *map =3D is_tx ? sst_ssp_channel_map : sst_ssp_slot_map;
>=20
> > > So the "channel" map is for transmit and the "slot" map is for receiv=
e?
> > > That naming doesn't seem at all obvious, I'd expect some confusion and
> > > resulting bugs there. =20
>=20
> > yes as multiple channels get interleaved to slot while transmitting and=
 on
> > recive side various lots get de-interleaved to channels :)
> > These controls allow you to route stuff.
>=20
> I can tell what they're supposed to do given the above code, what I'm
> saying is that when I see the above code I'm expecting to find bugs
> elsewhere since it's not going to be clear if you see either variable in
> isolation.  Better naming please, for example use the direction.
Sure will add tx and rx to the control names to make it explict. Thanks for
the suggestion

> > The DSP has the bitmap for interlever as explained in sst_send_slot_map=
()
>=20
> > /*
> >  * channel map value is a bitfield where each bit represents a slot
> >  *
> >  *                        76543210      # 0 =3D slot 0, 1 =3D slot 1
> >  *
> >  * e.g. codec1_0 tx map =3D 00000101b -> data from codec_out1_0 goes in=
to slot
> >  * 0, 2
> >  */
>=20
> > so based on the channel selected here we will set the map and send to D=
SP.
> > For none case we don't need to do anything. Yes this bit need this
> > explanation so will add up
>=20
> But why not - why is the effect of clearing all the bits to do nothing?
Okay thanks for pointing out, We did check on this bit. So initially DSP
wasn't supporting the dynamic updates of the  slots so thsi was fine but
later we added support. On re-examining again as you pointed yes 'none'
value needs to reset the bitmap and send to DSP so we just need to forward
the IPC here as well. I will fix it up.

> > > > +			 !strncmp(kctl->id.name, w->name, index)) {
> > > > +			struct sst_enum *e =3D (void *)kctl->private_value;
> > > > +
> > > > +			e->w =3D w;
> > > > +
> > > > +		} else if (strstr(kctl->id.name, "deinterleaver") &&
> > > > +			 !strncmp(kctl->id.name, w->name, index)) {
> > > > +
> > > > +			struct sst_enum *e =3D (void *)kctl->private_value;
> > > > +
> > > > +			e->w =3D w;
> > > > +		}
>=20
> > > Again no fallthrough case.
>=20
> > would that be valid. We have only volume, params, mute, interlevaer and
> > deinterleaver controls only :)
> > Can add fall thru for therotical if you feel that is right thing to do.
>=20
> Yes, it's better.  This is part of the whole thing about the code
> setting off alarm bells - things look fragile and the missing error
> checking does nothing to dispel that.
Yup, will add these

--=20
~Vinod

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUKPVoAAoJEHwUBw8lI4NHQbIQAJqg1lEM0bOLeNxKnPlafw3i
J8DwQ8iyVG9sHMSIYQ+dceORYsEgY0uYjvDd5to0Z5mIFUeYqQ3nB358uKJfKdQD
EDOUzzBT4Jn1Pc4gKFn23W22Dq1FpjDE3U3N13WGSxeCxfXJczxgT06sRk4rEBH/
ysHhW+2wDge/gFbjvc8LHakpKGx7gasgrF0Mug74e9t0Ir8FovVqFCh+0kwZBwRA
UXxS84L8/Nx0a7ekWJ0POoopHkcJRGgN2V7hg7eD47cXyzT4y5501jRZur2k/FmG
xl6Dwjx1MIKN6WQh0WXAy8SVBvRrFbbmwmALXnN/gSToxlGM1hg+GnW4Ey8+UtKV
l5CE8o4VoKZ6BHRC9CG5Ij4+rIk8sSog65VzAmalGpCuem4OICYzSKA+bFILRx74
wK6EHjDDrUou6WsuMFI5GF5dPd9aIn9H18CWvRdag0LmMQEmZrLx31lJp+GOITBR
QJASTCOl6cx6/O8rObQ4DgrUlK24JWeG9DWb+A0u7ZShFtHU15SfrjiJ3J4Xejeb
IF8wFK2vYaQb5/Av6KaL2hHOUBEgyL5AuSvkSIrOpWRlYRnUXcXS0w+6OvN1xliZ
G38QE2S/Aym4A6Kc4mDcqGR0TTOVItJQnX+q+t4HZ2nsK2lXAtisHfVGqir3SaaY
3eaHaEMfjO5JL7JStOTN
=n209
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--

--===============5311277383062848929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5311277383062848929==--
