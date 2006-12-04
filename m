From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] create device symlink in snd-aoa
Date: Mon, 04 Dec 2006 09:50:09 +0100
Message-ID: <1165222209.5553.54.camel@johannes.berg>
References: <20061202101445.GA15619@aepfle.de>
	<20061202101526.GA15631@aepfle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2133895478=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E3861191
	for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2006 09:50:13 +0100 (MET)
In-Reply-To: <20061202101526.GA15631@aepfle.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Olaf Hering <olaf@aepfle.de>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2133895478==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-noxvHUtz6Yf/OlPWuFPT"


--=-noxvHUtz6Yf/OlPWuFPT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-12-02 at 11:15 +0100, Olaf Hering wrote:
> create sysfs device symlinks for snd-aoa in /sys/class/sound/controlC0
> This allows hald to recognize the device as sound device.
> Furthermore it allows the desktop user to actually access the sound=20
> device nodes. hald and related packages will modify the acl attributes.
>=20
> Fixes https://bugzilla.novell.com/show_bug.cgi?id=3D106294

This is probably the best solution we can come up now. I've been
pondering doing this for a while and wasn't really sure which of the
devices to use, this simply uses the i2s bus device.

Technically, this isn't really correct because the actual control is
with the i2c codec chip, but there may be multiple so this is probably
as good as we can do right now.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

> Signed-off-by: Olaf Hering <olaf@aepfle.de>
>=20
> ---
>  sound/aoa/aoa.h                           |    2 +-
>  sound/aoa/core/snd-aoa-alsa.c             |    3 ++-
>  sound/aoa/core/snd-aoa-alsa.h             |    2 +-
>  sound/aoa/core/snd-aoa-core.c             |    4 ++--
>  sound/aoa/fabrics/snd-aoa-fabric-layout.c |    2 +-
>  5 files changed, 7 insertions(+), 6 deletions(-)
>=20
> Index: linux-2.6/sound/aoa/aoa.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/sound/aoa/aoa.h
> +++ linux-2.6/sound/aoa/aoa.h
> @@ -99,7 +99,7 @@ struct aoa_fabric {
>   * that are not assigned yet are passed to the fabric
>   * again for reconsideration. */
>  extern int
> -aoa_fabric_register(struct aoa_fabric *fabric);
> +aoa_fabric_register(struct aoa_fabric *fabric, struct device *dev);
> =20
>  /* it is vital to call this when the fabric exits!
>   * When calling, the remove_codec will be called
> Index: linux-2.6/sound/aoa/fabrics/snd-aoa-fabric-layout.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/sound/aoa/fabrics/snd-aoa-fabric-layout.c
> +++ linux-2.6/sound/aoa/fabrics/snd-aoa-fabric-layout.c
> @@ -1014,7 +1014,7 @@ static int aoa_fabric_layout_probe(struc
> =20
>  	ldev->gpio.methods->init(&ldev->gpio);
> =20
> -	err =3D aoa_fabric_register(&layout_fabric);
> +	err =3D aoa_fabric_register(&layout_fabric, &sdev->ofdev.dev);
>  	if (err && err !=3D -EALREADY) {
>  		printk(KERN_INFO "snd-aoa-fabric-layout: can't use,"
>  				 " another fabric is active!\n");
> Index: linux-2.6/sound/aoa/core/snd-aoa-alsa.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/sound/aoa/core/snd-aoa-alsa.c
> +++ linux-2.6/sound/aoa/core/snd-aoa-alsa.c
> @@ -14,7 +14,7 @@ MODULE_PARM_DESC(index, "index for AOA s
> =20
>  static struct aoa_card *aoa_card;
> =20
> -int aoa_alsa_init(char *name, struct module *mod)
> +int aoa_alsa_init(char *name, struct module *mod, struct device *dev)
>  {
>  	struct snd_card *alsa_card;
>  	int err;
> @@ -28,6 +28,7 @@ int aoa_alsa_init(char *name, struct mod
>  		return -ENOMEM;
>  	aoa_card =3D alsa_card->private_data;
>  	aoa_card->alsa_card =3D alsa_card;
> +	alsa_card->dev =3D dev;
>  	strlcpy(alsa_card->driver, "AppleOnbdAudio", sizeof(alsa_card->driver))=
;
>  	strlcpy(alsa_card->shortname, name, sizeof(alsa_card->shortname));
>  	strlcpy(alsa_card->longname, name, sizeof(alsa_card->longname));
> Index: linux-2.6/sound/aoa/core/snd-aoa-alsa.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/sound/aoa/core/snd-aoa-alsa.h
> +++ linux-2.6/sound/aoa/core/snd-aoa-alsa.h
> @@ -10,7 +10,7 @@
>  #define __SND_AOA_ALSA_H
>  #include "../aoa.h"
> =20
> -extern int aoa_alsa_init(char *name, struct module *mod);
> +extern int aoa_alsa_init(char *name, struct module *mod, struct device *=
dev);
>  extern void aoa_alsa_cleanup(void);
> =20
>  #endif /* __SND_AOA_ALSA_H */
> Index: linux-2.6/sound/aoa/core/snd-aoa-core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/sound/aoa/core/snd-aoa-core.c
> +++ linux-2.6/sound/aoa/core/snd-aoa-core.c
> @@ -82,7 +82,7 @@ void aoa_codec_unregister(struct aoa_cod
>  }
>  EXPORT_SYMBOL_GPL(aoa_codec_unregister);
> =20
> -int aoa_fabric_register(struct aoa_fabric *new_fabric)
> +int aoa_fabric_register(struct aoa_fabric *new_fabric, struct device *de=
v)
>  {
>  	struct aoa_codec *c;
>  	int err;
> @@ -98,7 +98,7 @@ int aoa_fabric_register(struct aoa_fabri
>  	if (!new_fabric)
>  		return -EINVAL;
> =20
> -	err =3D aoa_alsa_init(new_fabric->name, new_fabric->owner);
> +	err =3D aoa_alsa_init(new_fabric->name, new_fabric->owner, dev);
>  	if (err)
>  		return err;
> =20
>=20

--=-noxvHUtz6Yf/OlPWuFPT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFc+FB/ETPhpq3jKURAs5IAJ4yoy/6QWfWBrCPa6Wym8CimHx92wCgrCSE
OspSLAwkvfQ3nespvVojI38=
=CNzO
-----END PGP SIGNATURE-----

--=-noxvHUtz6Yf/OlPWuFPT--



--===============2133895478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2133895478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2133895478==--
