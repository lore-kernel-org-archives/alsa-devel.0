From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Subject: Re: Regression 2.6.35-rc6: ALSA Intel HDA/Realtek:
 missing	Beep
Date: Thu, 29 Jul 2010 11:15:17 +0200
Message-ID: <20100729091517.GA8902@darkside.kls.lan>
References: <20100728144903.GA18170@darkside.kls.lan>
	<s5hzkxbtya9.wl%tiwai@suse.de> <s5htynjtwz2.wl%tiwai@suse.de>
	<20100728212745.GA15394@darkside.kls.lan>
	<s5hd3u6alkp.wl%tiwai@suse.de>
	<20100729080930.GA20619@darkside.kls.lan>
	<s5h7hkeae35.wl%tiwai@suse.de>
	<20100729084138.GA15456@darkside.kls.lan>
	<s5h39v2acvf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4506109900568012951=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from piggy.rz.tu-ilmenau.de (piggy.rz.tu-ilmenau.de [141.24.4.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DA39103955
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 11:15:20 +0200 (CEST)
In-Reply-To: <s5h39v2acvf.wl%tiwai@suse.de>
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


--===============4506109900568012951==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 29, 2010 at 10:52:36AM +0200, Takashi Iwai wrote:
> Usually the codec SSID isn't checked in other places, so passing a
> bogus value should be OK.  Pass a value like 2:

Mh, 1 probably :)

$ cat /etc/modprobe.d/local-alsa.conf=20
options snd-hda-intel model=3Dasus-p5q
install snd-hda-intel /sbin/modprobe --ignore-install snd-hda-intel $CMDLIN=
E_OPTS && { cd /sys/class/sound/hwC0D0; echo -n 1 > subsystem_id; echo -n 1=
 > reconfig; : ; }

Yep, Beep is back :)

Btw...

On Thu, Jul 29, 2010 at 10:26:22AM +0200, Takashi Iwai wrote:
> So, the fix is likely to override SSID value, or create a special
> quirk rule to enable PC-beep for known white-list, supposing BIOS
> won't be fixed in any future...

Well, the Board is from 2007, the last BIOS is from Aug 2009. I don't
think Asus will provide an update just for that :)


Thanks for your help
   Mario
--=20
Unfortunately, the chip vendors have delayed the availability of the
long-promised crystal-ball peripherals yet again, forcing the governor
code to rely on heuristics; once again, software must make up for
deficiencies in the hardware.                  -- Jonathan Corbet, LWN

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEVAwUBTFFGpRS+e2HeSPbpAQLGsQf/dAsW94fg4LqJkoh8tAuAL0Hdj/LrD7BJ
wO3pBQgcfad40KUEVxWTKrelou0HRYWFamZbeOcbjO2sLBKyP8P4ITD3vaT+U746
aG3P1AEGGu22+S0DOldGZY/oRSAqF/ldkNeqb2Han4yGhFj5mJWhpJrPV1IUgFG6
96MsKC1i8w4ksyVNu35Vcmeb/eVWbc0MKKJCDKPun1ExogBwv9135gpKxeuP4kbw
WMeR4TL6CVkOojvvKyonE2ejPjVov8j4CpPv1zoaGYQEtNaIYUhie5tvL0vDp0Mf
DcgHe0Jk6MEqywSUlEuUyHSZVhenq4139KKVCtGdnrUCPOwIL7eIEg==
=cUhG
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

--===============4506109900568012951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4506109900568012951==--
