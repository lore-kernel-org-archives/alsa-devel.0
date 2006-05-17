From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] alsa integer control ranges
Date: Wed, 17 May 2006 14:21:10 +0200
Message-ID: <1147868470.15507.9.camel__23821.3617275052$1147868554$gmane$org@johannes>
References: <1147780945.29795.110.camel@johannes>
	 <Pine.LNX.4.61.0605161430220.9330@tm8103.perex-int.cz>
	 <1147817058.6753.7.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0605170836470.10248@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-G4lvbkVisl3hvEGj4mrA"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8032317C
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 14:21:38 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0605170836470.10248@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, ALSA development <alsa-devel@alsa-project.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org


--=-G4lvbkVisl3hvEGj4mrA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 08:41 +0200, Jaroslav Kysela wrote:

> It's better to have problematic values by default and define a module=20
> (driver) option to enable the "compatible" behaviour.=20

I just committed the patch to be always compatible. I'm not going to
clutter the code even more.

> Otherwise the apps=20
> will be never fixed.=20

True.

> Also, ideally, you can fix apps and send patches to=20
> authors and/or create problematic controls in the dummy driver=20
> (drivers/dummy.c) and send a notice to app developers that they have=20
> broken apps and ask to fix them refering to the dummy driver test case.=20

The dummy driver isn't a bad idea, all the rest is. There are *dozens*
of broken apps, and most of their code is horrid. I couldn't even fix
alsamixer for the 3..28 range brokenness.

johannes

--=-G4lvbkVisl3hvEGj4mrA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGsVNKVg1VMiehFYAQKldxAAug4lXUqIcAbOxDkxZTKj8fv72hi73Lnl
JVGQlehbpyyGSZyJcicUh9ZFOZnXrkMH21DUdyqDSKpUsaq6NleNF3GwqmrK0A+J
4TNwFY2j142s3idfnB53rxiiXDDURSGc1HpruGMqGZH931pU0GdK42n5CtTT3nDe
LnYARWLtYW2FlLbfu2bOlThQuSOqdZAn3HUw00fRBXcJqE0bNNGPkezN4ShfrqAP
4BnXwlSc2j15u4+QazGRCuRtHfBP5rnXFa6Rb+bjFFxOb72FTwwdUf/exrOM4l7y
xSd5c08T9hXvZWADzBGmnO6IEiSSP/2hQk4inoY2UsXxSoxGMWYqYxN2KIT9NxrW
s+gdA/aXdMB4pqI5uM9avbKWv5sixren1VRCfbjJg1Id3p6LMpC4TJTFSWjfEJxu
H/54ycyGrYRDt/syfqfcFXxexLA87uVnP2NaTVDwenOAzoFp6PxFKn+KhZ+WhRWp
LInOU77KFbC3rK94EOVWq7CRzcmDyBc1Wc931S1dkSL7ZBvgnSf6jX08KUAoQzWM
53gyWNhkd0rTgEHMWiWID2oJctx8pFBh30puRWW7mejOYEoPQL5atRvZ5aokTAc7
JaNa1wGakWoKrSOj27T93ed/KylRoOqnOH5PdCcQ3Zv69zc5e17Xpa4cLYQDFcTQ
847+WTLeXZk=
=NSXw
-----END PGP SIGNATURE-----

--=-G4lvbkVisl3hvEGj4mrA--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
