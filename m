From: Prasant J <pj0585@gmail.com>
Subject: Re: ASoC: mmap or read/write?
Date: Fri, 19 Oct 2012 15:06:34 +0530
Message-ID: <CAA2DH4vYZC-cK4P3crhQS7xkDRhh0cxKLAXacp144Ni2nL8HOQ@mail.gmail.com>
References: <mailman.1.1350554402.30975.alsa-devel@alsa-project.org>
 <5080F434.6040602@topic.nl> <50811626.9030100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BF7126531C
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 11:36:36 +0200 (CEST)
Received: by mail-qa0-f44.google.com with SMTP id 25so7883qao.17
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 02:36:34 -0700 (PDT)
In-Reply-To: <50811626.9030100@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 19, 2012 at 2:28 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Mike Looijmans wrote:
>> From: Prasant J <pj0585@gmail.com>
>>>> Prasant J wrote:
>>>>> I'm writing an alsa application for recording & playing 16 channel audio.
>>>
>>> I'm working with Beaglebone (ARM Cortex-A8 720 MHz). (Currently
>>> failures are for 8 channels 32 bit / 16 bit, but our final target is
>>> 16 channels)
>>>
>>> I have managed to get Audio capture working fine (after certain linux
>>> optimizations) but playback is giving under-runs (only when PLAYBACK &
>>> CAPTURE run together)
>>
>> You must be doing something wrong. I'm doing 32-bit, 16-channel input
>> at 51.2kHz on a OMAP-L138 (an ARM9 CPU at 450 MHz)
>

@Mike:
I'm playing & recording at the same time, that should be the reason.

When I was using arecord (only capture) I was getting overruns and
only after making some linux optimizations, I was able to record
properly. Are you 100% sure you do not observe any errors? Did you do
tests for longer durations?


> Playback and capture at the same time seems to be harder for certain
> embedded devices.  I don't know if this is a driver bug or a hardware
> limitation.
>

@Clemens:
The bottle-neck is SD card access. Driver bug cannot be ruled out, but
it is difficult to evaluate.

Regards, Praant

P.S.: How do I reply to a post whose mail I did not receive. (I have
enabled alsa-devel mails only now, but if someone does not include me
in cc, I do not receive the posts started by me)
