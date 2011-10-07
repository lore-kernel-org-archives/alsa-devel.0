From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3] ASoC: Add support for cs42l73 codec
Date: Fri, 07 Oct 2011 19:59:13 +0530
Message-ID: <1317997753.1573.2285.camel@vkoul-udesk3>
References: <1317917945-32580-1-git-send-email-brian.austin@cirrus.com>
	<20111006185746.GA17685@opensource.wolfsonmicro.com>
	<10520301-F8F9-4096-91F8-141F22CEA68C@cirrus.com>
	<20111007103359.GG19080@opensource.wolfsonmicro.com>
	<1317985636.1573.2272.camel@vkoul-udesk3>
	<20111007114239.GB24534@sirena.org.uk>
	<F41D058E-D2A8-4046-B391-1452889ED54C@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 580C8103BAE
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 16:36:28 +0200 (CEST)
In-Reply-To: <F41D058E-D2A8-4046-B391-1452889ED54C@cirrus.com>
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
Cc: "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "<lrg@ti.com>" <lrg@ti.com>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-10-07 at 14:05 +0000, Austin, Brian wrote:
> On Oct 7, 2011, at 6:42 AM, Mark Brown wrote:
> > On Fri, Oct 07, 2011 at 04:37:16PM +0530, Vinod Koul wrote:
> > 
> >> See below:
> > 
> >> +static const struct snd_kcontrol_new dac1_output_mixer[] = {
> >> +       SOC_DAPM_SINGLE("Headphone Switch", CS42L73_PWRCTL3, 0, 1, 1),
> >> +       SOC_DAPM_SINGLE("LineOut Switch", CS42L73_PWRCTL3, 1, 1, 1),
> >> +};
> > 
> >> +static const struct snd_kcontrol_new dac2_output_mixer[] = {
> >> +       SOC_DAPM_SINGLE("Speakerphone Switch", CS42L73_PWRCTL3, 2, 1,
> >> 1),
> >> +       SOC_DAPM_SINGLE("Speakerphone LineOut Switch", CS42L73_PWRCTL3,
> >> +                       4, 1, 1),
> >> +       SOC_DAPM_SINGLE("EarSpeaker Switch", CS42L73_PWRCTL3, 3, 1, 1),
> >> +};
> > 
> >> I think naming should be slightly better :)
> > 
> > I'm not sure, it might be more than the naming.  The fact that we're in
> > PWRCTL registers could be confusing hardware design, or the structure of
> > the hardware may not actually reflect what the driver is doing.
> > 
> 
> The way to enable the output is to enable the output pin.  I have no control in SW 
> over the DAC's. The pins are power controlled of course. I know it looks strange, 
> but without using a machine driver to enable/disable the pins for a certain route, 
> this seems to be the best solution.
> 
> I am of course open to other ideas :)
What i saw in the spec is that this codec has three PCM ports and each
one can be input to the DACs. The DAC output goes to output pins and in
some cases shared (like DAC2 for ep/spkr).
For output you have amp switches at end, so we can control where output
is going as well.
So we can have is APCM -> Mixer's -> DAC -> out switches -> pins
All this is codec domain so why should machine driver be bothered about
this stuff. Anything external to codec should be handled in machine
driver, otherwise we end up creating same code in all machine drivers
which use this codec.

-- 
~Vinod
