From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Problem with snd_soc_suspend
Date: Thu, 17 May 2012 22:46:05 +0100
Message-ID: <20120517214604.GK26337@opensource.wolfsonmicro.com>
References: <4FB0A685.3040408@codeaurora.org>
	<20120514083430.GG31985@opensource.wolfsonmicro.com>
	<4FB55DDE.30804@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9014480971920985439=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BD78E103D27
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2012 23:46:08 +0200 (CEST)
In-Reply-To: <4FB55DDE.30804@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============9014480971920985439==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HkMjoL2LAeBLhbFV"
Content-Disposition: inline


--HkMjoL2LAeBLhbFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 17, 2012 at 01:21:50PM -0700, Patrick Lai wrote:
> On 5/14/2012 1:34 AM, Mark Brown wrote:

> >This sounds like expected behaviour, if the widgets aren't marked as
> >ignoring suspend then they will be suspended.

> As CODEC is getting more complicated and more widgets would be defined,
> I don't think it's scalable to mark ignore suspend per widget.

You only have to do this for widgets on the edge of the graph, it's
just the same input to output algorithm that's applied as normal but
with a subset of input and output widgets being considered.

> >No, the whole point here is to suspend.  If we did that we'd never
> >suspend any active streams.

> If so, what is purpose of ignore_suspend? My problem is that active
> stream which has ignore_suspend flag set ends up suspended because an
> inactive stream without ignore_suspend flag set happens to be using
> same CODEC but different digital audio interface. I don't think it's
> the right behavior. DAPM should maintain widget usage reference. Only
> If all CODEC DAIs that are using given widget are going to suspend
> should DAPM go ahead power off the widget.

The suspend of the device is somewhat orthogonal to the suspend of the
device as a whole - the device as a whole is suspended if there are no
active widgets and the widgets will go inactive if they're not part of
an active path.  You will at the very least always have to mark inputs
and outputs that are connected to the DAIs as ignoring suspend, adding
something to flag the DAI widgets now we have those should be trivial.

--HkMjoL2LAeBLhbFV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPtXF1AAoJEBus8iNuMP3d03oP/2tLVROs1hUCgPIxgfwSf2VQ
RHND8FQKZlhafIV3/j1nps2du/WCRYndwSis+o87PplRLwXTFMXrsC2D5tWyALKf
QAzVgzBepjpuOBH3g03HQU8GXgRA8oq74ZcKlfFrsFkUfBzg1QEC2rkeoDaq9O3e
5swaDyOMc1+ZvG5IS+ikiCNM1ZqujnlzdnbHxwwxDCTBYnv4hAXD8/PfY86jDI0X
izABa1mCwRfSvcTgzxF0zHmMgXzL3y4OgBSBxB0Y4xoa9SJ5Xi6Eb34eEG0WD/MB
mfVXEo/JVr2N9yFcx2R1r0QWSZCuORL04JJ92zHsN/UGDCSbsYM6iCanncd7NRrX
Lht9IGvtUd3wVTGvaxSdYzHoeCJc6uZlc+rTKA7IgmhvoECYnL0NF6CXETWgNa2m
8iOvYmB6QHw2ntwP/G2LIkghzO2byjucVkW/OrPWTKboElKbY7ZtCtyPehTcpgnr
qAMKxMOl+MHeeAsHsx2mHd2uSI1SQSMSx2+etrmnYPHkGQ0y6m1BwyQGRQrJqk2D
nDkK0dB9lJsJlYYlfA5fXPA3VwGYPIhFJDIjWBqh1Og7YbIYMpKzljh3EWSylZ2k
dmwoT900bre91UzwAyz0WlhYe5FBWyhG2racpK2MwnsN6dcD7RphacvrWt2rCDpB
Y4dZKGEpXDMCTimJsWsx
=hLeJ
-----END PGP SIGNATURE-----

--HkMjoL2LAeBLhbFV--

--===============9014480971920985439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9014480971920985439==--
