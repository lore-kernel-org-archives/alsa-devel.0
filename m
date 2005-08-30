From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: No sound on ATI IXP with Realtek ALC655 rev0 (MSI Megabook S270)
Date: Tue, 30 Aug 2005 11:30:38 +0200
Message-ID: <200508301130.42008.rene@exactcode.de>
References: <200508291419.34270.rene@exactcode.de> <s5hslws3cma.wl%tiwai@suse.de> <s5hr7cc3c5s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3206848.gl1x2A9N0N";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr7cc3c5s.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--nextPart3206848.gl1x2A9N0N
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Monday 29 August 2005 19:06, Takashi Iwai wrote:

> Anyway, /proc/asound/card0/codec97#0/* files would be needed for
> further debugging.
>
> If it's related with EAPD, does changing the ac97 reg 7ah (misc
> control) bit 1 have any influence?
> You can change the ac97 register value by writing above ac97#0-0+regs
> file.  See alsa-kernel/Documentation/Procfiles.txt for details.

Yes. The register had 0:7a =3D 2092, I echoed "7a 2090" into the proc file =
and=20
voila - sound is working!

Thank you very much!,

=2D-=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45

--nextPart3206848.gl1x2A9N0N
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDFCdBQuICExGFvYIRAuEUAJ0Tq2YpbKQs6mA0FNyTeDqhrZu6WwCfajM1
yOnhb+zShNOoR0TceKhl3JY=
=z3Dd
-----END PGP SIGNATURE-----

--nextPart3206848.gl1x2A9N0N--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
