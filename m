From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: HDMI codec, way forward?
Date: Wed, 21 Oct 2015 21:49:28 +0530
Message-ID: <20151021161927.GG27370@localhost>
References: <20151018171641.GV32532@n2100.arm.linux.org.uk>
 <s5hwpuj2dwh.wl-tiwai@suse.de> <20151020033809.GZ27370@localhost>
 <20151020080800.GU32532@n2100.arm.linux.org.uk>
 <20151020140148.GC27370@localhost>
 <20151021092744.GC32532@n2100.arm.linux.org.uk>
 <s5heggol4o7.wl-tiwai@suse.de>
 <20151021140307.GE32532@n2100.arm.linux.org.uk>
 <s5ha8rcl3c8.wl-tiwai@suse.de>
 <20151021143747.GG32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 270D32608B3
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 18:16:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151021143747.GG32532@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, tomi.valkeinen@ti.com, Arnaud Pouliquen <arnaud.pouliquen@st.com>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, David Airlie <airlied@linux.ie>, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 21, 2015 at 03:37:47PM +0100, Russell King - ARM Linux wrote:
> On Wed, Oct 21, 2015 at 04:10:31PM +0200, Takashi Iwai wrote:
> > On Wed, 21 Oct 2015 16:03:07 +0200,
> > Russell King - ARM Linux wrote:
> > > It's only the point if you can code it up properly, which from what I
> > > read in that file, it isn't.
> > 
> > An idea can fly without coding, too :)
> > 
> > > Build the i915 DRM drivers as a module, load up the system, and then
> > > try removing the i915 DRM module and see what happens to the audio part.
> > > For starters, you have no protection what so ever against acomp->ops or
> > > acomp->dev becoming NULL - it's hellishly racy.
> > 
> > Yes, very likely.
> > 
> > > Secondly, you reject the initialisation if acomp->ops isn't set, but you
> > > allow acomp->ops to later become unset by the i915 DRM module being
> > > removed.  If you can cope with acomp->ops being unset at a random point
> > > during the audio driver's use, why can't you cope with it being set at
> > > some random point later?
> > 
> > Setting/unsetting on the fly would be picky because the code does
> > refcounting.  Maybe an easier option is to inc/dec module usage
> > count appropriately in use.
> > 
> > > I don't think this code has been thought through at all.
> > 
> > True, more hardening needed.

I will try to fix this once I am done with Skylake drivers.. Plus adding new
features like ELD in on my plan for this interface

> In any case, this doesn't (and can't) solve the CEC problem, so it's not
> a solution to the problem at hand.

Sorry am not sure I follow the reasons for that, wouldn't CEC be another
slave in such an interface? I though component fwk did allow us to have
multiple slaves..

-- 
~Vinod
