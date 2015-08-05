From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [REANNOUNCE] Audio Mini Summit 2015, 8th October,
 Dublin
Date: Wed, 5 Aug 2015 08:26:03 +0530
Message-ID: <20150805025603.GE11789@localhost>
References: <20150714150352.GW11162@sirena.org.uk> <55BC772C.50801@metafoo.de>
 <20150803032128.GO29916@localhost>
 <20150804161335.GW20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3008655971157484084=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E2AC265A79
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 04:54:26 +0200 (CEST)
In-Reply-To: <20150804161335.GW20873@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3008655971157484084==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2015 at 05:13:35PM +0100, Mark Brown wrote:
> On Mon, Aug 03, 2015 at 08:51:28AM +0530, Vinod Koul wrote:
> > On Sat, Aug 01, 2015 at 09:37:16AM +0200, Lars-Peter Clausen wrote:
>=20
> > > Full media controller integration for both ALSA and ASoC. How this ca=
n be
> > > used to export topology information to userspace and how to for examp=
le
> > > attach a specific volume control to a specific media controller entit=
y. And
> > > maybe also how to de-duplicate similar functionality between DAPM and=
 media
> > > controller.
>=20
> > The recently merged topology core allows us to 'send' the complete topo=
logy
> > information for a component to kernel drivers.
>=20
> > So with this we now we have two additional choices:
> > - assuming all components use topology framework, we don't need to quer=
y, we
> >   use the topology information available in usermode. Some more support=
 to
> >   parse topology binary installed and show as controls in alsa-lib migh=
t be
> >   required here
>=20
> That'd require us to move all the DAPM information for drivers out of
> the kernel and into userspace which seems a bit worrying - it's going to
> be harder for things that need events and I worry about the effect on
> quality of implementation if people stop sending things to get reviewed.
Not for this option, for example in SKL.

kernel doesnt have toplogy information coded in, it is parsed and build from
topology binary which is built by alsa-lib. So if we add more alsa-lib APIs
to parse the installed binary we have good view of system without going to
kernel, we know complete graph and controls...

> > - do a reverse path, based on dapm and control info (driver will need t=
o add
> >   code for linking the two) we add a new reverse API, which tells us the
> >   topology information from kernel
>=20
> That's basically what the media controller API discussion has been.
Yes lets discuss more during the conf...

--=20
~Vinod

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwXtDAAoJEHwUBw8lI4NHF2EQAM0ycHZl4DTGlrL+guKwmeOd
SQ3u7gpv4BwTMV52sj/HyvZhXUq0JKnQDCsopZIIVVLyMhrQyXELhDZ0TtPR04ZH
wy2Ah7zKfanlPEN5kfdtVPExPx5qTnVBlaFJtCTPN6oEbk5Tl/ZUNWs/Ee6nIhHK
Am1MKBeDv30im9RNh3AflVfVg9auvF/itj/k+0nUka05W4m/BuUy+aRRf7sHxM11
EqDih2LG8kVNgaa5CAJ04lnHYuPse8R+ysF5Ky3gM+C+jOGxemWer5ee5+XhoMeT
LIdhguz3nobHd+TjxMqDrk++rYFXStb0wYU/BwESFGSkh+XjxPvlYjx8xne8hHs3
SOjCvNnKeFNS8rJoE3ZFce6A9RRAxEPk8E0sldjHdkK2AgVJLdovbfH/Q/c8uBqm
i3NBzg936v/TxsqAE2/vJ3xEpKBVx7H6f5dcn/SP73V5Vziw1EQzS0mPHf6Ybyk5
dNEQPd8T/e48UuWXIb82AeYp0nZOLSNleFDf9wFFnO24jSW1Z84IIDxXo+qAcTvQ
fZboD+L0RDVBUfcczqqBf0ZvU++M81AxRJkX76f4igjtr/2hA+QV9s5dvYGrGw49
/q9RRlC4uG3aV6KFXX7hUMqD/FzlxAf+GxY9cfZQbcxjOfcmYy6ymzol8Z0enbGK
jzni1j2qt7CrHBF1/sQL
=pDWF
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

--===============3008655971157484084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3008655971157484084==--
