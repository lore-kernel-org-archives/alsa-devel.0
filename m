From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/3] ALSA: Add the explicit appl_ptr sync
	support
Date: Wed, 21 Jun 2017 20:21:06 +0900
Message-ID: <32c68d13-d522-209a-9965-37440d096b48@sakamocchi.jp>
References: <20170620153352.27775-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 4FC8F2668F0
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 13:21:09 +0200 (CEST)
In-Reply-To: <20170620153352.27775-1-tiwai@suse.de>
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

On Jun 21 2017 00:33, Takashi Iwai wrote:
> Hi,
> 
> this is a patchset for the issues we've discussed recently lengthily,
> the explicit sync of appl_ptr by disabling the control mmap.
> The first patch achieves it for a driver setting the new INFO flag.
> 
> The second patch is for a generic ABI extension I wanted to implement
> for long time.  It allows user-space reporting its supporting protocol
> version, so that the kernel can behave differently.  It's especially
> useful for extending the ABI struct to use the reserved bits.
> 
> The third patch is the optimization by the second patch; it simply
> skips the previous workaround when the user-space declares itself
> being new enough to support the feature.
> 
> The corresponding alsa-lib patchset will follow in another thread.
> 
> 
> thanks,
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (3):
>    ALSA: pcm: Add the explicit appl_ptr sync support
>    ALSA: pcm: Add an ioctl to specify the supported protocol version
>    ALSA: pcm: Limit the appl_ptr sync workaround only for old user-space
> 
>   include/sound/pcm.h         |  1 +
>   include/uapi/sound/asound.h |  4 +++-
>   sound/core/pcm_compat.c     |  1 +
>   sound/core/pcm_native.c     | 28 ++++++++++++++++++++++++++++
>   4 files changed, 33 insertions(+), 1 deletion(-)

I prefer this direction and support this patchset.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Tested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

However, when running with patched alsa-lib[1], due to a commit 
f8ff2f28ba49 ("ALSA: pcm: Skip ack callback without actual appl_ptr 
update")[2], callback functions in driver side for .ack are not called 
from ioctl handler in ALSA PCM core. When page frames for control data 
of PCM substream is mapped to VMA of the application, the application 
updates the value of pointer in the frame, then transfer the value via 
ioctl. Comparing these two values should be the same and ALSA PCM core 
skip the callback.

When considering about behaviour of old userland stuffs, it's not 
necessarily easy to reduce call frequency of the callback, mmm...

[1] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/122066.html
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/sound/core/pcm_lib.c?h=topic/pcm-sync-applptr&id=f8ff2f28ba49fa41a06215ac3187dede347bc9a7

Thanks

Takashi Sakamoto
