From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: cs4205 sp/dif support
Date: Tue, 2 Apr 2002 12:14:15 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020402121415.A2845@shaftnet.org>
References: <20020401164457.B21453@shaftnet.org> <Pine.LNX.4.33.0204021219120.544-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0204021219120.544-100000@pnote.perex-int.cz>; from perex@suse.cz on Tue, Apr 02, 2002 at 12:21:44PM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2002 at 12:21:44PM +0200, Jaroslav Kysela wrote:
> It would be better to add a new flag to ac97->flags like AC97_CS_SPDIF to=
=20
> avoid conditions via AC97 ID numbers (more codecs from Cirrus Logic can=
=20
> behave in same way and having separate conditions for each codecs makes=
=20
> code unreadable).

Okay, I've done this; but I have another question:

Should the ac97_codec update the spdif rate when we get a sample rate chang=
e?
Otherwise, we could get a little out of sync -- the spdif rate defaults to=
=20
48kHz, but we open the pcm device at 44.1Hz...

 - Pizza
--=20
Solomon Peachy                                    pizzaATfucktheusers.org
I ain't broke, but I'm badly bent.                           ICQ# 1318344
Patience comes to those who wait.
    ...It's not "Beanbag Love", it's a "Transanimate Relationship"...

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8qebnysXuytMhc5ERAgNhAJ4xydso208ysnf2dM8CkWLo2q0V0wCeIhC1
wPoZQLZ6I2j4Rw1P5DEIvF0=
=m4Yh
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
