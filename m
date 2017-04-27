From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: fix uninitialized pointer use
Date: Thu, 27 Apr 2017 19:58:10 +0530
Message-ID: <20170427142810.GJ6263@localhost>
References: <20170427110014.2316664-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170427110014.2316664-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jeeja KP <jeeja.kp@intel.com>, Jayachandran B <jayachandran.b@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, G Kranthi <gudishax.kranthikumar@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 27, 2017 at 12:59:58PM +0200, Arnd Bergmann wrote:
> The error handling in bxt_sst_dsp_init() got changed in a way that
> it now derefences an uninitialized pointer when printing a warning
> about the device not being found:
> 
> sound/soc/intel/skylake/bxt-sst.c: In function 'bxt_sst_dsp_init':
> sound/soc/intel/skylake/bxt-sst.c:567:14: error: 'skl' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> As we do have a valid device pointer available at the call site,
> let's use that instead.

Thanks Arnd for this fix, but this was also reported by SFR earlier today
and have pasoted same patch via
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-April/120214.html

Patches are same, so Mark can take either :)

-- 
~Vinod
