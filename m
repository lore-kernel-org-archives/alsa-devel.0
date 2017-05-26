From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/14] Revised patchset for PCM in-kernel
	copy support
Date: Fri, 26 May 2017 22:59:26 +0900
Message-ID: <7ec3bd93-1763-0827-56b4-98685244a709@sakamocchi.jp>
References: <20170525191735.13787-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 53BA52668C9
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 15:59:30 +0200 (CEST)
In-Reply-To: <20170525191735.13787-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Hi,

On May 26 2017 04:17, Takashi Iwai wrote:
> Hi,
> 
> this is a sort of RFC, a revised patchset of the previous two patches
> for killing set_fs() usages in PCM.  Instead of converting to the
> merged copy_silence ops, this adds a new copy_kernel ops instead.
> At the same time, copy/silence are changed to receive the position and
> size in bytes instead of frames.  This allows us to simplify the PCM
> core code.  As a result, a good amount of code could be removed from
> pcm_lib.c.
> 
> Note that this patchset isn't complete, containing only two driver
> conversions (nm256 for interleaved and rme9652 for non-interleaved) as
> a demonstration.
> 
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (14):
>    ALSA: pcm: Introduce copy_user, copy_kernel and fill_silence ops
>    ALSA: nm256: Convert to new PCM copy ops
>    ALSA: rme9652: Convert to the new PCM ops
>    ALSA: pcm: Drop the old copy and silence ops
>    ALSA: pcm: Check PCM state by a common helper function
>    ALSA: pcm: Shuffle codes
>    ALSA: pcm: Call directly the common read/write helpers
>    ALSA: pcm: More unification of PCM transfer codes
>    ALSA: pcm: Unify read/write loop
>    ALSA: pcm: Simplify snd_pcm_playback_silence()
>    ALSA: pcm: Direct in-kernel read/write support
>    usb: gadget: u_uac1: Kill set_fs() usage
>    ALSA: pcm: Kill set_fs() in PCM OSS layer
>    ALSA: pcm: Build OSS writev/readv helpers conditionally
> 
>   drivers/usb/gadget/function/u_uac1.c |   7 +-
>   include/sound/pcm.h                  |  80 ++++-
>   sound/core/oss/io.c                  |   4 +-
>   sound/core/oss/pcm_oss.c             |  81 +----
>   sound/core/oss/pcm_plugin.h          |   6 +-
>   sound/core/pcm_lib.c                 | 551 +++++++++++++----------------------
>   sound/pci/nm256/nm256.c              |  57 ++--
>   sound/pci/rme9652/rme9652.c          |  71 +++--
>   sound/soc/soc-pcm.c                  |   5 +-
>   9 files changed, 386 insertions(+), 476 deletions(-)

Overall, I prefer this patchset to your previous one, especially for 
patch 05-10 in a point of code refactoring. If patches of 00-04 and 
05-10 were inverted in order, I would give my reviewed-by signature as 
soon...

Patch 00-04 looks good. Even if drivers transfer PCM frames for kernel 
space by PCM substream, 'struct snd_pcm_ops.fill_silence' has no 
influence. It's reasonable to have three operations, instead of two 
which we've proposed. But as you said, there's a lack of patches for the 
other drivers.

As I stated, patch 11-14 are pending from my current reviewing. It's for 
next week. (I need a batch of time to consider about it.)


Good night

Takashi Sakamoto
