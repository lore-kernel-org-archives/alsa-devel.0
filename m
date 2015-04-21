From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [RFC 0/4] ASoC DSP topology
Date: Tue, 21 Apr 2015 16:23:51 +0100
Message-ID: <1429629831.2797.9.camel@loki>
References: <1429217285.7100.18.camel@loki> <5535F513.8030902@ti.com>
 <20150421092812.GA22845@sirena.org.uk> <553642EC.8010400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D5DE8261504
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 17:23:59 +0200 (CEST)
In-Reply-To: <553642EC.8010400@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-04-21 at 15:30 +0300, Peter Ujfalusi wrote:
> On 04/21/2015 12:28 PM, Mark Brown wrote:
> > On Tue, Apr 21, 2015 at 09:58:27AM +0300, Peter Ujfalusi wrote:
> > 
> >> It is not entirely clear for me based on the first look, but who is
> >> responsible to initiate the topology load? Is it the component or machine
> >> driver? We have had issues with deferred probing when the component driver was
> >> in charge of loading the firmware. I got around this by initiating the FW load
> >> from the machine driver and via callbacks I notified the component driver to
> >> take over from that point. This fixed the probe order and I can also handle
> >> cases when the filesystem does not have the firmware so I can fall back to
> >> 'legacy' mode.
> > 
> > Could you expand on those issues please?  I'd *really* not expect the
> > machine driver to be involved in loading firmware for a component driver
> > (think how this is going to affect generic drivers) and it's not obvious
> > to me what impact this might have on deferred probe either.
> 
> The two issue were interconnected. We had cases when all components have been
> loaded, but the machine driver was still in the deferred list, if we loaded
> any non related module the card will suddenly got created.
> It is due to the firmware loading. The firmware load will not kick the
> deferred module list (we had a hack in place to kick the queue from the ABE
> driver):

Yes, I remember that hack :)

Can you take a look at the work Jarkko did for FW and component loading
in sst-acpi.c. This should work for ABE too.

> Components are loaded and registered in ASoC with the exception of the parts
> needing the FW, since the dynamic FW contained widgets, routes, etc. So the
> ABE driver loaded and requested the FW, probe exited with success. Machine
> driver is still not able to form the card since the ABE widgets, PCMs are
> missing, it goes to deferred probe. The ABE driver loads the dynamic FW,
> parses it, DAPM widgets, PCMs, routes are created and registered. But the
> machine driver is in deferred list and there is nothing to kick that queue,
> which means that we have everything, but the card is not created.
> 
> But if we initiate the FW load from the machine driver and we pass the FW down
> to the component driver(s) interested in handling the FW we are going to be
> fine since we only register the card when the component drivers already parsed
> and processed the FW image.
> 
> In this way we can have fall back for cases when the FW is not available on
> the filesystem (some distro might want to go w/o binary blob).
> 
> We have discussed this with Liam in the past: in my view the DSP topology (or
> Dynamic FW) should be represented in the machine level and it would be the
> best if the same image could carry card level widgets routes and links. If you
> have big enough change in the FW and it's provided widgets/PCMs you would need
> separate machine driver or at least a way to have different set of machine
> level routes, widgets, links, etc for different DSP topology file.
> 

The component level allows us to target the physical component devices
that may have runtime definable topologies. This would include codecs
too, since some vendors are making codecs with built in FW (maybe TI
too ?). The machine level more represents the board HW topology and this
should be derived from ACPI or DT.

Fwiw, I've not been following ABE development so I'm not sure of the
current driver state in newer kernels. I dont see any problems if the
ABE driver used the same sst-acpi.c like probing method. Btw, there is
now also a non atomic trigger() that would simplify the ABE code too :)

Liam
