From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Ambiguous DAPM widget names and DPCM
Date: Tue, 23 Jul 2013 13:48:23 +0100
Message-ID: <1374583703.2475.25.camel@loki>
References: <51EE3F18.3030207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 590B7264E9F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 14:48:29 +0200 (CEST)
In-Reply-To: <51EE3F18.3030207@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2013-07-23 at 10:30 +0200, Daniel Mack wrote:
> Hi Mark,
> Hi Liam,
> 
> I spent some hours reverse-engineering the DPCM code, and I plan to
> prepare a patch to add some documentation once I've assembled a fully
> working setup. However, I have a general question regarding DAPM widget
> names.
> 
> DPCM uses DAPM widgets and routes in order to determine the FE <-> BE
> connections at runtime. The problem with this is that widget names are
> very ambiguous, as the automatically created widgets for DAIs are named
> after their stream_name properties, which contain "Playback" or
> "Capture" for all components in my case. Hence, the code which walks the
> connections (snd_soc_dapm_dai_get_connected_widgets()) will most likely
> match the wrong one (which has empty sound/sink lists), which results in
> a failure like this:
> 
> [   16.606268]  fe: ASoC: fe no valid playback route
> 
> I hacked the names of all components so they are unique, but even then,
> the problem is that snd_soc_dapm_new_dai_widgets() is called twice for
> the CPU DAI, once from soc_probe_platform(), and later from
> soc_probe_link_dais(), and both calls would create DAPM widgets with
> identical names, resulting in the same problem as described above.
> 
> I don't know how to handle this, but I believe that nobody was really
> hit by this issue yet, as DPCM doesn't seem to be used widely, at least
> not by any machine code in mainline.

You might be the first to hit this as I never hit it with OMAP4 or the
Haswell DSP code (but it's possible everything just worked for me).

Fwiw, the Haswell audio DSP code can be found here :-

https://git.kernel.org/cgit/linux/kernel/git/lrg/asoc.git/log/?h=intel/haswell-audio-dsp

Dynamic Compressed audio support is now in this branch too.

> 
> One idea would be to change the automatically generated names of DAI
> widgets in order to make them unique, or re-factor the lookup routines.
> 
> Any opinion on that? Do I miss a general consideration here?
> 

I did initially have something like that for OMAP that based the DAI
widget name on the DAI device name, but this also needed something that
would work for codecs with multiple DAI's. In the end it wasn't required
for OMAP, but it sounds like something like a unique name is required
now. 

> With more hacks in place, the setup somehow succeeds, but when the
> stream is opened, we'll hit a BUG() in sound/core/pcm_memory.c, because
> the FE device's DMA type is undefined. But that's another topic I'll
> address later.

Hmm, it looks like your FE is being treated as a regular static PCM in
this case.

Liam
