From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [bug report] ASoC: dapm: Implement and instantiate
 DAI widgets
Date: Thu, 19 Jan 2017 14:50:46 +0530
Message-ID: <20170119092046.GK3573@localhost>
References: <20170119073826.GA28899@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B78E261740
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 10:20:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170119073826.GA28899@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 19, 2017 at 10:38:26AM +0300, Dan Carpenter wrote:
> Hello Mark Brown,

Dan you need to update Mark's email in your address book, its been a while
since he moved away from wolfson..

> 
> The patch 888df395ebc5: "ASoC: dapm: Implement and instantiate DAI
> widgets" from Feb 16, 2012, leads to the following static checker
> warning:
> 
> 	sound/soc/soc-dapm.c:3944 snd_soc_dapm_new_dai_widgets()
> 	error: 'w' dereferencing possible ERR_PTR()
> 
> sound/soc/soc-dapm.c
>   3929          if (dai->driver->playback.stream_name) {
>   3930                  template.id = snd_soc_dapm_dai_in;
>   3931                  template.name = dai->driver->playback.stream_name;
>   3932                  template.sname = dai->driver->playback.stream_name;
>   3933  
>   3934                  dev_dbg(dai->dev, "ASoC: adding %s widget\n",
>   3935                          template.name);
>   3936  
>   3937                  w = snd_soc_dapm_new_control_unlocked(dapm, &template);
> 
> This can either return NULL or ERR_PTR(-EPROBE_DEFER).
> 
>   3938                  if (!w) {
>   3939                          dev_err(dapm->dev, "ASoC: Failed to create %s widget\n",
>   3940                                  dai->driver->playback.stream_name);
>   3941                          return -ENOMEM;
>   3942                  }
>   3943  
>   3944                  w->priv = dai;
>                         ^^^^^^^^^^^^^
> 
>   3945                  dai->playback_widget = w;
>   3946          }
> 
> regards,
> dan carpenter
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
~Vinod
