From: Daniel Griscom <griscom@suitable.com>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Tue, 27 Nov 2012 15:10:45 -0500
Message-ID: <p06240802ccdacd0f08d7@[192.168.1.8]>
References: <p06240816ccd2e5cc9db7@[192.168.1.8]>
 <50AE99E7.6080008@gmail.com> <p06240802ccd72a8f5c3e@[192.168.1.12]>
 <50B21255.8080202@gmail.com> <p06240812ccd8489d6378@[192.168.1.12]>
 <50B31800.2000000@gmail.com> <p06240804ccd98cef996c@[192.168.1.8]>
 <50B4A870.7040201@gmail.com> <p06240808ccdaa0a47bbb@[192.168.1.8]>
 <50B4F699.5090205@ladisch.de> <p0624080cccdaac242dc3@[192.168.1.8]>
 <50B518A9.4090807@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway12.websitewelcome.com (gateway12.websitewelcome.com
 [67.18.82.6]) by alsa0.perex.cz (Postfix) with ESMTP id 894D92615CF
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 21:10:53 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway12.websitewelcome.com (Postfix) with ESMTP id BB4863722BC20
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 14:10:54 -0600 (CST)
In-Reply-To: <50B518A9.4090807@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa Developer <alsa-devel@alsa-project.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

At 8:46 PM +0100 11/27/12, Clemens Ladisch wrote:
>Daniel Griscom wrote:
>>  We are using a bInterval value of 1 (on a high-speed device). We've
>>  recently tried bumping this up to 2, and the problem was no longer
>>  evident
>
>This might indicate that the controller has problems reading the
>packet data from memory; there's a considerable overhead for each
>memory transaction, and the controller needs to update the DMA lists.
>(The pattern might be caused by some data, which arrives too late,
>interfering with the reading of the next packet.)

So, might this whole thing have been caused by setting bInterval to 1 
in the device descriptor?

>If 2 is the first save interval, consider using 4.

Interval lengths are 2 ^ (bInterval - 1) microframes, so we went from 
1 microframe to 2. Should I go right to a bInterval of 2 (4 
microframes)?

>  For that matter,
>full-speed devices work fine with one packet per frame.  There isn't
>a problem with buffering one millisecond of data in the device, is it?

We are indeed trying to squeeze the milliseconds out of the audio 
chain, but getting it robust is obviously the priority.

>(The only reason to use smaller intervals is if you really require sub-
>millisecond latencies, or if the bigger packets would eat up too much
>bandwidth in one of the microframes.  The cost of smaller intervals is
>more overhead on the host, on the bus, and in the device.)

We have plenty of bus bandwidth, and I'd thought we had plenty of CPU 
power, but perhaps not.


Thanks,
Dan

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
