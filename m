From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: HDMI codec, way forward?
Date: Wed, 21 Oct 2015 18:34:37 +0100
Message-ID: <20151021173437.GK32532@n2100.arm.linux.org.uk>
References: <s5hwpuj2dwh.wl-tiwai@suse.de> <20151020033809.GZ27370@localhost>
 <20151020080800.GU32532@n2100.arm.linux.org.uk>
 <20151020140148.GC27370@localhost>
 <20151021092744.GC32532@n2100.arm.linux.org.uk>
 <s5heggol4o7.wl-tiwai@suse.de>
 <20151021140307.GE32532@n2100.arm.linux.org.uk>
 <s5ha8rcl3c8.wl-tiwai@suse.de>
 <20151021143747.GG32532@n2100.arm.linux.org.uk>
 <20151021161927.GG27370@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 0C2A926047F
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 19:34:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151021161927.GG27370@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, tomi.valkeinen@ti.com, Arnaud Pouliquen <arnaud.pouliquen@st.com>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, David Airlie <airlied@linux.ie>, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 21, 2015 at 09:49:28PM +0530, Vinod Koul wrote:
> On Wed, Oct 21, 2015 at 03:37:47PM +0100, Russell King - ARM Linux wrote:
> > In any case, this doesn't (and can't) solve the CEC problem, so it's not
> > a solution to the problem at hand.
> 
> Sorry am not sure I follow the reasons for that, wouldn't CEC be another
> slave in such an interface? I though component fwk did allow us to have
> multiple slaves..

Not with the way you're using the component helper here.

I guess that not all my message is being read, because people keep
replying half-way down my messages...

You can only register a struct device _once_ as a slave device.

With the way you're using it here for audio, you're registering the
i915 DRM device as a slave component device, and the audio side as
the master.  That means the audio master can bind to the DRM slave
component device.

You can't then have a CEC master bind to the i915 DRM slave device
(it's already bound to the audio master device), and you can't
register the i915 DRM device as a second slave component device.
It becomes indistinguishable from the first, and there's no way
to tell which of the two different 'ops' structures should be used
with which master.

I said this in my message 20151021140307.GE32532@n2100.arm.linux.org.uk
which was two of my replies ago in this sub-thread.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
