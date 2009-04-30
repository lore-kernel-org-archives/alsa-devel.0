From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH] ASoC: TWL4030: Disable DACs in
	analog	loopback
Date: Thu, 30 Apr 2009 04:53:20 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F63E05BE@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F63E05BA@dlee07.ent.ti.com>
	<200904301146.49080.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id D7B5F1038AB
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 11:53:29 +0200 (CEST)
In-Reply-To: <200904301146.49080.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

> > In analog loopback mode, DACs should not be enabled. For 
> > that reason, DAC widgets (DAC Right1, DAC Left1, DAC
> > Right2, DAC Left2) will power DACs only during playback.

> > Analog loopback requires to set a master enable bit when any
> > of the analog bypass switches are enabled.

> I have also noticed this, also in analog loopback mode the 
> bits in the OPTION register can be cleared, since we don't
> need those to have analog loopback.

At least, the digital filters (configured in OPTION reg) are
enabled when the corresponding DAC is enabled, can we attach
them to a DAC somehow? Could it be a valid approach?

> But I'm afraid, this patch does break the Digital loopback, 
> which needs the DACs to be powered, in case when the capture
> path is set in analog mode the ADC(s) also need to be powered.

I think that digital loopback should mix TX with RX only when
both digital paths are enabled, i.e. in a full-duplex scenario.
I don't expect it to automatically enable DACs for me, although
maybe I'm wrong and my argument breaks what digital loopback
means :( Please clarify.

> Both analog and digital loopback connects to 'Analog XY 
> Playback Mixer', which turns on/off the physical DAC on
> the given route.

That was a part of the audio map that doesn't make much sense
to me, joining analog and digital loopback.

> I have been thinking of - as a part of a big
> clean up - to separate these, since as you have pointed out,
> the DACs are not needed for the analog loopback.
