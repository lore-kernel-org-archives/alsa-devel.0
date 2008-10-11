From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Sat, 11 Oct 2008 12:36:09 -0500
Message-ID: <1223746569.5193.6.camel@petrie.sacredspiral.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de> <1223583478.5018.0.camel@home>
	<s5hbpxt7zui.wl%tiwai@suse.de> <1223619975.4700.2.camel@home>
	<s5hzlld6j6u.wl%tiwai@suse.de>
	<1223662652.5275.10.camel@petrie.sacredspiral.co.uk>
	<s5hd4i7p1ce.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1498852556162693225=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (carpathia.dereferenced.org
	[64.71.161.129])
	by alsa0.perex.cz (Postfix) with ESMTP id B0A2F1037F5
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Oct 2008 19:36:32 +0200 (CEST)
In-Reply-To: <s5hd4i7p1ce.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, "Ted T. Logian" <tedtheologian@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1498852556162693225==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PmvZbM+5fTse3WIWB2by"


--=-PmvZbM+5fTse3WIWB2by
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

Serial console output from my try with this driver in various modes:

nenolod@petrie:~$ aplay -D hw:2,0 ~/13\ -\ Emerge\ \(Junkie\ XL\ Remix
\)\ \[Explicit\].wav=20
Playing WAVE '/home/nenolod/13 - Emerge (Junkie XL Remix)
[Explicit].wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
XFi DAC reset timeout
=EF=BB=BFXFi DAC reset timeout
=EF=BB=BFXFi DAC reset timeout
=EF=BB=BFXFi DAC reset timeout
=EF=BB=BFXFi DAC reset timeout
=EF=BB=BFXFi DAC reset timeout
^C
<system hardlocks on interrupt>

Noise is now on the right channel only.

It might make more sense to poll for the DAC reset in the interrupt
handler. I have noticed that the card generates an interrupt request in
Windows once the DAC is online.

Something leads me to believe that the DMA mask is 32 bits, but given
that the behaviour is similar in both instances, I am unsure.

William

On Sat, 2008-10-11 at 18:01 +0200, Takashi Iwai wrote:
> At Fri, 10 Oct 2008 13:17:32 -0500,
> William Pitcock wrote:
> >=20
> > With this patch, the driver does output audio, but the DAC dies and we
> > only get noise. Going to try to whack at this with a larger hammer, it'=
s
> > a fairly obvious bug, it just needs some debugging. The noise sounds
> > like the write pointer is off-by-one; it sort of resembles the source
> > audio.
>=20
> OK, good to hear that it's not always locking up.
>=20
> > Some patches for mixer stuff are coming soon (next few hours
> > probably)... as well as chip revision detection and some other
> > niceities.
>=20
> Great.  I'm looking forward to your patches.
>=20
> Meanwhile, the patch below might improve something.
> Basically test sets the DMA mask, and use the continuous pages instead of
> SG buffers (in case it's the error cause).
> Give it a try.  (And I'll update the git tree, too).
>=20
> Also, try different XXX_* flags in sbxfi.c.  The default setting isn't
> completely identical with OSS v4 driver.
>=20
>=20
> thanks,
>=20
> Takashi
>=20
> diff --git a/sound/pci/sbxfi/sbxfi.c b/sound/pci/sbxfi/sbxfi.c
> index 8a0eea0..86dd025 100644
> --- a/sound/pci/sbxfi/sbxfi.c
> +++ b/sound/pci/sbxfi/sbxfi.c
> @@ -66,6 +66,9 @@ enum {
>  #define SBXFI_MAX_BUFFER	(SBXFI_TLB_PAGES * SBXFI_PAGE_SIZE)
>  #define SBXFI_MAX_SRCS		128	/* 256 / 2 */
>  #define SBXFI_TIMER_FREQ	96000
> +/* FIXME: which mask? */
> +/* #define SBXFI_DMA_MASK		DMA_32BIT_MASK */
> +#define SBXFI_DMA_MASK		DMA_28BIT_MASK
> =20
>  #define MAX_CHANNELS		2
> =20
> @@ -154,6 +157,9 @@ struct sbxfi {
>  /* constant ticks */
>  /* #define XXX_CONST_TICKS		(96000 * 5 / 1000) */
> =20
> +/* SG or continuous buffer */
> +#undef XXX_USE_SG
> +
>  #ifdef XXX_48K_ONLY
>  #define BASE_RATE	48000
>  #else
> @@ -796,8 +802,13 @@ static int sbxfi_setup_tlb(struct sbxfi *chip, struc=
t sbxfi_port *port,
> =20
>  	pgtbl =3D (u32*)chip->tlb.area;
>  	pgtbl +=3D port->tlb_index;
> +#ifdef XXX_USE_SG
>  	for (p =3D 0; p < pages; p++, pgtbl++)
>  		*pgtbl =3D snd_pcm_sgbuf_get_addr(substream, p * SBXFI_PAGE_SIZE);
> +#else
> +	for (p =3D 0; p < pages; p++, pgtbl++)
> +		*pgtbl =3D substream->runtime->dma_addr + p * SBXFI_PAGE_SIZE;
> +#endif
> =20
>  	return 0;
>  }
> @@ -1319,7 +1330,9 @@ static struct snd_pcm_ops sbxfi_playback_ops =3D {
>  	.prepare =3D sbxfi_playback_prepare,
>  	.trigger =3D sbxfi_playback_trigger,
>  	.pointer =3D sbxfi_pcm_pointer,
> +#ifdef XXX_USE_SG
>  	.page =3D snd_pcm_sgbuf_ops_page,
> +#endif
>  };
> =20
>  static struct snd_pcm_ops sbxfi_capture_ops =3D {
> @@ -1331,7 +1344,9 @@ static struct snd_pcm_ops sbxfi_capture_ops =3D {
>  	.prepare =3D sbxfi_capture_prepare,
>  	.trigger =3D sbxfi_capture_trigger,
>  	.pointer =3D sbxfi_pcm_pointer,
> +#ifdef XXX_USE_SG
>  	.page =3D snd_pcm_sgbuf_ops_page,
> +#endif
>  };
> =20
>  static int __devinit sbxfi_create_pcm(struct sbxfi *chip)
> @@ -1351,9 +1366,15 @@ static int __devinit sbxfi_create_pcm(struct sbxfi=
 *chip)
>  	pcm->info_flags =3D SNDRV_PCM_INFO_HALF_DUPLEX;
>  #endif
>  	strcpy(pcm->name, "SB-XFi");
> +#ifdef XXX_USE_SG
>  	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
>  					      snd_dma_pci_data(chip->pci),
>  					      1024 * 64, 32 * 1024 * 1024);
> +#else
> +	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
> +					      snd_dma_pci_data(chip->pci),
> +					      1024 * 64, 32 * 1024 * 1024);
> +#endif
>  	chip->pcm =3D pcm;
>  	return 0;
>  }
> @@ -1781,6 +1802,13 @@ static int __devinit sbxfi_create(struct snd_card =
*card, struct pci_dev *pci,
>  	if (err < 0)
>  		goto error;
> =20
> +	if (pci_set_dma_mask(pci, SBXFI_DMA_MASK) < 0 ||
> +	    pci_set_consistent_dma_mask(pci, SBXFI_DMA_MASK) < 0) {
> +		printk(KERN_ERR PFX "Unable to set DMA mask\n");
> +		err =3D -EINVAL;
> +		goto error;
> +	}
> +
>  	err =3D sbxfi_alloc_buffer(chip);
>  	if (err < 0)
>  		goto error;
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>=20

--=-PmvZbM+5fTse3WIWB2by
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI8OQJoB+26npOQg4RAoHgAJ9zVDcHVG7J+CHrEvQUNXD1ID5waQCeIUEw
Ho/z0LfLo70zSrjxuNeR69w=
=sQUv
-----END PGP SIGNATURE-----

--=-PmvZbM+5fTse3WIWB2by--


--===============1498852556162693225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1498852556162693225==--
