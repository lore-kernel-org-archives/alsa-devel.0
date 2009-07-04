From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: Help required with debugging
Date: Sat, 4 Jul 2009 19:22:21 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BB71F61@bgsmsx501.gar.corp.intel.com>
References: <98769532B4BB14429434178695419EAE5BAEB764@bgsmsx501.gar.corp.intel.com>
	<alpine.LNX.2.00.0907020951500.6728@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 01920103812
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Jul 2009 15:52:28 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.0907020951500.6728@eeebox2.perex-int.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Jaroslav Kysela [mailto:perex@perex.cz]
>Sent: Thursday, July 02, 2009 1:39 PM
>To: Harsha, Priya
>Cc: alsa-devel@alsa-project.org; tiwai@suse.de
>Subject: Re: [alsa-devel] Help required with debugging
>
>On Thu, 2 Jul 2009, Harsha, Priya wrote:
>
>> Why is runtime->hw_ptr_jiffies updated in hw_ptr()? This should be only
>> updated in the interrupt context right?
>
>The idea of hw_ptr_jiffies is to have a check if real-time clock in sync
>with the DMA buffer position. If your hardware does block transfers and is
>not able to return fine position in period set SNDRV_PCM_INFO_BATCH flag.
Thanks a lot. Setting the runtime->hw.info = SNDRV_PCM_INFO_BATCH in the ops->prepare(), helps getting past the issue. Its true that the hardware is doing a batch transfer of period_size into the dma_buffer of ALSA.

>But it's rather a workaround than a proper fix, because timestamps are
>updated but the ring buffer position is not moved (which brokes the idea
>to have a relation between the ring buffer position and the real-time
>clock).
Actually the firmware does not update the timestamp till the period size is reached, i.e., the firmware increments the timestamp with period_size and transfers the same to the dma_buffer.
>
>I think that this sort of drivers might require to implement the
>SNDRV_PCM_POS_KEEP return value in case when position does not change from
>last read to notify midlevel PCM code that they're not able to handle fine
>pointer resolution.
I don't find this return value in the ALSA code, can you help me with more details of what needs to be returned and where.
>
>Also, hardware with large FIFOs should update properly runtime->delay
>value now.
I am not finding a field called delay in runtime structure. Where can I find it...and is there a documentation/comment on what this value needs to hold?
>
> 						Jaroslav
>
>-----
>Jaroslav Kysela <perex@perex.cz>
>Linux Kernel Sound Maintainer
>ALSA Project, Red Hat, Inc.
