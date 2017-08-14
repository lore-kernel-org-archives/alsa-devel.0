From: ThomasJF <tsepp2001@t-online.de>
Subject: Re: non-blocking mode example
Date: Mon, 14 Aug 2017 19:55:46 +0200
Message-ID: <2a3cecc4-730c-208b-0674-68bbbe5d72d4@t-online.de>
References: <86b4d23e-d214-ccbc-33b3-4f7d2de9600f@t-online.de>
 <a9bcf062-f4cf-1466-dbfa-90e67148fb13@ladisch.de>
 <e6600808-5f98-335f-9b58-bce7b15f6c63@t-online.de>
 <693e0d31-9b74-3ccf-e4a5-aac3b94ee4da@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout03.t-online.de (mailout03.t-online.de [194.25.134.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C394266CB8
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 19:55:52 +0200 (CEST)
Received: from fwd19.aul.t-online.de (fwd19.aul.t-online.de [172.20.27.65])
 by mailout03.t-online.de (Postfix) with SMTP id 16E0742572C5
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 19:55:52 +0200 (CEST)
In-Reply-To: <693e0d31-9b74-3ccf-e4a5-aac3b94ee4da@ladisch.de>
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

Thanks again Clemens,

I did it with success (moving the pointer with arithmetic forward after 
each periodsize in the big buffer). Now I have a do-while loop with 
select. Now a (I hope ...) last question:

To get the tcp-commands for stop/pause:

1.) Do I have to adapt the tcp-commands inside this loop or...

2.) Do I have to work with any poll descriptors (which?)

Best regards
Thomas


Am 13.08.2017 um 19:46 schrieb Clemens Ladisch:
> ThomasJF wrote:
>> I have read a file to buffer with "allframes".
>>
>> 1.) Do I use snd_pcm_writei(...) with a size of "allframes" or loop it
>>      with smaller packages (periodsize)
> In blocking mode, the call would be able to write all bytes, eventually.
> But in non-blocking mode, it is never possible to write more than the
> buffer size immediately.  So if you try with more frames, the function
> will write as much as it can, and you have to retry with the remaining
> frames later anyway.
>
>> 2.) What are the actual functions to get the interrupt and send the
>>      frames needed into the ringbuffer (standard I/O or select)?
> The snd_pcm_writei() call sends the frames to the buffer.  The
> notification that the device is ready (i.e., that there is enough free
> space in the buffer to write more samples) comes through any of the
> file-handle-waiting functions (select, poll, epoll).
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
