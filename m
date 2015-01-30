From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Add sysfs entries via static
 attribute groups
Date: Fri, 30 Jan 2015 18:27:05 +0100
Message-ID: <54CBBEE9.8060007@metafoo.de>
References: <1422638525-612-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-062.synserver.de (smtp-out-064.synserver.de
 [212.40.185.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D25F260474
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 18:27:06 +0100 (CET)
In-Reply-To: <1422638525-612-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 01/30/2015 06:22 PM, Takashi Iwai wrote:
[...]
> -
> -	if (rtd->codec) {

It looks as if these attributes are now registered unconditionally.

> -		/* add DAPM sysfs entries for this codec */
> -		ret = snd_soc_dapm_sys_add(rtd->dev);
> -		if (ret < 0)
> -			dev_err(rtd->dev,
> -				"ASoC: failed to add codec dapm sysfs entries: %d\n",
> -				ret);
> -
> -		/* add codec sysfs entries */
> -		ret = device_create_file(rtd->dev, &dev_attr_codec_reg);
> -		if (ret < 0)
> -			dev_err(rtd->dev,
> -				"ASoC: failed to add codec sysfs files: %d\n",
> -				ret);
> -	}
> -
>   	return 0;
>   }
>
