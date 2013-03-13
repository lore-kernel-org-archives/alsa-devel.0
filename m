From: Daniel Mack <zonque@gmail.com>
Subject: Re: [patch] ALSA: ASoC: tas5086: signedness bug in
	tas5086_hw_params()
Date: Wed, 13 Mar 2013 11:29:01 +0100
Message-ID: <514054ED.7050501@gmail.com>
References: <20130313053253.GA17674@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id E9475264F0A
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 11:30:50 +0100 (CET)
Received: by mail-bk0-f48.google.com with SMTP id jf20so358784bkc.21
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 03:30:50 -0700 (PDT)
In-Reply-To: <20130313053253.GA17674@longonot.mountain>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, kbuild@01.org
List-Id: alsa-devel@alsa-project.org

On 13.03.2013 06:32, Dan Carpenter wrote:
> "val" has to be signed for the error handling to work.

Absolutely.

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Daniel Mack <zonque@gmail.com>


> 
> diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
> index 008bea4..41d03ae 100644
> --- a/sound/soc/codecs/tas5086.c
> +++ b/sound/soc/codecs/tas5086.c
> @@ -251,7 +251,7 @@ static int tas5086_hw_params(struct snd_pcm_substream *substream,
>  {
>  	struct snd_soc_codec *codec = dai->codec;
>  	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
> -	unsigned int val;
> +	int val;
>  	int ret;
>  
>  	priv->rate = params_rate(params);
> 
