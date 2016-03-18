From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Bad rever-select of CONFIG_SND_HDA_I915
Date: Fri, 18 Mar 2016 20:11:06 +0530
Message-ID: <20160318144106.GK2490@localhost>
References: <s5hk2l0utly.wl-tiwai@suse.de> <20160318080648.GH2490@localhost>
 <s5hshzo5ee2.wl-tiwai@suse.de> <20160318102806.GI2490@localhost>
 <s5hfuvo5b3x.wl-tiwai@suse.de> <20160318105407.GJ2490@localhost>
 <s5ha8lw58s5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 612A9265926
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 15:36:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5ha8lw58s5.wl-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 18, 2016 at 12:23:54PM +0100, Takashi Iwai wrote:
> > > I guess the build failure won't happen even if you rip off
> > > SND_HDA_I915 dependency from SND_SOC_INTEL_SKYLAKE.  Let's check.
> > 
> > It doesn't. So both work well :)
> > 
> > Depends on DRM_I915 as well as removing current select.
> > 
> > FWIW, the removing the DRM will not work as HDMI will fail so dailinks wont
> > be there and sound card will not get registered :)
> > 
> > So which one to do in above?
> 
> HDMI would never work without graphics, so it shouldn't be a big
> problem.  I'm for dropping the dependency, for now.

Okay sent you the patch for that

-- 
~Vinod
