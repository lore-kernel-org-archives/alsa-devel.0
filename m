From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [RFC] Add dB scale information to AK4xxx codec
Date: Sun, 3 Sep 2006 16:53:57 +0100
Message-ID: <20060903155357.GA10408@tarte.seehuhn.de>
References: <s5hlkp96qfm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1993778615=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hlkp96qfm.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1993778615==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

sorry about the delay, I was travelling again.

On Mon, Aug 28, 2006 at 01:38:21PM +0200, Takashi Iwai wrote:
> Also, I found an error in AK5365 capture gain and fixed in this patch.
> Now there are two capture volume controls, "Capture Volume" and
> "Capture Gain Volume".  The former is the attenuation up to 0dB, the
> latter is IPGA (independent gain) in AK4524/4528.  Jochen, please
> try this patch with your revo 5.1 board.

I do not quite understand the new volume controls.  I think something
is wrong, now.  What is the expected behaviour of the controls?

=46rom table 17 (page 35) of the AK5365 specs I think that IPGA and DATT
are only separate units inside the chip, but should be treated as one
continuous scale for the purpose of the driver.  The table looks like
the input volume can be adjusted in steps from "mute" to +12dB.  Why
would we want two controls here?

Also I notice the presence of a "PCM Capture Gain Capture" control,
which looks wrong.  I can change "PCM Capture Gain Capture" on its
own, but when I change "PCM Capture Gain", the "PCM Capture Gain
Capture" control jumps to have the same value.

I hope this helps,
Jochen
--=20
http://seehuhn.de/

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE+vqVf+iD8yEbECURAodQAJsGQO84lgmAy249TuALqoMpYFFaJgCgtgO+
a5xYVs5+igJEZBOHCd80/1U=
=vKz+
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--


--===============1993778615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1993778615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1993778615==--
