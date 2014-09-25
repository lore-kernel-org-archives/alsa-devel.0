From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 1/7] ASoC: Intel: mrfld: add the gain
	controls
Date: Thu, 25 Sep 2014 19:36:24 +0530
Message-ID: <20140925140624.GY24663@intel.com>
References: <1411125368-5836-1-git-send-email-subhransu.s.prusty@intel.com>
 <1411125368-5836-2-git-send-email-subhransu.s.prusty@intel.com>
 <20140925142026.GS27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0767053864279034884=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EBFCC260411
 for <alsa-devel@alsa-project.org>; Thu, 25 Sep 2014 16:36:07 +0200 (CEST)
In-Reply-To: <20140925142026.GS27755@sirena.org.uk>
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


--===============0767053864279034884==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
Content-Disposition: inline


--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 03:20:26PM +0100, Mark Brown wrote:
> On Fri, Sep 19, 2014 at 04:46:02PM +0530, Subhransu S. Prusty wrote:
>=20
> > +/* Gain helper with min/max set */
> > +#define SST_GAIN(name, path_id, task_id, instance, gain_var)				\
> > +	SST_GAIN_KCONTROLS(name, "Gain", SST_GAIN_MIN_VALUE, SST_GAIN_MAX_VAL=
UE,	\
> > +		SST_GAIN_TC_MIN, SST_GAIN_TC_MAX,					\
>=20
> As far as I can tell from following the macros through this looks like
> it will create controls called "name Gain Volume" which doesn't seem
> excellent.
The convenstion we used was <pipeline identifer> and then module. So if gain
block is in media 0 input we refer to it as "media 0 in Gain Volume"
This helps to identify the module location and help in understanding control
by looking at the name
>=20
> > +#define SST_NUM_GAINS 36
> > +static struct sst_gain_value sst_gains[SST_NUM_GAINS];
>=20
> > +static const struct snd_kcontrol_new sst_gain_controls[] =3D {
> > +	SST_GAIN("media0_in", SST_PATH_INDEX_MEDIA0_IN, SST_TASK_MMX, 0, &sst=
_gains[0]),
>=20
> This table is full of magic number references into the array...
>=20
> > +	SST_GAIN("codec_out1", SST_PATH_INDEX_CODEC_OUT1, SST_TASK_SBA, 0, &s=
st_gains[23]),
> > +	SST_GAIN("media_loop1_out", SST_PATH_INDEX_MEDIA_LOOP1_OUT, SST_TASK_=
SBA, 0, &sst_gains[30]),
>=20
> ...with holes in the array.  This seems really error prone.
I will fix the holes here..

> >  	char params[0];
> >  } __packed;
> > +/**** widget defines *****/
> > +
> > +#include <sound/soc.h>
> > +#include <sound/tlv.h>
> > +struct sst_ids {
>=20
> This is adding includes in the middle of the file (which isn't the usual
> kernel coding style) and is missing a blank lines.  This sort of stuff
> is getting quite repetitive and hence annoying, especially the blank
> lines thing which comes up again and again and just makes everything
> even harder to read.
Sorry about this one, i will make sure this is fixed properly and not
repeated

--=20
~Vinod

--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUJCFgAAoJEHwUBw8lI4NHt+QQAKxZV+uHS+xkx8Ll+SlTXFv6
WP9nyd+fTxxRn+tGU93X5nc74a3xkaQhw7SgdKxNyz/uG6m31Pim4aMbhPbSNnfz
38PxrJYYgJIOgZ+734ishyEvv6prIUDTngIrfWppIelavIh/9wgxvO2mGETJIvNR
eZhai5GteKaJJCBl+QlBEWWF/P0PDZygnEz1nHdXuXLyt8k4ciFsMDKT+0ovIdl/
13J57F36LLbNaupjDL/dp+oahjkrMSggf/y0foSdhLpoJ9AbLddtoBdNrcwzryLr
S8q6VPMTwXyKafuXQsKLesvndpCKMP+RIVpZiWKq0bInGsNMuNvsn15L4jH03VKc
kEcIwA7447fpS7t7tJA2fMJQhgeaLVRf6ncn6gdde/DAtgg5n/2erSw1LwhZJ52H
hH6saenMWZDYfLmdPQzzWFXZXcovlJZXLHWpCS45mpsbwytEGHuRUgTlyXPmtpJ3
bhzcmsypLdaxGlkVx5n2Gw6G7I9H9K64qEInssjc/ekTorq+eh4zojo++5qC5fiz
b/zhetceTT6DVVTj5njjvVDN6SOquTGMXp6h2eQ+HIU2/9HyD/vYTFzQsck+qdMi
e1tgwHmWTzrs1bXfw+ZYnEQH/ceXGk2N+h5U/MQuew3IIzXDPLOhQgBMOcNIrcnY
mLJJCY3kP00My70dQDAW
=nbqY
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--

--===============0767053864279034884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0767053864279034884==--
