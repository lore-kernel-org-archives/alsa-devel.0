From: joshk@triplehelix.org (Joshua Kwan)
Subject: Re: Some problems with snd-au8830
Date: Sun, 12 Sep 2004 14:54:50 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040912215450.GD12433@triplehelix.org>
References: <20040912084204.GA22712@darjeeling.triplehelix.org> <1095015988.2056.9.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1095015988.2056.9.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 12, 2004 at 03:22:09PM -0400, Manuel Jander wrote:
> That are hardware error flags. Normally, one "IRQ fifo error" occurrs
> for the first time playback ocurrs. But more than one message of those
> plus the others certainly is odd. I Would try to change the PCI slot. By
> the way, do you mind sending a lspci output, and some general
> information about your system ?

Yeah, I always notice the fifo error when I play for the first time.
There's also usually a large crackle which is kind of bad..

Well, the card is in my last PCI slot. I'll try moving it though.

Here's lspci info:

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version=
?) (rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (re=
v c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (re=
v c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (re=
v c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (re=
v c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (re=
v c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev=
 a4)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev=
 a4)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev=
 a4)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Contr=
oller (rev a1)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 A=
udio Controler (MCP) (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (re=
v a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:09.0 Multimedia audio controller: Aureal Semiconductor Vortex 2 (re=
v fa)
0000:02:00.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD=
 [Radeon 7200]

> Cool that you actually got jackd working :P, i never got it working on
> whatever hardware i have tried it (intel8x0, ESS maestro 2e, au8820 and
> au8830). The aureal driver does support any period size power of 2 upto
> 4096 bytes; that includes 1024 (4096 if that where 16bit stereo frames
> instead bytes). Why jackd was unable to set that up ? I guess the error
> message is somewhat wrong; probably some other parameter could not be
> met.

-p512 -P sounds like utter crap, btw. And if I do jackd -d oss, it all
works very nicely.

Would it matter that my .asoundrc is set up for hardware mixing?

pcm.au8830 {
  type hw
  card 0
}

ctl.au8830 {
  type hw
  card 0
}

Thanks for the help so far.

--=20
Joshua Kwan

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQUTFqaOILr94RG8mAQKvow//TO9Lk7J7cZhaQrDomaSBafoDXYkpaZOj
9FdsnQ9DaSwhlLmOXlG2VWJSo8iXN4pPl6GXCf5TK3vLMslVtVgLpwS3tDiVT0Oa
bKvHUhcZJt6qz7mF1mNm+EhKK5R6zfcE6e2MyOeu2q2Q9ou4QXF/22Ts2UzUGpWo
P/nrawnGAHIkPDrrrc1S0amKDbSIuMpmlAGOQOUlNnUZnzwBZs6hFNvOjs/7A6PO
Bb3qzXdh/nJnf/vdhWZEbUxVvTGFQX8ZDN7P0EAFuSxQ3Xw/GayFZFFs7+cJH8zB
1Oknx/TEpm/Dq8yEMEdrBS24Ze3j/Nnm1qZN33B+MQmE7PGTqRItGgkME09K+45g
/OThdwc+ZYnLb+isyhWY1lX/w9TtDxYiXcliuoAW9CIEa2vcwSfHYS1wLSMrISb0
Omguaq2pAGvXXj+uMSv02sjt0Z7LVikDULdBUXSg91MCz9Y1fl+NNDksaMFFOP80
YQj6ZBAcFx2WpZXGYbG32YKfVCwhrXfWHUPm8WaAbTf7vHRGy/ksqk3fdXmS0F8s
P27JCyxFQjJ0DpN+yUYRUQNDd+h56mgIyezl3/W1Wr7+Mru8jAJOAqum80h8YoNP
liZmfcD/dr/aR3Xg4fndNUPTJNMHfq8BbZOMm3CI6tyMcftMnfT6dfL6H51Hk+UU
KvsIbJrZh3w=
=Fze6
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
