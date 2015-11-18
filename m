From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/3] ASoC: remove SND_SOC_BYTES_EXT
Date: Wed, 18 Nov 2015 23:49:53 +0530
Message-ID: <20151118181953.GX25173@localhost>
References: <1447853952-6414-1-git-send-email-vinod.koul@intel.com>
 <s5hlh9ve7n0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id ECAF5265D91
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:16:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hlh9ve7n0.wl-tiwai@suse.de>
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

On Wed, Nov 18, 2015 at 02:53:23PM +0100, Takashi Iwai wrote:
> On Wed, 18 Nov 2015 14:39:09 +0100,
> Vinod Koul wrote:
> > 
> > The SND_SOC_BYTES_TLV and SND_SOC_BYTES_EXT provide similar functionality,
> > with only difference that SND_SOC_BYTES_EXT have limitations of 512 bytes
> > as parameters whereas no such restrictions on SND_SOC_BYTES_TLV
> > 
> > So remove SND_SOC_BYTES_EXT and update users to use SND_SOC_BYTES_TLV
> 
> Hmm, won't this break user-space?  Both use the difference access
> methods, so I wonder how they can be kept compatible.

Yes they will, so should we then keep these and mark SND_SOC_BYTES_EXT
depricated ..?

Mark what should we do with these

-- 
~Vinod
