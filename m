From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Fri, 20 Oct 2017 21:41:48 +0530
Message-ID: <20171020161148.GV30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <s5hzi8nvb55.wl-tiwai@suse.de>
 <20171020051101.GG30097@localhost>
 <s5hpo9iuwwx.wl-tiwai@suse.de>
 <20171020154649.GP30097@localhost>
 <s5hd15hn7ha.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hd15hn7ha.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 20, 2017 at 05:50:57PM +0200, Takashi Iwai wrote:
> On Fri, 20 Oct 2017 17:46:49 +0200,
> Vinod Koul wrote:
> > > > > > --- a/include/linux/mod_devicetable.h
> > > > > > +++ b/include/linux/mod_devicetable.h
> > > > > > @@ -228,6 +228,13 @@ struct hda_device_id {
> > > > > >  	unsigned long driver_data;
> > > > > >  };
> > > > > >  
> > > > > > +struct sdw_device_id {
> > > > > > +	__u16 mfg_id;
> > > > > > +	__u16 part_id;
> > > > > > +	__u8 class_id;
> > > > > > +	kernel_ulong_t driver_data;
> > > > > 
> > > > > Better to think of alignment.
> > > > 
> > > > sorry not quite clear, do you mind elaborating which ones to align?
> > > 
> > > kernel_ulong_t may be aligned to 4 or 8 bytes, depending on
> > > architecture, so there can be a hole between class_id and driver_data.
> > > It's not an ABI, so we don't have to care too much, but it's still
> > > something exposed, hence better to be conscious about alignment.
> > 
> > ah :) is that why hda is unsigned long :) Btw doesnt that cause compat
> > issues, should we not do something like u64 here?
> 
> Oh, don't take the HD-audio case as a good reference, it's a bad guy
> ;)  In the case of hda, the definition isn't really exposed.

Not really it is for ext-hda codecs

> The alignment doesn't matter whether it's unsigned long or
> kernel_ulong_t.  It's a generic issue when you define some struct and
> expose it.  In a safer side, you can put the enough pad bytes so that
> the long field is aligned in 8 bytes.  Or use packed struct.  Or you
> can just ignore and let it be so, but aware of the possible holes in
> your code.

that makes sense, I can add some reserved fields for padding here to fix and
retain the kernel_ulong_t then

-- 
~Vinod
