From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: HDMI codec, way forward?
Date: Wed, 21 Oct 2015 15:37:47 +0100
Message-ID: <20151021143747.GG32532@n2100.arm.linux.org.uk>
References: <20151018161329.GV27370@localhost>
 <20151018171641.GV32532@n2100.arm.linux.org.uk>
 <s5hwpuj2dwh.wl-tiwai@suse.de> <20151020033809.GZ27370@localhost>
 <20151020080800.GU32532@n2100.arm.linux.org.uk>
 <20151020140148.GC27370@localhost>
 <20151021092744.GC32532@n2100.arm.linux.org.uk>
 <s5heggol4o7.wl-tiwai@suse.de>
 <20151021140307.GE32532@n2100.arm.linux.org.uk>
 <s5ha8rcl3c8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 5E8152606E8
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 16:38:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5ha8rcl3c8.wl-tiwai@suse.de>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, tomi.valkeinen@ti.com, Arnaud Pouliquen <arnaud.pouliquen@st.com>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, David Airlie <airlied@linux.ie>, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 21, 2015 at 04:10:31PM +0200, Takashi Iwai wrote:
> On Wed, 21 Oct 2015 16:03:07 +0200,
> Russell King - ARM Linux wrote:
> > It's only the point if you can code it up properly, which from what I
> > read in that file, it isn't.
> 
> An idea can fly without coding, too :)
> 
> > Build the i915 DRM drivers as a module, load up the system, and then
> > try removing the i915 DRM module and see what happens to the audio part.
> > For starters, you have no protection what so ever against acomp->ops or
> > acomp->dev becoming NULL - it's hellishly racy.
> 
> Yes, very likely.
> 
> > Secondly, you reject the initialisation if acomp->ops isn't set, but you
> > allow acomp->ops to later become unset by the i915 DRM module being
> > removed.  If you can cope with acomp->ops being unset at a random point
> > during the audio driver's use, why can't you cope with it being set at
> > some random point later?
> 
> Setting/unsetting on the fly would be picky because the code does
> refcounting.  Maybe an easier option is to inc/dec module usage
> count appropriately in use.
> 
> > I don't think this code has been thought through at all.
> 
> True, more hardening needed.

In any case, this doesn't (and can't) solve the CEC problem, so it's not
a solution to the problem at hand.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
