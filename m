From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Using snd_pcm_set_params() on a capture handle
Date: Mon, 26 Oct 2015 12:27:41 +0100
Message-ID: <562E0E2D.9060400@metafoo.de>
References: <20151025174442.b318e489f0568566a4b82908@mega-nerd.com>
 <562D376E.7000308@ladisch.de>
 <20151026194701.7258eceaea5cb7a7a41bcf94@mega-nerd.com>
 <562DEF9C.8090706@ladisch.de>
 <20151026202321.cc3f5496a60a9369542d6be6@mega-nerd.com>
 <562DF600.8020809@ladisch.de>
 <20151026205431.e306afd9e96991ebe7fa7889@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EB5626062F
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 12:27:43 +0100 (CET)
In-Reply-To: <20151026205431.e306afd9e96991ebe7fa7889@mega-nerd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/26/2015 10:54 AM, Erik de Castro Lopo wrote:
> Clemens Ladisch wrote:
> 
>> To get the current parameters of the device, use snd_pcm_hw_params_current().
> 
> Ah, that makes sense. Now I get:
> 
>     ACCESS:  RW_INTERLEAVED
>     FORMAT:  S32_LE
>     SUBFORMAT:  STD
>     SAMPLE_BITS: [0 0]
>     FRAME_BITS: [64 64]
>     CHANNELS: [2 2]
>     RATE: [48000 48000]
>     PERIOD_TIME: [6250 6250]
>     PERIOD_SIZE: [300 300]
>     PERIOD_BYTES: [0 0]
>     PERIODS: [0 0]
>     BUFFER_TIME: [0 0]
>     BUFFER_SIZE: [1200 1200]
>     BUFFER_BYTES: [9600 9600]
>     TICK_TIME: [0 0]
> 
> Why is SAMPLE_BITS == [0 0], even though the format is S32_LE?

That appears to be a bug in snd_pcm_hw_params_current() which does simply
not set SAMPLE_BITS.

- Lars
