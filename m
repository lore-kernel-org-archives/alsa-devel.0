From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 2/2 v2] ALSA: hda - Deferred probing with
 request_firmware_nowait()
Date: Thu, 9 Aug 2012 16:04:03 +0200
Message-ID: <20120809140403.GA10145@avionic-0098.mockup.avionic-design.de>
References: <20120809080713.GC24808@avionic-0098.mockup.avionic-design.de>
 <s5hzk64earo.wl%tiwai@suse.de>
 <20120809103430.GA1560@avionic-0098.mockup.avionic-design.de>
 <s5hobmk2ql5.wl%tiwai@suse.de> <s5hd3302ovw.wl%tiwai@suse.de>
 <s5ha9y42os2.wl%tiwai@suse.de> <5023BAA0.1080304@canonical.com>
 <s5h4noc2ntn.wl%tiwai@suse.de> <s5h1ujg2nm7.wl%tiwai@suse.de>
 <5023C0FC.2030207@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2643890270188533377=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id EFDC7266341
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 15:34:22 +0200 (CEST)
In-Reply-To: <5023C0FC.2030207@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2643890270188533377==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 03:54:04PM +0200, David Henningsson wrote:
> On 08/09/2012 03:36 PM, Takashi Iwai wrote:
> >+/* callback from request_firmware_nowait() */
> >+static void azx_firmware_cb(const struct firmware *fw, void *context)
> >+{
> >+	struct snd_card *card =3D context;
> >+	struct azx *chip =3D card->private_data;
> >+	struct pci_dev *pci =3D chip->pci;
> >+
> >+	if (!fw) {
> >+		snd_printk(KERN_ERR SFX "Cannot load firmware, aborting\n");
> >+		goto error;
> >+	}
>=20
> Another thing, aren't you missing a
>=20
> chip->fw =3D fw;
>=20
> here?

Adding that line here fixes the problem for me.

Thierry

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQI8NTAAoJEN0jrNd/PrOh+1MP/32F4f/B7NVwAF0xDBuZhYaB
DN9KkfSUi8Y8O7wJnIpi2INXjuO4DQycbJuLw4Om645R+Ok1m/EUtM9s30Lm3Mkc
3iJTo6598mwMHuI5qMLIJ+5j0iY3saSCqHLgexY/9FeyVpvRLj5zlp9f/n+aOhwf
U1ZYHtfoLsh9JpeppbnfTtCe/3RkpMsOYsMoF8iMRc8IourVC6grBIrTBRV3qDcp
XufoM8Ik1CwmTD86cfEcVGvA6SDMt4zFFwSEdJVQstKHuXRPugOGiB7V9Qe1E4yU
Rb89YDORAhcxDPRz812ki0GN6l8CdownZ+MlZ+URG98h40CqPyM+Vfa8AYgJWvwu
HYgnr3/dGh9n7h19NdENN7e6pqrb5HgxvgbJM4z85l6GWLwUC50NehQJs2McYeNf
ChIE65aH8gfyrCQmIxvpelv6tw2jBHNhmGnAymSK6YYp1lgHLiDPRBxn5wGGtqZr
kzARmrgLHnyV37F650dTfw64Eo8R0dZt3rF3hCXbeUvDzDYXTJYYZGEuNIZwYNCF
H9GvINevaMscUAsz09+q4QgBNZZ5S/FNstPrSTZBctatYkTJ1WaQ+prrd4Ayb3o3
yv77I1aKEOFDxfA6Ash9NMvdQi9q3Ev+BVj6CA+Fk9Zn+4/VVwSSpV7zW3SspOmk
Gj9yPgwxCwRq9EiAUFeC
=JnU1
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

--===============2643890270188533377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2643890270188533377==--
