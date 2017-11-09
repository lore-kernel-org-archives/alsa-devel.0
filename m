From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/6] ALSA: pcm: check parameter on
	snd_pcm_running()
Date: Thu, 9 Nov 2017 11:40:22 +0900
Message-ID: <0a642561-7c16-c54d-185b-3f39c5560738@sakamocchi.jp>
References: <87r2t8p5tz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 9502C2677C4
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 03:41:07 +0100 (CET)
In-Reply-To: <87r2t8p5tz.wl%kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Nov 9 2017 11:11, Kuninori Morimoto wrote:
> 
> Hi Takashi-san, Mark
> 
> snd_pcm_running() is using "substream" and "substream->runtime"
> pointer, no check.
> These patches adds its check in function,
> and removes duplicate checks from each drivers.
> 
> Not super important, but can be cleanup
> 
> Kuninori Morimoto (6):
>    ALSA: pcm: check parameter on snd_pcm_running()
>    ALSA: pdaudiocf: remove unneeded check for snd_pcm_running()
>    ASoC: dwc: remove unneeded check for snd_pcm_running()
>    ASoC: omap-hdmi-audio: remove unneeded check for snd_pcm_running()
>    ASoC: xtfpga-i2s: remove unneeded check for snd_pcm_running()
>    ASoC: rsnd: remove unneeded check for snd_pcm_running()
> 
>   include/sound/pcm.h                    | 3 +++
>   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c | 2 +-
>   sound/soc/dwc/dwc-pcm.c                | 2 +-
>   sound/soc/omap/omap-hdmi-audio.c       | 3 +--
>   sound/soc/sh/rcar/core.c               | 5 +----
>   sound/soc/xtensa/xtfpga-i2s.c          | 4 ++--
>   6 files changed, 9 insertions(+), 10 deletions(-)

This is a bad direction. I exactly oppose to your idea.

 >  include/sound/pcm.h | 3 +++
 >  1 file changed, 3 insertions(+)
 >
 > diff --git a/include/sound/pcm.h b/include/sound/pcm.h
 > index 24febf9..a8e49f5 100644
 > --- a/include/sound/pcm.h
 > +++ b/include/sound/pcm.h
 > @@ -664,6 +664,9 @@ void snd_pcm_stream_unlock_irqrestore(struct 
snd_pcm_substream *substream,
 >   */
 >  static inline int snd_pcm_running(struct snd_pcm_substream *substream)
 >  {
 > +     if (!substream || !substream->runtime)
 > +             return 0;
 > +
 >       return (substream->runtime->status->state == 
SNDRV_PCM_STATE_RUNNING ||
 >               (substream->runtime->status->state == 
SNDRV_PCM_STATE_DRAINING &&
 >                substream->stream == SNDRV_PCM_STREAM_PLAYBACK));

In a view of 'design by contract', this function has a pre-condition 
that a given argument should not be NULL. Callers _should_ guarantee it 
to keep semantics of this function.

Your idea appends the duty of callers to this function. This causes a 
semantical contradiction. If it were something to bring kernel 
corruption such as BUG_ON(), the original design would be kept. When 
substream is NULL, it's a bug of drivers in adding PCM components. When 
runtime is NULL, it's a bug of ALSA PCM core in handling open system call.


Regards

Takashi Sakamoto
