From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Power down links before
 turning off display audio power
Date: Mon, 25 Jun 2018 14:23:49 +0530
Message-ID: <20180625085348.GA30506@intel.com>
References: <1529659551-22902-1-git-send-email-sriramx.periyasamy@intel.com>
 <a1991293-7d83-8aa8-6a2d-85d06fad7adb@linux.intel.com>
 <s5htvpuvj3p.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 368862675C8
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 11:05:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htvpuvj3p.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Patches Audio <patches.audio@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 22, 2018 at 07:14:50PM +0200, Takashi Iwai wrote:
> On Fri, 22 Jun 2018 18:42:24 +0200,
> Pierre-Louis Bossart wrote:
> > 
> > On 6/22/18 4:25 AM, Sriram Periyasamy wrote:
> > > On certain platforms, Display HDMI HDA codec was not going to sleep state
> > > after the use when links are powered down after turning off the display
> > > power. As per the HW recommendation, links are powered down before turning
> > > off the display power to ensure that the codec goes to sleep state.
> > 
> > The change looks ok, I am still not clear on display power
> > management. snd_hdac_display_power is called both from hdac_hdmi.c and
> > skl.c in the respective probe/suspend/resume routines, wondering if
> > this is redundant or intentional.
> 
> Yeah, it looks like that skl.c keeps the display power on by assuming
> that it's turned off by the codec driver, but it doesn't happen
> actually.  I also find it fishy there...
> 

snd_hdac_display_power is called intentionally to ensure that the codec is
powered up before any communication is initiated from either skl.c or
hdac_hdmi.c.

Thanks,
Sriram.
