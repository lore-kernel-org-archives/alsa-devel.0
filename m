From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: regression in handling VIA onboard sound chip, ALSA, 2.6.13, 2.6.14-rc4
Date: Mon, 17 Oct 2005 20:52:56 +0200
Message-ID: <200510172052.59224.rene@exactcode.de>
References: <200510171032.29040.rene@exactcode.de> <s5hk6gczb6h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6214711.kLSjZWLZ1i";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk6gczb6h.wl%tiwai@suse.de>
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

--nextPart6214711.kLSjZWLZ1i
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Monday 17 October 2005 12:32, Takashi Iwai wrote:

> Ren=E9 Rebe wrote:
> > up to 2.6.12-* the VIA onboard sound chip did always work as expected.
> > Recently (2.6.13.* - I also tested 2.6.14-rc4) I get a timeout reading
> > AC97 registers:
> >
> > PCI: Via IRQ fixup for 0000:00:11.5, from 0 to 4
> > via82cxxx: Six channel audio available
> > PCI: Setting latency timer of device 0000:00:11.5 to 64
> > via82cxxx: timeout while reading AC97 codec (0xAA0000)
> > ac97_codec: AC97 Audio codec, id: ADS112 (Analog Devices AD1981)
> > via82cxxx: board #1 at 0xE000, IRQ 20
>
> No wonder, they are messages from OSS via82cxxx driver...

You are so right - sorry for the stray report. With the ALSA driver all is=
=20
fine as usual.

Yours,

=2D-=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45

--nextPart6214711.kLSjZWLZ1i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDU/MLQuICExGFvYIRAkkLAJ42IQb9TJT/3xhVRCf7x1hPkrVfOQCZARQl
8xRMDFuD4CGbMTYQh/qbfxw=
=i16s
-----END PGP SIGNATURE-----

--nextPart6214711.kLSjZWLZ1i--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
