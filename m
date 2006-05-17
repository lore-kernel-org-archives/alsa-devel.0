From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] alsa integer control ranges
Date: Wed, 17 May 2006 14:16:58 +0200
Message-ID: <1147868218.15507.4.camel__49019.0145712861$1147868365$gmane$org@johannes>
References: <1147780945.29795.110.camel@johannes>
	 <s5h7j4m40kf.wl%tiwai@suse.de>
	 <1147817023.6753.5.camel@localhost.localdomain>
	 <s5hy7x10y5t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9Zq8cjkjFUA1nO6k30kS"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0C81178
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 14:17:08 +0200 (MEST)
In-Reply-To: <s5hy7x10y5t.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, ALSA development <alsa-devel@alsa-project.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org


--=-9Zq8cjkjFUA1nO6k30kS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 11:59 +0200, Takashi Iwai wrote:

> We have several issuess regarding the conversion of dB <-> raw volume
> values:
>=20
> - some codecs use linear volume
> - some codecs have non-linear dB slopes

And I made a huge table so that the slope is linear! Otherwise it'd have
been logarithmic. Anything else is pretty user-unfriendly though.

johannes

--=-9Zq8cjkjFUA1nO6k30kS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGsUOKVg1VMiehFYAQL1HA//SDp/RiOTHCb481p7thrIQInny/N/7+Fz
mG61MkLxCts8kmxRJz1qF93676DPIXUTn53sipPHX1BmgMz+B9A74BpiN9yEK9Ba
fVst+9s2fzirpA7tpoNIzLczmi3IEvOt+ZBNmeep4q3t0So3GYzQI/QOrMZTDcU5
OxfpZbG/fCy2v6iLoLbpHvV5kSX4+mKLwg3qn951Y+B7wnj1z7KgIpyN9vnc1Y4G
v2mXk08GPu50KfvuCiPjRirZuS8+gdRi9qzsPlKC1kpvjZswFFJSHVpFkjtpy9Nc
4h4Du+AYflsTNL8E+3cXkVxedfmItCxc+yuz9asLCyZ0/Wx6LfxY3sYG1XrrLo+4
M7TKteabxIeLGoLTfXwnaV6pucmGGqk5dSZhLU0HqHuFIhmd/97U6A2K7JZ3JhUQ
aAb0X6W+Lh5gQhKFUguXIzceB6pmcub/BnBBi3AYHHE5zFD+oudpV1xO5Xl2KQ1p
x6XsiZGbPDFjeBwKKYaUG2s1shUo5qv+fiJ5cdysXI/k27sdBCXJgZYrhFGwo5AF
sPEM8SspoA93EaTROriZI+2GiM2xQAdqocby5Ni4F1VTco8cU9O6LKLK2USNA/26
NTE8rtd/Qtzk5SC3CgoKS73AxhdIK+0umlO4z9jJpTd3WGUtciAd3SSrJjSU+SJP
61H/iAqfJvI=
=KSuG
-----END PGP SIGNATURE-----

--=-9Zq8cjkjFUA1nO6k30kS--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
