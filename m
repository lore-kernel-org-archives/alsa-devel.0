From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [patch] ASoC: hdac_hdmi: Potential NULL deref in
 hdac_hdmi_get_spk_alloc()
Date: Tue, 3 May 2016 21:36:12 +0530
Message-ID: <20160503160611.GU2274@localhost>
References: <20160503074258.GA9722@mwanda>
 <20160503095639.GS2274@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160503095639.GS2274@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jeeja KP <jeeja.kp@intel.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Sachin Mokashi <sachinx.mokashi@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 03, 2016 at 03:26:39PM +0530, Vinod Koul wrote:
> On Tue, May 03, 2016 at 10:42:58AM +0300, Dan Carpenter wrote:
> > We intended || here instead of &&.  The original code potentially leads
> > to a NULL dereference.
> 
> This looks good to me, I will test this and get back

Acked-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Sachin Mokashi <sachinx.mokashi@intel.com>

-- 
~Vinod
