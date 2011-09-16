From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: wm8995: Return -EINVAL if device
	ID mismatch
Date: Fri, 16 Sep 2011 10:28:20 +0100
Message-ID: <1316165300.3229.8.camel@odin>
References: <1316141193.21890.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E5F824390
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 11:28:25 +0200 (CEST)
Received: by wwe32 with SMTP id 32so3033962wwe.5
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2011 02:28:23 -0700 (PDT)
In-Reply-To: <1316141193.21890.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-09-16 at 10:46 +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/codecs/wm8995.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
> index 5ad873f..05f7795 100644
> --- a/sound/soc/codecs/wm8995.c
> +++ b/sound/soc/codecs/wm8995.c
> @@ -1642,6 +1642,7 @@ static int wm8995_probe(struct snd_soc_codec *codec)
>  
>  	if (ret != 0x8995) {
>  		dev_err(codec->dev, "Invalid device ID: %#x\n", ret);
> +		ret = -EINVAL;
>  		goto err_reg_enable;
>  	}
>  

Both

Acked-by: Liam Girdwood <lrg@ti.com>
