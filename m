From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: intel: Fix PM and non-atomic crash
	in bytcr drivers
Date: Mon, 24 Apr 2017 18:27:17 +0530
Message-ID: <20170424125717.GR6263@localhost>
References: <20170424120955.15519-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D0AF266D82
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 14:55:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170424120955.15519-1-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 24, 2017 at 02:09:55PM +0200, Takashi Iwai wrote:
> The FE setups of Intel SST bytcr_rt5640 and bytcr_rt5651 drivers carry
> the ignore_suspend flag, and this prevents the suspend/resume working
> properly while the stream is running, since SST core code has the
> check of the running streams and returns -EBUSY.  Drop these
> superfluous flags for fixing the behavior.
> 
> Also, the bytcr_rt5640 driver lacks of nonatomic flag in some FE
> definitions, which leads to the kernel Oops at suspend/resume like:
> 
>   BUG: scheduling while atomic: systemd-sleep/3144/0x00000003
>   Call Trace:
>    dump_stack+0x5c/0x7a
>    __schedule_bug+0x55/0x70
>    __schedule+0x63c/0x8c0
>    schedule+0x3d/0x90
>    schedule_timeout+0x16b/0x320
>    ? del_timer_sync+0x50/0x50
>    ? sst_wait_timeout+0xa9/0x170 [snd_intel_sst_core]
>    ? sst_wait_timeout+0xa9/0x170 [snd_intel_sst_core]
>    ? remove_wait_queue+0x60/0x60
>    ? sst_prepare_and_post_msg+0x275/0x960 [snd_intel_sst_core]
>    ? sst_pause_stream+0x9b/0x110 [snd_intel_sst_core]
>    ....
> 
> This patch addresses these appropriately, too.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
