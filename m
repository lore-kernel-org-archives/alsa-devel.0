From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: Audio Mini Conference Minutes - Edinburgh 21st
 October 2013
Date: Sat, 16 Nov 2013 17:01:40 +0800
Message-ID: <CA+v+29hOBcuH-teW+5si8qj9QD7o3bsMYFj8v-YfKJRM0XVn8w@mail.gmail.com>
References: <1382985876.2334.64.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 62889262626
 for <alsa-devel@alsa-project.org>; Sat, 16 Nov 2013 10:02:03 +0100 (CET)
Received: by mail-pd0-f177.google.com with SMTP id v10so4409851pde.8
 for <alsa-devel@alsa-project.org>; Sat, 16 Nov 2013 01:02:02 -0800 (PST)
In-Reply-To: <1382985876.2334.64.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, wangxingchao@xiaomi.com, ruyi@xiaomi.com
List-Id: alsa-devel@alsa-project.org

Hi Liam,

Very exciting meeting, very nice meeting minutes, thanks very much!
I'm quite interested with the "24 Bit HiRes Audio for Android" part,
see comments inline.

2013/10/29 Liam Girdwood <liam.r.girdwood@linux.intel.com>:
> I've pasted below the minutes from this years ALSA developer mini
> conference in Edinburgh. I'll also add it to the developer Wiki
> alongside some slides from Eric and Tanu (once I know the correct answer
> to the anti-spam captcha).
>
> Fwiw, there are some interesting "unclaimed" tasks/projects below.
> Please feel free to volunteer for anything below that may interest
> you.
>
> Btw, if you are replying to start a thread about a certain subject
> below, please snip the other context and change the email to match the
> new $SUBJECT. This should make things easier to track.
>
> Thanks
>
> Liam
>
> Audio BOF - Monday October 21st 2013 - Edinburgh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Attendees :-
> -----------------------------------------------------------------------
>
>   Mark Brown, Liam Girdwood, Pierre Bossart, Patrick Lai, Lars-Peter Clau=
sen,
>   Eric Laurent, David Henningsson, Takashi Iwai, Colin Guthrie, Tanu Kask=
inen,
>   Arun Raghavan, Paul Handrigan, Daniel Mack, Dylan Reid, Sven Neuman,
>   Dmimtris Papastamos, Charles Keepax, Nariman Poushin, Jo=E3o Paulo Rech=
i Vita,
>   Alexander Patrakov, Micheal Wu, Lennart Poettering
>
>
> Topics
> =3D=3D=3D=3D=3D=3D=3D
>
>
> Pulseaudio route management and UCM
> -----------------------------------
>
> There was interest for shared policy configuration file format across
> different systems. No such sharing has been planned. Tanu's initial react=
ion
> is that it's not feasible, but he is open to discussing it.
>
> What to do if there are multiple paths from A to B? One will be chosen,
> either arbitrarily or based on connection requirements or prioritization.
>
> How to control effect offloading? Tanu's vague idea is that if some kind =
of
> filtering is required/preferred, it's expressed as a requirement for a
> connection, and the node implementation will then enable the details of
> enabling the effect if such effect is available. Tanu doesn't know how we=
ll
> that would work in practice - and probably unaware of many details that
> would have to be taken into account.
>
> UCM being used by some people but missing good documentation. Liam to wri=
te
> documentation and use examples from Arun as "gold standard" example
> configurations. More UCM configs to go online in alsa-lib repo.
>
> UCM configs sometimes need updated for new kernel releases as Kcontrol st=
rings
> have changed. Suggestions made for additional UUID for each kcontrol to l=
essen UCM
> config name changes (e.g. vendor-part-reg-shift-mask could be used as ASoC
> kcontrol UUID). Naming changes also effect HDA kcontrols, but no HDA UCM =
configs
> yet ? kcontrol UUID harder for DSP and HDA.
>
> Arun reported UCM issue with combination of devices. e.g. Enable dev 1 & =
2 then
> disable dev 1 & 2. Maybe virtual device that combines devices ??
>
> #include for UCM - should be easy to add. Simplifies config for family of=
 similar
> devices like Panda, PandaES etc
>
> Device Names in UCM names. There are some standard names in UCM header bu=
t need
> more. Liam to add more names.
>
> Arbitration, UCM does not do arbitration but leaves that up to sound serv=
er.
>
> Controls names need more standardisation. Kcontrol naming mainly based on=
 HW
> specified within data sheets. Difficult for userspace to cope with great =
degree
> of naming variations and provide enough information for userspace to know
> which volume is master etc.
>
>
>
> Audio Delay and Timing granularity
> ----------------------------------
>
> Some DMA drivers very bad at providing position information used to work =
out
> buffer positions. Difficult for userspace to render audio and wake up cor=
rectly
> with such HW unless we can provide mechanism for userspace to know the DM=
A position
> accuracy. IOCTL suggested, info is in driver so easy to expose.
>
> There already is the SNDRV_PCM_INFO_BATCH flag which is supposed to indic=
ated that
> the granularity is period-size-ish. It makes sense for applications
> like pulse-audio to check whether this flag is set or not.
>
>
>
> Hostless Audio
> --------------
>
> Hostless should now use kcontrol to join the graph links to enable or dis=
able and
> not hostless PCM device (old Android hack).
> e.g. FM playback loopback to codec, Modem PCM handling.
> i.e. CODEC <-> CODEC type. Need mixer to expose set config changes as link
> config is static e.g. WB/NB configs.
>
>
>
> Audio Offloading for Android
> ----------------------------
>
> Avail in KK, supports > 1 compressed devices. No guarantee on no dropped =
samples
> when changing compressed to PCM and vice versa (or enabling effects ????)
> Not available yet when in use with video, no tech reason to stop this.
> AV sync good. Some effects can be offloaded and some not.
>
>
> Compressed API
> --------------
>
> Intel to upstream remaining fixes. AR - Liam, Vinod.
>
> Stable updates with no users. 3.10 is stable but we can changes core API =
since
> there are no users.
>
>
> Android Audio Effects Framework Modifications
> ---------------------------------------------
>
> Composite with HW and SW representations. Supports 3rd party GUI controls
> but they must use the effect API and not bypass with private IOCTLs.
>
> How do we do library, like tiny effects ? API exists in use by Factory,
> can we extend to alsa ?
>
> Nobody using compressed and effects outside of Android atm.
>
>
> 24 Bit HiRes Audio for Android
> ------------------------------
>
> How do we handle 24 bit audio at fast rates e.g. 192kHz. Being pushed by =
market.
> Flac suggested as source media and not PCM.
>
> We could use offload, on roadmap for Hires audio on android PCM,
> maybe float instead of 24 bit. Need for 192kHz, Probably not use effects.
>

Now i'm working on Xiaomi TV and it's a very cool product,see page
introduction here:
http://www.xiaomi.com/mitv
(Sorry here's only Chinese page yet, no english version. But hopefully
you're attracted with the pictures)

It's running Android with Qualcom&Mstar's chipset. i hope we can
support High Bit Rate audio with HDMI output
in next generation, so i would see more update about this in Android.

Does android support HBR audio now? As i know from Dolby guys, no
customers in Android area are buying Dolby TrueHD license, so i guess
the answer is NO. Most of the customers are from AV receivers and
BlueRay players.

Intel HDA claimed support HBR audio but i donot know if there's any
ARM based chipset vendor claim supporting HBR audio with their HDMI control=
ler.
Even the ARM HDMI controller supports HBR transferring, seems Android
software doesnot support yet. So given some vendors support HBR audio
under
Android, they're using private APIs, and the code maybe not in upstream yet.

For TV and set-top boxes in home theater, users have higher quality
requirement, just as you mentioned above. I would like xiaomi could
know more schedule about this feature implementation and ready to make
some contribution. we have plenty of users for testing every week of
such cool features, so if any guys have codes ready for test under
Android, it's really a good chance.

thanks
--xingchao

>
> Effect Support in ALSA
> ----------------------
>
> Several proposals for APIs.
>
> Control device type, do we need new control or use existing CTL ? Per car=
d or
> per DSP / CODEC. ? Not to use control API for everything , could confuse =
some
> userspace. Get/set could be any control type, not just binary ? Binary bl=
obs
> used to hide workings of effects.
>
> Topology Query and edit - query the graph from HDA/DAPM -
> used to establish connections and end points. per card based IOCTL. Could=
 be new
> alsamixer to allow users to control volumes.
>
> Media controller API. How do we match to ALSA. Need non LGPL library for =
android.
> Missing certain features, someone needs to write code. MC API is Video or=
iented,
> library is just wrappers around IOCTLs, 1 man week of simple work to impl=
ement
> non LGPL version.
>
> Removal/creation - kernel can provide any type of information to user spa=
ce key values.
> Document new keys, generic structure. Channel mapping possible using tupl=
es.
> Need to support dynamic entity information. Handles static pipeline well,
> and can also expose dynamic with some complexity (with more entities).
>
> Abstract away sink+sources in userspace library, maybe too complex.
>
> Trivial to use UUIDs for dynamic entities. Start with prototype and see w=
hat happens.
> Action on Intel/Vinod ?
>
> Topology 2 NODES and EFFECT IOCTLS could be replaced with media controlle=
r as MediaC
> provides good match.
>
>
>
> Sending/Receiving Binary data to drivers
> ----------------------------------------
>
> Use cases that go above 256/512 ?  byte limit for binary controls.
> Extend for larger ? Do something about it. Action for ????? Tiwai/Mark ??=
??
>
> MMAP for some parameters. Visualizer, peak meters. ? Multiple of 4k pages.
> Can be used for DMA buffer positions on IPC IRQ based DSPs.
> Avoid copying large amounts of data. trade off for DSP. Usable for DEBUG =
too.
> Prototype and see what happens - Who ??
>
> Expose API for sending large chunks of data e.g. 2MB. Nice for generic co=
de to send
> this data (no special tooling) Needs new API for large data chunks. What =
about write().
> Patrick to prototype some code.
>
>
> DSP resource management
> -----------------------
>
> Do we need pre-trigger to work out MIPS/MHz + buffer resources for DSP
> resources. Tables used atm for most DSPs.
>
> Something for policy or UCM to specify ? Could change for different FWs.
> Peak and average loading gives difficulty.
>
> Might not get feedback, latency in the pipe and need to agree on units of
> measurements. Complex problem. Estimate worst case.
>
> OMAP4 example uses DAPM, expose reource usage numbers, expose capability =
limits.
>
> Liam to publish clock resource management logic for Haswell DSP. Can be u=
sed as
> starting point for investigations into feasibility etc.
>
>
>
> HDMI - Hotplug
> --------------
>
> Can cause changes to audio path. Do we need to tell userspace card has ch=
anged ?
> Specific for ELD or generic problem ?
>
> Suggestion to remove and then insert card not usable
>
> Signal for monitor re-pluging, ELD not available right away.
> How to sync ELD information, ELD time out signal ? DSPs can change capabi=
lities,
> ELDS can be garbage. PA maybe ask to quickly for ELD info, expose new jac=
k for HDA
> when ELD is known.  Generic event to tell userspace that card has changed.
> HDA/MIMI specific solution.
>
> Generic API to talk between audio and DRM devices. Bespoke atm. Code live=
s in
> the wrong place atm. Need to sync. Code is already upstream.
>
> David to prototype a solution based on deferring the probe until ELD is r=
eady.
>
>
> Mic/LED hotkey
> --------------
>
> Few different scenarios - from slides. Multiple cards and multiple mics.
> Which Mic will LED represent ? card or system or other.
>
> We'll not use the LED class because it does not buy us anything: LED
> class is writable for root only, and PA does not run as root.
>
> Nobody seemed to have a firm convincing argument in any direction. As suc=
h,
> keeping the current behaviour (reflect mute state of internal card) will =
be
> kept for now.
>
> Alexander suggested looking at what NetworkManager does with the wifi-off
> indicator in the presence of multiple wireless devices with
> (potentially) their own wifi-off switches.
>
>
> Performance - Use case startup
> ------------------------------
>
> Discussing optimisation from DPCM - users QC, TI and Intel. DSP can route=
 to
> multiple endpoints from a single PCM.
>
> Startup call back -> PCM -> FE -> BE. Then hw_params(), followed by prepa=
re()
> and trigger(). Cold start latency 113ms on QDSP since some slow ops on QD=
SP
> are serialised. Solution to shift some prepare() work into DAPM.
> DAPM ops are tun in parallel and a workq.
>
>
> Compressed offload
> ------------------
>
> Video/Audio offload - pass audio timestamp. Metadata for QDSP stored at f=
ront of
> compressed data by QC. Transport stream already supported by compressed A=
PI.
> Timestamps may differ in DSP implementations. AV sync topic requested by =
V4Linux
> for long time. Only discussed for PCM not offload, need TS for offload an=
d support
> of V4Linux guys.
>
> Compressed offload transcoding. - How do we specify this transform. New A=
PI for
> userspace to spec output of decoder. All sorts of routing combinations ar=
e possible
> making implementation very difficult. Query the the BE connected to the F=
E, we may
> be able to call existing PCM API's on the BE PCM. Patrick to prototype so=
me
> code.
>
>
> Firmware based Kcontrols and Graphs
> -----------------------------------
>
> Patches have been developed to attach Kcontrol and Graph meta data to DSP=
 FW.
> This allows single DSP driver to be used with multiple FWs without modifi=
cation.
> Patch V1 reviewed last year before TI layoff and we should be ready for V=
2 before
> end of year.
>
> Consists of kernel patch and userspace tool to generate the control and g=
raph
> data. Current userspace tool is needing work to improve config generation.
> There is no config file format at present. Paul and some Wolfson guys have
> volunteered to assist in this effort. Code currently works on OMAP4 platf=
orms.
>
> Kernel code is here (top 5 patches) :-
>
> https://git.kernel.org/cgit/linux/kernel/git/lrg/asoc.git/log/?h=3Dtopic/=
firmware
>
> Userspace tool is here :-
>
> git@gitorious.org:omap-audio/asoc-fw.git
>
>
> Clean up ALSA code
> ------------------
>
> Move plugins to their projects - move ffmpeg plugin to ffmpeg  project, e=
tc.
>
> Drivers, requests to move to device probe model, away from alsa model.
> Need to register device files at end of driver creation.
> Input susbsys uses possible method that could be copied. sysfs files need=
 sync
> to avoid races for creation. Agreement.
>
>
> Process, How do we work
> -----------------------
>
> Bug reports. Who looks at bugs. No takers.
>
> New mailing lists ? no, just use filters to hide emails that are not
> of interest.
>
>
> Misc
> ----
>
> Softvol, add SND_CTL for no softvol in ctl open. Use alsa conf file or ct=
l.
> Arun encouraged to revive the email thread on the topic.
>
> Possible bug where specially crafted javascript can set PA volume to 100%.
> Defined pulseaudio behviour (Colin), related to flat volumes.
>
> New ASoC drivers must now use generic DMA engine PCM driver.
>
> Non atomic trigger requirments from DSP drivers. DSPs mostly sleep when p=
erforming
> IPC and need a trigger call that can sleep. Patrick will investigate.
>
> Propagate errors from BEs to FEs. Patrick to investigate. This will also =
include
> reporting underruns too.
>
> System restart for DSP FW crashes. This requires reloading all FW and try=
ing to
> recover all active streams. Patrick to investigate.
>
> Lennart asked about the support of audio "mute" via systemd session manag=
ement,
> like input and drm drivers already do. Takashi took a look at input evdev=
 code,
> and actually it's revoking instead of muting.  The advantage of revoking =
over
> muting is that it's simpler and doesn't need the capability check, as far=
 as he
> read through discussion threads.  But Takashi is not sure whether revoking
> behavior is good for PA at all.
>
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
