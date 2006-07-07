From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 01/12] snd-powermac:
	no	longer	handle	anything with a layout-id property
Date: Fri, 07 Jul 2006 11:55:06 +0200
Message-ID: <1152266106.15068.34.camel@localhost>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
	<s5hac7yvfhe.wl%tiwai@suse.de> <jehd26aa25.fsf@sykes.suse.de>
	<jeu0631xpr.fsf@sykes.suse.de> <1151619973.22380.50.camel@mindpipe>
	<jehd231rjx.fsf@sykes.suse.de>
	<1152250720.9862.32.camel@localhost.localdomain>
	<s5hpsghwxny.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1573560524=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 71EB6276
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 11:55:20 +0200 (MEST)
In-Reply-To: <s5hpsghwxny.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, netstar@gatheringofgray.com, linuxppc-dev@ozlabs.org, Lee Revell <rlrevell@joe-job.com>, Andreas Schwab <schwab@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============1573560524==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HaeAWssTSe3NyMMqNg66"


--=-HaeAWssTSe3NyMMqNg66
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-07 at 11:51 +0200, Takashi Iwai wrote:

> Currently, it's aliased to PMacToonie.conf, so that "PCM" volume is
> added automatically when no corresponding h/w volume eixsts.

Will submit a patch to name it "PCM" then on tas instead of "PCM1"

johannes

--=-HaeAWssTSe3NyMMqNg66
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARK4veKVg1VMiehFYAQK+/A//U2nLucaP6G1jZy1y462kQ5BX0HSYY5WK
YfoLrGBlBvbqTs6GgWJEhaTx32vBcVZ3HXvf80QJF3ayhvLGQcPpnct3SaVpZ+cS
Qb0+2G8zTnhUOnwfeWs2r8pCmx4emzfZuX28VI3KaAV6ga/Ek2KPIhBWm+230OnY
/wKiiTM09P0XUKSKJM6fKG0IQoSAXHOkz3YNIUnJl4oQpmT7D96w84heS/OPS8bL
snAAZ2rga2waEmkArIZacoljSNp9BYdDoRn3GvgO/gw9yjz69T7TjyBfHfIVPVUA
i/7YqttgzkDCpeSrxnP5hmZqA07tjdQQRp34KO59tgc+6Z2X4FrzOA67x+irVzn+
g3KHhBznNw7mWN6LIQByRc8cR0K2RNv5yk8Jf8VHi0FJ6RplQpwAPp5tYo5P2hyH
fMD3I4nIr6T9tsO+gCc26gnfZzJPix2Fkb1x0t6sEQFqrKqpXWF9JPhaJ4FLVKh5
VdI9ePjt2gAhIEdGd+XQNZ/NucHdVsYr09st3NBIko9Iw93FzKhSxE5Ykde7HpJx
SFNeSIBPaqEauJ53BUlH9mrwrbiPnAsRORe+yD/kDBGEosw40Yr4mfBI/oV9UmRX
NakC21NvgAYnEnbJ9uyBo3AvEigDRMt5qUUp2VGJuvNDlWMW2iEhnvA9DcTd7+Ma
9Aagty/ciLI=
=3KMZ
-----END PGP SIGNATURE-----

--=-HaeAWssTSe3NyMMqNg66--



--===============1573560524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1573560524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1573560524==--
