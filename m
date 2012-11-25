From: Daniel Mack <zonque@gmail.com>
Subject: Re: Missing exactly 3 of 8 audio packets?
Date: Sun, 25 Nov 2012 13:43:01 +0100
Message-ID: <50B21255.8080202@gmail.com>
References: <p06240816ccd2e5cc9db7@[192.168.1.8]> <50AE99E7.6080008@gmail.com>
 <p06240802ccd72a8f5c3e@[192.168.1.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D63E2264ECA
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2012 13:43:07 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so4013307bkc.38
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2012 04:43:07 -0800 (PST)
In-Reply-To: <p06240802ccd72a8f5c3e@[192.168.1.12]>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Griscom <griscom@suitable.com>
Cc: Alsa Developer <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Dan,

On 25.11.2012 04:33, Daniel Griscom wrote:
> At 10:32 PM +0100 11/22/12, Daniel Mack wrote:
>> On 21.11.2012 21:13, Daniel Griscom wrote:
>>> On to the next problem we're having with our USB audio card.
>>> Recap: simple USB Audio Class embedded stereo audio card, running
>>> at 44.1kHz or 48kHz, using the 3.6.6 kernel and its associated
>>> ALSA modules to drive it, running on Jetway ND9D-2700, with an
>>> Atom D2700 and NM10 chipset. Output of "sudo lsusb -v" for card
>>> is appended below.
>>> 
>>> Problem: we're experiencing strange hiccups in the delivery of
>>> audio from the motherboard to the card. At 48kHz, the motherboard
>>> should send a 6-frame packet to the card once per high-speed
>>> microframe (every 125us). This usually works, but sometimes there
>>> are two closely related failures:
>>> 
>>> 1) Once in a while (every few seconds or minutes) a single
>>> packet will be missed
>>> 
>>> 2) Once in a longer while (every few minutes or hours), the
>>> system will go into a continuing error condition where three of
>>> every eight packets are missed.
>>> 
>>> In both cases, "missed" means that ALSA consumes the output
>>> audio from my motherboard application, but never sends a packet
>>> to the audio card. No USB errors, no logged messages; it just
>>> disappears.
>> 
>> I missed that detail before. What makes you so sure ALSA actually 
>> consumes audio it never sends out? Are you sending a test pattern
>> which is interrupted in your USB analyzer traces?
> 
> Great idea, and it took me a few days to be able to do it (too much
> turkey to be dealt with). The answer is yes: ALSA is consuming data
> that doesn't make it onto the USB bus.
> 
> My app is completely clocked by ALSA, sending out whatever the ALSA
> output stream will accept, and taking in whatever the ALSA input
> stream will offer. I set my app to output stereo triangle waves (in
> different frequencies), captured the data with the Beagle 1200, and
> then graphed it as a function of sample count. When things were
> running fine, the graph looked nice and clean. When the packets were
> being lost, both lines in the graph periodically jump, skipping
> values. The sizes of the jumps alternate, matching the pattern I
> cited where in each set of eight microframes two adjacent frames are
> skipped, and then a single frame is skipped.
> 
> If ALSA hadn't taken the data, my app would just wait until it did,
> with no data lost (although the output graph would still be bad as a
> function of time). So, ALSA (or something deeper) must be discarding
> the data.

Please do another test and change prepare_outbound_urb() so that instead
of calling ep->prepare_data_urb() to fill the URB, fill it directly with
some sort of easily recognizable test pattern (you can take the code
from "silence" case to access the buffers). Some kind of 16-bit counter
should do. And then check the payload with the Beagle and see whether
the pattern has gaps.

This test will tell us whether data is in fact lost before it hits the
usb audio driver, or if it's dropped by the USB HCD.


Daniel
