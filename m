From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 1/5] allow up to 32 PCM devices
Date: Wed, 12 May 2010 18:06:32 +0800
Message-ID: <20100512100632.GA13304@localhost>
References: <20100512013015.752623810@intel.com>
	<20100512015713.762299923@intel.com>
	<alpine.LNX.2.00.1005120925400.6856@eeebox2.perex-int.cz>
	<s5htyqdsg0w.wl%tiwai@suse.de> <20100512083950.GB11001@localhost>
	<s5hbpclsdbu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A498E24151
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 12:06:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hbpclsdbu.wl%tiwai@suse.de>
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

On Wed, May 12, 2010 at 05:01:57PM +0800, Takashi Iwai wrote:
> At Wed, 12 May 2010 16:39:50 +0800,
> Wu Fengguang wrote:
> > 
> > On Wed, May 12, 2010 at 04:03:43PM +0800, Takashi Iwai wrote:
> > > At Wed, 12 May 2010 09:29:57 +0200 (CEST),
> > > Jaroslav Kysela wrote:
> > > > 
> > > > On Wed, 12 May 2010, Wu Fengguang wrote:
> > > > 
> > > > > Reserve 32 minor numbers for PCM playback devices.
> > > > >
> > > > > The Intel SandyBridge HDMI audio codec provides 3 PCM devices with
> > > > > indices 3, 7, 8. Among which the device 8's minor number will be
> > > > > overlapped with the first capture device's minor number in the current
> > > > > static minor number allocation scheme.
> > > > >
> > > > > Also increase SNDRV_PCM_DEVICES to make pcm_dev_bits big enough to hold
> > > > > the increasing number of PCM devices.
> > > > 
> > > > I don't agree to have only 4 slots for soundcards in the static minor 
> > > > numbering. Maybe the driver should be converted to use subdevices or we 
> > > > might drop the static minor number allocation at all (it might have only 
> > > > impact for old distros).
> > 
> > Jaroslav, will there be so many sound cards in one system?
> 
> In the old time, yes.  Now we have less and less PCI slots.
> In theory, we may have lots of USB audio devices, though :)
> 
> Another possible solution would be to change the minor number
> assignment to a really dynamic one.  So far, due to legacy /dev/aload
> and co, we have some static restriction per card basis.

Another simple option is to "borrow" 2 slots from one of

- SNDRV_MINOR_HWDEP      :       has 4 slots 
- SNDRV_MINOR_RAWMIDI    :       has 8 slots
- SNDRV_MINOR_PCM_CAPTURE:       has 8 slots

What do you think?

> 
> > > Dropping such a base feature is really no good option.  Better to give
> > > simply an error for more than 8 PCMs in such a case, IMO.
> > 
> > Agreed.
> > 
> > > I also wonder whether having 4 individual PCMs is a way to go.  We may
> > > have PCM substreams, if any.  OTOH, the current IEC958 stream
> > > assignment mechanism doesn't consider multiple substreams well, e.g.
> > > we have no proper way to match the IEC958 status bits control to a PCM
> > > substream.
> > 
> > Hmm, what if there are two monitors attached, each want to play a
> > different music track?
> 
> PCM substreams are really independent from each other.  So,
> technically seen, substreams are feasible.
> 
> > I think the 3 HDMI devices are inherently independent. Each one can
> > have different hw rates, bits, and speaker allocation. And if
> > implemented as PCM substreams, how can the user space specify "please
> > play this music on this monitor"? AFAIK the windows driver also
> > exports 3 independent HDMI playback devices.
> 
> Yeah, as mentioned, SPDIF status mapping isn't provided properly as
> is.  Thus using PCM substreams may give some confusion indeed.

Can I ask a dumb question? Currently I select the target playback
device with the -D option:

        speaker-test -Dhw:0,3 

How can I do the job when PCM substreams are used?

Thanks,
Fengguang
