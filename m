From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: TODO list
Date: Fri, 30 Jun 2006 14:08:00 +0200
Message-ID: <1151669280.13412.4.camel@localhost>
References: <4475F316.5000908@superbug.co.uk>	<s5hpsi1qc1h.wl%tiwai@suse.de>
	<4476E687.10608@superbug.co.uk>	<s5hfyiwpzoe.wl%tiwai@suse.de>
	<44772DE3.60104@superbug.co.uk> <s5hslmwu3s2.wl%tiwai@suse.de>
	<44773B3C.4020206@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0772767630=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 18D71240
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 18:52:28 +0200 (MEST)
In-Reply-To: <44773B3C.4020206@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0772767630==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Waywum2wwQBjpiBptmfU"


--=-Waywum2wwQBjpiBptmfU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hah, finally found the thread. I knew there was something like this
lingering about.

> I was thinking more along the lines of User App -> OSS kernel shim ->=20
> userland daemon buffer, one buffer per user app -> alsa-lib.
> So, the mmap would not be a real mmap, it would be a simple matter of=20
> tricking the User app into thinking it is mmapped. It would be a double=20
> buffer really.
> So, the daemon buffer would just be whatever size the OSS user app=20
> wanted, and the daemon would then pass it's contents to alsa-lib or=20
> jackd as and when needed.
> All this would probably only be possible if some high res timer source=20
> (e.g. the system timer) was used to trigger the period boundaries. I=20
> think I mentioned that idea some time ago. Maybe we should just aim for=20
> that TODO item to help dmix work better at 44100Hz, and then worry about=20
> the OSS kernel shim after that.

I wonder if the kernel 'shim' should really be tied to OSS. I see
another application for this: bluetooth audio. Currently, there's a
kernel plugin that as far as I can tell doesn't do much more than
exactly this, push data it received from one side to the other side, the
actual communication is done in userspace. If we had a generic 'sound
driver' below alsa that could create any card with any mixer (compare to
the uinput layer!) then we could do *all* of that in userspace with
standard means.

And for the OSS emulation it'd just mean re-using that existing
interface and the existing oss emulation code (which moves and is
changed to only apply over virtual devices), and putting all the tricky
stuff into the oss daemon.

johannes

--=-Waywum2wwQBjpiBptmfU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARKUUHqVg1VMiehFYAQLGtw/9Fl6nnYJpHsHpUMFwsj5G6WVtW29jKKAD
sZ6qdo53GHzxc40PxrjmaGt5j2/WmQqWq/SgWutvsRppniiGE9kzlTF329NUbMUE
XGjzgwR0wKZFbEZXUGp/f8+jGygnUOf0VTmz3uDgQ4EUKxQiWlMufoEM7/Cab2he
lIp3oAoMAYn1cYedLyi7Gl8i7IXSaIE68wTVQRGnUY5SdxBcY/z4cWOGOgGTHn1X
eVKrCRMO4tRFgy368KrbqjZmuSuun1pyw14mqZ9IW6BbnXoI44nvU60BN1qUq8oF
6hChaGDACaDKnC88jwYE3BRyxEU8jk+TqJeCgzuZ201KbCQtvWMYNif4fiCGunfR
znIGsaB4B5cKr4EGdNs5VgC44vckFtcNieKAouoyeHZYQ8ezDZgPHppWfXAboM/T
pTL2YgssLBQ5MyR6BwzAfblWgk/v7TLODtZLx/+hGJDxPmTsl39l0YDeCQcB+2fe
VOm6qJL8C0jj8xSxvuhc+83Uuc+S2XuLSb2nwDXmVAQDWHQcDHet9pF+XGVsK+8N
EgUyNvPRTkhLZLaO1roEfZ2WYwGcOIrTDyf/xYOfjQjJqYf+J67JnmcHe+PmXIJ6
YMqQWzaX2XSFoLy92c4SZGTvWKHGndm4xYo8ztLbmSxZUN+Kplk9ehfqzZpDLd1Q
ZE/2SASguQw=
=CuJR
-----END PGP SIGNATURE-----

--=-Waywum2wwQBjpiBptmfU--



--===============0772767630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0772767630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0772767630==--
