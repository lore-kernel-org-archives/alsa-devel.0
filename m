From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC/PATCH] Stop Apple i2s DMA gracefully
Date: Sun, 29 Oct 2006 13:23:38 +0100
Message-ID: <1162124618.14051.42.camel@johannes.berg>
References: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
	<1162111764.14051.32.camel@johannes.berg>
	<17732.34486.450034.459264@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1230542021=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A72BC254
	for <alsa-devel@alsa-project.org>; Sun, 29 Oct 2006 13:24:59 +0100 (MET)
In-Reply-To: <17732.34486.450034.459264@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Paul Mackerras <paulus@samba.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, benjamin@sipsolutions.net
List-Id: alsa-devel@alsa-project.org


--===============1230542021==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+D0kmt1sNpcWYtfRNyx4"


--=-+D0kmt1sNpcWYtfRNyx4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-10-29 at 21:47 +1100, Paul Mackerras wrote:
> Johannes Berg writes:
>=20
> > Maybe we should clear the S0 bit and then check if it's active?
>=20
> That's what I do, exactly.

Whoops, missed that, sorry.

> The possible race is that the DBDMA might see the S0 bit set just
> before we clear it, but it will still take a little while for it to do
> the branch, fetch the stop command, and execute it.  So it is possible
> that we clear S0 and then check the ACTIVE bit and see that it is
> still set, but in fact the DBDMA did see the S0 bit set and is in the
> process of stopping, and if we do nothing it will stop and the input
> or output will stall.
>=20
> That's why I put the udelay(10) in there.  It may be possible to do
> better by telling the DBDMA to do a flush and looking at the status
> words in the DBDMA command list.  If we see the status from the flush
> then the DBDMA didn't see S0; if the DBDMA stops before writing out
> the status from the flush then it did see it.  However, the udelay
> seems to work OK and is simple.

Yeah, I just missed the S0 clearing, now I understand. Sorry about that.
Thanks for clearing it up.

So just in case anyone cares
Acked-by: Johannes Berg <johannes@sipsolutions.net>

Thanks a lot,
johannes

--=-+D0kmt1sNpcWYtfRNyx4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARUSdSKVg1VMiehFYAQI/zQ//YFyw5CCRc7mfDnG98DuAdlWfw8EGIUUU
quMtVjsT/CFaSRE9uy0eZU3dPJV21aNzJibVsgqTE1apdCQkCrzkJtHxNlKfDrjs
gX5dQVsDQmvg0A/qDowcYjnw8xMn6xH3O0VJQE44b4PwJohcYWspF/9wx1kLMcb0
mxm+tfwCramyqgZnaLXag70u2+tNmQZPYLuVXn5y5tRkcQq/5TUHZ5zBmGdTMILF
X8eQzvu8X+TQFhXlaNcwQqTkOC+AuMOm6A1GvE+Ud+9ItaqbxDdu04TBo8klO4bY
XJtW5TlrDULrR1IhpRMMr8muEkQXuwiGqUGSyXGmq6Amf3CiqsL7XJ0VPnaePsuI
oBWLqOVB3EVYxE8K7OCsmx7DJh9BOQTRDJemI+UiVrfF/2nH6iJdAW2lHOpTtnAc
k6WCOjKanZIzg4o1sCPcacDqoSHnPbjGXjMN93vzDzyaIK+KsShBn/S2xKC1gzr1
wT7+ASyEvQRCWOdWZ40OwLrtj3CDaaspBLTrnGNGyB0JsbYVbqiLrJmI3gHxeCWf
tLsOmstI0flSyedlUzqjAYX0VhG2rPvUn+0Za94nLq8BJtDCe+80B5t/fDhKnTQK
CVoijbfwhnFt+P/lJmCcX8h87fk9uxwe/l7lQekrWzFSanlChZ6yPICQGRhY8PWf
y2jt+8ZUPa0=
=m4v0
-----END PGP SIGNATURE-----

--=-+D0kmt1sNpcWYtfRNyx4--



--===============1230542021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1230542021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1230542021==--
