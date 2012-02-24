From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound/soc-core: Don't overwrite .poweroff
 in snd_soc_pm_ops
Date: Fri, 24 Feb 2012 14:59:28 +0000
Message-ID: <20120224145928.GQ5450@opensource.wolfsonmicro.com>
References: <a20a22fcfed7b4e62069ef8abebfa89f557646c2.1330080832.git.viresh.kumar@st.com>
	<20120224144618.GM5450@opensource.wolfsonmicro.com>
	<CAOh2x=nHZGCk6vqnKDv4Pz1c2kc=cVCXdqEZhS+AX+qGo=+9+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5284385810029838451=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D0081042D7
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 15:59:30 +0100 (CET)
In-Reply-To: <CAOh2x=nHZGCk6vqnKDv4Pz1c2kc=cVCXdqEZhS+AX+qGo=+9+w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: viresh kumar <viresh.linux@gmail.com>
Cc: pratyush.anand@st.com, Viresh Kumar <viresh.kumar@st.com>, rajeev-dlh.kumar@st.com, bhavna.yadav@st.com, bhupesh.sharma@st.com, armando.visconti@st.com, alsa-devel@alsa-project.org, vipin.kumar@st.com, shiraz.hashim@st.com, amit.virdi@st.com, mirko.gardi@st.com, salvatore.dedominicis@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, lrg@ti.com, vincenzo.frascino@st.com
List-Id: alsa-devel@alsa-project.org


--===============5284385810029838451==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="By57YlnFViWR/M0S"
Content-Disposition: inline


--By57YlnFViWR/M0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 06:57:00AM -0800, viresh kumar wrote:

> What's the preferred heading for sound/soc?

ASoC, this is the sort of thing that is readily discoverable by looking
at the logs...

--By57YlnFViWR/M0S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPR6WeAAoJEBus8iNuMP3d8ewP/3R8lpLrBYoohz8/Tw8kDf8t
hGB2bqzwp8cVm3ztEJWfTfYajEmWxDXbcBDKzzY4lTIxTg661hBBBuauZCR37J2X
SGFrgvq4QtqyPoYntfYiArvfVlTnLieZ52+YfzhSg2ChR/bPo78IyYqbDaIGoUtq
6pX7qAJem0tUHYw0JU//ySHTLHJ/HKgUQYRcWrpTiXyF+gL2DngQhZNmS1ue0Ua4
Qf41Xo8iZ/lYXNIbypjDp9Neu0q1ZBOC3OIj4g8eZ1OMjF5daTLEVDOmDETUemC/
kOHyNSSv6rw8eDhOJZ3eE28yZ/67GBUuF6LTA4WVz4IW8LM2Ebzdf+d/Fwn/8RDp
9l8xpzSWOXmnI3BwYtD8eUcgQUOjghhAXpSiPLf8dUeiKA8s/AS6x2QLzqJJpGla
KGnXulqJNHAB42yEKC3Pn3K3bbJoMrX37RRRrYqLSSOl7b6jTXK6Hp/9aD7oRhaZ
nWymVDlBuQHRpoysWRxupfXSBtyaQFjrXPWachaAfkjnT2UXKJ1vvnAxYq1EsBDV
Wd6Tj77rccIoJEvyl0EpSq5dvyMKSpp74nJcR45eLY7VJQXWhDxF3Cga83qo1SRX
QVluOU5kNuk+Luio7GmAHYEk16R9RhE86PvNLpp+7JQkLOo2a5aUX17d324PRr34
mQ/Dx1ZKOEcsstfw7o40
=went
-----END PGP SIGNATURE-----

--By57YlnFViWR/M0S--

--===============5284385810029838451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5284385810029838451==--
