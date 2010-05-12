From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/2] ALSA: include/linux/usb/audio.h: add
 __attribute__((packed))
Date: Wed, 12 May 2010 09:30:53 +0200
Message-ID: <20100512073053.GM30801@buzzloop.caiaq.de>
References: <1273594430-9356-1-git-send-email-daniel@caiaq.de>
	<s5hd3x2p3ds.wl%tiwai@suse.de>
	<20100511225054.GL30801@buzzloop.caiaq.de>
	<4BEA4D98.5010900@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B5E4F24445
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 09:31:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BEA4D98.5010900@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 12, 2010 at 08:41:28AM +0200, Clemens Ladisch wrote:
> Daniel Mack wrote:
> > ...
> > Thanks! One of the noted TODOs is that UAC2 offers the ability to a
> > device to dynamically change the supported range of options for a given
> > control. So an enum-driven control can get new values, lose some,
> > whatever. What would be the best way to map that to ALSA controls?
> 
> The control callbacks accept and return the new values; userspace
> gets notified of the changed control information with
> snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, &elem_id);
> 
> I'm quite sure that alsamixer can cope with this, but I don't know
> about any other mixers. :)
> 
> I think "alsactl restore" already does the right thing for controls
> that have changed.
> 
> > Another thing that we would need to support at some time is clock
> > selectors to switch from an internal clock to some external one. And
> > this can also be notfied dynamically - so for example: once an external
> > S/PDIF transmitter is connected, the driver gets informed about a new
> > valid clock source. I haven't found anything how this could be passed on
> > to higher levels from a driver, but I might have missed something :)
> 
> With a mixer control "Clock Source", of course. :)
> Or are you talking about new samples rates made available?

This is in theory possible, yet rather unlikely in reality. But a range
descriptor for available (valid) clock sources could do such a thing.

Ok, I'll go ahead and implement it, and then see what it takes.

Thanks,
Daniel
