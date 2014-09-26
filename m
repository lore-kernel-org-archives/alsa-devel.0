From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question about SNDRV_PCM_STATE_DRAINING and
	DMA	transfer
Date: Fri, 26 Sep 2014 09:35:37 +0200
Message-ID: <54251749.4040603@ladisch.de>
References: <87wq8rm20r.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0D78C260468
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 09:35:41 +0200 (CEST)
In-Reply-To: <87wq8rm20r.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "shiiba (Renesas)" <naoya.shiiba.nx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Kuninori Morimoto wrote:
> We noticed that DMA seems transfered +1 time when Ctrl-C happen.
> But, is this correct ? is this our driver bug ?
> [...]
> 7. DMA transfer interrupt happen
>
>    It calls snd_pcm_period_elapsed() and try to transfer next 2048 byte
>    snd_pcm_playback_avail() in snd_pcm_update_state() return 8192 this time.
>    then, it calls snd_pcm_drain_done()
>
> 9. snd_soc_dai_ops :: trigger called with SNDRV_PCM_TRIGGER_STOP
>
>    driver stops DMA transfer

There is no strong synchronization between snd_pcm_drain() and the rest
of the system; snd_pcm_drain() just waits for an underrun to happen.

In other words, the last actual DMA transfer is likely to contain
invalid (outdated) samples, but gets aborted immediately.


Regards,
Clemens
