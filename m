From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/3] ASoC: pcm_native: Use
	'snd_pcm_format_t' type
Date: Thu, 10 May 2018 02:42:59 +0900
Message-ID: <3471ba47-20d7-e4bf-b8ed-2d6970f174b6@sakamocchi.jp>
References: <1525621665-11022-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id E633626762C
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 19:43:05 +0200 (CEST)
In-Reply-To: <1525621665-11022-1-git-send-email-festevam@gmail.com>
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
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On May 7 2018 00:47, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> 'snd_pcm_format_t' type is better suited for iterating through the
> SNDRV_PCM_FORMAT members.
> 
> Also, use SNDRV_PCM_FORMAT_FIRST for the first element.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>   sound/core/pcm_native.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

You use 'ASoC' prefix in titile of this patch, but...

$ git log --oneline sound/core/pcm_native.c
...
41412fe92118 ALSA: pcm: Change return type to vm_fault_t
f853dcaae2f5 ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr
912e4c332037 ALSA: pcm: Return negative delays from SNDRV_PCM_IOCTL_DELAY.
c99c5a3bb575 ALSA: pcm: Unify delay calculation in snd_pcm_status() and 
snd_pcm_delay()
6448fcba2a7f ALSA: pcm: Unify playback and capture poll callbacks
763e5067aac9 ALSA: pcm: Clean up with snd_pcm_avail() and 
snd_pcm_hw_avail() helpers
...

It's better to use 'ALSA' prefix with 'pcm' or 'core' tag because your 
change is outside of ALSA SoC part and can affects whole PCM related 
stuffs. Furthermore, you need to post it to a maintainer of this 
subsystem as long as you'd like to request the maintainer to apply it.


Thanks

Takashi Sakamoto
