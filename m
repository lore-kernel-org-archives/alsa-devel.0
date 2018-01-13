From: "Kumar, Abhijeet" <abhijeet.kumar@intel.com>
Subject: RE: Applied "ASoC: hdac_hdmi: Ensuring proper setting of output
 widget power state" to the asoc tree
Date: Sat, 13 Jan 2018 04:49:48 +0000
Message-ID: <60213CA7255C53479ADE3BCF0360117F02E71524@PGSMSX104.gar.corp.intel.com>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
 <E1ea6ZJ-0003BS-KB@debutante> <20180112212012.GI21458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180112212012.GI21458@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Kp, Jeeja" <jeeja.kp@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Prusty, Subhransu S" <subhransu.s.prusty@intel.com>, "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>, "Tayal, SandeepX" <sandeepx.tayal@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> I've dropped this because it caused a conflict with the topic/hdac-hdmi branch - can you please check what's going on there?  
I'm working on inputs from Takashi and Pierre. After much of testing I'll share the revision patch which waits until actual state reaches target state (similar is implemented in hda) by ww03.

Warm Regards,
Abhijeet

-----Original Message-----
From: Mark Brown [mailto:broonie@kernel.org] 
Sent: Saturday, January 13, 2018 2:50 AM
To: Kumar, Abhijeet <abhijeet.kumar@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>; Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Kp, Jeeja <jeeja.kp@intel.com>; Koul, Vinod <vinod.koul@intel.com>; Prusty, Subhransu S <subhransu.s.prusty@intel.com>; Singh, Guneshwor O <guneshwor.o.singh@intel.com>; Tayal, SandeepX <sandeepx.tayal@intel.com>; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
Subject: Re: Applied "ASoC: hdac_hdmi: Ensuring proper setting of output widget power state" to the asoc tree

On Fri, Jan 12, 2018 at 09:08:53PM +0000, Mark Brown wrote:
> The patch
> 
>    ASoC: hdac_hdmi: Ensuring proper setting of output widget power 
> state
> 
> has been applied to the asoc tree at
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git

I've dropped this because it caused a conflict with the topic/hdac-hdmi branch - can you please check what's going on there?  I merged that into the topic/intel branch so probably just a rebase is needed.
