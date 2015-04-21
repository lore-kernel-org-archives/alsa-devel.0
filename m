From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC 0/4] ASoC DSP topology
Date: Tue, 21 Apr 2015 15:30:36 +0300
Message-ID: <553642EC.8010400@ti.com>
References: <1429217285.7100.18.camel@loki> <5535F513.8030902@ti.com>
 <20150421092812.GA22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DB3F2608ED
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 14:30:41 +0200 (CEST)
In-Reply-To: <20150421092812.GA22845@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On 04/21/2015 12:28 PM, Mark Brown wrote:
> On Tue, Apr 21, 2015 at 09:58:27AM +0300, Peter Ujfalusi wrote:
> =

>> It is not entirely clear for me based on the first look, but who is
>> responsible to initiate the topology load? Is it the component or machine
>> driver? We have had issues with deferred probing when the component driv=
er was
>> in charge of loading the firmware. I got around this by initiating the F=
W load
>> from the machine driver and via callbacks I notified the component drive=
r to
>> take over from that point. This fixed the probe order and I can also han=
dle
>> cases when the filesystem does not have the firmware so I can fall back =
to
>> 'legacy' mode.
> =

> Could you expand on those issues please?  I'd *really* not expect the
> machine driver to be involved in loading firmware for a component driver
> (think how this is going to affect generic drivers) and it's not obvious
> to me what impact this might have on deferred probe either.

The two issue were interconnected. We had cases when all components have be=
en
loaded, but the machine driver was still in the deferred list, if we loaded
any non related module the card will suddenly got created.
It is due to the firmware loading. The firmware load will not kick the
deferred module list (we had a hack in place to kick the queue from the ABE
driver):
Components are loaded and registered in ASoC with the exception of the parts
needing the FW, since the dynamic FW contained widgets, routes, etc. So the
ABE driver loaded and requested the FW, probe exited with success. Machine
driver is still not able to form the card since the ABE widgets, PCMs are
missing, it goes to deferred probe. The ABE driver loads the dynamic FW,
parses it, DAPM widgets, PCMs, routes are created and registered. But the
machine driver is in deferred list and there is nothing to kick that queue,
which means that we have everything, but the card is not created.

But if we initiate the FW load from the machine driver and we pass the FW d=
own
to the component driver(s) interested in handling the FW we are going to be
fine since we only register the card when the component drivers already par=
sed
and processed the FW image.

In this way we can have fall back for cases when the FW is not available on
the filesystem (some distro might want to go w/o binary blob).

We have discussed this with Liam in the past: in my view the DSP topology (=
or
Dynamic FW) should be represented in the machine level and it would be the
best if the same image could carry card level widgets routes and links. If =
you
have big enough change in the FW and it's provided widgets/PCMs you would n=
eed
separate machine driver or at least a way to have different set of machine
level routes, widgets, links, etc for different DSP topology file.

One of the issue with this: When we need to call the component driver's
firmware load function (to process the FW and create the widgets and then
register the component) the component is not registered (we need the firmwa=
re
to set up things) so generic snd_soc_* callback is not possible to use

-- =

P=E9ter
