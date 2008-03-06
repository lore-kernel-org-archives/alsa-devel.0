From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: [RFC] add a "private" field to the ac97 struct
Date: Thu, 06 Mar 2008 11:12:37 -0600
Message-ID: <1204823557.2939.5.camel@petrie.sacredspiral.co.uk>
References: <20080306164211.GA8205@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8673855430685227407=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (carpathia.dereferenced.org
	[64.71.161.129])
	by alsa0.perex.cz (Postfix) with ESMTP id D21831038E8
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 18:12:40 +0100 (CET)
In-Reply-To: <20080306164211.GA8205@Chamillionaire.breakpoint.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Cc: alsa-devel@alsa-project.org, Nicolas Pitre <nico@cam.org>
List-Id: alsa-devel@alsa-project.org


--===============8673855430685227407==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eyGlfb53s1Sv1D02PPpj"


--=-eyGlfb53s1Sv1D02PPpj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Why not modify ucb1400_detect_irq() to get an openfirmware handle on
PowerPC and read the resource tree at that time? This seems like a
better approach.

William

On Thu, 2008-03-06 at 17:42 +0100, Sebastian Siewior wrote:
> I have a PowerPC board with an AC97 controller and that one has an
> UCB1400 attached.
> Currently the UCB1400 driver discovers the interrupt via probing. This
> doesn't really work here. The resources are read from the device tree.
> I haven't found any other driver besides ucb1400_ts that uses the
> ac97_bus_type so I can't check where others get their HW information
> from.
>=20
> My proposal is to introduce a new field in struct snd_ac97 where the
> AC97 driver can leave the required HW info regarding the attached (in my
> case the interrupt for the ucb1400) before calling snd_card_register().
> I attached just a single int field since I am not aware if multiple
> devices / resource are realistic / possible. In that case maybe a void *
> or struct platform_device would be a better choice.
>=20
> Signed-off-by: Sebastian Siewior <sebastian@breakpoint.cc>
> ---
>  drivers/input/touchscreen/ucb1400_ts.c |   13 ++++++++-----
>  include/sound/ac97_codec.h             |    2 ++
>  2 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touch=
screen/ucb1400_ts.c
> index 607f993..95d1fea 100644
> --- a/drivers/input/touchscreen/ucb1400_ts.c
> +++ b/drivers/input/touchscreen/ucb1400_ts.c
> @@ -492,11 +492,14 @@ static int ucb1400_ts_probe(struct device *dev)
>  		goto err_free_devs;
>  	}
> =20
> -	error =3D ucb1400_detect_irq(ucb);
> -	if (error) {
> -		printk(KERN_ERR "UCB1400: IRQ probe failed\n");
> -		goto err_free_devs;
> -	}
> +	if (!ucb->ac97->device_irq) {
> +		error =3D ucb1400_detect_irq(ucb);
> +		if (error) {
> +			printk(KERN_ERR "UCB1400: IRQ probe failed\n");
> +			goto err_free_devs;
> +		}
> +	} else
> +		ucb->irq =3D ucb->ac97->device_irq;
> =20
>  	error =3D request_irq(ucb->irq, ucb1400_hard_irq, IRQF_TRIGGER_RISING,
>  				"UCB1400", ucb);
> diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
> index 0148058..bf920a2 100644
> --- a/include/sound/ac97_codec.h
> +++ b/include/sound/ac97_codec.h
> @@ -474,6 +474,8 @@ struct snd_ac97 {
>  	struct snd_ac97_build_ops * build_ops;
>  	void *private_data;
>  	void (*private_free) (struct snd_ac97 *ac97);
> +	/* device attached to the AC97 bus */
> +	int device_irq;
>  	/* --- */
>  	struct snd_ac97_bus *bus;
>  	struct pci_dev *pci;	/* assigned PCI device - used for quirks */

--=-eyGlfb53s1Sv1D02PPpj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH0CYFoB+26npOQg4RApO2AKCJi6yUWXnirAGA68w4jPnzZ7HXdgCgpmlj
91NptiTBmiwQJFAbgYusG2A=
=F59R
-----END PGP SIGNATURE-----

--=-eyGlfb53s1Sv1D02PPpj--


--===============8673855430685227407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8673855430685227407==--
