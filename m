From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v3] ASoC: Add support for cs42l73 codec
Date: Fri, 07 Oct 2011 16:37:16 +0530
Message-ID: <1317985636.1573.2272.camel@vkoul-udesk3>
References: <1317917945-32580-1-git-send-email-brian.austin@cirrus.com>
	<20111006185746.GA17685@opensource.wolfsonmicro.com>
	<10520301-F8F9-4096-91F8-141F22CEA68C@cirrus.com>
	<20111007103359.GG19080@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 914F0103B05
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 13:14:30 +0200 (CEST)
In-Reply-To: <20111007103359.GG19080@opensource.wolfsonmicro.com>
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
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "<lrg@ti.com>" <lrg@ti.com>, "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-10-07 at 11:34 +0100, Mark Brown wrote:
> On Thu, Oct 06, 2011 at 07:15:22PM +0000, Austin, Brian wrote:
> > On Oct 6, 2011, at 1:57 PM, Mark Brown wrote:
> > > On Thu, Oct 06, 2011 at 11:19:05AM -0500, Brian Austin wrote:
> 
> > >> +	{"DAC1 Mixer", "Headphone Switch", "XSPIN"},
> 
> > >> +	{"DAC1 Mixer", "Headphone Switch", "ASPIN"},
> 
> > >> +	{"DAC1 Mixer", "Headphone Switch", "VSPIN"},
> 
> > > This all looks totally wrong and I'm surprised the driver loads without
> > > errors.  There's two issues:
> 
> > > - All the controls here are for the input to the DAC mixers but their
> > >   names are for physical outputs.  I'd expect the switches to name
> > >   inputs (for example, "DAC1 Mixer VSPIN Switch").  What's actually
> > >   going on here?
> 
> > > - You've got three copies of each of the controls for each mixer - I'm
> > >   surprsied this loads without the core complaining that it can't
> > >   create controls with duplicate names.
> 
> > This works fine on my setup with a beagleboard. 
> 
> I'm frankly astonished.  What are these controls called?
> 
> > There are 3 routes for the HP/LO/SPK/SPKLO/EAR. What I am trying to accomplish is the following.
> > Allow a stream from any serial port to go to any output.
> 
> That's perfectly reasonable but what you've written doesn't seem to do
> that.  The DAPM routes are in the form:
> 
>     { destination, control, source }
> 
> so what the above example says is that audio is routed from XSPIN to
> DAC1 if the DAC1 Headphone switch is turned on.

See below:

+static const struct snd_kcontrol_new dac1_output_mixer[] = {
+       SOC_DAPM_SINGLE("Headphone Switch", CS42L73_PWRCTL3, 0, 1, 1),
+       SOC_DAPM_SINGLE("LineOut Switch", CS42L73_PWRCTL3, 1, 1, 1),
+};
+
+static const struct snd_kcontrol_new dac2_output_mixer[] = {
+       SOC_DAPM_SINGLE("Speakerphone Switch", CS42L73_PWRCTL3, 2, 1,
1),
+       SOC_DAPM_SINGLE("Speakerphone LineOut Switch", CS42L73_PWRCTL3,
+                       4, 1, 1),
+       SOC_DAPM_SINGLE("EarSpeaker Switch", CS42L73_PWRCTL3, 3, 1, 1),
+};
+

I think naming should be slightly better :)

-- 
~Vinod
