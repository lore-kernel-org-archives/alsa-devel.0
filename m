From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: DAPM: Fix build warning
Date: Wed, 25 Mar 2015 11:03:27 +0000
Message-ID: <20150325110327.GN23705@opensource.wolfsonmicro.com>
References: <1427278408-27134-1-git-send-email-ckeepax@opensource.wolfsonmicro.com> <s5htwx973h1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5htwx973h1.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, nikesh@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 25, 2015 at 11:53:30AM +0100, Takashi Iwai wrote:
> At Wed, 25 Mar 2015 10:13:28 +0000,
> Charles Keepax wrote:
> > 
> > commit c66150824b8a ("ASoC: dapm: add code to configure dai link
> > parameters") introduced the following build warning:
> > 
> > sound/soc/soc-dapm.c: In function 'snd_soc_dapm_new_pcm':
> > sound/soc/soc-dapm.c:3389:4: warning: passing argument 1 of 'snprintf'
> > discards 'const' qualifier from pointer target type
> >     snprintf(w_param_text[count], len,
> > 
> > This patch fixes this by adding a non-const temporary variable to hold
> > the value as it is created before assigning to the entry in
> > w_param_text.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> 
> An easier fix would be to replace with devm_kasprintf().  Then you can
> do it all in a single line.
> 
> 	w_param_text[count] = devm_kasprintf(card->dev, GFP_KERNEL,
> 				"Anonymous Configuration %d", count);
> 
> 
> Takashi

Thanks wasn't aware of that one, I will respin.

Thanks,
Charles
