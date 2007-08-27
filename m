From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: Noise at end of audio file
Date: Mon, 27 Aug 2007 13:36:58 -0500
Message-ID: <B082902A12CAEE4EA7FE2ED20609013B01729E43@dlee15.ent.ti.com>
References: <s5h1wdvipet.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 2072E10381D
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Aug 2007 20:37:06 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <s5h1wdvipet.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I thought that the noise could be a sync issue at the end of file, but
after getting the time between two succesive 'period' data sendings and
comparing it with the 'period time' given by aplay (verbose option), the
differences is of only ~10 us, I mean the values in all others periods
processed are in the same range, nothing special with the periods that
are giving noise.

However if the audio length is less than one buffer, no noise is listen
at all. The problem seems to be with files that don't fit in a single
buffer.

Misael

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Wednesday, August 22, 2007 10:02 AM
To: Lopez Cruz, Misael
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Noise at end of audio file

At Wed, 22 Aug 2007 09:31:25 -0500,
Lopez Cruz, Misael wrote:
> 
> I'm using aplay application for playback, the platform I'm working 
> with is ti-omap.
> 
> Regards,
> Misael
> 

Hm, then it's hard to tell...  Check whether the noise occurs after
playing just a silence data.  This reduces the possibility of "junk
data" in the last playback period.

If this happens with silence, then the problem is likely the hardware
parameter change.


Takashi

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Wednesday, August 22, 2007 7:23 AM
> To: Lopez Cruz, Misael
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Noise at end of audio file
> 
> At Mon, 20 Aug 2007 10:44:14 -0500,
> Lopez Cruz, Misael wrote:
> > 
> > Hi,
> >  
> > I listen some noise at the end of playback of an audio file, with
some
> 
> > debug I noticed that the noise appears in the last two period of the

> > playback. I tried changing the minimum number of period (it was 16
and
> 
> > changed to 32) but the noise appears even before. Any idea what
could 
> > be wrong?
> 
> With which apps and which device does this happen?
> 
> 
> Takashi
> 
