From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: pcm: Nuke snd_pcm_lib_mmap_vmalloc()
Date: Wed, 18 Jul 2018 15:21:25 +0900
Message-ID: <38b2f22e-02b6-7f66-5db9-3c598a52c85b@sakamocchi.jp>
References: <20180718054438.25308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 058462673C7
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 08:21:31 +0200 (CEST)
In-Reply-To: <20180718054438.25308-1-tiwai@suse.de>
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

On Jun 18 2018 14:44, Takashi Iwai wrote:
> snd_pcm_lib_mmap_vmalloc() was supposed to be implemented with
> somewhat special for vmalloc handling, but in the end, this turned to
> just the default handler, i.e. NULL.  As the situation has never
> changed over decades, let's rip it off.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   drivers/staging/most/sound/sound.c       | 1 -
>   include/sound/pcm.h                      | 2 --
>   sound/drivers/aloop.c                    | 1 -
>   sound/drivers/vx/vx_pcm.c                | 2 --
>   sound/firewire/bebob/bebob_pcm.c         | 1 -
>   sound/firewire/dice/dice-pcm.c           | 2 --
>   sound/firewire/digi00x/digi00x-pcm.c     | 1 -
>   sound/firewire/fireface/ff-pcm.c         | 1 -
>   sound/firewire/fireworks/fireworks_pcm.c | 1 -
>   sound/firewire/isight.c                  | 1 -
>   sound/firewire/motu/motu-pcm.c           | 2 --
>   sound/firewire/oxfw/oxfw-pcm.c           | 2 --
>   sound/firewire/tascam/tascam-pcm.c       | 1 -
>   sound/mips/sgio2audio.c                  | 3 ---
>   sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c   | 1 -
>   sound/soc/codecs/rt5514-spi.c            | 1 -
>   sound/usb/6fire/pcm.c                    | 1 -
>   sound/usb/caiaq/audio.c                  | 1 -
>   sound/usb/hiface/pcm.c                   | 1 -
>   sound/usb/misc/ua101.c                   | 2 --
>   sound/usb/pcm.c                          | 2 --
>   21 files changed, 30 deletions(-)

For files under 'sound/firewire':

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Regards

Takashi Sakamoto
