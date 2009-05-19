From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Mon, 18 May 2009 21:41:46 -0500
Message-ID: <1242700906.8063.191.camel@petrie>
References: <4A108482.4050108@charter.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5324456994966527445=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (unknown [64.71.161.129])
	by alsa0.perex.cz (Postfix) with ESMTP id CB4E62436A
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 04:41:47 +0200 (CEST)
In-Reply-To: <4A108482.4050108@charter.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: daedra <daedra@charter.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5324456994966527445==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-JNvGd3Hcpr0pFq5085uG"


--=-JNvGd3Hcpr0pFq5085uG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 2009-05-17 at 14:41 -0700, daedra wrote:
> Is this driver the same source that creative released a few months back=20
> or has it been updated to support more features?  Just Curious.

The ctxfi code supports all of the hardware PCM features, as far as I
know anyway.  "Features" like the Crystalizer are done in the windows
driver code itself, possibly uploading code to the DSP, but more likely
done in software.

I do not know if MIDI is implemented yet.  Maybe a project for the
summer if not.  MIDI should be similar to emu10k1.

William

--=-JNvGd3Hcpr0pFq5085uG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoSHGoACgkQoB+26npOQg6gEwCePh7ulVySDyuP2RcDWhnVrdSz
nDMAoJGa2JfZGXpSM/G769b5bDC9p6W1
=flwP
-----END PGP SIGNATURE-----

--=-JNvGd3Hcpr0pFq5085uG--


--===============5324456994966527445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5324456994966527445==--
