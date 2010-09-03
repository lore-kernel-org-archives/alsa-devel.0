From: Camilo Polymeris <cpolymeris@gmail.com>
Subject: Re: HCTL element callback
Date: Fri, 03 Sep 2010 03:29:26 -0400
Message-ID: <1283498966.5621.5.camel@aviva.ttga.homeip.net>
References: <1283464109.6921.10.camel@aviva.ttga.homeip.net>
	<alpine.LNX.2.00.1009030832140.10278@eeebox2.perex-int.cz>
	<1283498035.6921.20.camel@aviva.ttga.homeip.net>
	<alpine.LNX.2.00.1009030915440.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6853624531
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Sep 2010 09:29:33 +0200 (CEST)
Received: by gyh4 with SMTP id 4so607354gyh.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Sep 2010 00:29:30 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1009030915440.10278@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-09-03 at 09:16 +0200, Jaroslav Kysela wrote:
> On Fri, 3 Sep 2010, Camilo Polymeris wrote:
> 
> > On Fri, 2010-09-03 at 08:35 +0200, Jaroslav Kysela wrote:
> >> On Thu, 2 Sep 2010, Camilo Polymeris wrote:
> >>
> >>> Hello.
> >>> I am writing this mixer app:
> >>> http://emutrix.googlecode.com
> >>>
> >>> I have trouble with callbacks. So far I have implemented callbacks for
> >>> the master volume fader and clock rate selection (integer and enum,
> >>> resp.)
> >>> But "pad" callbacks (boolean) won't work. In fact, I have noticed that
> >>> alsamixer 1.0.22 also doesn't react to pad changes from the application.
> >>> But the driver reacts to both as expected, so we're dealing with the
> >>> same element.
> >>
> >> It seems like a bug in the emu driver. The elem put callbacks does not
> >> check for changes (they should return 1).
> >>
> >> Does this patch help?
> >>
> >> diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
> >> index 05afe06..7bd1c1a 100644
> >> --- a/sound/pci/emu10k1/emumixer.c
> >> +++ b/sound/pci/emu10k1/emumixer.c
> >> @@ -622,6 +622,7 @@ static int snd_emu1010_adc_pads_put(struct snd_kcontrol *kcontrol, struct snd_ct
> >>   	if (cache != emu->emu1010.adc_pads) {
> >>   		snd_emu1010_fpga_write(emu, EMU_HANA_ADC_PADS, cache );
> >>   	        emu->emu1010.adc_pads = cache;
> >> +	        return 1;
> >>   	}
> >>
> >>   	return 0;
> >> @@ -670,6 +671,7 @@ static int snd_emu1010_dac_pads_put(struct snd_kcontrol *kcontrol, struct snd_ct
> >>   	if (cache != emu->emu1010.dac_pads) {
> >>   		snd_emu1010_fpga_write(emu, EMU_HANA_DAC_PADS, cache );
> >>   	        emu->emu1010.dac_pads = cache;
> >> +	        return 1;
> >>   	}
> >>
> >>   	return 0;
> >>
> >>  					Jaroslav
> >>
> >> -----
> >> Jaroslav Kysela <perex@perex.cz>
> >> Linux Kernel Sound Maintainer
> >> ALSA Project, Red Hat, Inc.
> >>
> >
> >
> > Hello.
> > I think it doesn't help. I applied the patch, built the sources,
> > installed them (with 'make install') and reloaded alsa (with 'alsa
> > reload'). That should have installed the new module, right?
> > If so, the patch didn't help. I am not very experienced with kernel
> > stuff, so if I did something wrong, please tell me and I'll try again.
> 
> Reboot your machine at first to ensure that you have loaded new ALSA 
> kernel modules.
> 
>  					Jaroslav
> 
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
> 

Very nice. That worked. Thanks!
By the way, I have noticed two small errors (I think) with element
names:
* Pads are labeled 14dB, but they are actually ~12dB (intended as
-10dBV/+4dBu)
* Enum items (inputs) are labeled 0202 SPDIF Left/Right, but the
connector is on the 1010 card. The outputs are ok.
Are you keeping those for backwards-compatibility?

Again, thanks.
Camilo
