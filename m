From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: soc-cache: Add support for
 standard register caching
Date: Fri, 22 Oct 2010 09:03:51 -0700
Message-ID: <20101022160351.GE16521@opensource.wolfsonmicro.com>
References: <1287757702-9573-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1287757702-9573-3-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 21F98103863
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 18:04:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1287757702-9573-3-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 22, 2010 at 03:28:20PM +0100, Dimitris Papastamos wrote:

> +static int snd_soc_cache_default_sync(struct snd_soc_codec *codec)
> +{
> +       const u8 *cache;
> +       struct snd_soc_codec_driver *codec_drv;
> +       unsigned int val;
> 
> +	codec_drv = codec->driver;
> +	for (n = 0; n < codec_drv->reg_cache_size; ++n) {

Please use i as an array index unless using something meaningful.

> +                       if (!memcmp(&val, cache, codec_drv->reg_word_size))
> +                               continue;

This memcmp() looks very suspicious - we're copying from an unsigned int
into a variable of another type.  That seems to have a bit of an
endianness assumption, doesn't it?  It certainly needs comments
explaining how it works; a similar thing applies to the other memcpy()
and memcmp() operations in the code.

> +static int snd_soc_cache_default_deinit(struct snd_soc_codec *codec)
> +{

_exit or _free would be traditional.

> +	kfree(codec->reg_cache);
> +	return 0;
> +};

Extra ; (I'm surprised nothing warns).
