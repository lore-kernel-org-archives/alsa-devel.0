From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Audio mini conference 2014?
Date: Wed, 20 Aug 2014 12:32:37 +0530
Message-ID: <20140820070236.GC13288@intel.com>
References: <alpine.DEB.2.00.1408121011200.10517@phandrigan-desktop>
 <53EA6165.3070902@zonque.org> <s5hbnropcvd.wl-tiwai@suse.de>
 <20140813165517.GB17528@sirena.org.uk>
 <20140817231021.GQ14537@sirena.org.uk>
 <s5hha1aw6we.wl-tiwai@suse.de> <20140819172948.GX13288@intel.com>
 <alpine.DEB.2.00.1408191451550.10517@phandrigan-desktop>
 <20140820042109.GY13288@intel.com> <s5hy4ujhfta.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 89EF626582A
 for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2014 11:26:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy4ujhfta.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tanu Kaskinen <tanu.kaskinen@linux.jf.intel.com>, Paul Handrigan <paul.handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 20, 2014 at 07:48:33AM +0200, Takashi Iwai wrote:
> ===
> 
> Audio Miniconf 2014 Topics
> 
> - ASoC componentization (Lars)
> 
> - Dynamic FW (Vinod)
>   Me and Liam will try to send RFCs before the conference. At least on
>   my side thats next todo after current mrfld driver is done.
> 
>   We have working code atm. For the folks who want to look at early
>   state of affairs, here are the trees:
>   Kernel: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/sound.git dfw-3.15
>   Usermode: git://git.infradead.org/users/vkoul/dynamic_fw.git
> 
> - Effect API (yet again) (Vinod)
> 
> - More DSP support esp on PCM side (Vinod)
> 
> - Rewinding in ALSA PCM plugins (Alexander)
> 
> - Resampler quality evaluation for PulseAudio (Alexander)
> 
> - Testing / QA (Takashi)
>   How people do test?  Can we have some automation?
>   (IIRC, openSUSE has some automatic audio test running on VM, but I
>    forgot the details...)
I would be interested in this as well, some test framework for auto regression
checks would be great.

I think Mark would be at KS and can update if we can leverage something for
kselftest stuff being discussed there

> - ABI/API documentation (Takashi)
>   We're not good at this at all, obviously.  Let's define the priority
>   to start working on.
I think ASoC has grown a lot with DPCM etc making it very dynamic atm. So
yes it will help to add more

> - Control names (Takashi)
>   It's wild west for now, everyone picks up a random funky name.
yes, I think the current control names were too HDA specific. With DSP and
audio hub proliferation on SoCs/Codecs revisiting this would certainly be
great. Like how do I specify volume control for gain before a mixer, or gain
in capture BE which is different from the one on capture FE.

> 
> - Code removals (Takashi)
>   There have been actions to remove the codes for old hardware
>   recently.  Which is acceptable?  Feature removals, too?

Configuration convergence:
>From the OS side, we have Desktop OSes relying on PA, Chrome using CRAS,
Android using flinger. With DSPs and tons of configuration it doesn't bode
well to have multiple configuration for same stuff for the sound cards. Can
we talk about unifying the configuration at least. Sure OSes will have their
own ways to use, but from ALSA can we standardize configurations which
can be reused across.

And lastly, our users :)
Ask from PA, Android, ChomesOS folks??

-- 
~Vinod
