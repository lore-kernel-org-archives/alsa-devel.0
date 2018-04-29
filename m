From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 10/11] ASoC: AMD: Add const to snd_soc_ops
	instances
Date: Sun, 29 Apr 2018 21:52:20 +0000
Message-ID: <CAGS+omDEcX_FdemOsJjmFON9WBYODBRrJZwDKXcQ_ksTJmzkRA@mail.gmail.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524741374-13523-10-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f196.google.com (mail-ua0-f196.google.com
 [209.85.217.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 82A19266EBE
 for <alsa-devel@alsa-project.org>; Sun, 29 Apr 2018 23:52:31 +0200 (CEST)
Received: by mail-ua0-f196.google.com with SMTP id a2so3899516uak.2
 for <alsa-devel@alsa-project.org>; Sun, 29 Apr 2018 14:52:31 -0700 (PDT)
In-Reply-To: <1524741374-13523-10-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vijendar.Mukunda@amd.com
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, tiwai@suse.com, Mark Brown <broonie@kernel.org>, weiyongjun1@huawei.com, alexander.deucher@amd.com, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 5:18 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> From: Akshu Agrawal <akshu.agrawal@amd.com>

> Marking snd_soc_ops instances const

> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>   sound/soc/amd/acp-da7219-max98357a.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
b/sound/soc/amd/acp-da7219-max98357a.c
> index fa5ad5b..133139d 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -171,17 +171,17 @@ static void cz_dmic_shutdown(struct
snd_pcm_substream *substream)
>          da7219_clk_disable();
>   }

> -static struct snd_soc_ops cz_da7219_cap_ops = {
> +static const struct snd_soc_ops cz_da7219_cap_ops = {
>          .startup = cz_da7219_startup,
>          .shutdown = cz_da7219_shutdown,
>   };

> -static struct snd_soc_ops cz_max_play_ops = {
> +static const struct snd_soc_ops cz_max_play_ops = {
>          .startup = cz_max_startup,
>          .shutdown = cz_max_shutdown,
>   };

> -static struct snd_soc_ops cz_dmic_cap_ops = {
> +static const struct snd_soc_ops cz_dmic_cap_ops = {
>          .startup = cz_dmic_startup,
>          .shutdown = cz_dmic_shutdown,
>   };
> --
> 2.7.4
