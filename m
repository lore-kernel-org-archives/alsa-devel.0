From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 3/9] ASoC: Intel: Skylake: add DSP
 platform widget event handlers
Date: Mon, 21 Sep 2015 08:54:10 +0530
Message-ID: <20150921032410.GD2381@localhost>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-4-git-send-email-vinod.koul@intel.com>
 <20150919161122.GD30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8181099009145939393=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2232D260537
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 05:21:32 +0200 (CEST)
In-Reply-To: <20150919161122.GD30445@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8181099009145939393==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2015 at 09:11:22AM -0700, Mark Brown wrote:
> On Mon, Aug 17, 2015 at 10:56:38PM +0530, Vinod Koul wrote:
>=20
> > +	if (list_empty(&s_pipe->w_list)) {
> > +		ret =3D skl_tplg_get_pipe_widget(ctx->dev, w, s_pipe);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
>=20
> I'm not entirely clear what this is supposed to do or if it does it
> correctly - I suspect it's trying to always create the pipe widget which
> might be a bit clearer if it just created the pipe widget.  The fact
> that it's checking if a list is empty is a bit worrying, what if some
> but not all of the entries needed on that list are there?  Is just
> getting a widget really sufficient initialisation?

For quick reference, on first run of a pipe, we create a w_list of all
widgets in that pipe. This list is not freed on PMD event as widgets within
a pipe are static. This saves us cycles to get widgets in pipe every time.

So if we already initialized all the widgets of a pipeline we don't need
that anymore. I will add comment for this as well

>=20
> > +	return skl_tplg_bind_unbind_pipe_modules(ctx, s_pipe, true);
> > +}
> > +/*
> > + * A PGA represents a module in a pipeline. So in the Pre-PMU event of=
 PGA
>=20
> Blank line between functions and the next thing.  I am getting fed up of
> seeing this.
Will fix these

Thanks
--=20
~Vinod

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV/3haAAoJEHwUBw8lI4NHIOsQALtKcYmRCfKqNMjZhZFiLfmc
35ZwLr3rXLirjEuiLI6Lkxu7OmIAvZOD1I93vm/m4XC5BFY7H5uTjRvNjFpFuJEz
nJHa/ZeIkh2ppiOXHGbvcuQIB8/Syk5Qw5VFk6vVvql8yGou90KVsrM37a/9Htgp
ZjHbp/yXObgILLyUlSWOCtEpWcoNfxzoNEBVssTzyTPAdqsjQonI3sRPS9cbY4Lp
B/i+xP5/EhNAKg/i8y3evKmQ5D0p090RKCU/fVDg5GJKQiUrjhdE374hqSrsCOcs
T1QaDX8lHhiV7AI8gRpvUBRlZP16TbvRuzS60n2YHpxzCyCt2WA/Mwhn75PoI8s2
dYh17qXJt6IZwyJsQKJ4cm9+JCmeKFIGSOSeay9J+mPMNlQTWZVchXszdxnU+1S/
DxxlW3Ndcf9nDJnAwGzU4crto58v2UjFWNe0DpFjmL8vMXrumqgsK4K5VSb6DqGe
lzfTmkAAXcuaygXIk0w8YRymWK4Kh9g1UfMbHPcSVN38chQQzefKfWxnv9JAsEuc
MAoEnYCkzJOp25Z1G7A5XPCxNC8sI87F0moYIeZKSg+eiPcp6A0A/segjo+8zCi2
S0ppdumk0YxxANGwm1U1IKmqi0RqGTe6WgF82D4Qwmy+5ls2BT/AXnrk/mnoWlEb
Xk/mLwMjsQ1cZwTDpLjG
=r+Z0
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--

--===============8181099009145939393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8181099009145939393==--
