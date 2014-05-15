From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] dma: pl330: Add support for DMA_PAUSE
	command
Date: Thu, 15 May 2014 21:21:12 +0200
Message-ID: <537513A8.701@metafoo.de>
References: <1400037830-21211-1-git-send-email-tushar.behera@linaro.org>
 <CABb+yY3YocX=8Dv7DysM4tcx=NTCCGGipz_gpMfpKDnAw7R8iw@mail.gmail.com>
 <CAHbNUh0fVND_oGLXWzsyKzbmJc_=FqhZTAnVHE4GGZ5aaJQbEg@mail.gmail.com>
 <5373607D.2000200@metafoo.de>
 <CAHbNUh1bmBniGVtvK4PpmpaKOnwG=MgtupkTEnjD6SS3r_-yjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-123.synserver.de (smtp-out-167.synserver.de
 [212.40.185.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 34F812625D7
 for <alsa-devel@alsa-project.org>; Thu, 15 May 2014 21:21:16 +0200 (CEST)
In-Reply-To: <CAHbNUh1bmBniGVtvK4PpmpaKOnwG=MgtupkTEnjD6SS3r_-yjw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Jassi Brar <jassisinghbrar@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
List-Id: alsa-devel@alsa-project.org

On 05/15/2014 02:01 PM, Tushar Behera wrote:
> On 14 May 2014 17:54, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 05/14/2014 02:07 PM, Tushar Behera wrote:
>>>
>>> On 14 May 2014 17:29, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>>>>
>>>> On Wed, May 14, 2014 at 8:53 AM, Tushar Behera <tushar.behera@linaro.org>
>>>> wrote:
>>>>>
>>>>> While playing back audio, pmc_dmaengine requests the DMA channel to
>>>>> stop DMA transmission through DMA_PAUSE command.
>>>>>
>>>>> Currently PL330 driver doesn't support DMA pause command, leaving
>>>>> the DMA state inconsistent when the system resumes. Instead, it would
>>>>> be better to terminate the DMA transfer during suspend and restart
>>>>> again during resume.
>>>>>
>>>>> Tested with audio playback across a suspend-resume cycle.
>>>>>
>>>> What is pmc_dmaengine? How does DMA_PAUSE help, when there is no
>>>> DMA_RESUME?
>>>>
>>>
>>> Sorry, it is a typo.
>>>
>>> sound/core/pcm_dmaengine.c:snd_dmaengine_pcm_trigger() -->
>>> dmaengine_pause() is called during system suspend.
>>
>>
>> It is only called if the DMA driver has support for pausing and resuming DMA
>> transfers. Or at least that is the intention.
>>
>> - Lars
>
> During suspend, snd_dmaengine_pcm_trigger():SNDRV_PCM_TRIGGER_SUSPEND
> is called which unconditionally calls dmaengine_pause(). Should we
> update snd_dmaengine_pcm_trigger() to check for DMA pause/resume
> support and call dmaengine_pause() or dmaengine_terminate_all()
> accordingly?

As far as I understand it we do not have to do anything for TRIGGER_SUSPEND 
if we do not set the SNDRV_PCM_INFO_RESUME flag. It looks like 
TRIGGER_SUSPEND is called unconditionally during suspend. But since the 
error code is ignored it should be fine if we just call dmaengine_pause() 
and that return -ENOSYS or similar.

Are you seeing an actual issue that you are trying to fix with your patch?

- Lars
