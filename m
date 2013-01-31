From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: PandaBoard ES Audio Problems
Date: Thu, 31 Jan 2013 18:23:19 +0000
Message-ID: <1359656599.10392.13.camel@loki>
References: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>
 <510AA9A0.4060009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 24C3C2625E3
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 19:23:24 +0100 (CET)
In-Reply-To: <510AA9A0.4060009@ladisch.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-01-31 at 18:28 +0100, Clemens Ladisch wrote:
> Brent Weatherall wrote:
> > At a high level, when configuring the built in audio device (3.5 mm jack),
> > the device accepts ANY rate requested (via snd_pcm_set_rate_near).  it
> > accepts unsupported rates without alteration.  If the rate is actually not
> > supported, then 'snd_pcm_hw_params' fails with error '-22'.
> 
> This sounds as if the driver published incorrect constraints.
> 
> Do you have a pointer to the driver's source code?
> 

The OMAP4 ABE driver doesn't actually know the exact constraints if
there is not a valid playback path between source PCM and sink (it will
still throw out anything insane though). This is because it can route
audio from most of it's PCMs to most of it's components, e.g. HS, HF,
BT, MODEM, Earpiece, etc where some components have different
constraints. It's possible that you dont have a path in your case.

Can you check you have enabled a valid playback path with
alsaucm/alsamixer and then test with aplay. This should help narrow down
the issue.

I've CC'ed Peter since 3.4 is a little old and he is working on the
latest OMAP4 codebase.

Regards

Liam
