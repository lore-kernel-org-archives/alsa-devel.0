From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 2/2] ALSA: hda: support for wallclock
	timestamps
Date: Sat, 29 Sep 2012 09:47:24 +0800
Message-ID: <CAN8ccibY_X4LPdpxkUZVA1ZxonwVcFSp3dTWUgppd6UDnvEp8w@mail.gmail.com>
References: <1348820142-15822-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1348820142-15822-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B2CE265005
 for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2012 03:47:25 +0200 (CEST)
Received: by qabj40 with SMTP id j40so362104qab.17
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 18:47:24 -0700 (PDT)
In-Reply-To: <1348820142-15822-2-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> Reuse code from clocksource to handle wall clock counter.
> Since wrapparound occurs, the audio timestamp is reinitialized
> to zero on a trigger. Synchronized linked devices will
> start counting from same reference to avoid any drift.

> @@ -2024,6 +2096,22 @@ static int azx_pcm_trigger(struct
snd_pcm_substream *substream, int cmd)
>                         azx_readl(chip, OLD_SSYNC) & ~sbits);
>         else
>                 azx_writel(chip, SSYNC, azx_readl(chip, SSYNC) & ~sbits);
> +       if (start) {
> +               azx_timecounter_init(substream, 0, 0);
> +               if (nsync > 1) {
> +                       cycle_t cycle_last;
> +
> +                       /* same start cycle for master and group */
> +                       azx_dev = get_azx_dev(substream);
> +                       cycle_last = azx_dev->azx_tc.cycle_last;
> +
> +                       snd_pcm_group_for_each_entry(s, substream) {
> +                               if (s->pcm->card != substream->pcm->card)
> +                                       continue;
> +                               azx_timecounter_init(s, 1, cycle_last);
> +                       }
> +               }
> +       }
>         spin_unlock(&chip->reg_lock);
>         return 0;
>  }

Will the timer reinitialise when multistreaming using front panel headphone
, rear panel speakers , digital output and hdmi ?
