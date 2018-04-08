From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 14/15] ARM: pxa: change SSP devices
	allocation
Date: Sun, 08 Apr 2018 14:16:17 +0200
Message-ID: <87o9it3nce.fsf@belgarion.home>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-15-robert.jarzmik@free.fr>
 <CAK8P3a2hYWO2eweg3zpR7iJoqtH4uxJLAxJAno7L96G7nA2HxQ@mail.gmail.com>
 <87lge4485x.fsf@belgarion.home>
 <CAK8P3a1ko=YEwR2VOahH0OWHfeOyWAzDYah4DSohBcvTNq_MKQ@mail.gmail.com>
 <87zi2i2ljy.fsf@belgarion.home>
 <CAK8P3a0xJnVfXfUtP+JXGNgc2-LuHUmZCMq-SnEQw3wu3azemA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr
 [80.12.242.123])
 by alsa0.perex.cz (Postfix) with ESMTP id 99DC0266D47
 for <alsa-devel@alsa-project.org>; Sun,  8 Apr 2018 14:16:21 +0200 (CEST)
In-Reply-To: <CAK8P3a0xJnVfXfUtP+JXGNgc2-LuHUmZCMq-SnEQw3wu3azemA@mail.gmail.com>
 (Arnd Bergmann's message of "Thu, 5 Apr 2018 09:29:30 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Arnd Bergmann <arnd@arndb.de> writes:

> I don't know exactly how the probing works, but I'd assume that we have
> the correct device pointers in pxa2xx_ac97_dev_probe() and
> asoc_ssp_probe(), or maybe in pxa2xx_ac97_*_startup() and
> pxa_ssp_startup().

Yes, let's try this way, in the former patch

"ASoC: pxa: remove the dmaengine compat need" :
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -126,7 +127,7 @@ int __pxa2xx_pcm_open(struct snd_pcm_substream *substream)
                return ret;
 
        return snd_dmaengine_pcm_open(
-               substream, dma_request_slave_channel(rtd->platform->dev,
+               substream, dma_request_slave_channel(rtd->cpu_dai->dev,
                                                     dma_params->chan_name));
 }

The cpu_dai device should be either pxa27x_ac97 or pxa-ssp-dai.<Id>, and amend
the dma slave map accordingly.

Cheers.

-- 
Robert
