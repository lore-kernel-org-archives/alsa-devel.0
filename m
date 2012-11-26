From: Daniel Griscom <griscom@suitable.com>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Sun, 25 Nov 2012 22:14:00 -0500
Message-ID: <p0624080eccd8028e2fa3@[192.168.1.12]>
References: <p06240816ccd2e5cc9db7@[192.168.1.8]>
 <50AE99E7.6080008@gmail.com> <p06240802ccd72a8f5c3e@[192.168.1.12]>
 <50B21255.8080202@gmail.com> <50B249A6.108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway04.websitewelcome.com (gateway04.websitewelcome.com
 [69.56.195.7]) by alsa0.perex.cz (Postfix) with ESMTP id 8DD6F2615E8
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 04:14:04 +0100 (CET)
Received: from gator683.hostgator.com (gator683.hostgator.com
 [174.132.158.226])
 by gateway04.websitewelcome.com (Postfix) with ESMTP id CC49587C4EA59
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2012 21:14:02 -0600 (CST)
In-Reply-To: <50B249A6.108@ladisch.de>
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

At 5:39 PM +0100 11/25/12, Clemens Ladisch wrote:
>Daniel Mack wrote:
>>>  On 21.11.2012 21:13, Daniel Griscom wrote:
>>>>  1) Once in a while (every few seconds or minutes) a single
>>>>  packet will be missed
>>>>
>>>>  2) Once in a longer while (every few minutes or hours), the
>>>>  system will go into a continuing error condition where three of
>>>>  every eight packets are missed.
>>  [...]
>>  This test will tell us whether data is in fact lost before it hits the
>>  usb audio driver, or if it's dropped by the USB HCD.
>
>These look like hardware errors.

It's possible. This is a Jetway NF9D-2700 motherboard, with USB 
handled by an NM10, and there are other Linux issues with the 
hardware (e.g. the PowerVR GPU isn't supported in recent Ubuntu 
versions). But, the test results in my previous email (sent after 
yours) imply that it's a software issue.

>You might want to try to check the
>frames' status in retire_playback_urb(),

I've looked that function over, but it's not clear where in the 
various structures I'd find the status. Suggestion?

>but this will show only DMA/
>FIFO problems on the host; the HC will not be able to detect whether the
>receiving device has handled the packet.

You mean, if the data is put on the USB bus, but the receiving device 
(my audio card) loses it, there's no way the above will show this? 
The missing data never appears on the USB bus, so I'm pretty sure 
that isn't the problem here.


By the way, I'd stated that the pattern of missing packets repeats 
every eight microframes, and never varies. I've found that that isn't 
completely true; it sometimes does vary, but not by much. By 
microframe numbers within a frame, here are the two patterns I've 
seen:

0 - Miss
1 - Miss
2 - Send
3 - Send
4 - Send
5 - Miss
6 - Send
7 - Send

0 - Miss
1 - Send
2 - Send
3 - Send
4 - Send
5 - Miss
6 - Miss
7 - Send

(I've spent a while trying to concoct some sort of rule for these 
patterns based on the microframe numbers' bits, with no success. Oh, 
well.)


As always, thanks for your continuing help,
Dan

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
