From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to use implicit feedback with full duplex?
Date: Tue, 26 Mar 2013 21:06:22 +0100
Message-ID: <5151FFBE.7040304@gmail.com>
References: <51116F36.9040106@ladisch.de>
 <alpine.LNX.2.00.1302052326150.1207@xoschi> <5112B969.50905@ladisch.de>
 <alpine.LNX.2.00.1303242323480.5410@xoschi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id E9D192602C6
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 21:06:31 +0100 (CET)
Received: by mail-bk0-f52.google.com with SMTP id it16so1102662bkc.25
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 13:06:31 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1303242323480.5410@xoschi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 24.03.2013 23:49, Eldad Zack wrote:
> 
> Hi Clemens,
> 
> On Wed, 6 Feb 2013, Clemens Ladisch wrote:
> 
>> Eldad Zack wrote:
>>> On Tue, 5 Feb 2013, Clemens Ladisch wrote:
>>>> I thought I'd try to use implicit feedback with my simple audio device:
>>>> [...]
>>>> This works fine when playing something:
>>> ...
>>>> But when I then try to record at the same time, the driver refuses to
>>>> configure the input endpoint (to the only format, which is already set):
>>>> And despite that "alreay in use" check, the input endpoint is affected
>>>> so much that playback breaks.
>>>>
>>>> Is full duplex supposed to work?  Does it work with other devices?
>>>
>>> This is probably a "yes, but" :)
>>> I use my device mostly full duplex, but with jack opening both
>>> playback and capture at the same time.
>>>
>>> I assume you are opening two different streams, one for playback and
>>> one for capture.
>>
>> Jack *also* uses two different streams, but it opens them at the same
>> time.
>>
>>> Can you try using jackd -d alsa -d hw:x with the device and see if that
>>> works for you?
>>
>> That works.  This means that there is a race condition in the driver, or
>> that the different open/hw_params/prepare order trips it up.
> 
> Yes, and also on closing (close/hw_free).
> I finally had some time to look into this - patch below adds some 
> checks and with it:
>     
> * Starting playback, waiting, starting capture: capture doesn't start,
>   playback continues without breaking.
>     
> * Starting capture, waiting, starting playback: playback doesn't start,
>   capture breaks - but it is possible to restart the streams afterwards.
>   [On my setup (with xhci), when the streams break I must restart my box
>   to get them to work again with current code].
> 
> * Starting both - no change, works good.
> 
> This is the order the ops get called when both are start at once, if it 
> helps anyone:
> 
> playback	capture
> open
> 		open
> 		hw_params
> 		 set_format
>  		prepare
>  		 set_format
> hw_params
>  set_format
> prepare
>  set_format
> prepare
>  set_format
> 		prepare
> 		 set_format
>  trigger
> 		trigger
> 
> I'll try to figure out why capture breaks next.
> I still quite slow around the code and don't understand some parts of 
> it so this might take me a while.

Thanks for looking into this!

> @Daniel, do you have any hints for this case (capture breaking
> when starting playback)?

Give me some time to catch up and rebuild my FTU setup please. I hope
I'll be able to get back to you by the end of this week.


Daniel
