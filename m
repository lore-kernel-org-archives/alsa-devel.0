From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Questions about virtual ALSA driver (dummy),
 PortAudio and full-duplex drops
Date: Tue, 06 Aug 2013 13:41:50 +0200
Message-ID: <5200E0FE.1000205@canonical.com>
References: <51EF41C8.2040701@imi.aau.dk>
 <201307241403.28873.gineera@aspect135.co.uk> <51F07150.1060004@imi.aau.dk>
 <51F0E3C5.4020400@ladisch.de> <51FD9AB6.4050408@imi.aau.dk>
 <5200D712.2040800@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E77C42616CB
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 13:41:48 +0200 (CEST)
In-Reply-To: <5200D712.2040800@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, Smilen Dimitrov <sd@imi.aau.dk>
List-Id: alsa-devel@alsa-project.org

On 08/06/2013 12:59 PM, Clemens Ladisch wrote:
> Smilen Dimitrov wrote:
>> On 2013-07-25 10:37, Clemens Ladisch wrote:
>>> Your driver's .pointer callback must report the *actual* position at
>>> which the hardware has finished reading from the buffer
> 
> ... for a playback stream, or finished reading, for a capture stream.

Hi Clemens,

I'm not involved with Smilen but still find the questions interesting,
so as always, thanks for sharing your knowledge :-)

What if the pointer granularity is very coarse? E g, some hardware might
only be able what period you're in (IIRC, I've seen this on the Tegra
platform), rather than the actual sample. Would you recommend to report
the latest period boundary in that case, or interpolating it with timers?

This is also interesting to PulseAudio which likes to rewind buffers and
so on, and relies on a good pointer granularity.

>> The card then, uses it's own clock, which is not burdened with
>> anything else but filling buffers, meaning we can expect tight timing
>> here; and when it generates an IRQ, it is handled by kernel with
>> highest priority - ergo, not so much jitter. Timer functions, on the
>> other hand, run in softIRQ context - meaning they (and their
>> scheduling) could be preempted by the hardware IRQ of any other device
>> on the system; ergo, more jitter. Is this reasonable to assume?
> 
> Yes, but other hardware interrupts interfere only if other devices are
> used at the same time.

Also, it applies to kernel-space only. If you want to process anything
in userspace, you can still be interrupted by any kernel process -
hardIRQ, softIRQ or even other kernel tasks.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
