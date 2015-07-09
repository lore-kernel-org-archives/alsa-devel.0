From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 3/6] ASoC: Intel: Reorganize the common
	dsp structure
Date: Thu, 9 Jul 2015 10:02:39 +0530
Message-ID: <20150709043239.GG836@localhost>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
 <1435919647-14049-4-git-send-email-vinod.koul@intel.com>
 <20150708183833.GA11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2206571554099851213=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1918F265B90
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 06:31:00 +0200 (CEST)
In-Reply-To: <20150708183833.GA11162@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, liam.r.girdwood@linux.intel.com
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2206571554099851213==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 07:38:33PM +0100, Mark Brown wrote:
> On Fri, Jul 03, 2015 at 04:04:04PM +0530, Vinod Koul wrote:
> > From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
> >=20
> > We will add SKL platform data. So organizing common and platform
> > specific data helps.
>=20
> >  struct sst_dsp {
> > =20
> > +	/* Shared for all platforms */
> > +
> >  	/* runtime */
> >  	struct sst_dsp_device *sst_dev;
> >  	spinlock_t spinlock;	/* IPC locking */
> > @@ -268,10 +270,6 @@ struct sst_dsp {
> >  	int irq;
> >  	u32 id;
> > =20
> > -	/* list of free and used ADSP memory blocks */
> > -	struct list_head used_block_list;
> > -	struct list_head free_block_list;
> > -
>=20
> Perhaps a union might start to make sense at some point?
Initially we did start with a union but Liam didn't like another indirectio=
n.
Anyway since not a bunch a members are getting added here, this should be
okay

Liam you want to add here...

--=20
~Vinod

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnflnAAoJEHwUBw8lI4NHV5IQAMe0teP1ZthBpY/Uj1jXTRJX
jkSFO9TtdNF9z7NY/w5ebKSYqeSOzG2OT9AQxFf1PuHz8LYpkis0M1Mn3AJGfi9T
wcUMOZPQiobaYjodqMimvC+dVMfRhwjYqkLQJz5f5XuKdz6KqC0BQL2Ym65cRYq2
8CWzfW3nb+amHE0hHkSAWOCyIkcf+ZCjOhh/kmlG6ogLZ7c21gYVrOCKIl/+gPWs
of6xhB3j1KusWB4NHaUX878mpE+X+s8QdxMb8T04RnO8svvZ5T5QbCr3pD6leUZI
DZ8n2dc/Nzas2K/HDnvWZeb44B5rxb8cfjLRdL7vj1vSyrTqGwvDkF8tCJPTsNg7
HBlCp3myee/j4DBNFEpwyhEkzf8PyvPF353t2HqqgSBnAMj3BJdC5Cw7RrTA9cEr
JiNB9MPmNb2wg4S5zfgrVlLk5QhTk0/8Jhj1j65fnclv+XZ81DjONIb5w1K+atMV
DyWaoua5HL0nbUHg6nFZUZhZa2MDtDUoDk2x55ZXVyww8wawOOUssl2TGbljINRL
io7xxsGAKGxlCmDBcFOWggqxX1IgJJ8LXM6tZWUXnSP7dxSne4z5qXkLuQxuVR6M
C8HDAw8ZWj0wZ/GoEuV0V/uu7EoNTXYuosPQaHCadusLesVV0urakIX4ACRL60cZ
q9ZbM3O9BMqcRIZmK4tJ
=x8lJ
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--

--===============2206571554099851213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2206571554099851213==--
