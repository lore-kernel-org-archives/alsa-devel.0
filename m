From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: tegra: Does the PCM_TRIGGER_{PAUSE,
 RESUME} emulation really work?
Date: Sat, 23 Mar 2013 11:00:50 +0100
Message-ID: <514D7D52.5020504@metafoo.de>
References: <514C8618.9070307@metafoo.de> <514CEAA5.4040505@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id F1DDB26523E
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2013 10:58:50 +0100 (CET)
In-Reply-To: <514CEAA5.4040505@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 03/23/2013 12:35 AM, Stephen Warren wrote:
> On 03/22/2013 10:26 AM, Lars-Peter Clausen wrote:
>> Hi,
>>
>> The tegra pcm driver tries to emulate SNDRV_PCM_TRIGGER_PAUSE and
>> SNDRV_PCM_TRIGGER_RESUME. By passing SNDRV_PCM_TRIGGER_START and
>> SNDRV_PCM_TRIGGER_STOP to snd_dmaengine_pcm_trigger. But does this really
>> work? The old non-dmaengine based driver implemented this properly. I'd
>> reset the dma position pointer for SNDRV_PCM_TRIGGER_START, but keep it
>> where it was for SNDRV_PCM_TRIGGER_RESUME. But as far as I can see with the
>> dmaengine based driver the pointer always gets reset to 0 for both
>> SNDRV_PCM_TRIGGER_START and SNDRV_PCM_TRIGGER_RESUME.
> 
> It's quite possible this hasn't been tested, or tested recently. I don't
> recall how to test PAUSE/RESUME. Can you enlighten me?

Hm, I don't know of an application that is specificity designed to test
pause/resume, but any application using snd_pcm_pause, should be fine.

- Lars
