From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: ASoC: tegra: Does the PCM_TRIGGER_{PAUSE,
 RESUME} emulation really work?
Date: Fri, 22 Mar 2013 17:35:01 -0600
Message-ID: <514CEAA5.4040505@wwwdotorg.org>
References: <514C8618.9070307@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 280D42665C4
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2013 00:35:08 +0100 (CET)
In-Reply-To: <514C8618.9070307@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 03/22/2013 10:26 AM, Lars-Peter Clausen wrote:
> Hi,
> 
> The tegra pcm driver tries to emulate SNDRV_PCM_TRIGGER_PAUSE and
> SNDRV_PCM_TRIGGER_RESUME. By passing SNDRV_PCM_TRIGGER_START and
> SNDRV_PCM_TRIGGER_STOP to snd_dmaengine_pcm_trigger. But does this really
> work? The old non-dmaengine based driver implemented this properly. I'd
> reset the dma position pointer for SNDRV_PCM_TRIGGER_START, but keep it
> where it was for SNDRV_PCM_TRIGGER_RESUME. But as far as I can see with the
> dmaengine based driver the pointer always gets reset to 0 for both
> SNDRV_PCM_TRIGGER_START and SNDRV_PCM_TRIGGER_RESUME.

It's quite possible this hasn't been tested, or tested recently. I don't
recall how to test PAUSE/RESUME. Can you enlighten me?

Laxman, can you comment here?
