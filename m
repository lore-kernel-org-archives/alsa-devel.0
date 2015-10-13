From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ALSA: pcm: harmless underflow issue in
 snd_pcm_sw_params()
Date: Tue, 13 Oct 2015 15:06:07 +0300
Message-ID: <20151013120607.GM7289@mwanda>
References: <20151013070756.GA31537@mwanda>
 <s5heggzksyq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5heggzksyq.wl-tiwai@suse.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2015 at 11:39:41AM +0200, Takashi Iwai wrote:
> On Tue, 13 Oct 2015 09:07:56 +0200,
> Dan Carpenter wrote:
> > 
> > "params->tstamp_mode" is a user supplied int.  We cap the maximum but
> > allow negative values by mistake.  It's harmless but static checkers
> > complain.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> You already sent the same fix and it was applied in the commit
> 145d92e77e6f.
> 

Oops.  Sorry about that.

regards,
dan carpenter

