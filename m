From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: Noise at end of audio file
Date: Wed, 22 Aug 2007 09:31:25 -0500
Message-ID: <B082902A12CAEE4EA7FE2ED20609013B0163D225@dlee15.ent.ti.com>
References: <s5hmywjiwr9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from soda.ext.ti.com (soda.ext.ti.com [198.47.26.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 061E91038A5
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 16:32:33 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <s5hmywjiwr9.wl%tiwai@suse.de>
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

I'm using aplay application for playback, the platform I'm working with
is ti-omap.

Regards,
Misael 

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Wednesday, August 22, 2007 7:23 AM
To: Lopez Cruz, Misael
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Noise at end of audio file

At Mon, 20 Aug 2007 10:44:14 -0500,
Lopez Cruz, Misael wrote:
> 
> Hi,
>  
> I listen some noise at the end of playback of an audio file, with some

> debug I noticed that the noise appears in the last two period of the 
> playback. I tried changing the minimum number of period (it was 16 and

> changed to 32) but the noise appears even before. Any idea what could 
> be wrong?

With which apps and which device does this happen?


Takashi
