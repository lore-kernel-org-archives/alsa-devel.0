From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 1/7] ASoC: hda - add ASoC HDA codec
 match function
Date: Mon, 1 Jun 2015 10:35:04 +0530
Message-ID: <20150601050504.GH3140@localhost>
References: <20150526133256.GQ21577@sirena.org.uk>
 <s5hr3q3cv77.wl-tiwai@suse.de>
 <20150526194316.GY21577@sirena.org.uk>
 <s5hfv6ieero.wl-tiwai@suse.de>
 <20150527183406.GM21577@sirena.org.uk>
 <s5hpp5lde48.wl-tiwai@suse.de>
 <20150528195359.GG21577@sirena.org.uk>
 <s5hk2vsasjz.wl-tiwai@suse.de> <20150529081544.GC3140@localhost>
 <20150529173503.GQ21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C146A2619D8
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 07:03:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150529173503.GQ21577@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 29, 2015 at 06:35:03PM +0100, Mark Brown wrote:
> On Fri, May 29, 2015 at 01:45:44PM +0530, Vinod Koul wrote:
> 
> > well userspace parsing is only for the pin mapping and changes which
> > users want to do on their systems. For basic things the default graph
> > will be read by existing HDA parser and codec driver will create
> > widgets based on that. The generic HDA codec library should do most and
> > the HDA ASoC codecs should do device specfic work (like existing
> > patch_xxx)
> 
> So we *are* planning to continue to use the existing CODEC support but
> with some different interfacing on top of it?
Nope. Existing codecs wont be reused here.

We are doing new ASoC HDA codec drivers which use common hdac parsing logic.
Since some codecs need own methods we can't write a single HDA generic
codec, and had to do with generic codec parser and then specfic driver
(HDMI, ALC to start with) on top.

> 
> > > And it's the reason I suggested for pending merge until the codec side
> > > is ready.  We need the topology stuff merged at first, then HDA-codec
> > > driver together with user-space side.
> 
> > I dont mind if code doesnt get merged into next merge window and put
> > in one after that. But in needs to get accepted is some topic branch
> > so that subsequent series can be  psted and reviewed, merged. Btw
> > users will not see unless we have machine driver. I will add the
> > disable feature after this series, so no user conflicts occur
> 
> I need to have another look through.  TBH I suspect it would be easier
> with something that was more of a minimum viable prototype than with a
> part of the system - with something like this it's as much the overall
> shape of the solution that's being reviewed as anything else.
Sure, please do let us know if you have more questions on this and overall
approach.

-- 
~Vinod
