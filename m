From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Subject: Re: Regression 2.6.35-rc6: ALSA Intel HDA/Realtek:
 missing	Beep
Date: Thu, 29 Jul 2010 15:25:32 +0200
Message-ID: <20100729132532.GA18108@darkside.kls.lan>
References: <s5hzkxbtya9.wl%tiwai@suse.de> <s5htynjtwz2.wl%tiwai@suse.de>
	<20100728212745.GA15394@darkside.kls.lan>
	<s5hd3u6alkp.wl%tiwai@suse.de>
	<20100729080930.GA20619@darkside.kls.lan>
	<s5h7hkeae35.wl%tiwai@suse.de>
	<20100729084138.GA15456@darkside.kls.lan>
	<s5h39v2acvf.wl%tiwai@suse.de>
	<20100729091517.GA8902@darkside.kls.lan>
	<s5hlj8utyi3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6215242856093864647=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from piggy.rz.tu-ilmenau.de (piggy.rz.tu-ilmenau.de [141.24.4.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 06058243F9
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 15:25:36 +0200 (CEST)
In-Reply-To: <s5hlj8utyi3.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6215242856093864647==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 29, 2010 at 11:42:44AM +0200, Takashi Iwai wrote:
> OK, then try the patch below (over my previous two patches).  It
> enables PC-beep for your device forcibly.

Yes, it does and it works. Thank you very much again.

I just checked 2 more boards - the P5E-VM HDMI (P5E-V HDMI's little
brother) is already covered by the quirk and P5Q-EM (G45) seems to
specify it correctly (subsystem_id =3D 0x104382fe - seems I got the logic
wrong before - LSB isn't set here and it works).


regards
   Mario
--=20
This project is so important we can't let things that are more important
interfere with it.
                 -- Advertising/Marketing manager, United Parcel Service

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEVAwUBTFGBTBS+e2HeSPbpAQIn1AgAlDzLaBjPNs0UCokOb1MvXiU8S1/R8fja
W2YLhHpSsm0c41O0M7lwVCGl2b6nsZe/tcfZlvFbReFUHBONg79clkDCxLnLHKR6
6YW/a4mTl8/U/ynzUIYqef7r/cLh7MWFyf0wKjbQVVwMM2nZmzKL5pfweDsSnzL8
Fd4qCPnRf6qn5dmcDR+JlZUgdceh5KQdjnJdHNg5pctS4uiZQaQcEm9wR/UVNEDx
B8M++ChfCO/id9OLd/Wt05aTwNvdz+zRGWQa78MSCejfvFSWvLvmF2H1QWyF0i0O
ZWHNxzEDh21+t9w0paDosP58S6fxJ0mg0tIiUinfNF+UmW55aMiadg==
=XC1W
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

--===============6215242856093864647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6215242856093864647==--
