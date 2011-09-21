From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH] ASoC: Ensure we generate a driver name
Date: Wed, 21 Sep 2011 13:09:30 +0800
Message-ID: <CAHG8p1C28+d5NeyxQ0zCPAqgQ5ZtBNej+Az3PTnNFr==o9Ls=A@mail.gmail.com>
References: <1316524563-22407-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 40F3A10388F
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 07:09:34 +0200 (CEST)
Received: by qyk32 with SMTP id 32so4432190qyk.17
	for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2011 22:09:30 -0700 (PDT)
In-Reply-To: <1316524563-22407-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2011/9/20 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> Commit 873bd4c (ASoC: Don't set invalid name string to snd_card->driver
> field) broke generation of a driver name for all ASoC cards relying on the
> automatic generation of one. Fix this by using the old default with spaces
> replaced by underscores.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> =A0sound/soc/soc-core.c | =A0 18 +++++++++++++++---
> =A01 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 10e5cde..bd20154 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -30,6 +30,7 @@
> =A0#include <linux/bitops.h>
> =A0#include <linux/debugfs.h>
> =A0#include <linux/platform_device.h>
> +#include <linux/ctype.h>
> =A0#include <linux/slab.h>
> =A0#include <sound/ac97_codec.h>
> =A0#include <sound/core.h>
> @@ -1432,9 +1433,20 @@ static void snd_soc_instantiate_card(struct snd_so=
c_card *card)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s", card->name);
> =A0 =A0 =A0 =A0snprintf(card->snd_card->longname, sizeof(card->snd_card->=
longname),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s", card->long_name ? card->long_name :=
 card->name);
> - =A0 =A0 =A0 if (card->driver_name)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 strlcpy(card->snd_card->driver, card->drive=
r_name,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(card->snd_card->driv=
er));
> + =A0 =A0 =A0 snprintf(card->snd_card->driver, sizeof(card->snd_card->dri=
ver),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s", card->driver_name ? card->driver_n=
ame : card->name);
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(card->snd_card->driver); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (card->snd_card->driver[i]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case '_':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case '-':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case '\0':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!isalnum(card->snd_card=
->driver[i]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->snd_c=
ard->driver[i] =3D '_';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (card->late_probe) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D card->late_probe(card);
> --
If '\0', we should break out of loop?
