From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/2] ASoC: Set up debugfs only once per
	CODEC
Date: Fri, 13 Aug 2010 07:42:44 +0300
Message-ID: <201008130742.45006.peter.ujfalusi@nokia.com>
References: <1281624632-17992-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 8315024439
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 06:42:48 +0200 (CEST)
In-Reply-To: <1281624632-17992-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 12 August 2010 17:50:31 ext Mark Brown wrote:
> Since the debugfs directory is current per CODEC we should only init
> it when the CODEC is initialised, otherwise we end up with errors
> being generated when an attempt is made to add duplicate debugfs
> entries.

But if you move the init of debugfs where you have moved it, than the machi=
ne =

driver given DAPM widgets will have no debugfs entries, since the machine i=
nit =

is going to be called later (dai_link->init)...

> =

> Since most of this stuff is actually for the card we should refactor
> but this can come later.

Sure, refactoring will help, but with this change we have missing debugfs f=
iles =

for widgets, which is kind of confusing.

-- =

P=E9ter

> =

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index a004876..ac0fa22 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1323,6 +1323,9 @@ static int soc_probe_dai_link(struct snd_soc_card
> *card, int num) return ret;
>  			}
>  		}
> +
> +		soc_init_codec_debugfs(codec);
> +
>  		/* mark codec as probed and add to card codec list */
>  		codec->probed =3D 1;
>  		list_add(&codec->card_list, &card->codec_dev_list);
> @@ -1400,8 +1403,6 @@ static int soc_probe_dai_link(struct snd_soc_card
> *card, int num) if (ret < 0)
>  		printk(KERN_WARNING "asoc: failed to add codec sysfs files\n");
> =

> -	soc_init_codec_debugfs(codec);
> -
>  	/* create the pcm */
>  	ret =3D soc_new_pcm(rtd, num);
>  	if (ret < 0) {
