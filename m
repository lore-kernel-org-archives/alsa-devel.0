From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [BUG] (via82xx) no sound on VIA 8235 sound card with CMI9739 codec
Date: Sat, 27 Nov 2004 16:56:39 +0300
Message-ID: <20041127135639.GB2409@sirius.home>
References: <m2d5y0tnhe.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <m2d5y0tnhe.fsf@vador.mandrakesoft.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 26, 2004 at 08:32:45PM +0100, Thierry Vignaud wrote:
> Hardware:
> =========
> this card is managed by the snd-via82xx driver.
> it's named "VIA Technologies|VT8233 [AC97 Audio Controller]".
> according to /proc/asound/cards, this is a VIA 8235 card with CMI9739
> codec.
[skip]

> 		name 'IEC958 Playback Switch'
> 		value true

> 		name 'IEC958 Output Switch'
> 		value true

For some people CMI9739 started working after they turned off
everything IEC958-related.

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBqIeXW82GfkQfsqIRAjKOAJ4gU2MNDqYewSFscXBgPg+P+F65kgCfQlqI
h0XBgYDdkKRNaHIJx/0V6tc=
=tnkZ
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
