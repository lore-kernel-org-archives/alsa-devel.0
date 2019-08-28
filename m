From: Pavel Hofman <pavhofman@gmail.com>
Subject: Re: Options for ASYNC feedback source in USB-audio
	gadget (USB OTG)?
Date: Wed, 28 Aug 2019 18:15:02 +0200
Message-ID: <CA+SWvNwMVRG5C=pSTDBvmODLkJQ4b4eWv=u-VU0ULOx+C6K8Ew@mail.gmail.com>
References: <CA+SWvNwqg3Q37BWNpw7C+75Z+CO-zUo2UUYjvz88L3hW1tk=gQ@mail.gmail.com>
 <CA+SWvNztL5Ykt_LtU+zyv0MjWbM6wqAvM4U+JVcqvcN3AhdGNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23E6DF896FE
 for <Alsa-devel@alsa-project.org>; Wed, 28 Aug 2019 18:15:15 +0200 (CEST)
Received: by mail-qt1-x836.google.com with SMTP id k13so98582qtm.12
 for <Alsa-devel@alsa-project.org>; Wed, 28 Aug 2019 09:15:15 -0700 (PDT)
In-Reply-To: <CA+SWvNztL5Ykt_LtU+zyv0MjWbM6wqAvM4U+JVcqvcN3AhdGNg@mail.gmail.com>
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

On Wed, Aug 28, 2019 at 5:17 PM Pavel Hofman <pavhofman@gmail.com> wrote:
> IMO some common time frame must be used. E.g. kernel time in nanoseconds.
>
> How about something like this:
>
> 1) the core PCM part of alsa driver would keep relative samplerate and
> present such value in proc/sysfs to userspace.
> the calculation something like:
> copied X sample frames in Y kernel nanosecs (for the last e.g. approx.
> 30 secs ), with nominal samplerate 48kHz. The value would be
> (10^9 * X frames/Y nanosecs) / 48000 Hz samplerate = e.g. 1.00001

Perhaps the relative throughput could be calculated in alsa-lib when
talking to the driver? It has the same information available.
Turned-on by some environment var, regular output to some /tmp file
named after the corresponding hw card. Or does please alsa-lib have
some existing debug output, similar to /proc/asound, apart of stderr?

I very much appreciate any comments. IMO this would be a very useful
improvement, there are lots of RPi projects which would benefit from
properly working USB-audio connectivity.

Thanks,

Pavel.
