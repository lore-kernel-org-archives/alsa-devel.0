From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PandaBoard ES Audio Problems
Date: Thu, 31 Jan 2013 20:44:25 +0100
Message-ID: <510AC999.2090205@ladisch.de>
References: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>	<510AA9A0.4060009@ladisch.de>	<1359656599.10392.13.camel@loki>
 <CAAo96ZDNUY8Sp=kmjGXy5Ro0q7x22XVtO3Uv0VhhJBugUvOfTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 22FB7264EFF
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 20:45:38 +0100 (CET)
In-Reply-To: <CAAo96ZDNUY8Sp=kmjGXy5Ro0q7x22XVtO3Uv0VhhJBugUvOfTw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brent Weatherall <brentweatherall@gmail.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Brent Weatherall wrote:
> stepping through the ALSA code, it seems the error *might* be in
> the ALSA code, but I am probably reading the code incorrectly:
>
> pcm/interval.c:

That code is correct (it's used in a different context).

The problem is that the kernel driver returns wrong min/max values.

> Liam Girdwood wrote:
>> The OMAP4 ABE driver doesn't actually know the exact constraints if
>> there is not a valid playback path between source PCM and sink (it will
>> still throw out anything insane though). This is because it can route
>> audio from most of it's PCMs to most of it's components, e.g. HS, HF,
>> BT, MODEM, Earpiece, etc where some components have different
>> constraints. It's possible that you dont have a path in your case.

In theory, what the driver should do is:
- don't allow the PCM device to be opened if there is no valid route
  configuration (or just never allow a completely invalid
  configuration); and
- while the PCM device is open, lock the route configuration, or
- if changing the route during playback is necessary, allow to set
  only those routes that are possible with the current PCM
  configuration.


Regards,
Clemens
