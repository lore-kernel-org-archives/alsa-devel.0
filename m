From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5639 CODEC driver
Date: Tue, 25 Mar 2014 16:57:38 +0000
Message-ID: <20140325165738.GZ2269@sirena.org.uk>
References: <1395627397-6580-1-git-send-email-oder_chiou@realtek.com>
 <20140325133017.GY2269@sirena.org.uk>
 <5331A1D6.2070109@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4163706778156356537=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BC66264F23
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 17:57:47 +0100 (CET)
In-Reply-To: <5331A1D6.2070109@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4163706778156356537==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3rx43rDlPB5nB2+S"
Content-Disposition: inline


--3rx43rDlPB5nB2+S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2014 at 09:33:42AM -0600, Stephen Warren wrote:
> On 03/25/2014 07:30 AM, Mark Brown wrote:

> > Looking at the level of code similiarity between this and the rt5640
> > driver I can't help but think that these should be supported from a
> > single driver - a few quick spot checks of the register map suggests
> > that there's at least some overlap.  There will need to be some device
> > specific handling but it looks like there's more shared than not shared.
> > What are the issues that prevent the code being shared, there may be
> > something I've missed?

> FWIW, I was informed internally (although this certainly isn't
> normative) that RT5639 is RT5640 plus a DSP, and otherwise compatible.
> Related, I have a board that has a RT5639 and I'm running the RT5640
> driver on it for at least a simple use-case, without issue.

OK, it looked to be something like that - in that case the two
definitely should be sharing code.  Something like the current Wolfson
drivers or wm8994 for example, though probably even more sharing is
possible if it's just the addition of the DSP.

--3rx43rDlPB5nB2+S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMbV/AAoJELSic+t+oim9tD0QAIp7z0A4K4NCWZs4V9W97t4C
OJMfmYRafHrsDMTXf/BEtmtJkYUU75cbbt2NgROx+PxUx6QnJ0DIWxanYUHh1Mlx
uw2aBY9iooQFlqevJeuCsuTXZx4nt1caA5OxuC29jNSIM8eSVw1Pfmj/SxmEDSih
YMX+/EdiwdXB+cAagcTO5CV4kG4tfCwNPDeyIHAWgK7VBfJHrutCp097+z71D8iJ
j/rOvrykqPTKq+j8cKNV4alNDXhkC/6OVJYDa7g0bLGGJfqPxAkAUbv4hzUqww/i
jeuz4bpf5rkUzBNRRBvavGMvMsGx9my9IabIPumYSa0iyt0Nyhpce5DT8YQjNA9q
gMLgBpijxtWjhQbPhTgfJgzqxl57gOXQHcL7Pu7Kg8+Trv3+yCxgIFuw/aBsdMhX
XqMiJYvN5uPFzC27F+CykBnrW1utRDYMo2Gqdf9k8xdFyPvmq7/xoprnhZzMrGly
VBa14rVty+Zn4e7hFxahCCmPHT7NYJZC3XPjenIUhUJOLKBmA50ZbGbw5uTHb9ps
Itjfbo/ciyDZITgNnzNZZ0RLNVk7ydCzUT/CrH1mSLQCVgojkkHt4RA4p12Ktndy
DSju61Ou0VQW9y58utXza/KDzjdvfx74Dw9fHzTuxW6yOyyL+t5zVgFqBw5/BTJK
UegrGMcuKsvlewW+NZCo
=Lqjs
-----END PGP SIGNATURE-----

--3rx43rDlPB5nB2+S--

--===============4163706778156356537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4163706778156356537==--
