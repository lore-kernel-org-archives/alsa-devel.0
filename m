From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Add support for cs42l73 codec
Date: Thu, 6 Oct 2011 19:57:47 +0100
Message-ID: <20111006185746.GA17685@opensource.wolfsonmicro.com>
References: <1317917945-32580-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5702103815
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 21:03:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317917945-32580-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@linux.intel.com, joe@nucleusys.com, ramesh.babu@intel.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 06, 2011 at 11:19:05AM -0500, Brian Austin wrote:

> +	{"DAC1 Mixer", "Headphone Switch", "XSPIN"},
> +	{"DAC1 Mixer", "LineOut Switch", "XSPIN"},
> +	{"DAC2 Mixer", "Speakerphone Switch", "XSPIN"},
> +	{"DAC2 Mixer", "Speakerphone LineOut Switch", "XSPIN"},
> +	{"DAC2 Mixer", "EarSpeaker Switch", "XSPIN"},

> +	{"DAC1 Mixer", "Headphone Switch", "ASPIN"},
> +	{"DAC1 Mixer", "LineOut Switch", "ASPIN"},
> +	{"DAC2 Mixer", "Speakerphone Switch", "ASPIN"},
> +	{"DAC2 Mixer", "Speakerphone LineOut Switch", "ASPIN"},
> +	{"DAC2 Mixer", "EarSpeaker Switch", "ASPIN"},

> +	{"DAC1 Mixer", "Headphone Switch", "VSPIN"},
> +	{"DAC1 Mixer", "LineOut Switch", "VSPIN"},
> +	{"DAC2 Mixer", "Speakerphone Switch", "VSPIN"},
> +	{"DAC2 Mixer", "Speakerphone LineOut Switch", "VSPIN"},
> +	{"DAC2 Mixer", "EarSpeaker Switch", "VSPIN"},

This all looks totally wrong and I'm surprised the driver loads without
errors.  There's two issues:

 - All the controls here are for the input to the DAC mixers but their
   names are for physical outputs.  I'd expect the switches to name
   inputs (for example, "DAC1 Mixer VSPIN Switch").  What's actually
   going on here?

 - You've got three copies of each of the controls for each mixer - I'm
   surprsied this loads without the core complaining that it can't
   create controls with duplicate names.
