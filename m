Return-Path: <alsa-devel-bounces@alsa-project.org>
Date: Wed, 15 Jun 2016 14:13:03 +0200
From: Henrik Austad <henrik@austad.us>
Message-ID: <20160615121303.GB5950@sisyphus.home.austad.us>
References: <1465686096-22156-1-git-send-email-henrik@austad.us>
 <1465686096-22156-8-git-send-email-henrik@austad.us>
 <20160615114908.GB31281@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20160615114908.GB31281@localhost.localdomain>
Subject: Re: [alsa-devel] [very-RFC 7/8] AVB ALSA - Add ALSA shim for TSN
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9158460707544685415=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Takashi Iwai <tiwai@suse.de>, henrk@austad.us, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Henrik Austad <haustad@cisco.com>, netdev@vger.kernel.org, alsa-devel@vger.kernel.org, linux-media@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>


--===============9158460707544685415==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2016 at 01:49:08PM +0200, Richard Cochran wrote:
> Now that I understand better...
>=20
> On Sun, Jun 12, 2016 at 01:01:35AM +0200, Henrik Austad wrote:
> > Userspace is supposed to reserve bandwidth, find StreamID etc.
> >=20
> > To use as a Talker:
> >=20
> > mkdir /config/tsn/test/eth0/talker
> > cd /config/tsn/test/eth0/talker
> > echo 65535 > buffer_size
> > echo 08:00:27:08:9f:c3 > remote_mac
> > echo 42 > stream_id
> > echo alsa > enabled
>=20
> This is exactly why configfs is the wrong interface.  If you implement
> the AVB device in alsa-lib user space, then you can handle the
> reservations, configuration, UDP sockets, etc, in a way transparent to
> the aplay program.

And how would v4l2 benefit from this being in alsalib? Should we require=20
both V4L and ALSA to implement the same, or should we place it in a common=
=20
place for all.

And what about those systems that want to use TSN but is not a=20
media-device, they should be given a raw-socket to send traffic over,=20
should they also implement something in a library?

So no, here I think configfs is an apt choice.

> Heck, if done properly, your layer could discover the AVB nodes in the
> network and present each one as a separate device...

No, you definately do not want the kernel to automagically add devices=20
whenever something pops up on the network, for this you need userspace to=
=20
be in control. 1722.1 should not be handled in-kernel.


--=20
Henrik Austad

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAldhRk8ACgkQ6k5VT6v45lkURwCg0w3I+b0cfTOtO8D9xLT4Hj+A
yTsAoKdQJqdMmus+EVZ29VY24bS7s9t8
=b685
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in


--===============9158460707544685415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9158460707544685415==--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
