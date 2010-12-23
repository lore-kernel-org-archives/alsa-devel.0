From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: asoc SND_SOC_DAPM_AIF_IN question
Date: Thu, 23 Dec 2010 08:36:07 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C104C329@bgsmsx502.gar.corp.intel.com>
References: <438BB0150E931F4B9CE701519A44630104C104C2AA@bgsmsx502.gar.corp.intel.com>
	<20101222175503.GA27401@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 1743A24779
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 04:06:20 +0100 (CET)
In-Reply-To: <20101222175503.GA27401@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 22, 2010 at 11:25:29PM +0530, Mark Brown wrote:
> On Wed, Dec 22, 2010 at 10:39:55PM +0530, Koul, Vinod wrote:
> 
> > So my codec map looks like:
> >         /*headset map*/
> >         { "HSDAC Left", NULL, "PCM_In"},
> >         { "HSDAC Right", NULL, "PCM_In"},
> >         { "PCM_In", NULL, "Headset Rail"},
> >         { "Headset Rail", NULL, "Audio Rail"},
> 
> >         /*speaker map*/
> >         { "IHFDAC Left", NULL, "PCM_In"},
> >         { "IHFDAC Right", NULL, "PCM_In"},
> >         { "PCM_In", NULL, "Speaker Rail"},
> >         { "Speaker Rail", NULL, "Audio Rail"},
> 
> > But when the stream is started now all the widgets get powered on. The
> > debugfs entry says
> 
> You have unconditionally connected both speaker and headphone widgets to
> the same input so when that input becomes active paths are completed to
> both outputs and both outpus are enabled.
Okay, that makes sense.

> 
> These "Rail" widgets look quite unusual - what are they?
Audio Supply rails, I have one global audio rail which controls most of audio 
widgets and then separate rails for speakers and headset. For example I need to 
turn on Audio supply rail and then headset rail for headsets to work properly. 
So I described them as SND_SOC_DAPM_SUPPLY. Added events so that I power them on 
and power off when stream becomes active or inactive.
> 
> > What could I be doing wrong here? I want to add this PCM button for all
> streams
> > (4 eventually) and this be enabled whenever anyone of them is started.
> 
> What is a "PCM button" and what do you mean by starting a "stream"?
> Normally a stream would be a path between the CPU and the CODEC.
This is PCM interface enable between codec and cpu. So for PCM port to work 
between codec and cpu, we need to enable the PCM port, this one does 
that. This is going to be a global switch to be turned on for all streams (I 
have 4 playback and 1 capture, and can be simultaneous).

> 
> The way this works is that as described in reply to your previous mail
> DAPM powers anything on which has a completed path from input to output.
> As mentioned then if you have no routing control in the device the
> machine driver will arrange to enable and disable input and output
> widgets on the edge of the CODEC, either automatically using jack
> detection or by offering SOC_DAPM_PIN_SWITCH() or similar controls to
> applications.
So what I have is below picture in codec

PCM PORT -> HSDAC -> Earpiece/Headset*
	   -> IHFDAC ->Speaker
	   <- ADC <- MICs

(*this will be toggled by user using controls exposed by machine driver 
 which will using SOC_DAPM_PIN_SWITCH as suggested by you)

Here I was trying 
1) Putting the PCM_In Button as SND_SOC_DAPM_AIF_IN()
2) Add this to codec map for streams so that its enabled for all streams
3) Add supply rails before this so they are powered for this(which is working for me)

Now only problem for me is to how to add PCM button for all streams? I have few 
alternatives like doing this in supply events or in dai start function, but was 
hoping that since this can be represented as a widget it should be done thru the 
audio map

Any suggestions....

~Vinod
