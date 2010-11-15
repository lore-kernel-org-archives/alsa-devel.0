From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Direct write (using mmap_bigin and commit)
Date: Mon, 15 Nov 2010 14:22:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011151415310.29422@eeebox2.perex-int.cz>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE339@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D31F8103824
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 14:22:17 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE339@EXGMBX01.sasken.com>
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

On Mon, 15 Nov 2010, Irfan Shaikh wrote:

> Hello,
>
>         I am reading an raw PCM  file and want to write on PCM device using direct write (interleaved). I have gone through PCM.c test application.
> I am trying tio write PCM audio data as follows. I am unable to use  snd_pcm_mmap_begin and snd_pcm_mmap_commit properly. Please help me to use using these APIs
> Question :
> 1) How can i write to Ring buffer area (any pcm audio data)?  //Any example or explanation other than pcm.c
> 2) Do i need to write diffferently for each channel as shown in pcm.c
>
> I am trying to do following but not succeded (reading pcm file and writing content on device) . ANy thing played on audio device would help me in understanding.
>
>        snd_pcm_channel_area_t my_areas;
>        snd_pcm_uframes_t offset, frames, size;
>        snd_pcm_sframes_t avail, commitres;
>        int result;
>        char *buffer;
>
>        while(1)
>        {
>            avail = snd_pcm_avail_update(handle);
>            if(avail>=period_size)
>            {
>                size=periodsize
>                while (size > 0) {
>                        frames = size;
>                        err = snd_pcm_mmap_begin(handle, &my_areas, &offset, &frames);
>                        mybuffer=(char *)malloc(frames*2);
>                        result = fread (mybuffer,1,(frames*2),pFile);
>                        my_areas.addr=mybuffer;           // IS THIS CORRECT ? WILL THIS WORK ? How can i write my audio file data here in areas?

What's this? You just overwrite the read-only pointer value in my_areas. 
Use the ring buffer pointer and do memcpy or so. Use area returned from 
mmap_begin(), don't forget to add offset. Also, application must check, 
if my_areas description (buffer arrangement) is expected (check for 
sample step/offset).

The pcm.c is good example. Just try to understand what my_areas 
really does. And no, it's not necessary to handle just one sample, if you 
know the PCM ring buffer layout.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
