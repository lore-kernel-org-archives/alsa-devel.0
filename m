From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: The soc card can have auxiliary
 components
Date: Fri, 11 Dec 2015 20:22:08 +0000
Message-ID: <20151211202208.GS5727@sirena.org.uk>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
 <bb343fe20b14af90f695939d8faae50fae1ba97a.1449036307.git.mengdong.lin@linux.intel.com>
 <20151208185817.GX5727@sirena.org.uk>
 <5667EFCB.3010402@linux.intel.com>
 <20151209203836.GI5727@sirena.org.uk>
 <56694E6A.4090402@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7888409637823918397=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 450E326550C
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 21:22:16 +0100 (CET)
In-Reply-To: <56694E6A.4090402@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7888409637823918397==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hc1Ad1NXUysMDyjB"
Content-Disposition: inline


--hc1Ad1NXUysMDyjB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 10, 2015 at 06:05:30PM +0800, Mengdong Lin wrote:
> On 12/10/2015 04:38 AM, Mark Brown wrote:

> >OK, but I do think that's something we *should* be doing as part of the
> >overall move of CODECs to components and it's something that having this
> >change implies we should be doing as an immediate thing since it's the
> >more obvious direct use of the code (as Lars said in reply to the early
> >draft you posted IIRC).

> My early draft didn't use the aux components, so I'm not sure where to find
> Lars's comments on this idea.

He replied to some thing you posted by mistake and immediately
retracted.  Can't remember the subject, sorry.

> Please check if my understanding is right?

> I guess you want me to replace the "aux_dev" array from the struct
> snd_soc_card, by an "aux_components" array. And we may
> replace soc_bind_aux_dev() by soc_find_components(),
> replace soc_probe/remove_aux_dev() by soc_probe/remove_components.
> Probably soc_find/prove/remove_components need some adjustment for the the
> aux devices (DAIless codecs).

> And device driver of the these aux_dev need to use
> snd_soc_register_component() to make it as a component.

Yeah, pretty much.  I think we'll have a period where we support both
though as any CODEC *could* be used in this way and we're not ready for
that yet.

Let me have a look at converting some of the drivers over the weekend.

--hc1Ad1NXUysMDyjB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWazBwAAoJECTWi3JdVIfQmHQH/RC/hsupI9WMYtsuF3tHrmDR
eh/e5YHRbhdg67sjVFsrgBZjSd8OkU1ht+lPPA3ejACPharypRUOaU2AXSsQY+Eb
3pPn17Cep1PovwI/BNM3bt7kQaGL2KV6B/caRDocZDom4SJIS9sg/hDF3G/c9o88
e1d2bPZKYGoA3kCsuaAzCfx+aFpqyLbo+XkHWmFukdrmsq/S+a3j2ZybKUk56ymf
mGyKwvbUzZryPHYVgAbBScL2hmmYDX6qa99joKvYAcpgx6ndib+9e9So6LYkaCdu
V783MVdZwdmILWbwrSrdfcgTMv/7UVkYkml7MzOs8bXEef2wm9ZdNrice4vX2e8=
=hm2e
-----END PGP SIGNATURE-----

--hc1Ad1NXUysMDyjB--

--===============7888409637823918397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7888409637823918397==--
