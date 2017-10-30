From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: wm8741: Add digital mute callback
Date: Mon, 30 Oct 2017 15:41:35 +0000
Message-ID: <20171030154110.5vl2ajatnsr5c4sm@localhost.localdomain>
References: <1509352096-5491-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AE33266AE1
 for <alsa-devel@alsa-project.org>; Mon, 30 Oct 2017 16:41:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1509352096-5491-1-git-send-email-sergej@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, ce3a@gmx.de, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 30, 2017 at 09:28:16AM +0100, Sergej Sawazki wrote:
> Signed-off-by: Sergej Sawazki <sergej@taudac.com>
> ---
> Changes in v2:
>  * Refactored debug message.
> 
>  sound/soc/codecs/wm8741.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
> index b8c1940..5571882 100644
> --- a/sound/soc/codecs/wm8741.c
> +++ b/sound/soc/codecs/wm8741.c
> @@ -351,6 +351,17 @@ static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
>  	return 0;
>  }
>  
> +int wm8741_mute(struct snd_soc_dai *codec_dai, int mute)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +
> +	dev_dbg(codec->dev, "wm8741_mute:    mute = %d\n", mute);

It is still not really normal style to include the function name
in the debug messages. How about just "digital mute = %d\n" or
something like that?

Thanks,
Charles
