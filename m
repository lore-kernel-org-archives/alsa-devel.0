From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: Re: RFC: OSS driver removal, a slightly different approach
Date: Fri, 20 Jan 2006 19:55:25 -0500
Message-ID: <20060121005525.GA29562__5390.90672177753$1137808599$gmane$org@shaftnet.org>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <43D05D0C.1030900@keyaccess.nl> <0D5E76A0-FA1B-4CCC-BFA6-D84FBA1EE39D@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from shaft.shaftnet.org (rrcs-24-73-230-86.se.biz.rr.com [24.73.230.86])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 444D718F
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 01:55:57 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <0D5E76A0-FA1B-4CCC-BFA6-D84FBA1EE39D@yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brent Cook <busterbcook@yahoo.com>
Cc: Rene Herman <rene.herman@keyaccess.nl>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2006 at 01:04:30AM -0600, Brent Cook wrote:
> The Adlib card that I had was just an OPL-2 synthesizer, no PCM =20
> support at all. Normally, it was mono, 9 voices, 2 FM operators per =20
> voice + 3 noise channels, but there was a mode that supported 4 =20
> operators and reduced the number of voices to 4 or 5.

> An OPL-3 is just 2 OPL-2's, one for each stereo channel. I think that =20
> any card with an OPL-3 (SB-16) can act like an OPL-2.

The OPL2 is a 2-operator mono synth, While the OPL3 can operate in a
mode that makes it appear as two OPL2s (stereo, yay!) it has a native
4-operator mode that halves the number of resultant voices, but allows
much more complex instruments, as well as crude native stereo=20
capabilities.  (In the end, to do proper stereo panning you had to use=20
two voices and vary the volumes directly)

Meanwhile.  The original Adlib did indeed use an OPL2, and since the
original Sound Blaster was little more than an adlib with PCM bolted on,
so did the first few Sound Blaster cards (newer ones also dropped the
CMS AM synth chip, first by making them socketed and optional, later by
eliminating the capability altogether) The Sound Blaster Pro upped the
ante to include a mixer, stereo PCM and two OPL2s, one for each channel.=20
Creative Labs quickly revised the SBPro to include a single OPL3
instead, and that's also what went into the SB16 and its ilk (Vibra16,
AWE32, SB32, AWE64, with and without the CSP chip).  They dropped the FM
synthesis capability entirely when they went to PCI cards.

But I digress.

 - Solomon [I think I've used every card Creative put out in the ISA days]
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFD0YZ9PuLgii2759ARAkg9AKDmDCmbkOw+vxGi4qucKOvEu7fgPgCgxgmJ
Le3PWrHT9VSTuTPqkPd9TQ8=
=eGSd
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
