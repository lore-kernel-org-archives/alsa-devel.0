From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa: g5 tas codec problems
Date: Fri, 07 Jul 2006 10:49:08 +0200
Message-ID: <1152262148.15068.30.camel@localhost>
References: <1152258426.9862.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0266936122=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 44611245
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 10:49:12 +0200 (MEST)
In-Reply-To: <1152258426.9862.44.camel@localhost.localdomain>
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
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0266936122==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-UomaFieYQfqyDy49U9KL"


--=-UomaFieYQfqyDy49U9KL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-07 at 17:47 +1000, Benjamin Herrenschmidt wrote:
> Also, we should try
> (if not already the case) to cache our clock/i2s state so that
> subsequent prepare() don't try to change things that are already ok.=20

I do that, the function reads the dws and sfr registers and exits early
if they match.

johannes

--=-UomaFieYQfqyDy49U9KL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARK4gAqVg1VMiehFYAQLeKQ/9G3nI8+chYsXcB/yeZZtFkpk6+9LtQumc
IoiHKV0EFSRDb0e0ebWiK7YtJpSnp1LWnDZGLvx+RcfPLAK+lozFQkGKGT619413
Vk4dkHUKEnNwTLQDlgOD+vZMp9ScnIfrRKnfd9HacBkZyD96z+N7gL52QUaYXKfL
MzKqnDpMjbMN/qQbGsDQhPeuMMhtOXiI4NOwekfuYPRrzzXDhRaBHsDWkoZVmS6/
qzXGADl9dNB2PLmjCf5WrOtt4Qb3roG8A/XgS61J90uZwOJiTAjNpEiwwSmP2hqn
ohqTFmqQ6AtFE8WkI1WXUS8YQsHAlaB3oBWzp6q7cY+kzg6/yiC812M9VMsNvabv
wKbzRyjeszZP3xO0HSQ8ueU+yPMJn3UXTB2oBHVcMe4ku04KOU60JO3esQQOmH9E
tCGW4/Qb2Mqlc3SyFW4B9ojL95ozfaHez3Bua0/BKNHOsAHxE7ijLULqxoW49vZ5
kiKEDDPdUddcDU0+oNfRn46g7cjiBRPtwyOXg8xrMtpvuLP8M0VjS2AgNrPnhzg4
3jlB4oYWa/w8aMYGFGAdBy8ZQ8c64Ptzg5WpQiVtXNMIwwbgH/l3E1cSQPLFzIRQ
iaSo8SCZ4dQwzR3sBrmSe8cAxOFeSw2kmzq3Dspq6zuU+DfUeXlHMN3QvdtXlZ0u
bOfm6UyE2kw=
=AfNX
-----END PGP SIGNATURE-----

--=-UomaFieYQfqyDy49U9KL--



--===============0266936122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0266936122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0266936122==--
