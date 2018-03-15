From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ALSA: core: Allow drivers to set R/W wait
	time.
Date: Thu, 15 Mar 2018 16:07:39 +0000
Message-ID: <1521130059.7762.298.camel@linux.intel.com>
References: <20180314204440.14027-1-liam.r.girdwood@linux.intel.com>
 <s5hsh928gak.wl-tiwai@suse.de> <1521120937.7762.258.camel@linux.intel.com>
 <s5hin9x76n8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id D03B2267252
 for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2018 17:07:44 +0100 (CET)
In-Reply-To: <s5hin9x76n8.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2018-03-15 at 15:30 +0100, Takashi Iwai wrote:
> > It's not atm, as it was being set by the driver. Would probably mean an ABI
> > change to PCM ops or a new ioctl ? The latter wont break the ABI and the
> > default
> > value would remain if the ioctl was not called.
> 
> Basically this timeout is merely for a safety, wasn't considered as a
> part of the real functionality.
> 
> So, with your plan, this is exposed as a real PCM feature, as a part
> of API?  For what kind of scenario / purpose?

Use case is XRUN handling, DMA failure or FW crash detection. The shortened
timeout means we can recover far faster leaving a smaller gap in any audio.

Liam
