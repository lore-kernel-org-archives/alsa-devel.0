From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 4/7] snd-aoa: add codecs
Date: Tue, 30 May 2006 15:53:25 +0200
Message-ID: <1148997206.4372.13.camel@johannes>
References: <20060528190026.754474000@johannes.berg>
	<20060528190125.927852000@johannes.berg> <s5h8xol9gom.wl%tiwai@suse.de>
	<1148992996.3102.8.camel@johannes> <s5hr72bbqfm.wl%tiwai@suse.de>
	<1148995575.4372.5.camel@johannes> <s5hmzczbpps.wl%tiwai@suse.de>
	<1148996349.4372.7.camel@johannes>  <s5hpshvfwta.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0071437508=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A0DCF142
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 15:53:41 +0200 (MEST)
In-Reply-To: <s5hpshvfwta.wl%tiwai@suse.de>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0071437508==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xkoGql7H/f81wnFrgghD"


--=-xkoGql7H/f81wnFrgghD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-30 at 15:48 +0200, Takashi Iwai wrote:

> Actually the extra notification won't hurt much in practice.
> I've seen that some drivers also don't check the unchanged case and
> return always 1, so apparently the apps work.  But, it's of course
> better to check the state on the driver side.

Yeah, agreed. I'll fix it.

How about making alsamixer actually handle the error cases? In the onyx
codec, there's some things that prohibit changing the s/pdif output if
you dno't use a bitrate that can handle, but alsamixer 'changes' it
anyway...

johannes

--=-xkoGql7H/f81wnFrgghD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHxOU6Vg1VMiehFYAQJ2URAAhnNUEv2U/5vd1Whdj/PboPkawGjcrUYs
XYpdNcDhFWMSrJTbFIziVPWt8LeMdFw2hOI2pWMZj/x64CGteywpDMt/qQgIQ/pL
LuoiJXODDHlmWLKqzBr4Hlm2tLC56KMh7cjvfgAdlsXrc3NXgcwjVqVkUp1vWhGw
pARcK1J//7/h/pjuVem1tcDmQcYKpYBGOc62WqQdiN4NA1JCd5AnqrjrnYnqtInX
Uqta1haaRbfO/LjdbaHHsMOON/eFNU85IR/U794ISZMTaFc4xp4s0hMC51TIfv0m
U6nGA2kHaioVC6hqzQ6pUSn9lJlBiYRHcoln50UaKPGh8yCZwshOWIkpI4nxLaQr
dUlddkVFNaySNj0M5kgLOUft/KgEqCDh+eMI6SH59FbkxTOlz/O59HCFtg65qxMM
5a0v0phJz6C6p2kSpES6yL7my2Al56eAkxP+SpBb2mDrH1S2r+XDppTFqEQQoyR7
xLb145hNsp0bB0oWuun50J0ryqYHpaHQZYxaiYEyE+15Pyn6SmlSpXSVpO6R0k8Q
zXCJmwBwpeZZ5uBudhk0nyMS83rvf63o3A/EXUyIeCNlZSIMVopq4C8osoW3t+HM
QZyqOjZnX5Bhsmg932XIwutu3QRGut2yqVjNACTy+ZMNSlOu28veFGsbRk2jwNXQ
XPnnOZE43zc=
=9SY6
-----END PGP SIGNATURE-----

--=-xkoGql7H/f81wnFrgghD--



--===============0071437508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0071437508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0071437508==--
