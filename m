From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC/PATCH] Stop Apple i2s DMA gracefully
Date: Sun, 29 Oct 2006 09:49:23 +0100
Message-ID: <1162111764.14051.32.camel@johannes.berg>
References: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2027411806=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 827ED29D
	for <alsa-devel@alsa-project.org>; Sun, 29 Oct 2006 09:50:43 +0100 (MET)
In-Reply-To: <17732.11228.441627.300383@cargo.ozlabs.ibm.com>
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


--===============2027411806==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Q5ovm06cl0U+RMNcPWfM"


--=-Q5ovm06cl0U+RMNcPWfM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-10-29 at 15:19 +1100, Paul Mackerras wrote:
> This fixes the problem of getting extra bytes inserted at the
> beginning of a recording when using the Apple i2s interface and DBDMA
> controller.  It turns out that we can't just abort the DMA; we have to
> let it stop at the end of a command, and then wait for the S7 bit to
> be set before turning off the DBDMA controller.  Doing that for
> playback doesn't seem to be necessary, but doesn't hurt either.
>=20
> We use the technique used by the Darwin driver: make each transfer
> command branch to a stop command if the S0 status bit is set.  Thus we
> can ask the DMA controller to stop at the end of the current command
> by setting S0.
>=20
> The interrupt routine now looks at and clears the status word of the
> DBDMA command ring.  This is necessary so it can know when the DBDMA
> controller has seen that S0 is set, and so when it should look for the
> DBDMA controller being stopped and S7 being set.  This also ended up
> simplifying the calculation in i2sbus_pcm_pointer.
>=20
> Tested on a 15 inch albook.

Great!

> +			if (in_le32(&pi->dbdma->status) & ACTIVE) {
> +				/* possible race here? */
> +				udelay(10);
> +				if (in_le32(&pi->dbdma->status) & ACTIVE)
> +					goto out_unlock; /* keep running */

Maybe we should clear the S0 bit and then check if it's active?

Clearing the S0 bit when the DMA engine has already stopped doesn't make
a difference, and when it is still active we want to clear S0 in this
'play again case' anyway. Then if we clear it and check the ACTIVE bit
afterwards we can be sure that if it is still set the engine will
continue running.

Other than that, looks great to me, thanks a lot!

johannes

--=-Q5ovm06cl0U+RMNcPWfM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARURrEqVg1VMiehFYAQJJlQ//Qi95p7Md4k0O3/uV5feT65QJQXIBfDfz
Rol8KP/uiK/sqsITC0VvRoDQ1ODrBF4ILupJqNg0+0SnG9xqRzgQfTTVu9zgqrVg
FyBFJu7Q5hRzFiim3wDPrVPfPttqRwIR5aTzTVb0YUD9rE+RGRLqANfLIdTwvqYJ
+uLpZhIoodDiwuzzhMrbOh/yAz5kNNLrQPTjrstvuHbg69ngdmrbua0kZHJKLEjR
yVQayi44Mp5GPi/FruZ6bh0KBoyWP3YZ7zvWtM4Eo/liaZmPQb0agBkJ68/0SgDV
sW4gLs7d5LG0SrgX2z11t3GjJDL4sNf7sw8xM/J+qTpKEwSuM1a/mpL4ep3aERBY
YDViDtw8FGLKBnaxEG7OO0w7A2hhWOI6TEmDns7tt2QnA68K5Qs7MiulHKvWr4kK
Zw2RHw1ILoFrzymwqQ4aPfWbj0v/CBqnXIpBkH6nIUggykrSNp0xM/JIA5arfFNm
sodSb8UK8es0NARbRgrhArrHQUwPVtkS7+jMrbMcneLfZD8EU2sgWtVNAjZIAZGH
oNc/ylWgxlaZzIiYUDLcShGqxk5geoIagAjnuDcPZu17xbNj1x5C08uySaeHTbtH
iCjqpNg2HtcYhLXKL479PoR4qDmMKBrdSndwhjPiLnTuLZJqBVrYAXPBra8kqXrn
OW0Fm5HGmpw=
=aNfW
-----END PGP SIGNATURE-----

--=-Q5ovm06cl0U+RMNcPWfM--



--===============2027411806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2027411806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2027411806==--
