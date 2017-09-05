From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] ASoC: wm8741: Add digital mute callback
Date: Tue, 5 Sep 2017 14:33:51 +0100
Message-ID: <20170905133351.tfqsa6s33aeigfxy@localhost.localdomain>
References: <1504553653-8144-1-git-send-email-sergej@taudac.com>
 <1504553653-8144-2-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id DD32326683B
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 15:33:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1504553653-8144-2-git-send-email-sergej@taudac.com>
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
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 04, 2017 at 09:34:11PM +0200, Sergej Sawazki wrote:
> Signed-off-by: Sergej Sawazki <sergej@taudac.com>
> ---
>  sound/soc/codecs/wm8741.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
> index b8c1940..d552a8a 100644
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
> +	dev_dbg(codec->dev, "%s:    mute = %d\n", __func__, mute);

Its not really normal style to use __func__ in this sort of
print, just make it descriptive of what it does. Although I would
also say you could just drop it as well if you fancied it is a
little verbose even for debug output.

Otherwise this patch looks ok to me.

Thanks,
Charles
