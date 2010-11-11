From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Re: ALSA buffer query
Date: Thu, 11 Nov 2010 14:56:44 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE322@EXGMBX01.sasken.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE320@EXGMBX01.sasken.com>,
	<alpine.LNX.2.00.1011110817390.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id BB63B1037EE
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 10:26:48 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1011110817390.29422@eeebox2.perex-int.cz>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks for reply,

Please tell me if my understanding is correct

1) Check number of frames ready to be written in DMA area - using snd_pcm_avail_update
2) Call snd_pcm_mmap_begin(snd_pcm_t  * pcm, const snd_pcm_channel_area_t ** areas, snd_pcm_uframes_t * offset, snd_pcm_uframes_t * frames)

     (what does offfset specify here ?)

3) I need to fill my audio data to be played in area  {Please tell me if this is correct}

4) snd_pcm_mmap_commit(pcm_handle, offset, frames);

     Please tell me is my understanding correct to play my audio buffer on ASLA  playback device.

      I am not clear about where do i write my audio payload ? And how offset in snd_pcm_mmap_begin is realted to it ?

Thanks and Regards,




________________________________________
From: Jaroslav Kysela [perex@perex.cz]
Sent: Thursday, November 11, 2010 12:48 PM
To: Irfan Shaikh
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] ALSA buffer query

On Thu, 11 Nov 2010, Irfan Shaikh wrote:

> Hello All,
>
>
>      1) My understanding :  snd_pcm_writei() takes the allocated buffer
> from applications and passes the buffer beneath to the ASLA library and
> then to the ALSA driver for rendering Audio.
>
>      2) Query 1 : Instead of me allocating the buffer in ALSA
> application and passing the pointer in snd_pcm_writei, Can ALSA allocate
> the buffer and give to my application, so that i can copy my data into
> it.
>
>      3) Query 2 : Is there any wayto diirectly get hardware ALSA buffer
> from the ALSA driver to application so that i can copy PCM data to this
> buffer directly.
>                          If not, is there any way can we do this ?

Read alsa-lib documentation. snd_pcm_mmap_begin/snd_pcm_mmap_commit.

                                                Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.


SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
