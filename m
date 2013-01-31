From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: PandaBoard ES Audio Problems
Date: Thu, 31 Jan 2013 20:00:00 +0000
Message-ID: <1359662400.10392.26.camel@loki>
References: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>
 <510AA9A0.4060009@ladisch.de>	<1359656599.10392.13.camel@loki>
 <CAAo96ZDNUY8Sp=kmjGXy5Ro0q7x22XVtO3Uv0VhhJBugUvOfTw@mail.gmail.com>
 <510AC999.2090205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D8D19264EED
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 21:00:29 +0100 (CET)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Brent Weatherall <brentweatherall@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-01-31 at 20:44 +0100, Clemens Ladisch wrote:
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

Ah, this was my initial design too :)

Some userspace software will actually and validly open a PCM, configure
some mixers and then perform a hw_params() -> trigger(). So locking out
the PCM at open() for invalid paths breaks some userspace code. 

> - while the PCM device is open, lock the route configuration, or

We cant do this either as we have to support runtime switching between
different use cases (that use different back end components) e.g. MP3
playback to Phonecall

> - if changing the route during playback is necessary, allow to set
>   only those routes that are possible with the current PCM
>   configuration.

We do this already, but will first try and fixup any of the
configuration differences in the DSP so that the userspace operation
succeeds.

I guess Peter/Brent will have to look at the min/max values in more
detail.

Liam
