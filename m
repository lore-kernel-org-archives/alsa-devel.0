From: Romain Perier <romain.perier@collabora.com>
Subject: Re: [PATCH] ASoC: es8328: Remove extra blank lines
Date: Fri, 7 Apr 2017 09:42:05 +0200
Message-ID: <cdd2e7f0-72dc-8d4f-1daf-3f187336d6de@collabora.com>
References: <1488019328-9481-1-git-send-email-narcisaanamaria12@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 08E342664EB
 for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2017 09:42:08 +0200 (CEST)
In-Reply-To: <1488019328-9481-1-git-send-email-narcisaanamaria12@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org, john@metanate.com
List-Id: alsa-devel@alsa-project.org

Hello,

Le 25/02/2017 =E0 11:42, Narcisa Ana Maria Vasile a =E9crit :
> This was reported by checkpatch.pl
>
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
> ---
>  sound/soc/codecs/es8328.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
> index 3f84fbd..1967157 100644
> --- a/sound/soc/codecs/es8328.c
> +++ b/sound/soc/codecs/es8328.c
> @@ -177,8 +177,6 @@ static int es8328_put_deemph(struct snd_kcontrol *kco=
ntrol,
>  	return 0;
>  }
>  =

> -
> -
>  static const struct snd_kcontrol_new es8328_snd_controls[] =3D {
>  	SOC_DOUBLE_R_TLV("Capture Digital Volume",
>  		ES8328_ADCCONTROL8, ES8328_ADCCONTROL9,
Acked-by: Romain Perier <romain.perier@collabora.com>

Thanks,
Romain
