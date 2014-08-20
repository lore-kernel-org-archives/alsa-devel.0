From: Tomas Matejka <tomas.matejka@tcz.cz>
Subject: Re: ALSA - Channel swap
Date: Wed, 20 Aug 2014 14:37:20 +0200
Message-ID: <53F49680.2050003@tcz.cz>
References: <53F35310.2040300@tcz.cz> <53F377BB.90309@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ms.tcz.cz (ms.tcz.cz [90.182.135.222])
 by alsa0.perex.cz (Postfix) with ESMTP id 080812656E9
 for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2014 14:37:21 +0200 (CEST)
In-Reply-To: <53F377BB.90309@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

My kernel version is 3.2.18.
I can't uderstand this, does this mean that using Atmel, Linux and audio 
codec always result to channel swapping?
It would be very strange. How could codec manufacturer sell codec, which 
swaps channels ?
I need this for application that requires that audio channels can't be 
randomly swapped.

Dne 19.8.2014 18:13, Daniel Mack napsal(a):
> On 08/19/2014 03:37 PM, Tomas Matejka wrote:
>> Good afternoon,
>> i have a problem:
>> I use sound codec CS4202, which I control with AT91SAM9263.
>> I'm using ALSA sound library.  When i use CAPTURE mode, sometimes it
>> swaps left and right channel.
>> I have found this discussions on Internet, where is described similar
>> problem:
>>
>> http://pl.it-usenet.org/thread/17996/3593/
>> http://sinustrom.info/2013/03/21/atmel-soc-ssc-channel-swapping/
>>
>> I have figured out, that the problem could be in driver or in ALSA
>> library. Have you any solution ? Did you encountered similar problem ?
> When the mismatch happens, you'll certainly have wrong data on the I2S
> bus, so that bug cannot be caused by the codec driver.
>
> The most likely reason is that the platform's (AT91SAM9263) ASoC
> implementation has a problem syncing up the playback and record streams,
> probably in its DMA bits. I'd start searching in that area.
>
> I personally never worked with this platform, but for anyone else to
> help you, you should provide more information, such as the kernel
> version you're working with.
>
>
> Daniel
>
