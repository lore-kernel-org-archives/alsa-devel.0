From: Sergey Vlasov <vsu@altlinux.ru>
Subject: CVS server problems: old RCS files corrupted
Date: Mon, 17 Nov 2003 18:33:35 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031117153335.GA7554@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I have tried to look at the ALSA CVS log through the anonymous CVS access
(using recursive 'cvs log'), but encountered several errors in old files
(which no longer exist in the current version):

cvs [server aborted]: unrecognized operation '\x9' in /cvsroot/alsa/alsa-driver/kernel/Attic/mixer.c,v

cvs server: warning: duplicate key `log' in version `1.33' of RCS file `/cvsroot/alsa/alsa-driver/lowlevel/isa/Attic/es1688.c,v'
cvs server: warning: duplicate key `text' in version `1.33' of RCS file `/cvsroot/alsa/alsa-driver/lowlevel/isa/Attic/es1688.c,v'
...
cvs [server aborted]: invalid rcs file /cvsroot/alsa/alsa-driver/lowlevel/isa/Attic/es1688.c,v: premature end of value

Tried the backup server too - no difference.  Probably the files have been
corrupted?

-- 
Sergey Vlasov

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/uOpPW82GfkQfsqIRAod9AJwPYHlMGl1osQalwIh7WJJZhuLS2ACgjKEu
qLGSOk3VKh44eS/VfFHhD4g=
=Dz9S
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
