From: Tony Vroon <tony@linx.net>
Subject: Re: snd-hda-intel and MSI
Date: Wed, 23 Sep 2009 16:52:43 +0100
Message-ID: <1253721163.3434.57.camel@localhost>
References: <20090923143306.GC4488@aragorn.home.lxtec.de>
	<s5hpr9hzmx0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4866757418308015337=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D40B103897
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 17:53:53 +0200 (CEST)
In-Reply-To: <s5hpr9hzmx0.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============4866757418308015337==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ZjrByk0rbJk02ul8uCdn"


--=-ZjrByk0rbJk02ul8uCdn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-09-23 at 17:43 +0200, Takashi Iwai wrote:
> MSI is broken on some platforms.  IIRC, almost all non-Intel platforms
> didn't work until the recent ones.  So, it can't be enabled blindly as
> default, unfortunately.

Most of the "broken" platforms were AMD with integrated northbridges
where the required HyperTransport MSI mappings weren't enabled.
This is now handled correctly. I've seen graceful reverts where MSI
wasn't possible. (I recently submitted a patch for sata_nv to enable
MSI)

Regards,
Tony V.

--=-ZjrByk0rbJk02ul8uCdn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkq6REsACgkQp5vW4rUFj5qS4ACeLvgxFvYaKFcPodPmpb9dbtrc
6KAAn2F0nwPFnhI4yv4O7F/GSHlSQAij
=9EDd
-----END PGP SIGNATURE-----

--=-ZjrByk0rbJk02ul8uCdn--


--===============4866757418308015337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4866757418308015337==--
