From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: wm0010: fix memory leak
Date: Fri, 18 Sep 2015 12:39:41 +0100
Message-ID: <20150918113941.GG7694@ck-lbox>
References: <1442572341-28201-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1442572341-28201-2-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442572341-28201-2-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 18, 2015 at 04:02:20PM +0530, Sudip Mukherjee wrote:
> We have requested for the firmware but we have missed releasing it both
> on success and on error path.
> While checking the code it turned out that the requested firmware is not
> even used. More over the same firmware is being loaded by
> wm0010_stage2_load().
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---

hmm... odd guess this must have been missed when
wm0010_stage2_load was created.

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
