From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Wed, 22 Feb 2012 17:18:44 +0000
Message-ID: <20120222171843.GA3265@opensource.wolfsonmicro.com>
References: <s5h39aj5569.wl%tiwai@suse.de> <4F3516E4.2080706@canonical.com>
	<20120210155003.GA11701@sirena.org.uk>
	<4F35413F.9000701@canonical.com>
	<20120210163946.GG6472@opensource.wolfsonmicro.com>
	<s5hy5s625w8.wl%tiwai@suse.de>
	<20120213154458.GB3494@opensource.wolfsonmicro.com>
	<s5hwr7qzl6g.wl%tiwai@suse.de>
	<20120213192309.GG3494@opensource.wolfsonmicro.com>
	<s5hk43e24la.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4291132009976157738=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7C4EF245C2
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 18:18:46 +0100 (CET)
In-Reply-To: <s5hk43e24la.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============4291132009976157738==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 05:52:17PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Now that the kctl jacks are there I'm getting people asking me about it
> > often enough so I'd like to see it merged.

> Yeah, if things were easy, I'd be happy to merge.
> But, judging from the situation, I see no big reason to hurry too
> much.

I'm not sure what problems you see here - all the issues that are being
discussed here are about the kctl interface to applications, there's no
issues I can see with the in-kernel interfaces.

> Yes.  My concern is then how to map the existing jack API to the new
> name.  Thus I proposed some examples.

But this is an issue solely concerned with the userspace API and is also
going to result in something different to what HDA is doing currently.
I don't see that we need to wait for everyone to make up your mind
what's going on there in order to deal with the custom userspace
interface that HDA has.

Once we've got everything unified then we can refactor in place as we
please and whatever is done will cover all drivers, including any
updates to the core interface required to advertise the new information.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRSMnAAoJEBus8iNuMP3d57AP+gJQ62FmZqN6pE+NXYLnNgLO
N2IfHxSXEHYhsJ+4smk6nQeiLtpMxHJCQddyFmFfnd83pDJVjmuM/E4eKxqiSlqG
lzcda8toUOBIqFEXtvE+ITkW0ESptOcPkp42z2cueZwAl2IID7m/VY/crrs7BhR7
4ZPWCriL5k1X2V4wlgo1QtoRYApsgLlobS9pbC5jzFhjlRNHwY6eYm1R8vCgsp5K
8QnRFo3lA55QmevExZftF5FED93I75KJTJOWtI9EX7FZqCJFNz8L6AS9wVxqdcJl
yvOY/1QkKtgDpH8wUQIsCx3dMHFOVRPtckbIh73aF6OFVdyhWa1gGC0SBbFyFsJY
J38ya/DzUNkRpyRZ/jyAEo334eS3snYdr2sh7dtoXqKmEubXw6jXewH9Lx5/LPlM
g4CliMk93dCpPTtFiWkYOCmvU6cca3khbOpJowH2vTznGBbLJ5ZwrGiBqeMriuEr
DUYBpfzYScTU+lIvpMeb3sV0pX5CUymna54L3zuJ71ApxCHS1A+24COAklrh+vOQ
+3QZ5/menvc/xo/57Loxv9eBw7oEqZtBsgtkb9kcLWob6I0EZEjllUnxrfHikRzJ
6szYpQKdFa39xIg0lFPR0gFUTjD2iLHaAaWM6OVUvcYLkoZ+/0tYCA1+cywsVs2I
ALuiGgz5wOuovdlIDQq2
=PHR3
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

--===============4291132009976157738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4291132009976157738==--
