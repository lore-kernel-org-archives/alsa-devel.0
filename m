From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix comment width in soc-cache.c
Date: Tue, 05 Apr 2011 08:34:18 +0100
Message-ID: <1301988858.14075.108.camel@vega>
References: <1301907384-13094-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E43721039C7
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Apr 2011 09:34:22 +0200 (CEST)
Received: by wyg36 with SMTP id 36so76695wyg.38
	for <alsa-devel@alsa-project.org>; Tue, 05 Apr 2011 00:34:22 -0700 (PDT)
In-Reply-To: <1301907384-13094-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-04-04 at 17:56 +0900, Mark Brown wrote:
> Lines should be less than 80 columns.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-cache.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index 5655fce..3e7f691 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -393,10 +393,11 @@ static int snd_soc_16_16_spi_write(void *control_data, const char *data,
>  #define snd_soc_16_16_spi_write NULL
>  #endif
>  
> -/* Primitive bulk write support for soc-cache.  The data pointed to by `data' needs
> - * to already be in the form the hardware expects including any leading register specific
> - * data.  Any data written through this function will not go through the cache as it
> - * only handles writing to volatile or out of bounds registers.
> +/* Primitive bulk write support for soc-cache.  The data pointed to by
> + * `data' needs to already be in the form the hardware expects
> + * including any leading register specific data.  Any data written
> + * through this function will not go through the cache as it only
> + * handles writing to volatile or out of bounds registers.
>   */
>  static int snd_soc_hw_bulk_write_raw(struct snd_soc_codec *codec, unsigned int reg,
>  				     const void *data, size_t len)

Acked-by: Liam Girdwood <lrg@ti.com>
