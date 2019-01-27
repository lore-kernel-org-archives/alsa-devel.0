From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: alsa-utils 1.1.8: axfer tests take ages tu run.
Date: Sun, 27 Jan 2019 11:03:04 +0100
Message-ID: <20190127100304.4etta27wz6d7k65b@toy.home.lxtec.de>
References: <20190126144922.nim532ciqslpaahb@toy.home.lxtec.de>
 <20190126160432.eatvt2fyh4cdf5at@toy.home.lxtec.de>
 <20190127034438.GB7590@workstation>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1011252589976678907=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
 [83.223.90.233])
 by alsa0.perex.cz (Postfix) with ESMTP id 164B7266AA9
 for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2019 11:03:06 +0100 (CET)
In-Reply-To: <20190127034438.GB7590@workstation>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org


--===============1011252589976678907==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h44g7lukykxdpseb"
Content-Disposition: inline


--h44g7lukykxdpseb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Takashi Sakamoto <o-takashi@sakamocchi.jp> [2019-01-27 12:44 +0900]:

> Hi,
>=20
> On Sat, Jan 26, 2019 at 05:04:32PM +0100, Elimar Riesebieter wrote:
> > * Elimar Riesebieter <riesebie@lxtec.de> [2019-01-26 15:49 +0100]:
> >=20
> > > Hi,
> > >=20
> > > what are the tests in alsa-utils-1.1.8/axfer/test/ good for? mapper-t=
est and
> > > container-test are running very long time. I Can't find any docu in
> > > the source? If the need as long as on my 8-core the source is not
> > > ready for distribution, though.
> >=20
> >  container-test took 44min but passed!
>=20
> It's expected.
>=20
> The execution time of unit tests for axfer is file I/O bound, thus
> it's independent of processors. However, I guess it takes 20-50 minutes
> to finish all iterations.

FYI this will block build daemons on distribution machines.
alsa-utils 1.1.7 builds within a finger snip, though.

>=20
> I design the 'container-test' to iterate a set of building/parsing
> content of media container with memory comparison for 635,904 times.
> Each trial consists of the different combination of parameters
> described below:
>=20
> * buffer type for audio data frame (=3D2)
>  * linear buffer and interleaved for SND_PCM_ACCESS_MMAP_INTERLEAVED
>  * linear buffer and non-interleaved for SND_PCM_ACCESS_MMAP_NONINTERLEAV=
ED
> * type of media container and format of audio data frame (19 + 7 + 4 + 39=
 =3D 69)
>  * 19 formats for RIFF/Wave container
>  * 7 formats for AU container
>  * 4 formats for VOC container
>  * 39 formats for raw container
> * the number of samples in an audio data frame (=3D128)
>  * 1-128
> * the number of audio data frames in buffer (=3D6)
>  * 23
>  * 1047
>  * 2071
>  * 3095
>  * 4119
>  * 4500
>  * (23-4500 with 1024 step)
> * the number of audio data frames per second (=3D6)
>  * 44.1kHz
>  * 48.0
>  * 88.2
>  * 96.0
>  * 176.4
>  * 192.0
>=20
> When building/parsing media container, each implementation of media
> container executes I/Os to actual files.
>=20
>=20
> Like container-test, the 'mapper-test' iterates a set of muxing/demuxing
> between the buffers of audio data frame and the containers with memory
> comparison for 10,752 times. Each trial consists of the different
> combination of parameters described below
>=20
> * buffer type for audio data frame (=3D4)
>  * linear buffer and interleaved for SND_PCM_ACCESS_MMAP_INTERLEAVED
>  * linear buffer and non-interleaved for SND_PCM_ACCESS_MMAP_NONINTERLEAV=
ED
>  * linear buffer and interleaved for SND_PCM_ACCESS_RW_INTERLEAVED
>  * vector buffer and noninterleaved for SND_PCM_ACCESS_RW_NONINTERLEAVED
> * type of media container and format of audio data frame (=3D7)
>  * 7 formats for RIFF/Wave
> * the number of samples in an audio data frame (=3D32)
>  * 1-32
> * the number of audio data frames in buffer (=3D6)
>  * 23
>  * 1047
>  * 2071
>  * 3095
>  * 4119
>  * 4500
>  * (23-4500 with 1024 step)
> * the number of audio data frames per second (=3D1)
>  * 48.0 kHz
> * type of mapper (=3D2)
>  * single
>  * multiple
>=20
> When muxing/demuxing for buffer of audio data frame, it uses internal
> implementation of RIFF/Wave container, thus executes I/Os to actual
> files.

Thanks for explanation.

>=20
> I think it preferable to shorten the execution time of each unit test;
> e.g. several minutes at maximum, however the purpose of unit test is to
> detect bugs in advance and this program handles audio data frame between
> the several types of buffer for I/O to sound device and the several
> types of media container with combinations of many parameters. At
> present it's reasonable to takes such long time to finish the tests.

This means you need a sound device on the building machine? Thats
contra productive! I assume that at least our Debian buildd's don't
have a sound device. How are those tests handled in that case? We
need a properly solution for Linux distributions here!

> Of course, we can shorten the duration time by eliminating the range
> of parameters. Actually I've investigated to reduce iteration and reduce
> for the number of audio data frames in buffer by 6 options. But any
> reasonable explanation except for the duration time is required to be
> worth for it, IMO.

Well, what do you think to outbound your tests to i.e.
$PREFIX/doc/examples to let the user decide whether to run them or
not. A configure option to cancel the tests in the build process
would be an option to be decided by the distribution maintainer.

Elimar
Member of "Debian ALSA Maintainers"
--=20
  "Talking much about oneself can also
   be a means to conceal oneself."
         -Friedrich Nietzsche

--h44g7lukykxdpseb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEA5qPfgi7vn3+5mXKPas3Tbfc8bsFAlxNgdQACgkQPas3Tbfc
8buZLQ//S0IV30cLIMhKRC4jL86sYOq+6rcoxgThaaxmWC5Vi9HrQiAVu+GhAsAO
xvx33RchCTOYtMBZLMfh/iD1GPqQrssuWUH3wCXhHlz+kjLkav0wFvAMosRlu3Eh
RmePdxGqlhnPzq/Sa0RAKAOMQHxCakR5uFNfgikr/6Qt8gLR5yx5XBq2Wulo/f/c
05uyE1yv/bNFTxSq+ziSrhXd2oVWQ567khOGrO5MZ3qKHpwkrfiRsY8uOKMsOxGd
T6JNQetqXGM/6IXmxKMbhmdhmTvbbNbnQwUl4JeLghrrwwoyqnlkiXAfW3z6anw4
G74algRHwXgGnm++95tf45tR1fccruzxFLwkzLTFKgur9u8KzxR2jWqtktVqmBSz
xi7rzeS9lIvdSV1Y1i1sAycybYPzHXuS0IT/pM6Q2DtljTuzD6epcBXYJU5VgJ0t
3igHIrONpeg18pctiPa9bnXQi7kfyKk6VKGy+9NLSxmASjEnnfiX/gP8PKEUYOVT
HB9mykKWiwgM9fQq6L8WMxhOXP6QqRq8CUYhQ8wcSOkCFavVQ5nELpnLo0obtPzW
99ZROi9xDwdgMYArukrK0ySw2qdwNK+L5p2d5d/5O4vvmsUJzN+jSySwNPGFxnO4
wLBJhOCRYuI1091nbfH8o8GNTBQp8RE/n6KZj7KltnnpoXuSY9c=
=Am9W
-----END PGP SIGNATURE-----

--h44g7lukykxdpseb--

--===============1011252589976678907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1011252589976678907==--
