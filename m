From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Fix not to keep a
 reference to	tplg fw
Date: Thu, 26 Nov 2015 11:01:23 +0000
Message-ID: <20151126110123.GZ1929@sirena.org.uk>
References: <1448547060-32749-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5hoaeh6t8w.wl-tiwai@suse.de> <20151126091016.GK25173@localhost>
 <s5hio4p6rt4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5822126909911845355=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 069702614C5
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 12:01:34 +0100 (CET)
In-Reply-To: <s5hio4p6rt4.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5822126909911845355==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3rx43rDlPB5nB2+S"
Content-Disposition: inline


--3rx43rDlPB5nB2+S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 26, 2015 at 10:19:51AM +0100, Takashi Iwai wrote:
> Vinod Koul wrote:

> > So in SKL, we do request firmware of topology binary and topology core uses
> > that for strings here, so the patch 87b5ed8ec freed the topology binary
> > which causes panic while accessing kcontrols.

> This is strange.  If it's about the kctl name string, the panic
> shouldn't happen at accessing the kctl but at instantiating the kctl
> from snd_kcontrol_new that contains the invalid string pointer.
> The kctl object contains the string in itself, and there copies the
> string from the template.

I guess it's possible that if the control creation happens soon enough
after the memory is freed the data will still be valid.  This could be
tested for by hacking things to deliberately trash the memory before we
get to control creation.

> You really need to identify which path hits the issue exactly how.  In
> general, the string passed to template is only for creating the kctl.
> Once when kctl is created, the whole snd_kcontrol_new template and the
> allocated string is no use, so they can be freed.

That does suggest a fairly simple fix of just holding on to the firmware
for longer assuming that the analysis is correct.

--3rx43rDlPB5nB2+S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWVuaDAAoJECTWi3JdVIfQtqcH/iqWjeFeD5eGqt/SUXyfra+k
jLumgdeDsWVsCsqntqR3jQRtKJFfeM1qSnb2ePmYDrCSxm6kPNJ8zoMBFO1Gz6eF
vd2/U62UnhIMF0MWgd46jXkNQ2dmdvM+E26bNl16jxN0kktCS0+ntDaD6zaM4W4e
b6LnA61JD7YoUjGZTHOanFUvSgiPLo0BWX1A7xN+VzGL1BGpYEgcfu+5B90lQKx9
n9/62M8kD4rLS0HHE6Dvn0azsoyBAaLcZLsLXj3l7HM4d4PDMONcfZqCGIp0p2Bo
V25QuH4CSj/CZ13ZCPra7qnFw1qQ5Z7t+T7Y0vCTSfLEnYnkrTss4NbifnqlrNA=
=Czl4
-----END PGP SIGNATURE-----

--3rx43rDlPB5nB2+S--

--===============5822126909911845355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5822126909911845355==--
