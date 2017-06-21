From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH alsa-lib 0/4] Add the support for explicit
 sync of appl_ptr
Date: Wed, 21 Jun 2017 20:09:15 +0900
Message-ID: <2aaca467-b1c4-86b2-0a85-db66abd5c9a5@sakamocchi.jp>
References: <20170620153524.28099-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id F28552668F0
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 13:09:18 +0200 (CEST)
In-Reply-To: <20170620153524.28099-1-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 21 2017 00:35, Takashi Iwai wrote:
> Hi,
> 
> this is a patchset for alsa-lib corresponding to the patchset I've
> sent for kernel.  The first two patches do the actual fixes, while the
> last two are merely cleanups / optimizations.
> 
> 
> thanks,
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (4):
>    pcm: hw: Add the support for explicit sync of appl_ptr
>    pcm: hw: Call USER_PVERSION ioctl at open
>    pcm: hw: Remove superfluous call of snd_pcm_set_appl_ptr()
>    pcm: hw: Reduce redundant sync_ptr() calls
> 
>   include/sound/asound.h |  4 +++-
>   src/pcm/pcm_hw.c       | 47 ++++++++++++++++++++++++++++++++---------------
>   2 files changed, 35 insertions(+), 16 deletions(-)

I support this patchset.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

I did quick test with my devices and patched driver, running with kernel 
in 'topic/pcm-sync-applptr' branch[1]. I prepare for below four cases 
with combinations between ALSA fireworks driver and alsa-lib:

  - driver with/without the flag
  - alsa-lib with/without the patch

As long as checking logs from trace-cmd and strace, I got expected 
results in all of these cases.


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/log/?h=topic/pcm-sync-applptr

Thanks

Takashi Sakamoto
