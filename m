From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: wm9713: convert to regmap
Date: Mon, 26 Oct 2015 11:02:57 +0000
Message-ID: <20151026110257.GH10520@ck-lbox>
References: <1445722627-28854-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id D9AA926062F
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 12:19:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1445722627-28854-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 24, 2015 at 11:37:07PM +0200, Robert Jarzmik wrote:
> Convert the Wolfson WM9713 to regmap API. This will leverage all the
> regmap functions (debug, registers update, etc ...).
> 
> As a bonus, this will pave the path to gpio chip introduction, and
> devicetree support.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: fix suspend/resume (that specific part is not tested yet)
> ---
>  sound/soc/codecs/Kconfig  |   1 +
>  sound/soc/codecs/wm9713.c | 296 +++++++++++++++++++++++-----------------------
>  2 files changed, 152 insertions(+), 145 deletions(-)
<snip>
> @@ -1156,16 +1165,17 @@ static int wm9713_set_bias_level(struct snd_soc_codec *codec,
>  
>  static int wm9713_soc_suspend(struct snd_soc_codec *codec)
>  {
> -	u16 reg;
> +	regcache_cache_only(codec->component.regmap, true);
> +	snd_soc_cache_sync(codec);

I am assuming we don't want to be doing a cache_sync just after we
have marked the regmap as cache only.

>  
>  	/* Disable everything except touchpanel - that will be handled
>  	 * by the touch driver and left disabled if touch is not in
>  	 * use. */
> -	reg = ac97_read(codec, AC97_EXTENDED_MID);
> -	ac97_write(codec, AC97_EXTENDED_MID, reg | 0x7fff);
> -	ac97_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
> -	ac97_write(codec, AC97_POWERDOWN, 0x6f00);
> -	ac97_write(codec, AC97_POWERDOWN, 0xffff);
> +	snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x7fff,
> +				 0x7fff);
> +	snd_soc_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
> +	snd_soc_write(codec, AC97_POWERDOWN, 0x6f00);
> +	snd_soc_write(codec, AC97_POWERDOWN, 0xffff);

Also as you have already marked the regmap as cache only these
writes won't go to the hardware.

Thanks,
Charles
