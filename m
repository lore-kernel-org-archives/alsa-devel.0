From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [RFC] Add dB scale information to AK4xxx codec
Date: Thu, 7 Sep 2006 23:18:45 +0100
Message-ID: <20060907221844.GA7188@tarte.seehuhn.de>
References: <s5hpsebjxkf.wl%tiwai@suse.de>
	<20060904192738.GA16291@tarte.seehuhn.de>
	<s5h8xkyk631.wl%tiwai@suse.de>
	<20060905192453.GA2537@tarte.seehuhn.de>
	<s5hr6yokmym.wl%tiwai@suse.de>
	<20060907102954.GA17846@localhost.localdomain>
	<s5hirk0klu9.wl%tiwai@suse.de>
	<20060907110027.GA3030@tarte.seehuhn.de>
	<s5h7j0flu3v.wl%tiwai@suse.de> <s5h8xkvg245.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0083241861=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h8xkvg245.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0083241861==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Thu, Sep 07, 2006 at 04:52:58PM +0200, Takashi Iwai wrote:
> I confirmed that the same behavior appears on AK4524.
> So, it makes much more sense to combine ADC and IPGA controls to a
> single control.
Great, this should simplify things considerably.

> The patch below is the final version I have on my local tree.
> Please check whether it works for you.
It works nice.  I now get

    Simple mixer control 'PCM',0
      Capabilities: pvolume cvolume cswitch cswitch-joined
      Playback channels: Front Left - Front Right
      Capture channels: Front Left - Front Right
      Limits: Playback 0 - 127 Capture 0 - 151
      Front Left: Playback 127 [100%] Capture 0 [0%] [on]
      Front Right: Playback 127 [100%] Capture 151 [100%] [on]

One remaining problem: Unfortunatly left and right volume are
exchanged when recording.  When I record with the setting above (using
arecord) and then replay the recording with aplay all the sound comes
=66rom the left (!)  speaker.

I reactivated my register write spying patch and got

    reg4 <- 00
    reg5 <- 98

for the setting above.  So the actual register writes seem to be ok.
It seems that register 5 corresponds to the left channel (and 4 to the
right channel) on the revolution 5.1 card.

Otherwise everything seems fine.


Minor nit: the code (from ak4xxx-adda.c)

		/* register 4 & 5 */
		if (ak->type =3D=3D SND_AK5365)
			knew.private_value =3D
				AK_COMPOSE(idx/2, (idx%2) + 4, 0, 151) |
				AK_VOL_CVT | AK_IPGA;
		else
			knew.private_value =3D
				AK_COMPOSE(idx/2, (idx%2) + 4, 0, 163) |
				AK_VOL_CVT | AK_IPGA;

looks unnecessarily complicated.  The AK5365 has just two channels, so
shouldn't it be just as follows?

		/* register 4 & 5 */
		if (ak->type =3D=3D SND_AK5365)
			knew.private_value =3D
				AK_COMPOSE(0, idx + 4, 0, 151) |
				AK_VOL_CVT | AK_IPGA;
		else
			knew.private_value =3D
				AK_COMPOSE(idx/2, (idx%2) + 4, 0, 163) |
				AK_VOL_CVT | AK_IPGA;

> FYI, the second patch is for envy24control to make it work correctly
> after changing ADC ranges.
I only tried envy24control a long time ago.  Then it didn't recognise my
card and I ignored it afterwards.  Is it useful?  Should I give this a try?

Many thanks,
Jochen
--=20
http://seehuhn.de/

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFAJrEf+iD8yEbECURAjYLAJ9BCyA7JCUYa4Eb4qgj0CseHz1o9gCfTepZ
rJThT1r7dMELs+GJKRi6pNI=
=xiun
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--


--===============0083241861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0083241861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0083241861==--
