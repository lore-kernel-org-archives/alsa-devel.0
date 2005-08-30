From: Harald Welte <laforge@gnumonks.org>
Subject: Re: No sound on ATI IXP with Realtek ALC655 rev0 (MSI Megabook S270)
Date: Tue, 30 Aug 2005 14:24:23 +0200
Message-ID: <20050830122423.GC4295@rama.de.gnumonks.org>
References: <200508291419.34270.rene@exactcode.de> <200508301130.42008.rene@exactcode.de> <s5hhdd73glc.wl%tiwai@suse.de> <200508301149.46320.rene@exactcode.de> <s5hek8b3fpu.wl%tiwai@suse.de> <s5h7je33d59.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h7je33d59.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2005 at 12:57:54PM +0200, Takashi Iwai wrote:
> > Harald, the patch might fix the problem on your laptop, too.
> > Could you check it?
>=20
> I found that Harald's case is a bit different.  It uses ALC658 instead
> of ALC655, IIRC.
> The patch below is a newer version with more comments.
>=20
> Harald, please add the PCI SSID of your device in
> alc655_is_using_eapd() function and let me know whether it works.

The PCI ID's are the same:

0000:00:14.6 0703: 1002:4378 (rev 01)
	Subsystem: 1462:0131
        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 5
        Memory at fbdfcc00 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=3D0/0=
 Enable-

And unfortunately this patch also doesn't make the speakers work for me,
sorry :(

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDFE/3XaXGVTD0i/8RAjmaAJ95YyRgAd3tm5vGTETSgRdIMtY0EQCfTueO
T6Bn0fs7kxhcFYU58NTaJYg=
=01sf
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
