From: Martin Herren <sputnik@on-the-web.ch>
Subject: available sampling rate detection
Date: Tue, 11 Feb 2003 08:53:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030211085359.24a40185.sputnik@on-the-web.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary=")HDCAP?c=.fzyTt0"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--)HDCAP?c=.fzyTt0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hej,

i'm new on this list as well as to alsa.

We need to find out the supported sampling rates (and other parameters) for the pcm devices of soundcards.

We used snd_pcm_hw_params_test_rate() for this, which according to the documentation (http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.html#a53)
should return 1 if the rate is available, 0 otherwise.
The problem is that it always returned an non-null value, for any rate even if we knew it wasn't supported.

Then we found out that we need to call snd_pcm_hw_params_any() first, and then snd_pcm_hw_params_test_rate() returns 0 for supported rates, and a negativ value (-22) otherwise.

Is this the correct way to do the test or did we miss a point ?
If it is correct, the documentation should be updated.

An additional question, what is the correct way to find out all existing cards/buses on a system ? Currently we scan /proc/asound/card?/ for all pcmX[cp]. Is there a better way to do it ?

Thanks,

Martin

-- 
Martin Herren

Protux - A Free Professional Audio Tool for GNU/Linux:
-> http://www.nongnu.org/protux/
Open your Windows - Free your Mind - Enjoy:
->http://gnuwin.epfl.ch



--)HDCAP?c=.fzyTt0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+SKwdENZb8plGFLQRAsobAKCrwLfMlnNtL/Je6PtjGaE0Wsf0ywCePiyj
XFg+j88QL6NZkgkWQ+5A3sA=
=0OFO
-----END PGP SIGNATURE-----

--)HDCAP?c=.fzyTt0--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
