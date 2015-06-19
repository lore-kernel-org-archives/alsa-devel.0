From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Fri, 19 Jun 2015 10:12:53 +0200
Message-ID: <20150619081253.GA5747@dellaz>
References: <20150608084951.GA7512@dellaz>
 <loom.20150613T153708-781@post.gmane.org>
 <20150615164623.GA693@asus> <1434387868.2434.50.camel@loki>
 <20150616205053.GA323@asus> <1434532575.2471.13.camel@loki>
 <20150617213410.GA907@asus> <20150618111451.GH28601@localhost>
 <20150618184739.GA5434@asus> <20150619075439.GI28601@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DF4C26053E
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 10:13:04 +0200 (CEST)
Received: by wibdq8 with SMTP id dq8so11090128wib.1
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 01:13:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150619075439.GI28601@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Luka Karinja <luka.karinja@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Nikula, Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 19, 2015 at 01:24:39PM +0530, Vinod Koul wrote:
> On Thu, Jun 18, 2015 at 08:47:40PM +0200, Michele Curti wrote:
> > # Machine support
> > obj-$(CONFIG_SND_SOC_INTEL_SST) += boards/
> > 
> > Does this last line mean that nothing under the 'boards' folder will 
> > compile if the CONFIG_SND_SOC_INTEL_SST option is not enabled?
> > 
> > Tried to replace the line with
> > obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += boards/
> > and the machine driver builds and installs
> > 
> > I'll try to add a CONFIG_SND_SOC_INTEL_BOARDS selected by both
> > CONFIG_SND_SOC_INTEL_SST and CONFIG_SND_SST_MFLD_PLATFORM :)
> Yes you are right, that does cause the issue, we need to get the board to
> get included, so I am able to reproduce this.
> 
> Also I saw you patch, I dont this we need to add a new symbol as boards is
> the one where one should select the machine and allow other symbold to be
> auto selected, so better to do this

Yes, much better than mine :p

> 
> diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
> index 3853ec2ddbc7..6de5d5cd3280 100644
> --- a/sound/soc/intel/Makefile
> +++ b/sound/soc/intel/Makefile
> @@ -7,4 +7,4 @@ obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
>  obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += atom/
> 
>  # Machine support
> -obj-$(CONFIG_SND_SOC_INTEL_SST) += boards/
> +obj-$(CONFIG_SND_SOC) += boards/
> 
> With thhis machine compiles, can you please verify at your end. Also I think

Yes, it works, thank you ;)

> we should remove the prompt for SND_SOC_INTEL_SST, this should be selected
> by respective driver
> 
> I will send patches to fix all these
> 
> Thanks for reporting
> 
> -- 
> ~Vinod
> 
