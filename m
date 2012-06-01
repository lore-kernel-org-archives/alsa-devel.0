From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Confusing about Playback/Capture, CODEC/CODEC links,
 and snd_soc_dapm_link_dai_widgets()
Date: Fri, 1 Jun 2012 22:41:47 +0100
Message-ID: <20120601214146.GD4258@opensource.wolfsonmicro.com>
References: <4FC7F576.30101@wwwdotorg.org>
	<20120531233702.GA30717@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8170618358707878714=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6985224456
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2012 23:41:49 +0200 (CEST)
In-Reply-To: <20120531233702.GA30717@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8170618358707878714==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2012 at 12:37:09AM +0100, Mark Brown wrote:
> On Thu, May 31, 2012 at 04:49:26PM -0600, Stephen Warren wrote:

> > But if (2) is correct, I wonder why soc_dapm_stream_event()'s first if
> > statement appears to consider the playback_widget of both sides of the
> > DAI to be coupled; wouldn't one side's playback widget be coupled to the
> > other side's capture widget?

> The DAIs on CPUs have the opposite sense to DAIs on CODECs.  In a
> traditional CPU<->CODEC link we do connect the two playback widgets
> directly to each other.  The current code isn't correct, it's not
> normally noticable since most of the time the CPU DAI end of the link is
> a baseband which doesn't do anything real and is always activated
> bidirectionally so it really makes no odds which widget we look at.

> I'll fix this tomorrow.

Sorry, I misremembered the context here (should've looked at the code
not the quote!).  The current code is correct, it will only be used in
the case where we have a "real CPU" not the CODEC<->CODEC case so it's
doing the right thing.

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPyTcRAAoJEBus8iNuMP3d+PcP/3ifZ/QT/8Zq0xSlP87jfQAO
WViRBolW3D8H+vTgErGa1aSkktuOjPmLkQcDU91n33mL8ix2++je0belXIzFpdvc
khX2gHqBnn88Ojz4ONvCm/96XuYUBZiTYD0S66MK7dfmyijzR6Tw2b9IVxC2y1hX
AxWZ6V5O452AvuWJj5f3704FC3g4ew/jgwVEKXH8JCWhuNnKAXHSKp5OdGojtrYP
e8FvKHI9OprITfPysJGFRpZ6odD6lRN1WFPJU0pUPCe5HgUUQlqLb7DEvdtv0BBq
KgveETJM3DP6jmljpwUkwutmtcILxssO1aWh7efJGfc/LWOJXcwTgUxey4urQPR2
0ZzmOsQ9/I6Mh2LeYr6bMsp2c+mjhaRRrTDRgFXMsmW8Y9bpNwnKidzYIspl90WJ
4HmQGIlmYnRzx91QVbxuw8e8rcjoDYPb4g6sVQgDFzWTvfbMgiP0pFaBvAk44cYk
zzYr3OqYpL8Wy4Zuwb2SdGQBLDuPkP8r2gwotj6X7mJGqSuEKzUyvpia9wp1MM0r
Q0Qnhu3xrrkHbrFaZDOnoyRdJyZTRGbZ0PPS2KfZFQ2IS/Jq6QJy88TAYs2nQHRL
VIj2IIOzpjkbMGQ2bbS9/90AZ1YHWNk94357Pgwuy96N+Osv+DCSRDuUuhioczu7
vt0TrFYwWj0UD19IZm5A
=KpKn
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--

--===============8170618358707878714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8170618358707878714==--
