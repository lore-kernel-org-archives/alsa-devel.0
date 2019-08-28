From: Pavel Hofman <pavhofman@gmail.com>
Subject: Re: Options for ASYNC feedback source in USB-audio
	gadget (USB OTG)?
Date: Wed, 28 Aug 2019 17:17:12 +0200
Message-ID: <CA+SWvNztL5Ykt_LtU+zyv0MjWbM6wqAvM4U+JVcqvcN3AhdGNg@mail.gmail.com>
References: <CA+SWvNwqg3Q37BWNpw7C+75Z+CO-zUo2UUYjvz88L3hW1tk=gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 824A4F80362
 for <Alsa-devel@alsa-project.org>; Wed, 28 Aug 2019 17:17:26 +0200 (CEST)
Received: by mail-qk1-x72f.google.com with SMTP id m2so26602qki.12
 for <Alsa-devel@alsa-project.org>; Wed, 28 Aug 2019 08:17:25 -0700 (PDT)
In-Reply-To: <CA+SWvNwqg3Q37BWNpw7C+75Z+CO-zUo2UUYjvz88L3hW1tk=gQ@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 28, 2019 at 1:17 PM Pavel Hofman <pavhofman@gmail.com> wrote:
>
> But the feedback EP needs input data. The whole chain behind the
> virtual capture alsa device defined by the gadget driver is clocked by
> the playback soundcard. May I ask for your opinions on possible
> options for
>
> 1) gathering the feedback data from the playback chain
> 2) passing the gathered samplerate-diff data to the gadget module for
> the feedback EP to send to the USB host
>

IMO some common time frame must be used. E.g. kernel time in nanoseconds.

How about something like this:

1) the core PCM part of alsa driver would keep relative samplerate and
present such value in proc/sysfs to userspace.
the calculation something like:
copied X sample frames in Y kernel nanosecs (for the last e.g. approx.
30 secs ), with nominal samplerate 48kHz. The value would be
(10^9 * X frames/Y nanosecs) / 48000 Hz samplerate = e.g. 1.00001

2) the usb gadget code also creates/uses alsa driver, thus
measuring/displaying to userspace the same value, e.g. 1.00002 - USB
data incoming slightly faster than being consumed by the soundcard

3) the usb gadget would accept some feedback value via procfs/sysfs

4) a userspace daemon could monitor the relative samplerates of the
output and of the usb gadget (both values are relative to the same
kernel nanosecs clock), could calculate the required adjustment and
send proper value to the gadget feedback (in some format). Default
async feedback would be "no change", unless received required value
from userspace.

Monitoring the average throughput (samplerate relative to kernel
clock) could be enabled with a module param for alsa drivers, default
off.

The reason for dividing the "kernel-time samplerate" with nominal
samplerate is the chain can be resampling (48kHz -> 192kHz), but the
relative "deviation" should be the same for any samplerate.

Thanks a lot for any suggestions and comments.

Pavel.
