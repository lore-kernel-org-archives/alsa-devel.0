From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: pcm: allow delayed suspending
 request by	users
Date: Thu, 7 Jan 2016 13:55:16 +0530
Message-ID: <20160107082516.GJ11778@localhost>
References: <1451994289-29256-1-git-send-email-vinod.koul@intel.com>
 <s5hegdusvme.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FF76265546
 for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2016 09:21:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hegdusvme.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 06, 2016 at 02:08:57PM +0100, Takashi Iwai wrote:
> On Tue, 05 Jan 2016 12:44:49 +0100,
> Vinod Koul wrote:
> > -	pm_runtime_put(platform->dev);
> > -	for (i = 0; i < rtd->num_codecs; i++)
> > -		pm_runtime_put(rtd->codec_dais[i]->dev);
> > -	pm_runtime_put(cpu_dai->dev);
> > +	pm_runtime_mark_last_busy(platform->dev);
> > +	pm_runtime_put_autosuspend(platform->dev);
> > +
> > +	for (i = 0; i < rtd->num_codecs; i++) {
> > +		pm_runtime_mark_last_busy(rtd->codec_dais[i]->dev);
> > +		pm_runtime_put_autosuspend(rtd->codec_dais[i]->dev);
> > +	}
> > +
> > +	pm_runtime_mark_last_busy(cpu_dai->dev);
> > +	pm_runtime_put_autosuspend(cpu_dai->dev);
> > +
> >  	for (i = 0; i < rtd->num_codecs; i++) {
> >  		if (!rtd->codec_dais[i]->active)
> >  			pinctrl_pm_select_sleep_state(rtd->codec_dais[i]->dev);
> 
> Lots of duplicated codes there...  Worth to have a common helper?

I certainly think so :) will do this after merge window

-- 
~Vinod
