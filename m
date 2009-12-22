From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/1] Do not write to invalid registers on
 the wm9712.
Date: Tue, 22 Dec 2009 17:59:27 +0000
Message-ID: <1261504767.3555.2.camel@odin>
References: <1261502938-11137-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1261502938-11137-1-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org, patch@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2009-12-22 at 12:28 -0500, Eric Millbrandt wrote:
> This patch fixes a bug where "virtual" registers were being written to the
> ac97 bus.  This was causing unrelated registers to become corrupted (headphone 0x04,
> touchscreen 0x78, etc).
> 
> This patch duplicates protection that was included in the wm9713 driver.
> 
> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
> ---
>  sound/soc/codecs/wm9712.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
> index 0ac1215..e237bf6 100644
> --- a/sound/soc/codecs/wm9712.c
> +++ b/sound/soc/codecs/wm9712.c
> @@ -463,7 +463,8 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
>  {
>         u16 *cache = codec->reg_cache;
> 
> -       soc_ac97_ops.write(codec->ac97, reg, val);
> +       if (reg < 0x7c)
> +               soc_ac97_ops.write(codec->ac97, reg, val);
>         reg = reg >> 1;
>         if (reg < (ARRAY_SIZE(wm9712_reg)))
>                 cache[reg] = val;
> --

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
