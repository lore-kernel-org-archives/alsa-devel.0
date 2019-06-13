From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: (no subject)
Date: Thu, 13 Jun 2019 10:51:07 -0500
Message-ID: <a00b46af-30c6-fba5-096b-62d88f66ae37@linux.intel.com>
References: <trinity-bf4e0eb4-e575-4dfc-9315-bc322b7b7f19-1560405271802@3c-app-gmx-bs72>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E486F8076F
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 17:51:11 +0200 (CEST)
In-Reply-To: <trinity-bf4e0eb4-e575-4dfc-9315-bc322b7b7f19-1560405271802@3c-app-gmx-bs72>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ralf Beck <musical_snake@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/13/19 12:54 AM, Ralf Beck wrote:
> 
> Jaroslav Kysela wrote:
>> I just don't think that the mmap transfer mode is the culprit of the problems.
>> The problem is that the PCI cards off-loads the DMA transfers completely
>> without the extra framing required for those serial hardware interfaces which
>> are handled in the audio driver and the other kernel stacks (USB etc.).
> 
> The source of all evil is the ring buffer.
> It prevents all devices that require packet headers (Firewire/network based solutions) or that
> use a variable amount of frames per packet (all asynchronous devices, especially asynchronous USB ISO endpoints)
> from mapping their data directly into userspas memory without ever touching the audio data in it.
> 
> While this doesn't hurt performance to much with devices that offer only a few channels,
> it has a massive effect on network based devices with possibly hundreds of channels of which only
> a small number is used (e.g. record enabled) at a time.
> 
> The ringbuffer should be replaced by a buffer that holds the packets and a descriptor for how to find the data in it. Btw, alsa uses something similar already for the mmap handling.
> 
> The descriptor should consist of
> x periods, containing y chunks with a max size, containing z channels, each of the channel described by a start address and step value within that chunk.

You're assuming a reliable network where not a single packet is missing. 
I can bet that if you start adding support for packet-based audio some 
folks are going to want to support timestamps and missing packets, which 
would throw a large size monkey-wrench in your ideas of time reporting 
below.
Also note that you could rely on the compressed API to deal with packets 
as an interface between your applications and your hardware - even if 
the actual data is PCM. It's still based on a ring buffer but it doesn't 
have the built-in bytes-to-time relationship that the ALSA PCM API 
relies on.

> Examples:
> PCI device; 2 periods, 1 chunks per period, max size 64 frames per chunk, 2 channels per chunk
> USB device: 2 periods, 8 chunks (microframes) max size 8 frames (if at 44.1/48kHz), 2 channels per chunk,
> Same for Firewire, AVB (each chunk possibly containing several AVB streams, i.e. ethernet packets), etc.
> 
> Period elapsed => the number of chunks forming a period have been received
> 
> snd_pcm_avail(_update) => return the sum of actual frames of the period
> 
> snd_pcm_mmap_commit => return the descriptor for one chunk, the number of frames of the chunk and a channel map for the chunk. The reason for the latter is that on ethernet based devices (AVB) there is bo guarantee that streams of different endpoints are received in the same order (but in the same interval window).
> Alsa clients should then loop until they have processed all frames thar have been reported by snd_pcm_avail (instead of a period size number of frames).
> 
> Ah, and AM824 raw audio format, used by firewire and AVB, should by added to the list of audio formats, so conversion can be done in userspace.
> 
> Ralf
> 
> 
>   
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
