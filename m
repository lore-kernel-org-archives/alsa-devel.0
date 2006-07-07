From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 01/12] snd-powermac: no
	longer	handle	anything with a layout-id property
Date: Fri, 07 Jul 2006 10:22:44 +0200
Message-ID: <1152260564.15068.20.camel@localhost>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
	<s5hac7yvfhe.wl%tiwai@suse.de> <jehd26aa25.fsf@sykes.suse.de>
	<jeu0631xpr.fsf@sykes.suse.de> <1151619973.22380.50.camel@mindpipe>
	<jehd231rjx.fsf@sykes.suse.de>
	<1152250720.9862.32.camel@localhost.localdomain>
	<1152259477.15068.15.camel@localhost>
	<1152260005.9862.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0184403380=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E71B4221
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 10:22:49 +0200 (MEST)
In-Reply-To: <1152260005.9862.53.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Andreas Schwab <schwab@suse.de>, netstar@gatheringofgray.com, linuxppc-dev@ozlabs.org, Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org


--===============0184403380==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TkXpQI0LYMuBogDIuLYp"


--=-TkXpQI0LYMuBogDIuLYp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-07 at 18:13 +1000, Benjamin Herrenschmidt wrote:

> Maybe ... or not... I'd rather not bother. I think Alsa should be able
> to create softvol if there is no Master volume...

But how long should it wait for the master volume to become available?
Thing is, as far as I understand this, the mixer is dynamic and you can
add and remove things at any time essentially. No one does, but that's
another story.

johannes

--=-TkXpQI0LYMuBogDIuLYp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARK4Z0aVg1VMiehFYAQIckw//cQnUujl+RT4Bbaifc4Wj8V5kqrLyXhBL
BfJiaHwqGKKtkz1MWRXGy7VWsfbR+G60kAuxlEJaCR+w3KYBn8UneQQMmLFxBrSf
Kmy0xlH6DdxbPaNN4yK8EYntbWP7uX2EeIOVr0WJ/vr2piTGA2Ekg24wct34r25W
XCIinD8W4skevV1fNQ8O5fNdGefEAwLJrFypbJQBTs305EjBXi/WxEiXfdhDg0XD
C5/RBEUCsnPioXeuy2yGeHW/oVpAfWGLcnxHXHZskYeGYk44NaMLhWyctWmSQH4n
y0sSDwcz1bXpoOXIaTl8T5QCQAVwm+23h9WMlP3yfG6MuzzeD/8b9Fq5tZegGv08
FIcTLmIq+kaXiZvZWEG88KLiBnZjcoECns8TiS07FwP8EAxyOjkzJPhf9Q2ypnLg
jFhnzXbYM7Gs2VY966E/5/jo204xwKjdpnQ0HRpwJ+EKPe37JptbOz1iPCcUbmA6
LjN+alzetJBM2e9CU6oD5IMrHzHqdBjS1DdSoIlfj00XqYNKx/YMW6tICclCvlib
hXdLXSEJM0VcCqxd4zW3u268fBEfA/47nhqdkffgkgTCOBfH6l+lNIhnvD3ZbVTF
n1VNWqACL01wsDVK8MA+um1kwO7k7zV9zl1dqcrxTbrG3C3dAZpKV0NMhLsSzZGM
c7WANAN4z3E=
=K4HQ
-----END PGP SIGNATURE-----

--=-TkXpQI0LYMuBogDIuLYp--



--===============0184403380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0184403380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0184403380==--
