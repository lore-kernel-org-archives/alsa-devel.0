From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 14/15] ASoC: hdac_hdmi: Add jack
 reporting for user space
Date: Wed, 9 Dec 2015 11:14:20 +0530
Message-ID: <20151209054420.GA1854@localhost>
References: <s5htwnt1m2x.wl-tiwai@suse.de> <20151208074216.GO1854@localhost>
 <s5hio491iol.wl-tiwai@suse.de> <20151208083831.GP1854@localhost>
 <s5h7fkp1gda.wl-tiwai@suse.de> <20151208102059.GQ1854@localhost>
 <s5hio49kzen.wl-tiwai@suse.de> <20151208104256.GR1854@localhost>
 <s5hegexkybn.wl-tiwai@suse.de> <s5ha8plkxya.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 18125260591
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 06:41:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5ha8plkxya.wl-tiwai@suse.de>
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

On Tue, Dec 08, 2015 at 11:59:41AM +0100, Takashi Iwai wrote:
> On Tue, 08 Dec 2015 11:51:40 +0100,
> Takashi Iwai wrote:
> > 
> > On Tue, 08 Dec 2015 11:42:57 +0100,
> > Vinod Koul wrote:
> > > 
> > > On Tue, Dec 08, 2015 at 11:28:16AM +0100, Takashi Iwai wrote:
> > > > > Yes that was my thinking based on discussion and patches posted by Libin.
> > > > > But one more question who does PCM assignment, looking at patches it seems
> > > > > driver and no way to change that..
> > > > > 
> > > > > For example I have 10 devices connected  and we have 5 PCMs.
> > > > > I would like to route to 7th device, how would that be done?
> > > > 
> > > > Manage xrandr to enable the target monitor.  Then one PCM stream will
> > > > be switched to the corresponding audio, and it'll be notified to
> > > > user-space.
> > > 
> > > Thanks, that helps..
> > > 
> > > Looking at RFC patches I do not see that implemented, so maybe Libin
> > > and you will add that eventually
> > > 
> > > The question here is how will the switch be handled, can you please
> > > elaborate on that. From xrandr selection how will audio driver be
> > > notified and how will change be done?
> > 
> > The switch itself has to be done voluntarily by user-space,
> > unfortunately, as in the current form.  We thought of the preemptive
> > disconnection.  It works for aplay, but screws up PulseAudio, so
> > no-go.
> 
> Maybe the above wasn't clear enough.  Put in that way: the assignment
> of PCM stream and the switching of PCM stream are different things.
> The former is done at the time the HDA driver gets notified by i915
> (actually happens twice, one for disabling and one for enabling).  The
> audio driver notifies this to user-space.  Then user-space closes /
> reopens a stream accordingly, which is equivalent as switching a PCM
> stream.

Thanks for the explanation :)

SO how do you notify, thru alsa jack control. In that case if we had
assigned PCM to pin 5, device 62 and change to pin 5 device 35, how would
userspace view this

> We've tested the PCM switching in the driver side, but it broke the
> compatibility with PA.  So the switching itself is voluntarily done by
> user-space.

-- 
~Vinod
