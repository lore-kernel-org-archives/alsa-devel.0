From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: alsa hw params on SB Pro
Date: Mon, 7 Feb 2005 23:36:06 -0600
Message-ID: <20050208053606.GB8616@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

I seem to have the following problem.  On snd-sb8 with a SBPro (which is
capable of stereo), the best stereo playback mode is 22KHz - going above
22KHz implies that the output will be only one channel.

If I call snd_pcm_hw_params_set_channels_near with argument of 2
channels, I get 2 channels as requested.  But then I call
snd_pcm_hw_params_set_rate_near with argument of 44100, and have 44100
returned.  Thus I end up with a hwparams that the hardware is not
capable of.

Is there a reason the second call returns 44100 instead of 22050?
Conversely, calling _set_rate_near first and having 44100 returned
should mean that I only get 1 channel returned from _set_channels_near.
Isn't this the point of _near functions after all?

This is with libasound 1.0.8 and drivers version 1.0.8+2 from debian
(kernel 2.4.27).

Thanks,

--=20
Ryan Underwood, <nemesis@icequake.net>

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCCE/GIonHnh+67jkRAi/WAJ9lRMKzFFFVok16gsZqhgyY13G6MQCgil79
oHMbkRzcnUXzczGVeFBymPw=
=9YcJ
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
