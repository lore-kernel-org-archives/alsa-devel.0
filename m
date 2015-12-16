From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ASoC: Intel: Skylake: Fix a couple signedness bugs
Date: Wed, 16 Dec 2015 17:55:18 +0300
Message-ID: <20151216145518.GM5177@mwanda>
References: <20151212123815.GA21408@mwanda>
 <20151216144400.GN1854@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151216144400.GN1854@localhost>
Sender: kernel-janitors-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Dharageswari R <dharageswari.r@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 16, 2015 at 08:14:00PM +0530, Vinod Koul wrote:
> On Sat, Dec 12, 2015 at 03:38:15PM +0300, Dan Carpenter wrote:
> > These need to be unsigned because they hold negative error codes.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Acked-by: Vinod Koul <vinod.koul@intel.com>

Sorry, I sent a v2 of this with "be unsigned" changed to "be signed" in
the changelog, but I messed up the In-Reply-To header so it was a new
thread.

regards,
dan carpenter

