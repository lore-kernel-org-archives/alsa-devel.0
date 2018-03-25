From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: Re: [RESEND][PATCH v4 1/3] ALSA: core: let low-level
 driver or userspace disable rewinds
Date: Sun, 25 Mar 2018 16:16:43 +0530
Message-ID: <20180325104643.GA13721@intel.com>
References: <1521561668-28613-1-git-send-email-sriramx.periyasamy@intel.com>
 <1521561668-28613-2-git-send-email-sriramx.periyasamy@intel.com>
 <s5ho9jiu3fk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 687D4266AE4
 for <alsa-devel@alsa-project.org>; Sun, 25 Mar 2018 12:55:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5ho9jiu3fk.wl-tiwai@suse.de>
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
Cc: ALSA ML <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Ramesh Babu <ramesh.babu@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 20, 2018 at 05:17:35PM +0100, Takashi Iwai wrote:
> On Tue, 20 Mar 2018 17:01:06 +0100,
> Sriram Periyasamy wrote:
> > 
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > 
> > Add new hw_params flag to explicitly tell driver that rewinds will never
> > be used. This can be used by low-level driver to optimize DMA operations
> > and reduce power consumption. Use this flag only when data written in
> > ring buffer will never be invalidated, e.g. any update of appl_ptr is
> > final.
> > 
> > Note that the update of appl_ptr include both a read/write data
> > operation as well as snd_pcm_forward() whose behavior is not modified.
> > 
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
> 
> Well, I'm still not convinced with this flag.
> 
> First off, does it really need to be per PCM stream?  The introducing

Flag per PCM stream helps where each stream in given system may have
different requirement such as low power or low latency based on the
use case. For example in case of low power stream, driver can perform
required optimizations at hardware level based on the no_rewind flag.

> something to hw_parms implies that it varies per application.  But I
> can't imagine that a system requires different behavior per stream
> regarding such a thing.
> 
> Second, the driver can implement a check in PCM ack callback to
> prevent the rewind, too.  Then there is no need to touch the PCM
> core.
> 

As per the previous discussion at [1],

[1]
https://patchwork.kernel.org/patch/9795233/

from Pierre,

"The application (which is in most cases an audio server) *knows* if it
requires rewinds or not. It's part of its design, with rewinds typically
disabled if period interrupts are required. It's been that way for a
number of years now. The use of rewinds is typically associated with the
combination of a large buffer and no interrupts (having either of the
two would not require rewinds).

So the idea is that the application makes a statement that rewinds will
not be used, and the low-level driver makes use of the information to
enable whatever optimizations are available at the hardware level.

Exposing more information to userspace would quickly lead to a confusing
decision-making and would require more than just a flag."

Thanks,
Sriram.

> 
> thanks,
> 
> Takashi
> 
> > -- 
> > 2.7.4
> > 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
