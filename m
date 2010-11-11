From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA buffer query
Date: Thu, 11 Nov 2010 11:12:54 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011111108530.29422@eeebox2.perex-int.cz>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE320@EXGMBX01.sasken.com>,
	<alpine.LNX.2.00.1011110817390.29422@eeebox2.perex-int.cz>
	<16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE322@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E0E7E1038E4
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 11:12:55 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE322@EXGMBX01.sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Nov 2010, Irfan Shaikh wrote:

> Thanks for reply,
>
> Please tell me if my understanding is correct
>
> 1) Check number of frames ready to be written in DMA area - using snd_pcm_avail_update
> 2) Call snd_pcm_mmap_begin(snd_pcm_t  * pcm, const snd_pcm_channel_area_t ** areas, snd_pcm_uframes_t * offset, snd_pcm_uframes_t * frames)
>
>     (what does offfset specify here ?)

Offset to areas.

> 3) I need to fill my audio data to be played in area  {Please tell me if this is correct}

Yes.

> 4) snd_pcm_mmap_commit(pcm_handle, offset, frames);
>
>     Please tell me is my understanding correct to play my audio buffer 
> on ASLA playback device.

You may consult the pcm.c example for all transfer methods:

http://git.alsa-project.org/?p=alsa-lib.git;a=blob_plain;f=test/pcm.c;hb=HEAD

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
