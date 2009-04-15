From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hda-intel channels hibernate bug
Date: Wed, 15 Apr 2009 18:00:06 +0200
Message-ID: <1239811206.6981.9.camel@johannes.local>
References: <1238921730.3782.3.camel@johannes.local>
	<s5hocuz2xau.wl%tiwai@suse.de>
	<1239715639.22047.0.camel@johannes.local>
	<s5hd4bf2w27.wl%tiwai@suse.de>
	<1239716613.22047.2.camel@johannes.local>
	<s5h63h60zwf.wl%tiwai@suse.de> <1239809427.4809.7.camel@johannes.local>
	<s5hmyaiylkm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4638156060350555629=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id C3D1D244C3
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 18:00:37 +0200 (CEST)
In-Reply-To: <s5hmyaiylkm.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============4638156060350555629==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-THRoK22oE6iAS2k/C+pU"


--=-THRoK22oE6iAS2k/C+pU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-15 at 17:37 +0200, Takashi Iwai wrote:

> Do you mean that it has no effect on the playback volumes, or on the
> recording level?  The former is a bug, the latter not.

> > And the last time I could record sound it was all choppy and sounded
> > clipped.
>=20
> This might have been improved in the recent version.

Actually, nothing seems to have an impact on the recording level, which
is my problem -- audio is clipped.

Look at the waveforms in http://johannes.sipsolutions.net/files/123.wav

johannes

--=-THRoK22oE6iAS2k/C+pU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5gSDAAoJEKVg1VMiehFYKg0P/1tPF9T7Q23HalWy4vFAEhnH
tTBqHRVbVVCS3nqCjecCfZskvqleGwHyYq5URXwotya8n83cwPAs+H6OyjuBjLGx
pHGzLEaS01cURtiy0yK/1Cl0NsZLkEbdNt+W/zvoZOxvaeu977PjaVV9ZRtNFLSy
51jld0bdvTXFHDWp7MwQ5FlqgCtjtxlm34rMwwMqKSVfermEaeaZQ+nUTmjI/LxV
o7SezD++Os7d9DVzV5q3mWokHnXlA3FQtt2bcDs2xuS7Sxl65dxRLjwcVcteg6o9
QNGZh6oyq299tAfwIO3w58FbFovFXROQb3vyIuALxJAO+ScjVVr99kFA23GQDGna
Rz9u00ebOBdNCTiBOfiYRuWoNUPL9ylVgbBT27w4+NUK+rx5LBTEmQXPGR4PFq9h
SiWqS1+Q8FdQZAIx1MdBuS170/e8+oYst047qK1VnoJ6JsMCdt1uXYdo29H2l76Q
T2hMUO4hmPq+jzO5wSiJ0Ki5OSgRa1RiHZzN1MqcXf7tSuZTu/vYAjQbga4LD5MI
J6EjpK8hYIhbXsYvgaD3kX6CyfOQdtYQsSAEDIfLLBiqA+rwkQlpWuu3TXVap229
qdPRxcbosMBzsDnuv3IrA3j9LzteTr+8DlRuUT2pDALnWglNSxrvxJC7tmb1dHno
4VFN5+WMwa0JeYs0vtX5
=YVUC
-----END PGP SIGNATURE-----

--=-THRoK22oE6iAS2k/C+pU--


--===============4638156060350555629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4638156060350555629==--
