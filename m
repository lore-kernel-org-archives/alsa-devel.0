From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Re: SEGFAULT : snd_pcm_mmap_begin/commit
Date: Tue, 16 Nov 2010 14:48:37 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE340@EXGMBX01.sasken.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE33F@EXGMBX01.sasken.com>,
	<4CE247DD.7010303@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 2345D24369
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 10:23:16 +0100 (CET)
In-Reply-To: <4CE247DD.7010303@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks for your observation.

>Well, the only pointer dereference is to area, so area has an invalid
>pointer. Please check the return value of snd_pcm_mmap_begin to see why.

Return value is negative. (-77). How do i resolve it   (Using Sleep ??  / snd_pcm_wait() ??)

>Hmm, I've haven't used snd_pcm_mmap_* in a long time, but shouldn't the
>memcpy be above snd_pcm_mmap_commit? Second, if you're using memcpy, why
>don't settle with snd_pcm_writei in the first place?

i am actually unable to use _commit properly so was judt experimenting using memcpy().
My requirement is to use _begin and _commit.

I will experiment by using memcpy above _commit.

Thanks

________________________________________
From: David Henningsson [david.henningsson@canonical.com]
Sent: Tuesday, November 16, 2010 2:29 PM
To: Irfan Shaikh
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] SEGFAULT : snd_pcm_mmap_begin/commit

On 2010-11-16 09:44, Irfan Shaikh wrote:
> Hello All,
>
> I have been facing dificulty in using snd_pcm_mmap_begin and snd_pcm_mmap_commit.
> Shows Seg fault as pointed by comment in code below.
> Please tell me what wrong i am doing and how do i correct.
>
> /###################################################################################/
>          unsigned int count = (alsaParams->frames/(((alsaParams->bit_per_sample)*(alsaParams->num_channel)) / 8));
>          unsigned char *data = alsaParams->data;https://owa.sasken.com/owa/?ae=Item&t=IPM.Note&a=New#
>          snd_pcm_sframes_t frames_available, frames_transmit;
>          const snd_pcm_channel_area_t *area;
>          snd_pcm_uframes_t offset;
>          char *outbuffer;
>          int result;
>
>          /*available space in audio-buffer to write to*/
>          frames_available = snd_pcm_avail_update(alsaParams->pcm_handle);
>
>          /*
>           * prepare the areas
>           * and get back area, offset and frames_transmit
>           * frames_transmit gives back the REAL value of available frames which could be written to in the mmaped-area
>           * frames_transmit are less than frames_available
>           */
>          frames_transmit = frames_available;
>
>          snd_pcm_mmap_begin(alsaParams->pcm_handle,&area,&offset,&frames_transmit);
>
>          /*calculates the mmaped-buffer which could be written to*/
>          outbuffer = ((char *) area->addr + (area->first + area->step * offset)/ 8);    // ****** SEGFAULT *******

Well, the only pointer dereference is to area, so area has an invalid
pointer. Please check the return value of snd_pcm_mmap_begin to see why.

>
>          /*gives back the virtually written (writable) frames which should be always == frames_transmit*/
>          result = snd_pcm_mmap_commit(alsaParams->pcm_handle, offset, frames_transmit);
>
>          memcpy(outbuffer, data, count);  //data is actual data

Hmm, I've haven't used snd_pcm_mmap_* in a long time, but shouldn't the
memcpy be above snd_pcm_mmap_commit? Second, if you're using memcpy, why
don't settle with snd_pcm_writei in the first place?

--
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
