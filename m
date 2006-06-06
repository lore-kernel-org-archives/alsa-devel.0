From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: OSS/ALSA issue
Date: Tue, 6 Jun 2006 23:29:06 +0200
Message-ID: <200606062329.09662.alien999999999@users.sourceforge.net>
References: <200606062157.43489.alien999999999@users.sourceforge.net>
	<1149626271.4072.60.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1622311812=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1149626271.4072.60.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org

--===============1622311812==
Content-Type: multipart/signed; boundary="nextPart12112107.36I395IMB7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart12112107.36I395IMB7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Op dinsdag 6 juni 2006 22:37, schreef Lee Revell:
> On Tue, 2006-06-06 at 21:57 +0200, Alien wrote:
> > as a result, the sound was played, all sound looped (also flash), and
> > a few
> > hours later, my /var/log/kernel/warnings was > 600MB (kernel
> > warnings).
> >
> >
> > Now, we all know that:
> >
> > 1. ALSA has hardware mixing if the chipset/driver supports it (i know
> > mine does).
> >
> > 2. OSS does not do any multiple sounds
>
> It should work.  ALSA's OSS emulation supports mixing if the card has
> hardware mixing.  It is only in the case of software mixing that OSS
> emulation cannot support multiple open.
>
> Sounds like a driver bug.  What do the kernel warnings say?
>
> Lee

these are the kernel warnings

--nextPart12112107.36I395IMB7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEhfOluBWKXETrtdcRAhLPAJ0V1MBW8LvYz2kWS24oAUndylwCTACdGZML
MBsgh4PC4jNOT88yxJ5oFyg=
=HcJk
-----END PGP SIGNATURE-----

--nextPart12112107.36I395IMB7--


--===============1622311812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1622311812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1622311812==--
