From: Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [alsa-devel] [RFC] set up an sync channel between
 audio and display driver (i.e. ALSA and DRM)
Date: Tue, 20 May 2014 17:07:51 +0200
Message-ID: <537B6FC7.9030307@intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B447059@SHSMSX101.ccr.corp.intel.com>
 <1400596147.32158.36.camel@intelbox>
 <CAKMK7uFdPiBoTO-oKCF-t3JbHVwB9F_wFTNnUwgH5JL2fpSH7Q@mail.gmail.com>
 <20140520145729.GB23140@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20140520145729.GB23140@ulmo>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikkanen,
 Kimmo" <kimmo.nikkanen@intel.com>, "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "Babu,
 Ramesh" <ramesh.babu@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

On 20/05/2014 16:57, Thierry Reding wrote:
> On Tue, May 20, 2014 at 04:45:56PM +0200, Daniel Vetter wrote:
>> >On Tue, May 20, 2014 at 4:29 PM, Imre Deak<imre.deak@intel.com>  wrote:
>>> > >On Tue, 2014-05-20 at 05:52 +0300, Lin, Mengdong wrote:
>>>> > >>This RFC is based on previous discussion to set up a generic
>>>> > >>communication channel between display and audio driver and
>>>> > >>an internal design of Intel MCG/VPG HDMI audio driver. It's still an
>>>> > >>initial draft and your advice would be appreciated
>>>> > >>to improve the design.
>>>> > >>
>>>> > >>The basic idea is to create a new avsink module and let both drm and
>>>> > >>alsa depend on it.
>>>> > >>This new module provides a framework and APIs for synchronization
>>>> > >>between the display and audio driver.
>>>> > >>
>>>> > >>1. Display/Audio Client
>>>> > >>
>>>> > >>The avsink core provides APIs to create, register and lookup a
>>>> > >>display/audio client.
>>>> > >>A specific display driver (eg. i915) or audio driver (eg. HD-Audio
>>>> > >>driver) can create a client, add some resources
>>>> > >>objects (shared power wells, display outputs, and audio inputs,
>>>> > >>register ops) to the client, and then register this
>>>> > >>client to avisink core. The peer driver can look up a registered
>>>> > >>client by a name or type, or both. If a client gives
>>>> > >>a valid peer client name on registration, avsink core will bind the
>>>> > >>two clients as peer for each other. And we
>>>> > >>expect a display client and an audio client to be peers for each other
>>>> > >>in a system.
>>> > >
>>> > >One problem we have at the moment is the order of calling the system
>>> > >suspend/resume handlers of the display driver wrt. that of the audio
>>> > >driver. Since the power well control is part of the display HW block, we
>>> > >need to run the display driver's resume handler first, initialize the
>>> > >HW, and only then let the audio driver's resume handler run. For similar
>>> > >reasons we have to call the audio suspend handler first and only then
>>> > >the display driver resume handler. Currently we solve this using the
>>> > >display driver's late/early suspend/resume hooks, but we'd need a more
>>> > >robust solution.
>>> > >
>>> > >This seems to be a similar issue to the load time ordering problem that
>>> > >you describe later. Having a real device for avsync that would be a
>>> > >child of the display device would solve the ordering issue in both
>>> > >cases. I admit I haven't looked into it if this is feasible, but I would
>>> > >like to see some solution to this as part of the plan.
>> >
>> >Yeah, this is a big reason why I want real devices - we have piles of
>> >infrastructure to solve these ordering issues as soon as there's a
>> >struct device around. If we don't use that, we need to reinvent all
>> >those wheels ourselves.
> To make the driver core's magic work I think you'd need to find a way to
> reparent the audio device under the display device. Presumably they come
> from two different parts of the device tree (two different PCI devices I
> would guess for Intel, two different platform devices on SoCs). Changing
> the parent after a device has been registered doesn't work as far as I
> know. But even assuming that would work, I have trouble imagining what
> the implications would be on the rest of the driver model.
>
> I faced similar problems with the Tegra DRM driver, and the only way I
> can see to make this kind of interaction between devices work is by
> tacking on an extra layer outside the core driver model.
That's why we need a new avsink device which is a proper child of the 
gfx device, and the audio driver needs to use the componentized device 
framework so that the suspend/resume ordering works correctly. Or at 
least that's been my idea, might be we have some small gaps here and there.
-Daniel
Intel Semiconductor AG
Registered No. 020.30.913.786-7
Registered Office: Badenerstrasse 549, 8048 Zurich, Switzerland
