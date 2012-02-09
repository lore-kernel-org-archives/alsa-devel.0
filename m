From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] [trivial] twl4030: Fix typo in twl4030.c
Date: Thu, 09 Feb 2012 09:19:21 +0200
Message-ID: <4F337379.9060006@ti.com>
References: <1328702014-1956-1-git-send-email-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with SMTP id DA35B1038D6
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2012 08:19:18 +0100 (CET)
Received: by mail-lpp01m010-f51.google.com with SMTP id s15so1499924lag.24
	for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2012 23:19:16 -0800 (PST)
In-Reply-To: <1328702014-1956-1-git-send-email-standby24x7@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Masanari Iida <standby24x7@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, trivial@kernel.org, linux-kernel@vger.kernel.org, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 02/08/2012 01:53 PM, Masanari Iida wrote:
> Correct spelling "memroy" to "memory" in
> sound/soc/codecs/twl4030.c
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  sound/soc/codecs/twl4030.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index 3039ba2..d7eee0d 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -2221,7 +2221,7 @@ static int twl4030_soc_probe(struct snd_soc_codec *codec)
>  
>  	twl4030 = kzalloc(sizeof(struct twl4030_priv), GFP_KERNEL);
>  	if (twl4030 == NULL) {
> -		printk("Can not allocate memroy\n");
> +		printk("Can not allocate memory\n");
>  		return -ENOMEM;
>  	}
>  	snd_soc_codec_set_drvdata(codec, twl4030);

Could you please resend the patch with the ASoC maintainers on CC (Liam,
Mark), and the alsa-devel list.
Thank you.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
