From: Brent Weatherall <brentweatherall@gmail.com>
Subject: Re: PandaBoard ES Audio Problems
Date: Thu, 31 Jan 2013 11:50:13 -0800
Message-ID: <CAAo96ZD2nueeSHT_+oDicHw1TjJ=bOrBLjFhRz3neHsmWeY0vQ@mail.gmail.com>
References: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>
 <510AA9A0.4060009@ladisch.de> <1359656599.10392.13.camel@loki>
 <CAAo96ZDNUY8Sp=kmjGXy5Ro0q7x22XVtO3Uv0VhhJBugUvOfTw@mail.gmail.com>
 <510AC999.2090205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f52.google.com (mail-pb0-f52.google.com
 [209.85.160.52])
 by alsa0.perex.cz (Postfix) with ESMTP id CD315262629
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 20:50:14 +0100 (CET)
Received: by mail-pb0-f52.google.com with SMTP id mc8so1013346pbc.25
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 11:50:13 -0800 (PST)
In-Reply-To: <510AC999.2090205@ladisch.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

     OK.  It sounds like I need to go further down into the hardware driver
to ferret out the cause.  I agree with you it looks like a bad return from
hardware.  I will see if I can figure out how to get the correct code.  it
sounds to me like it should be in one of the TI OMAP branches then.  Thanks!

Regards,

Brent


On Thu, Jan 31, 2013 at 11:44 AM, Clemens Ladisch <clemens@ladisch.de>wrote:

> Brent Weatherall wrote:
> > stepping through the ALSA code, it seems the error *might* be in
> > the ALSA code, but I am probably reading the code incorrectly:
> >
> > pcm/interval.c:
>
> That code is correct (it's used in a different context).
>
> The problem is that the kernel driver returns wrong min/max values.
>
> > Liam Girdwood wrote:
> >> The OMAP4 ABE driver doesn't actually know the exact constraints if
> >> there is not a valid playback path between source PCM and sink (it will
> >> still throw out anything insane though). This is because it can route
> >> audio from most of it's PCMs to most of it's components, e.g. HS, HF,
> >> BT, MODEM, Earpiece, etc where some components have different
> >> constraints. It's possible that you dont have a path in your case.
>
> In theory, what the driver should do is:
> - don't allow the PCM device to be opened if there is no valid route
>   configuration (or just never allow a completely invalid
>   configuration); and
> - while the PCM device is open, lock the route configuration, or
> - if changing the route during playback is necessary, allow to set
>   only those routes that are possible with the current PCM
>   configuration.
>
>
> Regards,
> Clemens
>
