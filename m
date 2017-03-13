From: Paul Handrigan <paul.handrigan@cirrus.com>
Subject: Re: [patch] ASoC: cs35l35: returning uninitialized in
	probe()
Date: Mon, 13 Mar 2017 09:36:30 -0500
Message-ID: <44ad8957-b9e6-48bc-92ad-42d150462605@EX3.ad.cirrus.com>
References: <20170313123237.GA9287@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id CB912266BDA
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 15:36:34 +0100 (CET)
In-Reply-To: <20170313123237.GA9287@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On Mon, 13 Mar 2017, Dan Carpenter wrote:

> If cs35l35->pdata.stereo is false then "ret" isn't initialized.
> 
> Fixes: 6387f866a2cc ("ASoC: Add support for Cirrus Logic CS35L35 Amplifier")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
> index 260ed42c71e9..142ae642eaa1 100644
> --- a/sound/soc/codecs/cs35l35.c
> +++ b/sound/soc/codecs/cs35l35.c
> @@ -964,7 +964,7 @@ static int cs35l35_codec_probe(struct snd_soc_codec *codec)
>  		}
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static struct snd_soc_codec_driver soc_codec_dev_cs35l35 = {
> 
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
