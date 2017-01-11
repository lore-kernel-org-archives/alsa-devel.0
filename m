From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] ASoC: rt5651: use msleep for large delays
Date: Wed, 11 Jan 2017 12:01:34 +0000
Message-ID: <20170111120134.GA15356@osadl.at>
References: <1484135376-482-1-git-send-email-hofrat@osadl.org>
 <1484135749.12006.23.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484135749.12006.23.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 11, 2017 at 03:55:49AM -0800, Joe Perches wrote:
> On Wed, 2017-01-11 at 12:49 +0100, Nicholas Mc Guire wrote:
> > ulseep_range() uses hrtimers and provides no advantage over msleep()
> > for larger delays. Fix up the 75/85ms delays here to use msleep() and
> > reduce the load on the hrtimer subsystem.
> 
> If this is useful, why not convert all the large value
> usleep_range uses in sound/soc/ ?
>
thats what Im currently doing - just that it cant be done fully
automatic as it may be justified in some cases - so it needs a 
case-by-case review. 

And its not only in sound/soc/ its quite a bit in drivers/ as
well.

thx!
hofrat 
