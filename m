From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [bug] Missing "front" definition for byt-max98090
Date: Fri, 08 Sep 2017 14:30:48 +0300
Message-ID: <1504870248.26394.2.camel@iki.fi>
References: <1504787144.2980.23.camel@iki.fi> <s5hpob2havm.wl-tiwai@suse.de>
 <1504801997.2980.25.camel@iki.fi> <s5ho9qmqvmy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 905CC266AE1
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 13:30:51 +0200 (CEST)
In-Reply-To: <s5ho9qmqvmy.wl-tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, pulseaudio-discuss <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2017-09-07 at 19:13 +0200, Takashi Iwai wrote:
> On Thu, 07 Sep 2017 18:33:17 +0200,
> Tanu Kaskinen wrote:
> > 
> > On Thu, 2017-09-07 at 15:54 +0200, Takashi Iwai wrote:
> > > On Thu, 07 Sep 2017 14:25:44 +0200,
> > > Tanu Kaskinen wrote:
> > > > 
> > > > PulseAudio 11 stopped using "hw:" as a fallback for analog stereo if
> > > > "front:" doesn't work. This caused a regression on "Toshiba Chromebook
> > > > 2 (Swanky)", because PulseAudio doesn't any more do automatic mixer
> > > > adjustments when plugging in headphones. Apparently on this machine
> > > > "hw:1,0" works fine as a substitute for "front:1,0", but we're not
> > > > going to revert the change in PulseAudio, so could someone add the
> > > > "front" definition for this machine in alsa-lib? Unfortunately I'm not
> > > > proficient enough in the alsa-lib configuration system to make a patch
> > > > myself.
> > > 
> > > Well, this is about the device that has no alsa-lib config.  So far,
> > > we assumed that 'front' is available only when defined for the card.
> > > But now PA mandates it...  Hmm.  I guess it's no big problem to add a
> > > fallback to hw for the front PCM.
> > > 
> > > The patch below should work for such a device.  It's a patch to
> > > alsa-lib source, but basically you can modify similarly the file
> > > /usr/share/alsa/pcm/front.conf directly, too.
> > > 
> > > If it's confirmed to work, I'll merge the patch.
> > > 
> > > Maybe we can release alsa-lib 1.1.5 along with 4.13 kernel, so a
> > > quicker reply would be appreciated.
> > 
> > The reporter said[1] that your patch works fine.
> > 
> > I have a concern, though: what about those cases where hw:x,0 is not an
> > analog stereo device? The reason why PulseAudio was changed is that
> > with the Intel HDMI LPE driver PulseAudio thought that the card had an
> > analog stereo device, when in reality it only had HDMI. Doesn't your
> > patch reintroduce this problem?
> 
> Basically "front" doesn't mean the analog output, but rather it's
> an output from the front channels in multi speaker setups (corresponds
> to "rear", etc).  And, so far, we have no notion of analog output
> although we have a notion for digital output ("hdmi" and "spdif").
> That is, "front" doesn't guarantee at all it being an analog from its
> definition.

It would be good to at least guarantee that if both "front" and "hdmi"
are defined, "front" is not an HDMI device. Your patch breaks this
guarantee, so let's not apply it.

> So, for HDMI LPE, can we simply have a special profile for excluding
> the analog output in PA side?

I suppose that's the best solution. Or actually, I think the default
configuration can be modified so that it works properly with both the
HDMI LPE driver and with machines that don't have any alsa-lib
configuration. PulseAudio 11 already uses hw:x,0 as a stereo device if
everything else fails, we just need to add the mixer handling bits to
that fallback case.

(pulseaudio-discuss added to Cc.)

-- 
Tanu

https://www.patreon.com/tanuk
