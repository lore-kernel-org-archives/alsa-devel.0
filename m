From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: Question regarding the CS4205 driver (used in all current Dell notebooks)
Date: Tue, 30 Apr 2002 08:20:51 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <aaulkm$4ij$2@main.gmane.org>
References: <000301c1f004$b8c92550$ac1f830a@ico>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <000301c1f004$b8c92550$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2002 at 01:06:01AM -0400, Ivica Bukvic wrote:
> I've been trying to get the Crystal Sound (CS4205) notebook (Dell
> Inspiron 8200) soundcard to work with both OSS and Alsa (although I
> would prefer to get Alsa working rather than OSS), but it seems that
> both drivers have insufficient info about this card to get it to work. I
> did get it to "spit-out" sound, but that is the extent of it. I am using
> intel8x0 audio driver (since CS4205 seems to be just the AC97 codec
> while the Intel's chip does the work), but it only allows me non-duplex
> operation which is horrible for any kind of serious audio purposes.

So it works, but it doesn't work?

I have an Inspiron 4100, which also has a cs4205.   I've never tried full-
duplex operation, but it otherwise outputs sound like a champ.  (I'm=20
also the one who wrote the sp/dif support code for it..)

So, we need a little more information about what does and what doesn't
work.   Hell, I'm listening to a mp3 right now...

 - Pizza
--=20
Solomon Peachy                                    pizzaATfucktheusers.org
I ain't broke, but I'm badly bent.                           ICQ# 1318344
Patience comes to those who wait.
    ...It's not "Beanbag Love", it's a "Transanimate Relationship"...

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8zowjPuLgii2759ARAkkjAKDVKQw3qpSsuMoNnywUGxuQtgnOugCgrXI0
3grtkL4q+J3yJ1r/PlKsH6Q=
=Ek8C
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
