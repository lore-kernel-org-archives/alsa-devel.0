From: Phil Burk <philburk@google.com>
Subject: Re: [PATCH 0/2 v4] ALSA: pcm: anonymous dup
	implementation
Date: Thu, 7 Feb 2019 09:41:03 -0800
Message-ID: <CACL=Q7wpCJiiHoWE7FrArpm0DFYKUkLdPkUg+uh9=oOMPWWWMA@mail.gmail.com>
References: <20190204093910.23878-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-f193.google.com (mail-it1-f193.google.com
 [209.85.166.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 50F3F2666B3
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2019 18:41:16 +0100 (CET)
Received: by mail-it1-f193.google.com with SMTP id z20so1779611itc.3
 for <alsa-devel@alsa-project.org>; Thu, 07 Feb 2019 09:41:16 -0800 (PST)
In-Reply-To: <20190204093910.23878-1-perex@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.de>, Zach Riggle <riggle@google.com>, Mark Brown <broonie@kernel.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

Thanks for these patches for tinyalsa.  Looks great!

I made a few minor comments on the code layout.
https://github.com/perexg/tinyalsa/commit/f62b953f37693e8426ee4c20e53baae757ba1026
Can you see them?

Phil Burk

On Mon, Feb 4, 2019 at 1:39 AM Jaroslav Kysela <perex@perex.cz> wrote:

> This patchset contains the anonymous dup implementation with permissions
> checking for the ALSA's PCM interface in kernel to enable the restricted
> DMA sound buffer sharing for the restricted tasks.
>
> The code was tested through qemu and it seems to be pretty stable.
>
> The initial tinyalsa implementation can be found here:
>
>   https://github.com/perexg/tinyalsa/commits/anondup
>
> v2 of the patches:
>
> - change clone parameter to subdevice number for the pcm attach
> - change SNDRV_PCM_PERM_MAX to SNDRV_PCM_PERM_MASK
> - the tinyalsa implementation was a little updated (restructured)
>
> v3 of the patches:
>
> - group integer declarations in snd_pcm_anonymous_dup()
> - replaced substream->pcm with pcm in snd_pcm_anonymous_dup()
> - added SNDRV_PCM_PERM_RW check for read/write/readv/writev syscalls
>
> v4 of the patches:
>
> - more simple restriction control (only two modes - full/buffer)
> - the tinyalsa implementation follows this change
>
> Cc: Phil Burk <philburk@google.com>
> Cc: Zach Riggle <riggle@google.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Baolin Wang <baolin.wang@linaro.org>
>
> Jaroslav Kysela (2):
>   ALSA: pcm: implement the anonymous dup (inode file descriptor)
>   ALSA: pcm: implement the mmap buffer mode for the anonymous dup
>
>  include/sound/pcm.h         | 10 +++--
>  include/uapi/sound/asound.h |  6 ++-
>  sound/core/oss/pcm_oss.c    |  2 +-
>  sound/core/pcm.c            | 13 +++---
>  sound/core/pcm_compat.c     |  1 +
>  sound/core/pcm_native.c     | 97
> ++++++++++++++++++++++++++++++++++++++++++---
>  6 files changed, 110 insertions(+), 19 deletions(-)
>
> --
> 2.13.6
>
