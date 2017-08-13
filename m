From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: non-blocking mode example
Date: Sun, 13 Aug 2017 19:46:22 +0200
Message-ID: <693e0d31-9b74-3ccf-e4a5-aac3b94ee4da@ladisch.de>
References: <86b4d23e-d214-ccbc-33b3-4f7d2de9600f@t-online.de>
 <a9bcf062-f4cf-1466-dbfa-90e67148fb13@ladisch.de>
 <e6600808-5f98-335f-9b58-bce7b15f6c63@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C2CA266884
 for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2017 19:47:02 +0200 (CEST)
Received: from [192.168.42.221] (tmo-119-132.customers.d1-online.com
 [80.187.119.132])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id EA1CE5581B6B
 for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2017 19:46:57 +0200 (CEST)
In-Reply-To: <e6600808-5f98-335f-9b58-bce7b15f6c63@t-online.de>
Content-Language: en-US
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

ThomasJF wrote:
> I have read a file to buffer with "allframes".
>
> 1.) Do I use snd_pcm_writei(...) with a size of "allframes" or loop it
>     with smaller packages (periodsize)

In blocking mode, the call would be able to write all bytes, eventually.
But in non-blocking mode, it is never possible to write more than the
buffer size immediately.  So if you try with more frames, the function
will write as much as it can, and you have to retry with the remaining
frames later anyway.

> 2.) What are the actual functions to get the interrupt and send the
>     frames needed into the ringbuffer (standard I/O or select)?

The snd_pcm_writei() call sends the frames to the buffer.  The
notification that the device is ready (i.e., that there is enough free
space in the buffer to write more samples) comes through any of the
file-handle-waiting functions (select, poll, epoll).


Regards,
Clemens
