From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH 1/1] ASoC: max98088 - fix element type of
	the register cache.
Date: Fri, 12 Jul 2013 10:31:57 -0700
Message-ID: <CAEUnVG7b7sE5=Cg2fsgGUNeeJPecxHq_M1TSGPQ=TXDGynrupA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
 [209.85.223.175])
 by alsa0.perex.cz (Postfix) with ESMTP id C2CAD265A57
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 19:32:18 +0200 (CEST)
Received: by mail-ie0-f175.google.com with SMTP id a11so13550451iee.6
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 10:32:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Chih-Chung Chang <chihchung@chromium.org>, Evan Ragsdale <Evan.Ragsdale@maxim-ic.com>, patch@alsa-project.org, lgirdwood@gmail.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

+Maintainers and Maxim,

Chih-Chung, please CC maintainers on patches.

On Tue, Jun 25, 2013 at 12:47 AM,  <me@google.com> wrote:
> From: Chih-Chung Chang <chihchung@chromium.org>
>
> The registers of max98088 are 8 bits, not 16 bits. This bug causes the
> contents of registers to be overwritten with bad values when the codec
> is suspended and then resumed.
>
> Signed-off-by: Chih-Chung Chang <chihchung@chromium.org>
>
> diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
> index 3eeada5..566a367 100644
> --- a/sound/soc/codecs/max98088.c
> +++ b/sound/soc/codecs/max98088.c
> @@ -1612,7 +1612,7 @@ static int max98088_dai2_digital_mute(struct snd_soc_dai *codec_dai, int mute)
>
>  static void max98088_sync_cache(struct snd_soc_codec *codec)
>  {
> -       u16 *reg_cache = codec->reg_cache;
> +       u8 *reg_cache = codec->reg_cache;
>         int i;
>
>         if (!codec->cache_sync)
> --
> 1.8.3
>
