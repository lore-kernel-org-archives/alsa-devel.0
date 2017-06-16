From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: hda - Add Coffelake PCI ID
Date: Fri, 16 Jun 2017 13:26:17 +0530
Message-ID: <20170616075616.GC19154@localhost>
References: <1497414116-22733-1-git-send-email-subhransu.s.prusty@intel.com>
 <20170614044548.GG13020@localhost> <s5hpoe7ta2q.wl-tiwai@suse.de>
 <s5ho9trt9c9.wl-tiwai@suse.de> <s5ha858qvzx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C69D2669F3
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 09:53:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5ha858qvzx.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Megha Dey <megha.dey@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 16, 2017 at 08:36:50AM +0200, Takashi Iwai wrote:
> On Wed, 14 Jun 2017 07:41:10 +0200,
> Takashi Iwai wrote:
> > 
> > On Wed, 14 Jun 2017 07:25:17 +0200,
> > Takashi Iwai wrote:
> > > 
> > > But while writing this, I noticed that Broxton-T seems forgotten.
> > > Doesn't it need the similar workaround for SKL+ chips?
> > 
> > I meant like below.
> 
> Can anyone confirm whether it is required or not?

Sorry for the delay

> There are two things applied specific to BXT: one is the generic SKL+
> quirk and another is a quick to reduce DMA latency.  Maybe the latter
> one is superfluous for BXT-T but only the former one is needed?

Lets keep former and if someone complains add the later

> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > Takashi
> > 
> > -- 8< --
> > From: Takashi Iwai <tiwai@suse.de>
> > Subject: [PATCH] ALSA: hda - Apply quirks to Broxton-T, too
> > 
> > Broxton-T was a forgotten child and we didn't apply the quirks
> > properly.  Let's fix it.
> > 
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  sound/pci/hda/hda_intel.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index e3c696c46a21..774f72b26d13 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -369,7 +369,8 @@ enum {
> >  #define IS_KBL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa171)
> >  #define IS_KBL_LP(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9d71)
> >  #define IS_KBL_H(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa2f0)
> > -#define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
> > +#define IS_BXT(pci) ((pci)->vendor == 0x8086 && \
> > +		     ((pci)->device == 0x5a98 || (pci)->device == 0x1a98))
> >  #define IS_GLK(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x3198)
> >  #define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
> >  #define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci)) || \
> > -- 
> > 2.13.1
> > 

-- 
~Vinod
