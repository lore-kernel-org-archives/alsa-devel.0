From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v9 1/6] ASoC: Intel: mrfld: add the gain
 controls
Date: Wed, 15 Oct 2014 18:09:38 +0530
Message-ID: <20141015123938.GN1638@intel.com>
References: <1413356701-8535-1-git-send-email-vinod.koul@intel.com>
 <1413356701-8535-2-git-send-email-vinod.koul@intel.com>
 <20141015104947.GC27755@sirena.org.uk>
 <20141015102303.GM1638@intel.com>
 <20141015130817.GF27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5880303492005123659=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F911260432
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 15:15:23 +0200 (CEST)
In-Reply-To: <20141015130817.GF27755@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5880303492005123659==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hk6Zb6cduJ+I0Tmj"
Content-Disposition: inline


--hk6Zb6cduJ+I0Tmj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2014 at 03:08:17PM +0200, Mark Brown wrote:
> On Wed, Oct 15, 2014 at 03:53:03PM +0530, Vinod Koul wrote:
> > On Wed, Oct 15, 2014 at 12:49:47PM +0200, Mark Brown wrote:
> > > On Wed, Oct 15, 2014 at 12:34:56PM +0530, Vinod Koul wrote:
>=20
> > > > +/* the SST_GAIN macro above will create three alsa controls for ea=
ch
> > > > + * instance invoked, gain, mute and ramp duration, which use the s=
ame gain
> > > > + * cell sst_gain to keep track of data
> > > > + *
> > > > + * To calculate number of gain cell instances we need to device by=
 3 in
> > > > + * below caulcation for gain cell memory.
> > > > + * This gets rid of static number and issues while adding new cont=
rols
> > > > + */
> > > > +static struct sst_gain_value sst_gains[ARRAY_SIZE(sst_gain_control=
s)/3];
>=20
> > > The use of ARRAY_SIZE() is nice here but I'm a bit confused about the
> > > divide by 3 - there's an entry in sst_gains referenced for each eleme=
nt
> > > in sst_gain_controls.
>=20
> > Thats is the reason added the comment above.
>=20
> The comment isn't very clear (splitting it into multiple paragraphs
> doesn't help since it looks like the calculation stands separately to
> the controls), and everything would be a lot simpler if there were a
> define for the number of controls created per SST_GAIN() rather than
> just hard coding the magic number.
Ah my mistake wasnt intended to be multiple para. I will remove the blank
like and yes add SST_GAIN_SIZE as 3 and using that would be better.

I resend this patch with this change :)

--=20
~Vinod

--hk6Zb6cduJ+I0Tmj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUPmsKAAoJEHwUBw8lI4NHJWsQALo2WAvkGbhGu+pCZ2nSNMP5
F+16HmjesHOf0yxUInQaUYS1pL6YFeNpET1B5vWig56XFBCegA/INwKqMO961246
ZSdkfUzID2BvczDfjtTbGin4nuwy6+ZnkUYNgv4QZUgqThX6alD11ky32c/n9C+s
VtYt/ArdQyZJ6vxK1J2boppxeeoeTrFgyh5pPIhLaSIgv/Zohjr7DutN11bkE+FT
f1lzBdFEHBUM7Et4Yiyy5ScdIDteiqf5Hh/4ncjifx0OFmwlGOWIOsnmQ32lwiy6
2eAf6mRVl5GQlkA4dTBXKMEZsONPZrbglqMY9lGmMdT6MRCy9On7DHZP6GQ6Wkqb
cAXxEv/cVKptuBePuvLjOn3PTRtysKKCSfWi+dAj7G87qVcdpg6L4v1QMfiwOlHb
SQiAVMXiVm0z6pqbr7KKkCff2+PSuneNKkr72UMkFdZIv+2Yzr4ff7qkAn/ftvFj
HuwgOSaTK0P90CNktWq5eEHHyhxkV0A15fpVg56FOdBotWBLn0Y7WU8lkDkGtz1j
30lZEerYLZHTs2J/7uy0LhXQD+9Cd0R4TI5oWAH78KYiHBT4pmd1AgmPV30Fbeka
xU6D55cw89fxf86lMXFAnrDjlpgkCtqW5o8MENWPszpghEn0tlokxldpij+xJ8U5
vOL92donikXHJJxnDH55
=rBBj
-----END PGP SIGNATURE-----

--hk6Zb6cduJ+I0Tmj--

--===============5880303492005123659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5880303492005123659==--
