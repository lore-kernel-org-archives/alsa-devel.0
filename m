From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add flag to ignore
 pmdown_time at pcm_close
Date: Fri, 21 Oct 2011 11:42:27 +0530
Message-ID: <12D0C12AF19E15409D57F22566E88EF50A813690AD@bgsmsx501.gar.corp.intel.com>
References: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
	<1318592614-13110-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 34197103A69
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 08:13:36 +0200 (CEST)
In-Reply-To: <1318592614-13110-2-git-send-email-peter.ujfalusi@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Misael@alsa-project.org, Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -578,6 +578,7 @@ struct snd_soc_codec {
> 
>  	/* dapm */
>  	struct snd_soc_dapm_context dapm;
> +	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at
> stop */

I feel ignore_pmdown_time needs to be part of snd_soc_dai_driver structure.
It will give flexibility to control individual dai.  Individual dai's can choose to
Ignore power down delay.

Would it make sense?

In my codec, I need to ignore the power down delay for voice dais, but retain the delay
for HiFi dai's.
