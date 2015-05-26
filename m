From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 0/7] ASoC: intel - add skylake PCM driver
Date: Tue, 26 May 2015 09:44:36 +0530
Message-ID: <20150526041436.GQ3140@localhost>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <s5hsial16wu.wl-tiwai@suse.de> <20150525112458.GF3140@localhost>
 <s5ha8ws27i5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 96C1F26059B
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 06:13:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5ha8ws27i5.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2015 at 01:58:58PM +0200, Takashi Iwai wrote:
> > > Merging this without the codec driver would be rather confusing for
> > > users, since it gives a conflicting driver that doesn't work at all.
> > > I suppose that the merge should be pending until the complete
> > > implementation of ASoC HDA.
> > Well users wont notice till we have a machine driver which selects this
> > driver. That is why machine driver will come last and needs to be
> > merged only after controller and codec drivers are merged for end
> > users to notice
> 
> We still don't provide a way to lead to the right driver.  With your
> patch 5, it creates another SKL PCI driver that conflicts with the
> existing driver entry of snd-hda-intel.  So, at this moment, it just
> give a conflict for non-working driver, and it's not good to leave so
> unless the complete driver set is provided in a week or so.
Hi Takashi,

You are right in that but the point is that user cannot select this driver

+config SND_SOC_INTEL_HDA_SKYLAKE
+       tristate
+       select SND_SOC_HDA_CORE
+       help
+         Say Y here to include support for ASoC Intel "High Definition
+         Audio" (Skylake) and its compatible devices.

So unless someone selects this symbol (machine driver) it wont be built for
anyone (expect you and me to test :D ) and wont conflict.
Or did I miss something ?

Also anyway I will add the flag in this driver as follow on to disable
registering this device so that users don't see this device getting
registered, unless we have complete story merged.

Thanks
-- 
~Vinod
