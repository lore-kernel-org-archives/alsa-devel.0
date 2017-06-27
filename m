From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v3 0/2] ALSA: Add PCM USER_PVERSION ioctl
Date: Tue, 27 Jun 2017 20:43:43 +0900
Message-ID: <240adf1c-710c-d02c-994f-a9556577cc64@sakamocchi.jp>
References: <20170627102944.6836-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 64970266B63
 for <alsa-devel@alsa-project.org>; Tue, 27 Jun 2017 13:43:46 +0200 (CEST)
In-Reply-To: <20170627102944.6836-1-tiwai@suse.de>
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

On Jun 27 2017 19:29, Takashi Iwai wrote:
> Hi,
> 
> this is a revised patchset that is applied on top of the current
> for-next branch, in order to optimize the appl_ptr sync on x86-64,
> adapting the alsa-lib side change by Sakamoto-san's patchset.
> 
> Basically it adds a new ioctl for receiving the supported PCM protocol
> version from user-space side, and change the mmap code to allow only
> disabling the PCM status record depending on the supported protocol
> version.  The former patch is identical with the previous version,
> only the latter one differs.
> 
> The corresponding alsa-lib patch will follow.
> 
> 
> thanks,
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (2):
>    ALSA: pcm: Add an ioctl to specify the supported protocol version
>    ALSA: pcm: Disable only control mmap for explicit appl_ptr sync
> 
>   include/sound/pcm.h         |  1 +
>   include/uapi/sound/asound.h |  3 ++-
>   sound/core/pcm_compat.c     |  1 +
>   sound/core/pcm_native.c     | 29 ++++++++++++++++++++++++-----
>   4 files changed, 28 insertions(+), 6 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

I note that the idea of USER_PVERSION ioctl is itself worth for the 
other interfaces/protocols such as control. In the interfaces/protocols, 
many structures have reserved members. As Iwai-san described in the 
first patch, when changing them to utilize these reserved members, this 
idea is a solution to balance compatibility and extensibility.


Thanks

Takashi Sakamoto
