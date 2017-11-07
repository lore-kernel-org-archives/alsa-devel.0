From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: intel: initialize return value properly
Date: Tue, 7 Nov 2017 09:26:42 +0530
Message-ID: <20171107035641.GR3187@localhost>
References: <20171106133114.339667-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171106133114.339667-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Naveen Manohar <naveen.m@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Harsha Priya N <harshapriya.n@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 06, 2017 at 02:30:36PM +0100, Arnd Bergmann wrote:
> When CONFIG_SND_SOC_HDAC_HDMI is disabled, we can run into an
> uninitialized variable:
> 
> sound/soc/intel/skylake/skl.c: In function 'skl_resume':
> sound/soc/intel/skylake/skl.c:326:6: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> I have run into this on today's linux-next kernel, but it appears
> that this is an older problem that was just hard to trigger
> with randconfig builds as CONFIG_SND_SOC_HDAC_HDMI would in
> effect be impossible to disable when having SND_SOC_INTEL_SKYLAKE
> enabled.

do we need this in changelog :)

Anyway this sound fine to me, so:

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/intel/skylake/skl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 31d8634e8aa1..acb0ab470ca6 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -355,6 +355,7 @@ static int skl_resume(struct device *dev)
>  
>  		if (ebus->cmd_dma_state)
>  			snd_hdac_bus_init_cmd_io(&ebus->bus);
> +		ret = 0;
>  	} else {
>  		ret = _skl_resume(ebus);
>  
> -- 
> 2.9.0
> 

-- 
~Vinod
