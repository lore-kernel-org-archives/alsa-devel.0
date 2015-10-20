From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: HDMI codec, way forward?
Date: Tue, 20 Oct 2015 19:31:48 +0530
Message-ID: <20151020140148.GC27370@localhost>
References: <5620E482.6050507@ti.com> <5620EE2F.8070504@metafoo.de>
 <20151016133717.GI32532@n2100.arm.linux.org.uk>
 <20151018150834.GP27370@localhost>
 <20151018152048.GT32532@n2100.arm.linux.org.uk>
 <20151018161329.GV27370@localhost>
 <20151018171641.GV32532@n2100.arm.linux.org.uk>
 <s5hwpuj2dwh.wl-tiwai@suse.de> <20151020033809.GZ27370@localhost>
 <20151020080800.GU32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A7242665B6
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 15:58:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151020080800.GU32532@n2100.arm.linux.org.uk>
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

On Tue, Oct 20, 2015 at 09:08:00AM +0100, Russell King - ARM Linux wrote:
> > > Currently i915/audio component works as you described.  The audio is
> > > optional and HDMI graphics works without audio, while HDMI HD-audio
> > > mandates i915 graphics.
> > 
> > Right, but we also add additional interface on top of this to allow
> > things like ensuring display is on when audio wants to run and now
> > notification for events.
> > 
> > I don't see a reason why this can be used as single interface to bind as
> > well as talk to display from various components, unless I missed obvious
> > which prevent us from doing this in non i915 cases...
> 
> Maybe I can comment more specifically if I saw the code.  Right now all
> I'm aware of is this idea without any code, and I don't like it.

Ok, i will be post my patches tomorrow. FWIW uses interface in
sound/hda/hdac_i915.c for display power up/down

-- 
~Vinod
