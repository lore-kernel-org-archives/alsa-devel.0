From: Lars-Peter Clausen <lars@metafoo.de>
Subject: ASoC: atmel-pcm-dma: Leaking memory in
	atmel_pcm_hw_params
Date: Sun, 17 Mar 2013 15:39:58 +0100
Message-ID: <5145D5BE.3090501@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-223.synserver.de (smtp-out-223.synserver.de
 [212.40.185.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A70726518E
 for <alsa-devel@alsa-project.org>; Sun, 17 Mar 2013 15:38:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

The dmaengine based pcm driver for atmel calls snd_dmaengine_pcm_open from
it's hw_params callback. There is nothing preventing an application calling
hw_params more than once. snd_dmaengine_pcm_open allocates a new prtd struct
each time it gets called. So in case hw_params is called multiple times we
leak memory here.

Is there any specific reason why snd_dmaengine_pcm_open() needs to be called
from the hw_params callback and why it can't be called from the open
callback? The filter function depends on the data returned by
snd_soc_dai_get_dma_data(), but as far as I can see the DAI driver calls
snd_soc_dai_set_dma_data() from its startup() callback, so the data is
available in the PCM drivers open callback.

- Lars
