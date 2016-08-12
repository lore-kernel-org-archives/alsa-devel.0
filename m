From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH -next] ASoC: Intel: Skylake: Fix error return code in
 skl_probe()
Date: Fri, 12 Aug 2016 17:41:24 +0530
Message-ID: <20160812121124.GN9681@localhost>
References: <1471002318-20209-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471002318-20209-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jayachandran B <jayachandran.b@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 12, 2016 at 11:45:18AM +0000, Wei Yongjun wrote:
> Fix to return error code -ENODEV from the error handling
> case instead of 0, as done elsewhere in this function.

Acked-By: Vinod Koul <vinod.kou@intel.com>

-- 
~Vinod
