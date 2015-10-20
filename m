From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: HDMI codec, way forward?
Date: Tue, 20 Oct 2015 09:08:09 +0530
Message-ID: <20151020033809.GZ27370@localhost>
References: <5620E482.6050507@ti.com> <5620EE2F.8070504@metafoo.de>
 <20151016133717.GI32532@n2100.arm.linux.org.uk>
 <20151018150834.GP27370@localhost>
 <20151018152048.GT32532@n2100.arm.linux.org.uk>
 <20151018161329.GV27370@localhost>
 <20151018171641.GV32532@n2100.arm.linux.org.uk>
 <s5hwpuj2dwh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B6AD8265E10
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 05:34:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwpuj2dwh.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, David Airlie <airlied@linux.ie>, tomi.valkeinen@ti.com, Arnaud Pouliquen <arnaud.pouliquen@st.com>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 19, 2015 at 03:20:30PM +0200, Takashi Iwai wrote:
> On Sun, 18 Oct 2015 19:16:42 +0200,
> Russell King - ARM Linux wrote:
> > 
> > On Sun, Oct 18, 2015 at 09:43:29PM +0530, Vinod Koul wrote:
> > > Right but can I ask why you didn't try making video as component and then
> > > CEC, audio and others receive the notification over this.
> > 
> > Okay, I think I see what you're getting at.  No, I don't want to tie
> > this stuff into the component helpers because that's the wrong approach.
> > 
> > The component helper is purely about combining several struct devices
> > into one larger component for a subsystem which deals with card-level
> > components.  It's not about cross-subsystem stuff.
> > 
> > The problem with using it for cross-subsystem stuff is that it becomes
> > too tightly bound together: why should the graphics side get torn down
> > if you unload the audio or CEC driver?
> > 
> > Audio and CEC are rather optional for HDMI - HDMI can work without audio
> > and CEC being present.  However, audio can't be conveyed across the link
> > without the video side being configured.  So, it makes sense to allow
> > the CEC and audio parts to be loaded separately (possibly as modules)
> > while having the video parts built-in to the kernel - especially if you
> > want to use the HDMI output as the console.
> > 
> > Binding CEC and audio into the component helper alongside the video part
> > will mean that nothing will come up until all the components are present,
> > and everything will be torn down when any one of those components are
> > removed.  Clearly, that's undesirable.
> 
> Currently i915/audio component works as you described.  The audio is
> optional and HDMI graphics works without audio, while HDMI HD-audio
> mandates i915 graphics.

Right, but we also add additional interface on top of this to allow things
like ensuring display is on when audio wants to run and now notification for
events.

I don't see a reason why this can be used as single interface to bind as well
as talk to display from various components, unless I missed obvious which
prevent us from doing this in non i915 cases...

-- 
~Vinod
