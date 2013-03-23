From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: tegra: Does the PCM_TRIGGER_{PAUSE,
 RESUME} emulation really work?
Date: Sat, 23 Mar 2013 14:29:09 +0100
Message-ID: <514DAE25.1020505@metafoo.de>
References: <514C8618.9070307@metafoo.de> <514CEAA5.4040505@wwwdotorg.org>
 <514DAB42.6090601@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id C7456265283
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2013 14:27:10 +0100 (CET)
In-Reply-To: <514DAB42.6090601@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On 03/23/2013 02:16 PM, Laxman Dewangan wrote:
> On Saturday 23 March 2013 05:05 AM, Stephen Warren wrote:
>> On 03/22/2013 10:26 AM, Lars-Peter Clausen wrote:
>>> Hi,
>>>
>>> The tegra pcm driver tries to emulate SNDRV_PCM_TRIGGER_PAUSE and
>>> SNDRV_PCM_TRIGGER_RESUME. By passing SNDRV_PCM_TRIGGER_START and
>>> SNDRV_PCM_TRIGGER_STOP to snd_dmaengine_pcm_trigger. But does this really
>>> work? The old non-dmaengine based driver implemented this properly. I'd
>>> reset the dma position pointer for SNDRV_PCM_TRIGGER_START, but keep it
>>> where it was for SNDRV_PCM_TRIGGER_RESUME. But as far as I can see with the
>>> dmaengine based driver the pointer always gets reset to 0 for both
>>> SNDRV_PCM_TRIGGER_START and SNDRV_PCM_TRIGGER_RESUME.
>> It's quite possible this hasn't been tested, or tested recently. I don't
>> recall how to test PAUSE/RESUME. Can you enlighten me?
>>
>> Laxman, can you comment here?
> The tegra20/Tegra30 does not support the pause of the channel. It was
> through global pause. hence the pause and resume is implemented like stop
> transfer and again restart transfer. hence you are seeing this as the  reset
> pointer as 0.
> 

Yea, but in that case you shouldn't implement pause/resume at all. You've
changed the semantics on pause/resume on which applications rely. If
pause/resume are not implemented applications usually workaround it.

- Lars

> So pause is stop and resume is the start again.
> 
> If it is require to implement the dmaengine_pause/resume() then it can not
> be done truely, it can be done atelast in resolution of one buffer transfer.
> We can not stop dma in mid of buffer transfer and start from there. We can
> do cancel of current buffer transfer and then start from begining of current
> buffer, not from the point it was paused.
> 
> However, tegra114 support this pause and resume truely.
