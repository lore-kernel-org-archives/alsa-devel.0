From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 11/13] ASoC: Intel: mrfld: add the DSP
	DAPM widgets
Date: Thu, 24 Jul 2014 11:48:03 +0530
Message-ID: <20140724061803.GD8181@intel.com>
References: <1404967497-22537-1-git-send-email-subhransu.s.prusty@intel.com>
 <1404967497-22537-12-git-send-email-subhransu.s.prusty@intel.com>
 <20140718121920.GO17528@sirena.org.uk>
 <20140718142623.GH1985@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7071480984978788406=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id D37A5265765
 for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2014 08:24:06 +0200 (CEST)
In-Reply-To: <20140718142623.GH1985@intel.com>
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


--===============7071480984978788406==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2014 at 07:56:23PM +0530, Vinod Koul wrote:
> On Fri, Jul 18, 2014 at 01:19:20PM +0100, Mark Brown wrote:
> > On Thu, Jul 10, 2014 at 10:14:55AM +0530, Subhransu S. Prusty wrote:
> >=20
> > > +	pr_debug("%s: widget =3D %s\n", __func__, w->name);
> > > +	for (i =3D 0; i < w->num_kcontrols; i++) {
> > > +		if (dapm_kcontrol_get_value(w->kcontrols[i])) {
> > > +			mc =3D (struct soc_mixer_control *)(w->kcontrols[i])->private_val=
ue;
> > > +			val |=3D 1 << mc->shift;
> > > +		}
> > > +	}
> >=20
> > So, this is the usage of dapm_kcontrol_get_value() (quite a way away
> > from the patch exporting it!).  The usage here looks *very* strange.
> > We're calling the function but treating the result as a boolean and
> > manually decoding the DAPM data structures in order to get the control
> > shift...  that's odd to say the least.
> >=20
> > > +	SST_FILL_DESTINATION(2, cmd.output_id,
> > > +			     ids->location_id, SST_DEFAULT_MODULE_ID);
> > > +	cmd.nb_inputs =3D	fill_swm_input(&cmd.input[0], val);
> >=20
> > So what we're doing here is parsing the controls to get which inputs are
> > enabled...  it's not altogether clear to me that we shouldn't be doing
> > this at control update time.  Presumably we'll also need to be sending
> > these messages when the controls are updated to account for changes that
> > happen while streams are active.
> yes thats the idea. Here we send as mixer path is On. Yes the mixer update
> if On does send this as well.

Wanted to check if there is anything else required to be done for thsi
series, if not can you pls merge the ones before this in series, if okay.

Thanks
--=20
~Vinod

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJT0KUbAAoJEHwUBw8lI4NHECYP/2qrZfWgbnxWf1vIOQSHSNDA
dW3FgGikdechfAByYD+EqQ6H8bSF0rkM9MKdbe98RkbwIueIbR3rDKnm8jAldaWy
nAYhA8ZRUDChD/gQ1/uvcBZ4jTfOnXry3BG7Kl8uMO0SJA8K8o0zK7Fjup5W86Eq
huMisGbHDwpgfsP0d0KXbI8ZGec4bOa/MTNUCRKzrpGdOPLxUTaaoLAdqhBYU4X9
OaqDkNtnjP3/GJOCk2zsUYNqCx2+36sjWXOKt803Z+RaBlgCUJYtyZAxkDs7JYNf
q6eL0MowAheGItToY9Q0FNf542tAt3MLL7ittA8V/xlTlwhMEyI+VGcpm84yx7nj
+sUNxu9itq9F/kGCRffNDYmT0UZjOq6Nt3uG0XUYOkc+punAYVRynXTFJEBT2q0K
4EfRTbpz3uMPr4eCA7b4tIGb+ngQWpHvddMANzEzzI0VmJwWEpSLF8jccZzjLs1o
0XVgOTuM/HNIVns31qH+T5OjQzp4QUn0/YCG7NX6UQVzGnTZYNxetGtM/RjzNyWB
jprRLZ3o+Gz0rvSbrEKvolLNlkLkfJw5L8nPlVuYRd5qeeOsQzQ9zcVgm7o3Mjnr
ICTWKOer5ABIPtE5hH0UPGc3LQGvmq6D6EGq+U/05ZINVSUmWtaCMActoS1yMbKt
Pu7b8uqEii77zRp9uQh3
=arxs
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

--===============7071480984978788406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7071480984978788406==--
