From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Too many snd_pcm_mmap_readi calls
Date: Wed, 07 May 2014 11:01:56 +0200
Message-ID: <5369F684.7060502@ladisch.de>
References: <5369DE58.30208@janhomann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 874D92610B0
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 11:01:58 +0200 (CEST)
In-Reply-To: <5369DE58.30208@janhomann.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jan Homann <jh@janhomann.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jan Homann wrote:
> while(1) {
>     sleep(1);
>     snd_pcm_wait( pcm_handle, REC_BUFFER_ELEMENT_SIZE_MS + 10);
>     snd_pcm_mmap_begin(pcm_handle, &my_areas, &offset, &frames);
>     snd_pcm_avail_update ( pcm_handle );
>     snd_pcm_mmap_readi( pcm_handle, network_data.data_UC, ALSA_READ_FRAMES);
>     snd_pcm_mmap_commit(pcm_handle, offset, frames);
> }

The sleep will result in an overrun, which will throw off the timing
of all following calls.

You are not checking the return value of any of these functions.

Why are you calling snd_pcm_avail_update?  And why are you doing this
_after_ calling mmap_begin?

You are ignoring the number of frames returned by mmap_begin.  This
value could be smaller or larger than ALSA_READ_FRAMES.

Why are you using mmap in the first place, when you don't even try to
access the buffer directly?


Regards,
Clemens
