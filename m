From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 1/7] ASoC: hda - add ASoC HDA codec
	match function
Date: Mon, 25 May 2015 16:51:50 +0530
Message-ID: <20150525112150.GE3140@localhost>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-2-git-send-email-vinod.koul@intel.com>
 <20150522125634.GX21391@sirena.org.uk>
 <s5hwq00enw8.wl-tiwai@suse.de>
 <20150522174106.GV21577@sirena.org.uk>
 <s5hsiao32g6.wl-tiwai@suse.de> <20150523055156.GZ3140@localhost>
 <20150525104828.GA21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id CA1BF26048D
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 13:20:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150525104828.GA21577@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2015 at 11:48:28AM +0100, Mark Brown wrote:
> On Sat, May 23, 2015 at 11:21:56AM +0530, Vinod Koul wrote:
> > On Fri, May 22, 2015 at 08:13:45PM +0200, Takashi Iwai wrote:
> 
> > > The point is that a HD-audio object can be inherited to two different
> > > level of objects, legacy and ASoC.  Both are bound on the same bus,
> > > but to the corresponding drivers.  Both objects use the very same bus
> > > ops, thus they share the same hdac_bus.
> 
> > Thanks a bunch Takashi for clarifying :)
> 
> > I guess one clarification may still help, The SKL Audio controller is PCI
> > device, the PCM driver in this series will load against the PCI device.
> > Now the driver will go ahead and initialize the HDA bus. Also we provide our
> > own matching function here.
> 
> > The matching function is for matching the devices on HDA link. The probing
> > of the bus will find the HDA codecs present in the bus and we will match
> > them based on Vendor ID and Device ID in match function above.
> 
> > Let us know if you have more questions
> 
> To be honest the above isn't really clarifying things for me.  I know
> what a matching function is for,
I was trying to clarify that we are matching hda codec device here and not
PCI HDA controller

> the thing that is really worrying about
> this is that we've got different matching functions depending on how the
> HDA bus is instantiated.  Given that HDA is an enumerable bus why would
> we want or need that - why and how does the matching differ depending on
> the driver we're using for the bus?  I would not expect that matching
> using the HDA identification registers would be something that varies
> depending on how we register the bus.

The hdac core doesn't actually do matching. If you see the match
function provided by core (hda_bus_match), it is a wrapper and
actual matching for legacy devices is being done in legacy code, see
hda_codec_match. This match function expects the hdac_device to be
wrapped in legacy hda_codec, which we don't need here.

So for ASoC we are embedding hdac_device in soc_hda_codec and using
the vendor_id and revision_id to match, so hda to write a new one.

I do not mind if we commonize this and have common match function in
hdac, if legacy is happy with it. Or perhaps the move to core later on
as ASoC HDA matures, either way whatever you n Takashi agree with
would be okay by me.

HTH

Thanks
-- 
~Vinod
