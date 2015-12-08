From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 14/15] ASoC: hdac_hdmi: Add jack
 reporting for user space
Date: Tue, 8 Dec 2015 14:08:31 +0530
Message-ID: <20151208083831.GP1854@localhost>
References: <1449523078-4311-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-14-git-send-email-subhransu.s.prusty@intel.com>
 <s5hy4d6kzb5.wl-tiwai@suse.de> <20151208063135.GN1854@localhost>
 <s5htwnt1m2x.wl-tiwai@suse.de> <20151208074216.GO1854@localhost>
 <s5hio491iol.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 58AE7265D7E
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 09:35:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hio491iol.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 08, 2015 at 08:52:10AM +0100, Takashi Iwai wrote:
> On Tue, 08 Dec 2015 08:42:16 +0100,
> Vinod Koul wrote:
> > 
> > On Tue, Dec 08, 2015 at 07:38:46AM +0100, Takashi Iwai wrote:
> > > On Tue, 08 Dec 2015 07:31:36 +0100,
> > > Vinod Koul wrote:
> > > > 
> > > > On Mon, Dec 07, 2015 at 05:18:06PM +0100, Takashi Iwai wrote:
> > > > > On Mon, 07 Dec 2015 22:24:28 +0100,
> > > > > > +		sprintf(jack_name, "HDMI/DP, Pin=%d Jack", pin->nid);
> > > > > 
> > > > > Such a name makes sense only to be compatible for PA, and then this
> > > > > string isn't compatible.  Note that it's not about pin but for PCM
> > > > > stream.  You may wonder why it matters -- see the whole discussion on
> > > > > MST support.
> > > > 
> > > > So in our case we have added only one PCM Backend in DSP. In codec we have
> > > > one DAI supported, thus creating a DAIlink
> > > > 
> > > > The Codec DAI is mapped to a stream which we fix to a CVT. Future we
> > > > will add two more streams which are mapped to other two CVTs.
> > > > 
> > > > We use MUX controls to allow user to specfiy how CVT and PINs are connected
> > > > togther, this way we can route stream to any pin.
> > > > 
> > > > Extending this concept, behind a pin for MST there may be different 'ports',
> > > > right? Shouldn't that be another mux configuration :) So we can treat three
> > > > streams coming to codec to be routed to any pin and then any port. Since we
> > > > have only 3 CVTs we will have only 3 streams...
> > > 
> > > You can't do that easily.  Remember that you may connect up to 64
> > > different devices at the same time per pin, and this can switch on the
> > > fly.  How would you implement a MUX?
> > 
> > somehow I was under impression that it is 3.. Btw even if 64 devices can be
> > connected how many can we render to?
> 
> That's what I meant below.  Although you can may connect quite a lot
> of devices, the number of devices that can be actually output at the
> same time is limited, actually equal with the number of converters.

Okay got it now, that is how my 3 limit for MST is coming from as we
have 3 CVTs so we can actually stream to only 3 devices per port
although someone may theoretically connect 64!

> > > Though, the max number of converters is limited, thus what you can
> > > actually use is defined by this constraint.  Due to this, we'll likely
> > > manage MST for the legacy HDA by assigning MST devs dynamically to
> > > pins in a certain procedure to make things compatible.
> > 
> > but how many MST devs are you going to create?
> 
> This is exactly the point: for the legacy HDA, instead of creating the
> entry for each MST devices, they are assigned dynamically to PCM at
> activation.  So the number of devices exposed to user-space is
> limited -- or better to say, user-space won't notice the difference.

And how many PCMs are you proposing for MST?

> > > > Back on present :), what do you recommend for us for jack name.
> > > 
> > > Depends on your purpose.  If you want to keep it compatible, then use
> > > the compatible string.
> > 
> > Since compatible string would mean specfying PCM, which we don;t know and is
> > per machine driver dailink defination, we would go ahead with logical
> > "HDMI/DP, Pin=%d Jack" names.
> 
> But then it makes little sense.  Multiple MST devices can be on the
> same pin.

Well am not supporting MST at the moment. How is legacy handling this,
how do you report jack for 64 X 3 devices :)

Or, are you reporting jack for PCMs based on connection to pin/device, I
think latter.

But then you would hit limit of PCMs, I assume you maybe doing 9 PCMs for
this, so if someone connects 10th device we won't report it's jack?

-- 
~Vinod
