From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [PATCH try2 1/2] enable capture from line-in and
	CD on	Revolution 5.1
Date: Wed, 4 Oct 2006 17:22:38 +0100
Message-ID: <20061004162238.GA11969@seehuhn.de>
References: <20061003232655.GA1871@tarte.seehuhn.de>
	<20061003232755.GB1871@tarte.seehuhn.de>
	<s5h8xjwl5u2.wl%tiwai@suse.de>
	<20061004111847.GA2395@tarte.seehuhn.de>
	<s5hlknwjc5t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1904083580=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hlknwjc5t.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1904083580==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, Oct 04, 2006 at 06:09:18PM +0200, Takashi Iwai wrote:
> Thanks, both patches are applied to HG tree now.
Great, thanks a lot!

I tried to get the headphone output working, but to no avail.
Until now I tried the following:

1) I tried setting each and every GPIO line to 1 and to 0.
  Nothing helped.

2) The DAC actually has 8 channels which looks like a waste for a 5.1
  card, so I thought that maybe the last two channels are for the
  headphone output (they actually look connected to something on the
  board).  Optimistically I tried to add a volume control for these
  two extra channels and turned up the volume, but there was still no
  output.

3) I tried to combine 1) and 2), i.e. having the volume up for
  channels 7 and 8 and then to play with the GPIO pins.  Still no
  success.

Do you have any idea what else I could try?  How do other, similar
cards switch between speakers and headphone?

Many thanks,
Jochen
--=20
http://seehuhn.de/

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFI9/OmQikLRypuYcRAnJPAKDlfspOqXK0wTepDDKo27kQiGX4qwCfe0Go
0nB2Zu/hNom5sMy7Qku0DO0=
=XTyV
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--


--===============1904083580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1904083580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1904083580==--
