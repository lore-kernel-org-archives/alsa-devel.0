From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 1/5] allow up to 32 PCM devices
Date: Wed, 12 May 2010 16:39:50 +0800
Message-ID: <20100512083950.GB11001@localhost>
References: <20100512013015.752623810@intel.com>
	<20100512015713.762299923@intel.com>
	<alpine.LNX.2.00.1005120925400.6856@eeebox2.perex-int.cz>
	<s5htyqdsg0w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 0899E244B2
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 10:40:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htyqdsg0w.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 12, 2010 at 04:03:43PM +0800, Takashi Iwai wrote:
> At Wed, 12 May 2010 09:29:57 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Wed, 12 May 2010, Wu Fengguang wrote:
> > 
> > > Reserve 32 minor numbers for PCM playback devices.
> > >
> > > The Intel SandyBridge HDMI audio codec provides 3 PCM devices with
> > > indices 3, 7, 8. Among which the device 8's minor number will be
> > > overlapped with the first capture device's minor number in the current
> > > static minor number allocation scheme.
> > >
> > > Also increase SNDRV_PCM_DEVICES to make pcm_dev_bits big enough to hold
> > > the increasing number of PCM devices.
> > 
> > I don't agree to have only 4 slots for soundcards in the static minor 
> > numbering. Maybe the driver should be converted to use subdevices or we 
> > might drop the static minor number allocation at all (it might have only 
> > impact for old distros).

Jaroslav, will there be so many sound cards in one system?

> Dropping such a base feature is really no good option.  Better to give
> simply an error for more than 8 PCMs in such a case, IMO.

Agreed.

> I also wonder whether having 4 individual PCMs is a way to go.  We may
> have PCM substreams, if any.  OTOH, the current IEC958 stream
> assignment mechanism doesn't consider multiple substreams well, e.g.
> we have no proper way to match the IEC958 status bits control to a PCM
> substream.

Hmm, what if there are two monitors attached, each want to play a
different music track?

I think the 3 HDMI devices are inherently independent. Each one can
have different hw rates, bits, and speaker allocation. And if
implemented as PCM substreams, how can the user space specify "please
play this music on this monitor"? AFAIK the windows driver also
exports 3 independent HDMI playback devices.

Thanks,
Fengguang
