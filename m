From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [MINUTES] Linux Plumbers Audio Mini Conference -
 Santa Fe 2016
Date: Fri, 4 Nov 2016 10:54:55 +0200
Message-ID: <e7fc9e49-6d6a-c224-d045-ef80308e11e0@ti.com>
References: <1478213478.21597.13.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AC0126720A
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 09:54:59 +0100 (CET)
In-Reply-To: <1478213478.21597.13.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "mengdong.lin" <mengdong.lin@linux.intel.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Lai,
 Patrick" <plai@quicinc.com>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>, Eric Laurent <elaurent@google.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

Liam,

On 11/04/2016 12:51 AM, Liam Girdwood wrote:
> Minutes below. Comments, corrections and omissions welcomed.
> =

> We are missing some links to some of the slides presented. Please reply w=
ith a link =

> if you have one.

Were there any discussion related to 'Move of ASoC clocking into the
clock API'? Any conclusions, plans?

-- =

P=E9ter

> Audio Mini Conference Minutes - Santa Fe 2016 =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Present: Mark, Rakesh, Liam, Vinod, Mengdong, Pierre, Patrick, Takashi S,
> Javilars, Takashi I, Eric, Dylan, Mauro, Shuah, Charles, Matthew, Lars, S=
agar
> and others.
> =

> =

> Android USB Audio - Eric
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> USB audio is becoming more important as analog jack can be removed. USB s=
tack
> is difficult to optimise for low power/latency audio (too many wake ups w=
ith
> USB 1ms tick). Aim to add no_irq (no IRQ for each period) and mmap suppor=
t in
> USB 3.0 stack to improve power and latency.
> =

> USB playback and capture with synchronised start API is missing from stac=
k/ALSA.
> Some patches were posted for synchronised endpoint but never made it to t=
he
> list, Pierre is going to resend.
> =

> USB currently defines simple audio endpoints. Support is needed to define=
 more
> complex USB audio endpoints rather than just "playback" and "capture".
> =

> Sub 10ms latency (round trip ?) is difficult to achieve on USB due to sta=
ck and
> drivers. Mmap may help reduce latency by removing buffer copies.
> =

> =

> Inter Device Dependencies
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> =

> Kernel Summit joined for this discussion. There is complexity between dev=
ices,
> more than just a parent/child relationship for some devices making it dif=
ficult
> to order probing and PM ops.
> =

> Rafael, has created patch set to solve dependences for PM ops in Gregs tr=
ee, =

> the patches could also be used for probing. The patches add an API to all=
ow
> device relationships to be established as a graph. This API supports non
> parent/child relationships to and allows PM ops to run in a deterministic
> sequence. Relationship dependency discovery needs to come from DT/ACPI and
> will need standardised bindings.
> =

> Mark described the current audio workarounds where the machine driver spe=
cifies
> relationships and deferred probe is used to manage the probing sequence.
> Some people do not like the high number deferred probe messages in dmesg.
> =

> Relation graphs must be ordered so that cycles to do not exist.
> =

> Next steps are to use Rafaels patches for probe ordering.
> =

> =

> AV Sync - Eric
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> A few frame counters are 32 bit (compressed API) and should be 64 bit.
> Vinod will update compressed API to 64 bit.
> =

> Timers should also consider boot time and suspend/resume time as it's cur=
rently =

> difficult to keep AV syn over suspend/resume cycles.
> =

> AV sync on TV's hacky atm, we need AV sync API in ALSA. Takashi noted thi=
s was
> long time problem that needs solution. Some options for AV sync were pseu=
do
> transport streams (like existing mpeg format) but these were difficult for
> mmap(). Other devices had used runtime PLL updating with patches sent in =
the
> past ?
> =

> Compressed API could be used to send transport stream for AV sync.
> =

> =

> HDMI/DP glue to GFX - Vinod
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> =

> Currently several interlaces exist to pass DP/HDMI events and information
> between audio and GFX stacks/drivers.  ARM devices using pdata interface, =

> i915 has another solution, BYT uses another interface. Needs to be consis=
tent
> for user space ELD notification, jack detection/mapping. Currently HDA dr=
ivers
> have hack to assist userspace (PCM5).
> =

> There are also difficulties mapping PCMs, channels and jacks to multiple
> HDMI/DP devices.
> =

> Tikashi and Vinod to investigate best solutions.
> =

> =

> DP-MST - Vinod
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Jack notifications more difficult with MST (extra complexity). How do we =
map
> multiple jacks from multiple monitors, disable unused pins when not rende=
ring ?
> The 5.1 use case for gaming has to split channels to multiple monitors.
> Decision is that new devices would export topology to userpace so that us=
erspace
> know the jack, channel mappings. =

> =

> =

> Soundwire Support - Rakesh and Pierre
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =

> =

> Soundwire new hardware interface for audio devices. Needs new subsystem s=
upport
> for soundwire master and slave devices. Hardik has posted initial RFC to =
the =

> list for review.
> =

> Rakesh presented slides . Link to the slides ?
> =

> Some people had reviewed the RFC. Some changes to strct device/driver usa=
ge =

> required to make it more like other subsystems upstream. There is also ne=
ed
> to deal with devices that can power off after or before enumeration. Some
> confusion over the terminology used too, compared to other bus systems li=
ke I2C.
> Master should be device and not driver. Top level feedback is that it doe=
s not
> look like bus code.
> =

> There is also a need to consider objects in DT/ACPI. AR Vinod, to look at=
 STIO. =

> =

> =

> Topology and UCM file deployment - Vinod, Mengdong, Liam
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> =

> Difficult to release and deploy topology/ucm updates with alsa-lib cadenc=
e.
> Distros to be contacted for best deployment where cadence can be faster t=
han
> alsa-lib. Liam and Vinod to contact distro package maintainers.
> =

> =

> UCM - Liam, Mengdong
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Which driver card name string to change, there are 3 - long, short and dr=
iver.
> CRAS uses the string in the []. Not sure about PA.
> =

> Liam to create patch that includes machine name in card name string.
> =

> Mengdong has added #include and #define like support to topology. Mengdong
> will port this to UCM too so that a library of codecs can be built up and =

> included by the machine ucm files. e.g.
> =

> Asus T100 UCM would include rt5640 codec and baytrail DSP UCM configs.
> =

> =

> Tracepoint for audio - Lars, Takashi S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Lars and Takashi S have similar patchsets. Easy to make tooling for parsi=
ng
> traceout. This could replace printk and snd_printk, but builds bigger bin=
ary.
> Option to disable can be added to reduce size. Uses ftrace output and tim=
estamp.
> Used in the PCM operations. Patches are still WiP and will be posted as R=
FC when
> ready.
> =

> =

> Dropping Dice Driver - Takashi S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Dice hardware has serious problems making it unusable. Takashi S to discu=
ss with
> Clemens regarding any potential work around for HW issue. If no work arou=
nd is
> found then it could be marked as broken or moved to staging ?
> =

> =

> Sound Open Firmware - Liam
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> =

> Liam introduced SOF and took QA. Liam is also working on an ELF executable
> firmware image that can run on the developers host PC.
> =

> http://alsa-project.org/main/index.php/Firmware
> =

> =

> Paravirtualisation of Audio Drivers - Rakesh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Safety critical systems have requirements to play safety critcal sounds (=
like
> alarms, warnings) and regular non safety critical sound like media. Rakes=
h =

> proposed a Xen hypervisor method to guarantee the safety critical audio w=
ould
> always take precedence over the non safety critical audio.
> =

> Xen would run a privileged OS (for safety critical) and unprivileged OS (=
for
> non safety critical audio). A para virtualised audio driver would allow t=
he
> Unprivileged OS to play audio on the privileged OS.
> =

> Lars suggested Libvirt and KVM may make this task far easier and less res=
tricted
> than using Xen. Rakesh to investigate further.
> =

> =

> Userspace driver for Firewire - Takashi S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Need to represent mixers for some USB and FW devices in userspace. Why ?.
> Possibility of using topology for userspace. Nobody keen on exposing kern=
el APIs
> as userspavce ABIs. Possibility of looking at libvirt interfaces for user=
space
> drivers many similarities. Kernel component, already use FW sound card.
> =

> Mixer API not suitable, many bus so use control API.
> =

> =

> ALSA Stream Configuration Domains - Lars
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> ALSA has powerful but complex system to configure and constrain stream
> configurations at runtime but it does not scale well on modern ASoC based
> sound devices with multiple components and DAIs.
> =

> Lars presented a solution that can break complex sound cards down to simp=
le
> domains where configuration can be set by userspace to exactly match each
> use case. Userspace would also be able to read the configuration in each =
domain.
> New APIs calls would be needed in alsa-lib to achieve this.
> =

> Lars also requested that ASoC become a first class citizen with ALSA since
> most new sound cards are ASoC based. Proposal was accepted.
> =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =
