From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: VT8233/A/8235 Clock Problem
Date: Tue, 9 Dec 2003 13:46:20 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031209104620.GC835@master.mivlgu.local>
References: <20031208210455.GF1802@sirius.home> <NDBBLGIKBJENLAMOLFHGMEAIEDAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <NDBBLGIKBJENLAMOLFHGMEAIEDAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 08, 2003 at 01:17:38PM -0800, Mark Knecht wrote:
>    This sounds encouraging. For those of us not in the know, can you tell me
> anything about *what* dxs support is? Just point me at a web site with an
> explanation if you have one. And what are dxs options 1, 2, 3 & 4 really
> doing?

Seems that the only description is what "modinfo snd-via82xx" gives...

0 (unspecified) - consult the table of known subsystem IDs to find the
real value (use 3 if the subsystem ID is not in the table).

1 - enable full support for DXS channels.

2 - disable DXS channels completely.

3 - enable DXS channels, but allow 48000 sample rate only.

4 - enable DXS channels, allow all sample rates, but don't set the rate in
the codec (always set the codec to 48000).

>    Does this 2-channel motherboard sound chip actually do hardware mixing?
> Or is that for other sound chips in this family?

VIA 8233 (but _not_ 8233A) and 8235 can do hardware mixing of 4 streams
(the streams must have the same sample rate - on the first open the
sampling rate is set, and subsequent streams cannot use anything other).

Actually the chip can support 6-channel output (usually the Mic In and
Line In jacks can be switched to work as outputs - look in alsamixer for
these options, use 'm' to toggle; however, I did not try this myself).
However, in this mode the hardware mixing of multiple streams is not
available (the second subdevice is used for 4- and 6-channel modes).

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1af8W82GfkQfsqIRAhbYAJ4xD1fQ2Y7qbmgGzGQm3dMldfco7ACfXp7Q
TxE5ZK1jslBeZj+iSeY+jMw=
=yX7q
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
