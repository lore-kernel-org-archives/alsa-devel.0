From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: max9867: Add
	CONFIG_SND_SOC_MAX9867 to build
Date: Sat, 20 Feb 2016 01:37:38 -0800
Message-ID: <CABCoZhDi+80jx6TT=BaGtNnu8_hUE2zBmq4cBD5MOjM9nFnhRg@mail.gmail.com>
References: <1455936752.19371.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com
 [209.85.213.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 697CF261537
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 10:37:39 +0100 (CET)
Received: by mail-vk0-f43.google.com with SMTP id k196so95351759vka.0
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 01:37:39 -0800 (PST)
In-Reply-To: <1455936752.19371.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Acked-by: anish kumar<yesanishhere@gmail.com>

On Fri, Feb 19, 2016 at 6:52 PM, Axel Lin <axel.lin@ingics.com> wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 621c0a3..185a712 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -283,6 +283,7 @@ obj-$(CONFIG_SND_SOC_MAX98088)      += snd-soc-max98088.o
>  obj-$(CONFIG_SND_SOC_MAX98090) += snd-soc-max98090.o
>  obj-$(CONFIG_SND_SOC_MAX98095) += snd-soc-max98095.o
>  obj-$(CONFIG_SND_SOC_MAX98357A)        += snd-soc-max98357a.o
> +obj-$(CONFIG_SND_SOC_MAX9867)  += snd-soc-max9867.o
>  obj-$(CONFIG_SND_SOC_MAX98925) += snd-soc-max98925.o
>  obj-$(CONFIG_SND_SOC_MAX98926) += snd-soc-max98926.o
>  obj-$(CONFIG_SND_SOC_MAX9850)  += snd-soc-max9850.o
> --
> 2.1.4
>
>
>
