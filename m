From: Johannes Berg <johannes@sipsolutions.net>
Subject: snd-aoa review?
Date: Fri, 26 May 2006 14:41:23 +0200
Message-ID: <1148647283.16989.46.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0987851476=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B9D43177
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 14:41:38 +0200 (MEST)
Received: from [84.135.221.87] (helo=johannes.berg)
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.61) (envelope-from <johannes@sipsolutions.net>)
	id 1FjbdC-0000gA-UV
	for alsa-devel@alsa-project.org; Fri, 26 May 2006 13:41:31 +0100
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0987851476==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nKqlZCSiD+786RGheL3u"


--=-nKqlZCSiD+786RGheL3u
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hey,

I'm trying to make snd-aoa handle all of the layout-id based Apple sound
stuff that snd-powermac can handle so we can remove that part from
snd-powermac and get snd-aoa in. This still requires some changes like
headphone detection, and some more codec support, but most things are
there now.

The code is described at
http://johannes.sipsolutions.net/Projects/snd-aoa and the git tree is
suitable for including into sound/ in the linux sources by just copying
the directory into there and doing the trivial Makefile/Kconfig hookups
(Makefile just add the aoa/ subdir and Kconfig just source
sound/aoa/Kconfig). doc/ should probably removed then.

I'd like to get this reviewed a bit by you, what should I do for that?
Should I post a full patch that adds all the files? Or is it ok for you
to pull the tree with git?

johannes

--=-nKqlZCSiD+786RGheL3u
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHb3cKVg1VMiehFYAQL63w/+M+HnHwSW81EyZV4RnKmxkxkCQh5UzjzN
cYWa4GDc10A4lNKuL3ebfw8cg559x2v8XqbYNeTmaD+LFeerNcwXmVL7KeRk2/HC
J+NZT8kFXgyfzaEU5CsLtxArzFUELd7DFtiK4luBPQK8tx08tVUJBSzTTJoALLWl
b7FUyxUPKtFb+Qq03+pN1AY3Cm17b0op6zMr/fuJrkSwYAje3pWiD8qRusaakoiQ
S3nFICTS5WXUZ7h1MtEoRkTQXLq3oyLqVvorToBltQVf6Pbaqcu8Tiha9SIOemoi
jfkG+SOnXXkYKyfwRCJttHkCFeKoIwvM1nJ+9oX7u1m0aavQ+86XL6awf6j7QMQh
s8Plb3QU/Mx1NQ7FaTVsrUFgiDGtiuMc7AFCJCI4cuYNrjeI0afg+Ogtw4jVMe2D
WxYyGFTz09Dq31XB/7RM3e3QkEnUE1gziL3oQ//nzgautQqBiWyIQBRusVR1oRlY
riJZc+lsCb8hdjZPFzakpjiEdjaMhtm1Lii+sTUMcxPg4XoLDPf3Lg0T+bzC1MiZ
1yVy9EmbhAfRYLGy95Z5PtPVbgV11boDW4rsb1Dn93EgGtZ8gtB9IQFGeUqB0zEX
58+fe+Ny0J9/yqZeR8YF6YqMhRIfR5p4Pv4FxpC+YsR3mZwvbNrEcIJPsSs4rx5Q
X1qPr16Upno=
=80Po
-----END PGP SIGNATURE-----

--=-nKqlZCSiD+786RGheL3u--



--===============0987851476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0987851476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0987851476==--
