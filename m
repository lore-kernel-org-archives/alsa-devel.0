From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC 0/4] ASoC DSP topology
Date: Tue, 21 Apr 2015 09:58:27 +0300
Message-ID: <5535F513.8030902@ti.com>
References: <1429217285.7100.18.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id B7E6E260467
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 08:58:34 +0200 (CEST)
In-Reply-To: <1429217285.7100.18.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Liam,

On 04/16/2015 11:48 PM, Liam Girdwood wrote:
> It's been about 2 years since posting V1 of the ASoC dynamic firmware pat=
ches
> and a lot has changed since then ...
> =

> This RFC series is being posted instead of a V2 patch series atm since we=
 are
> still completing some testing on the codebase and developing a new usersp=
ace
> tool. Expect V2 once more testing is completed shortly.
> =

> ASoC topology (formerly called dynamic firmware) allows audio DSP topolog=
y to
> be defined as part of the firmware package and not hard coded into the dr=
iver.
> This allows DSP vendors to ship multiple different firmwares or firmwares=
 with
> programmable topologies for different devices (i.e. phones, tablets, TVs)=
 using
> a single DSP driver. The DSP topology can be contained as part of the fir=
mware
> file or exist as separate files. The topology core and file format is gen=
eric
> and not tied to any single vendor or device. =

> =

> The topology core consists of kernel and userspace components :-
> =

> Kernel. The kernel core reads in the topology data and builds the driver
> capabilities and audio topology based on this data. This includes building
> the DAPM graph, setting PCM and DAI capabilities, registering kcontrols a=
nd
> registering DAPM widgets.

It is not entirely clear for me based on the first look, but who is
responsible to initiate the topology load? Is it the component or machine
driver? We have had issues with deferred probing when the component driver =
was
in charge of loading the firmware. I got around this by initiating the FW l=
oad
from the machine driver and via callbacks I notified the component driver to
take over from that point. This fixed the probe order and I can also handle
cases when the filesystem does not have the firmware so I can fall back to
'legacy' mode.

> The userspace tool allows the creation of binary DSP FW topology files ba=
sed on
> a topology text files.

Is it possible to get access to the user space part so if I have time I can
try to convert the OMAP4/5 AESS/ABE code to use tplg?

Thanks,
P=E9ter

> =

> Changes since V1:-
> =

>  o Name changed to ASoC Topology
>  o Structures from soc.h and soc-dapm.h no longer exposed as UAPIs
>  o Moved to component model from codec/platform model.
>  o Added reserved fields in each UAPI structure.
>  o UAPI structures packed and endianess defined for each structure.
>  o Added support for PCM, DAI and codec <-> codec link capabilities.
>  o Added support for client drivers manifests.
>  o Added support for private data for each dynamic object type.
>  o Single list of dynamic objects rather than list of each object type.
> =

> Liam
> =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =
