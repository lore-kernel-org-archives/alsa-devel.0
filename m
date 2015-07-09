From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 5/6] ASoC: Intel: Add Skylake IPC library
Date: Thu, 9 Jul 2015 18:48:23 +0530
Message-ID: <20150709131823.GR836@localhost>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
 <1435919647-14049-6-git-send-email-vinod.koul@intel.com>
 <20150708184627.GB11162@sirena.org.uk>
 <20150709052613.GK836@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4473763926770022353=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 13781265139
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 15:17:03 +0200 (CEST)
In-Reply-To: <20150709052613.GK836@localhost>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4473763926770022353==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lHuqAdgBYNjQz/wy"
Content-Disposition: inline


--lHuqAdgBYNjQz/wy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2015 at 10:56:13AM +0530, Vinod Koul wrote:
> On Wed, Jul 08, 2015 at 07:46:27PM +0100, Mark Brown wrote:
> > On Fri, Jul 03, 2015 at 04:04:06PM +0530, Vinod Koul wrote:
> >=20
> > Mostly looks good - a few small things here, nothing too major:
> >=20
> > > +static struct ipc_message *skl_ipc_reply_find_msg(struct sst_generic=
_ipc *ipc,
> > > +		u64 ipc_header)
> > > +{
> > > +	struct ipc_message *msg =3D NULL;
> > > +	struct skl_ipc_header *header =3D (struct skl_ipc_header *)(&ipc_he=
ader);
> > > +
> > > +	if (list_empty(&ipc->rx_list)) {
> > > +		dev_err(ipc->dev, "ipc: rx list is empty but received 0x%x\n",
> > > +			header->primary);
> > > +		goto out;
> > > +	}
> > > +
> > > +	msg =3D list_first_entry(&ipc->rx_list, struct ipc_message, list);
> >=20
> > This says it finds the message but it appears to just return the head of
> > the list without reference to the supplied header other than casting it
> > to skl_ipc_header and possibly using it in an error print?
> Yes you are right. Actually currently we dont expect to queue up so we ne=
ver
> bother looking up. But yes intention to find messages when they are quued=
, I
> will add that bit
And it doesn't work. The message comparison fails as we don't have a cookie
for replies :(

That would be reworked in future with FW. For now I am going to rename this
to skl_ipc_reply_get_msg() as it essentially gets first and only message in
queue

--=20
~Vinod

--lHuqAdgBYNjQz/wy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnnSfAAoJEHwUBw8lI4NHSCMQAMuGvdjpH7oJdUbNz37viymG
vev2VNdSM4KHDgHyDir5kBU4O03Kj0EAIXMU9OZ1ToAoZiJIQxrYykZzlcX95v5s
2c6o4SLEHV1KjqY2xYjeys8VCxvcMuYjqFwIA6ik8Cy0RQkjMTuArefcguWWlqU0
aOZ840D6Gao1szePedrxyo8QQv/uq/QSMZ3BzGq+oQx2zDzrGiRZeV4b5cjvlOjO
f4TRgJoMVfYQYotYbW8Km1qRoT241r0+cHwrOOkCuVN/sgzexkeBfRWKNzKQ0oan
jwl9E54Bd5zdoxGXMuZYkLEUg89zuzyY92AZc4ENHbSKhOPwUpzCPsEsoH4wfs7C
qtbYSwOwD7JUqnx1ISAzQ/Eev0/b2XVaf9fAVSTREyytxpdXE4m3k9Be+uV2cTQN
tcbJABkHqTsuo1DJOCEUG9alXWiBWR5Ct63WxSYpCoN3DnWi1MJrhk7hL5Xw1VZy
XqADhV2sFj4N5Mg6saLrLligrd7DyTtrQ5uAalHeuSitZjOGoMGpEkIwqEJUO2oB
WlgUQX/sm2XhriQ1uNkJEoX4QU4UN2v+KAEs7SYiMt+y0HConCcakePa0jTgPurF
nvjp+igkFnRZ5y8B6hzETsn7mWwocDVPe8kTu4YlgCIU+53HK2qpuYIASCBau8Id
l6lq0SAwU9xKSASmScJq
=iafr
-----END PGP SIGNATURE-----

--lHuqAdgBYNjQz/wy--

--===============4473763926770022353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4473763926770022353==--
