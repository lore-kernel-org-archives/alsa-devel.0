From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Check for NULL register bank in
	snd_soc_get_cache_val()
Date: Mon, 6 Jun 2011 11:48:28 +0100
Message-ID: <4DECB07C.3050908@ti.com>
References: <1307356006-23959-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 31F5424340
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 12:48:31 +0200 (CEST)
In-Reply-To: <1307356006-23959-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 06/06/11 11:26, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-cache.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index d82ab42..9a88a27 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -463,6 +463,9 @@ static bool snd_soc_set_cache_val(void *base, unsigned int idx,
>  static unsigned int snd_soc_get_cache_val(const void *base, unsigned int idx,
>  		unsigned int word_size)
>  {
> +	if (!base)
> +		return -1;
> +
>  	switch (word_size) {
>  	case 1: {
>  		const u8 *cache = base;

Acked-by: Liam Girdwood <lrg@ti.com>
