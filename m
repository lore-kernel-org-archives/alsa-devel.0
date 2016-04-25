From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v3 1/6] ASoC: fsl_ssi: Real hardware
 channels max number is 32
Date: Mon, 25 Apr 2016 10:20:56 -0700
Message-ID: <CAG5mAdwfKTF9Rhz0w622TXPcQ8NtAQ-z=VKiuh=ozu4kNScVuA@mail.gmail.com>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1453130771-24419-2-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F743265068
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 19:21:17 +0200 (CEST)
Received: by mail-oi0-f49.google.com with SMTP id r78so183814129oie.0
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 10:21:17 -0700 (PDT)
In-Reply-To: <1453130771-24419-2-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 18, 2016 at 7:26 AM, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
wrote:
>
> The max number of slots in TDM mode is 32:
> - Frame Rate Divider Control is a 5bit value
> - Time slot mask registers control 32 slots.
>
> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 40dfd8a..cfc78b8 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1167,14 +1167,14 @@ static struct snd_soc_dai_driver
fsl_ssi_dai_template = {
>         .playback = {
>                 .stream_name = "CPU-Playback",
>                 .channels_min = 1,
> -               .channels_max = 2,
> +               .channels_max = 32,
>                 .rates = FSLSSI_I2S_RATES,
>                 .formats = FSLSSI_I2S_FORMATS,
>         },
>         .capture = {
>                 .stream_name = "CPU-Capture",
>                 .channels_min = 1,
> -               .channels_max = 2,
> +               .channels_max = 32,
>                 .rates = FSLSSI_I2S_RATES,
>                 .formats = FSLSSI_I2S_FORMATS,
>         },
> --
> 1.9.1
>

I haven't seen any movement on this patch for some time.  I just wanted to
add my Tested&Reviewed.  These patches work for me on the fsl_ssi.


Tested-By: Caleb Crome <caleb@crome.org>
Reviewed-"By: Caleb Crome <caleb@crome.org>
