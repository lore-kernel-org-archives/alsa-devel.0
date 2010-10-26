From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: mapping externally allocated Scatter Gather DMA
 buffers
Date: Tue, 26 Oct 2010 09:24:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010260923070.29422@eeebox2.perex-int.cz>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 13B36103910
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Oct 2010 09:24:40 +0200 (CEST)
In-Reply-To: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manu Abraham <abraham.manu@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Oct 2010, Manu Abraham wrote:

> Hi,
>
> I have been wondering how to interface a Scatter Gather region as a DMA
> buffer for an Audio Grabbing device.
> The device is a NOC type device, similar to a SOC, the audio grabber is a
> part of it, for realizing the audio
> capabilities on the device.
>
> The hardware DMA is mostly a Scatter Gather based engine, and it can be
> described thus, briefly.

Use snd_pcm_lib_preallocate_pages_for_all() - type SNDRV_DMA_TYPE_DEV_SG 
and snd_pcm_sgbuf_* routines. Check hda_intel.c source for more details.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
