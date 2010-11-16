From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: SEGFAULT : snd_pcm_mmap_begin/commit
Date: Tue, 16 Nov 2010 09:59:09 +0100
Message-ID: <4CE247DD.7010303@canonical.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE33F@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ECE124340
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 09:59:13 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE33F@EXGMBX01.sasken.com>
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
