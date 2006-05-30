From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 4/7] snd-aoa: add codecs
Date: Tue, 30 May 2006 15:39:09 +0200
Message-ID: <1148996349.4372.7.camel@johannes>
References: <20060528190026.754474000@johannes.berg>
	<20060528190125.927852000@johannes.berg> <s5h8xol9gom.wl%tiwai@suse.de>
	<1148992996.3102.8.camel@johannes> <s5hr72bbqfm.wl%tiwai@suse.de>
	<1148995575.4372.5.camel@johannes>  <s5hmzczbpps.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0861103746=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9BB81142
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 15:41:54 +0200 (MEST)
In-Reply-To: <s5hmzczbpps.wl%tiwai@suse.de>
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


--===============0861103746==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-UxCJmYgR3/VOVxVI+McB"


--=-UxCJmYgR3/VOVxVI+McB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-30 at 15:35 +0200, Takashi Iwai wrote:

> And I thought the put callbacks in your code always return either 1 or
> -err?

Yeah, they return 1 if the change was applied (or no change) and -err if
there's an error about the change (only in very few cases).

I figured the extra notification wouldn't hurt, and to the application
there wouldn't be a problem.

johannes

--=-UxCJmYgR3/VOVxVI+McB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHxK+qVg1VMiehFYAQKNyQ/+MkfMuZcBA4ipYh8v9NrEm+LXfSlzfZJG
iwWwoHLnzBQf3Yi1/o/ay6z5cRjgMQlGp3MkgQkuAx5GigkRbkrinJw33UBaz3SI
PuzOHTe5cUQO51CWWme8UIrsKFm0Kb2HZOWOfsrBW5NvGeDxo3U63P0aqtrtpvy0
8/LL2Fd9iibeGvW6aEqqL+rtSKNhtZPXqDvOOyzQSgFQhRuw0oLPkaOilTJ0DY3u
JBcvpQ9HS3TKK+uFc9ii5vTX+KmeJoKZuYgdL+rSCbGrn0X5nNDLa+gunBzTYS+q
dAnKET+2QKON4R8f7umoff5w7ozVp90QOaoM9HzKGMWXFq1+pvTbK7FikEhdO+Pg
IMIAQrQLdvrTTeY0+ifwpteIp0TzMR07KvE84aDY8zmXBEPtmYdM8oTXqAYn+akH
L8ZvE5QnBv+0BiYrHBnV06NjDocA8mzjor79BoeFmdci2EJmP5O0UmZ/qcqOlm++
K50O5VqedcVwDGf2ESZORp65f0a2xDU42rPKxGkVKDk7PHTD/EHSFlOon9FDn3zc
0mK0Rd7b/LyUMmliQjiqvRcUhcm/tqyajuRsqGu2QXqg0Xy0z4wA8HCOl3qD2Zvs
RDzigmeJJmSEnpmrIl/YkOPjM830uE/IDWP5fx5mbCROe1wWVPxHO4hGJUfbCTTy
s6om8mr0MrE=
=qhIM
-----END PGP SIGNATURE-----

--=-UxCJmYgR3/VOVxVI+McB--



--===============0861103746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0861103746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0861103746==--
