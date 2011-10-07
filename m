From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v3] ASoC: Add support for cs42l73 codec
Date: Fri, 07 Oct 2011 09:29:46 +0530
Message-ID: <1317959986.1573.2214.camel@vkoul-udesk3>
References: <1317917945-32580-1-git-send-email-brian.austin@cirrus.com>
	<20111006185746.GA17685@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E6F7245CE
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 06:06:59 +0200 (CEST)
In-Reply-To: <20111006185746.GA17685@opensource.wolfsonmicro.com>
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
Cc: Brian Austin <brian.austin@cirrus.com>, lrg@ti.com, alsa-devel@alsa-project.org, ramesh.babu@intel.com, joe@nucleusys.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-10-06 at 19:57 +0100, Mark Brown wrote:
> On Thu, Oct 06, 2011 at 11:19:05AM -0500, Brian Austin wrote:
> 
> > +	{"DAC1 Mixer", "Headphone Switch", "XSPIN"},
> > +	{"DAC1 Mixer", "LineOut Switch", "XSPIN"},
> > +	{"DAC2 Mixer", "Speakerphone Switch", "XSPIN"},
> > +	{"DAC2 Mixer", "Speakerphone LineOut Switch", "XSPIN"},
> > +	{"DAC2 Mixer", "EarSpeaker Switch", "XSPIN"},
> 
> > +	{"DAC1 Mixer", "Headphone Switch", "ASPIN"},
> > +	{"DAC1 Mixer", "LineOut Switch", "ASPIN"},
> > +	{"DAC2 Mixer", "Speakerphone Switch", "ASPIN"},
> > +	{"DAC2 Mixer", "Speakerphone LineOut Switch", "ASPIN"},
> > +	{"DAC2 Mixer", "EarSpeaker Switch", "ASPIN"},
> 
> > +	{"DAC1 Mixer", "Headphone Switch", "VSPIN"},
> > +	{"DAC1 Mixer", "LineOut Switch", "VSPIN"},
> > +	{"DAC2 Mixer", "Speakerphone Switch", "VSPIN"},
> > +	{"DAC2 Mixer", "Speakerphone LineOut Switch", "VSPIN"},
> > +	{"DAC2 Mixer", "EarSpeaker Switch", "VSPIN"},
> 
> This all looks totally wrong and I'm surprised the driver loads without
> errors.  There's two issues:
> 
>  - All the controls here are for the input to the DAC mixers but their
>    names are for physical outputs.  I'd expect the switches to name
>    inputs (for example, "DAC1 Mixer VSPIN Switch").  What's actually
>    going on here?
> 
>  - You've got three copies of each of the controls for each mixer - I'm
>    surprsied this loads without the core complaining that it can't
>    create controls with duplicate names.
This codec has two DACs, three PCM ports. Each DAC has a mixer to allow
any port to be routed to it

I recommended this to be done as it helps DAPM to power off unused
paths.

-- 
~Vinod
