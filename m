From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH 1/3] ASoC: TWL4030: Enable voice filters
 for voice sidetone
Date: Mon, 22 Jun 2009 20:52:10 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E3555FB3B@dlee04.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31C@dlee04.ent.ti.com>
	<20090619095808.GD5270@sirena.org.uk>
	<200906220925.40839.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A31524422
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 03:52:18 +0200 (CEST)
In-Reply-To: <200906220925.40839.peter.ujfalusi@nokia.com>
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
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> On Friday 19 June 2009 12:58:08 ext Mark Brown wrote:
> > On Fri, Jun 19, 2009 at 03:23:41AM -0500, Lopez Cruz, Misael wrote:
> > > Digital voice loopback (sidetone) requires voice filters
> > > to be enabled: VTXL, VTXR, VRX.

> > Is it possible to handle this by inserting DAPM widgets for these
> > filters into the bypass paths and letting DAPM power them up? 

> I think for the Voice interface this is feasible.

I don't see any problem with either voice or HiFi interfaces
in playback path. I think that by inserting filter widgets between
Digital and Analog Playback Mixers should be enough. That way
filters get enabled in digital bypass (as widget will be after
Digital Playback Mixer) and get disabled in analog bypass (new
widgets are before Analog Playback Mixer)

> > I'm also wondering if with the new bias level management 
> > stuff which keeps the codec in BIAS_ON while any DAPM widgets
> > are powered some of the bypass mode stuff can be removed
> > or simplified?

> I have been wondering about the same, but in the HiFi path it 
> is not that simple. Most probably it is possible to add DAPM
> widget for the Audio Filter L1/R1 (which is at the moment always
> enabled), but for the L2/R2 it is not that simple.

Could you please clarify why it's not that simple?

I see more problems in capture path because TXR2, TXL2 paths are
shared in voice and tdm scenarios.

> Simplifying the twl4030_mute function should be possible at 
> this point, I think, by moving those output mutes as DAPM_PGA_E
> widgets on the paths. This is in my to-do list... Although I
> have to check that such a change should not cause any 'clicks'
> on the outputs.

-Misa
