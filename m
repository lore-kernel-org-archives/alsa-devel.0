From: Stuffed Crust <pizza@shaftnet.org>
Subject: Selectable async notification signal?
Date: Sun, 7 Apr 2002 23:45:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020407234548.A14312@shaftnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
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


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

How painful would it be to add an API call to set the async notification
signal to be something other than SIGIO?

I'm getting select()s blocking indefinately because of this.  While
changing a #define works for my local alsa-lib tree, it doesn't help
anyone who needs to use my code.

 - Pizza
--=20
Solomon Peachy                                    pizzaATfucktheusers.org
I ain't broke, but I'm badly bent.                           ICQ# 1318344
Patience comes to those who wait.
    ...It's not "Beanbag Love", it's a "Transanimate Relationship"...

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8sRJsysXuytMhc5ERAhZXAJ9gTTWHCdm4L1qE2+UYlMbaNdMqlACbBkx+
KdKy6Dw6JQ3eB+nnMZkSpkY=
=MUCB
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
