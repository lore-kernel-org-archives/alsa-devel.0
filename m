From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 00/17] ASoC: twl6040: Cleanups and fixes
Date: Sun, 18 Sep 2011 18:41:18 +0200
Message-ID: <20110918164118.GM32263@sortiz-mobl>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
 <1316164789.3229.4.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1316164789.3229.4.camel@odin>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Liam,

On Fri, Sep 16, 2011 at 10:19:49AM +0100, Liam Girdwood wrote:
> On Thu, 2011-09-15 at 15:39 +0300, Peter Ujfalusi wrote:
> > Hello,
> > 
> > The first four patch of this series (the MFD/Input patches) has been already
> > sent to upstream to the relevant lists, but I wanted to include here as well,
> > since I have dependency on that series later on.
> > If it is OK with you, it would be best to merge these MFD/Input changes through
> > the audio tree for 3.2.
> > 
> > Code cleanup, and fixes for the twl6040 codec driver.
> > Main changes:
> > - reg_cache has been rested to chip defaults
> > - codec initialization changes
> > - Correction for the Earphone path
> > - AUX L/R output support
> > - Headset/Handsfree control name changes
> > - Headset DC offset workaround
> > 
> 
> All Acked-by: Liam Girdwood <lrg@ti.com>
> 
> Samuel, IIRC we have a dependency on MFD. Do you mind if this goes via
> ASoC ?
Sure, no problem. I ACKed the MFD parts, if you need it.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
