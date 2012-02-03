From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: fsi: Add FSI DMAEngine support
Date: Fri, 3 Feb 2012 11:56:52 +0000
Message-ID: <20120203115652.GH3151@opensource.wolfsonmicro.com>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7662838202061371376=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2C6E8103DF9
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 12:56:54 +0100 (CET)
In-Reply-To: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============7662838202061371376==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MP5ln1Rcf9Bvi+ZW"
Content-Disposition: inline


--MP5ln1Rcf9Bvi+ZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2012 at 12:48:46AM -0800, Kuninori Morimoto wrote:

> These are DMAEngine support for FSI driver

Applied patches 1-17, thanks.

> FSI will use PIO version if CPU/platform doesn't have DMAEngine support.

Is this a regression compared to the existing code?

--MP5ln1Rcf9Bvi+ZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPK8t+AAoJEBus8iNuMP3d2cwP+gM+xV4Vs0urilNoDur2+MnV
+1TzZqGdPFhdXYXE5QZaAXSQ10GmQN15NTN+kl93soUCe1Ma/ivoMPfvP+h5DDw0
cQrDzVr6/0SK760s4OBrjOo8BaRmJV+6y6VdKxNwqV8MFBJuAHIYHjvqBGmn+d4p
Q3lQFodY0W67VVA8mjRPQjmOF4N5snPzphi6vSMtOJC0rfcVHJpKAu7/2Tk3RRQ0
dyDjUOT5fImed20OLwcIiqqjewAExovCG//NwvewJUKN1LHCaYMdLk438MufzxrF
iUaMSE1W0IPpz5T9pkPmXAQavbU0xoKdliOaG4Jqj/9ICOxmEx1aPpzKCrntr1qe
aTRt4kb6JgpIqD8/ZVjLVhKstDIkis/GxWkHP4Hs0Znflpq/9VsQYk7X6T4niZaj
wuXCcpx38mfIp+jmJeS5lpovGPCVx0SXcUS6m4S6B3LVWuOIEcGZDG9KmS+gF2JA
g9BReLVPcPZJg5civi8QGImq3Cm5m9bl6R4aQuMjz6pjkcQfDrhStRErTg9zyuLR
F9AvnqH4lm+kF6jgF57BrihX8MJce0TgouXN40rOWim2JLrcVAH8LZ8JDNNytIQK
tyJSWNSyOz5kw7argRZfqp5a/+Q7ODK46f+E2DrRniLNLU8KltrZ7n0xTC6XX599
ACIspOKWbLVlMnnZgKNo
=7DaE
-----END PGP SIGNATURE-----

--MP5ln1Rcf9Bvi+ZW--

--===============7662838202061371376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7662838202061371376==--
