From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Add support for cs42l73 codec
Date: Fri, 7 Oct 2011 11:34:00 +0100
Message-ID: <20111007103359.GG19080@opensource.wolfsonmicro.com>
References: <1317917945-32580-1-git-send-email-brian.austin@cirrus.com>
	<20111006185746.GA17685@opensource.wolfsonmicro.com>
	<10520301-F8F9-4096-91F8-141F22CEA68C@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F294624478
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 12:34:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <10520301-F8F9-4096-91F8-141F22CEA68C@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<vinod.koul@linux.intel.com>" <vinod.koul@linux.intel.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>, "<lrg@ti.com>" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 06, 2011 at 07:15:22PM +0000, Austin, Brian wrote:
> On Oct 6, 2011, at 1:57 PM, Mark Brown wrote:
> > On Thu, Oct 06, 2011 at 11:19:05AM -0500, Brian Austin wrote:

> >> +	{"DAC1 Mixer", "Headphone Switch", "XSPIN"},

> >> +	{"DAC1 Mixer", "Headphone Switch", "ASPIN"},

> >> +	{"DAC1 Mixer", "Headphone Switch", "VSPIN"},

> > This all looks totally wrong and I'm surprised the driver loads without
> > errors.  There's two issues:

> > - All the controls here are for the input to the DAC mixers but their
> >   names are for physical outputs.  I'd expect the switches to name
> >   inputs (for example, "DAC1 Mixer VSPIN Switch").  What's actually
> >   going on here?

> > - You've got three copies of each of the controls for each mixer - I'm
> >   surprsied this loads without the core complaining that it can't
> >   create controls with duplicate names.

> This works fine on my setup with a beagleboard. 

I'm frankly astonished.  What are these controls called?

> There are 3 routes for the HP/LO/SPK/SPKLO/EAR. What I am trying to accomplish is the following.
> Allow a stream from any serial port to go to any output.

That's perfectly reasonable but what you've written doesn't seem to do
that.  The DAPM routes are in the form:

    { destination, control, source }

so what the above example says is that audio is routed from XSPIN to
DAC1 if the DAC1 Headphone switch is turned on.
