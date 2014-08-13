From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [v4 02/12] ASoC: Intel: mrfld: set private data
 for cpu-dai
Date: Wed, 13 Aug 2014 21:50:43 +0200
Message-ID: <53EBC193.9070105@metafoo.de>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-166.synserver.de
 [212.40.185.166])
 by alsa0.perex.cz (Postfix) with ESMTP id F1303265593
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 21:50:43 +0200 (CEST)
In-Reply-To: <1407145563-1303-3-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

[...]
> +static int sst_media_dai_probe(struct snd_soc_dai *cpu_dai)
> +{
> +	struct sst_data *sst = dev_get_drvdata(cpu_dai->dev);
> +
> +	snd_soc_dai_set_drvdata(cpu_dai, sst);

snd_soc_dai_set_drvdata does dev_set_drvdata(dai->dev, data) internally, so 
this function does:

	dev_set_drvdata(cpu_dai->dev, dev_get_drvdata(cpu_dai->dev));

That's pretty much a noop.

> +	return 0;
> +}
>   static struct snd_soc_dai_driver sst_platform_dai[] = {
>   {
> +	.probe = sst_media_dai_probe,
>   	.name = "media-cpu-dai",
>   	.ops = &sst_media_dai_ops,
>   	.playback = {
>
