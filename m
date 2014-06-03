From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [alsa-devel] [RFC] set up an sync channel between
 audio and display driver (i.e. ALSA and DRM)
Date: Tue, 3 Jun 2014 01:42:03 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B46503C@shsmsx102.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B447059@SHSMSX101.ccr.corp.intel.com>
 <1400596147.32158.36.camel@intelbox>
 <CAKMK7uFdPiBoTO-oKCF-t3JbHVwB9F_wFTNnUwgH5JL2fpSH7Q@mail.gmail.com>
 <20140520145729.GB23140@ulmo> <537B6FC7.9030307@intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B44C2EA@SHSMSX101.ccr.corp.intel.com>
 <20140522195807.GA14357@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20140522195807.GA14357@phenom.ffwll.local>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikkanen,
 Kimmo" <kimmo.nikkanen@intel.com>, "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "Babu,
 Ramesh" <ramesh.babu@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, Thierry Reding <thierry.reding@gmail.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Vetter,
 Daniel" <daniel.vetter@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] 

> > Hi Daniel,
> >
> > Would you please share more info about your idea?
> >
> > - What would be an avsink device represent here?
> >  E.g. on Intel platforms, will the whole display device have a child
> > avsink device or multiple avsink devices for each DDI port?
> 
> My idea would be to have one for each output pipe (i.e. the link between
> audio and gfx), not one per ddi. Gfx driver would then let audio know
> when a screen is connected and which one (e.g. exact model serial from
> edid).
> This is somewhat important for dp mst where there's no longer a fixed
> relationship between audio pin and screen

Thanks. But if we use avsink device, I prefer to have an avsink device per DDI or several avsink devices per DDI,
It's because
1. Without DP MST, there is a fixed mapping between each audio codec pin and DDI;
2. With DP MST, the above pin: DDI mapping is still valid (at least on Intel platforms),
  and there is also a fixed mapping between each device (screen) connected to a pin/DDI.  
3. HD-Audio driver creates a PCM (audio stream) devices for each pin.
  Keeping this behavior can make audio driver works on platforms without implementing the sound/gfx sync channel.
  And I guess in the future the audio driver will creates more than one PCM devices for a DP MST-capable pin, according how many devices a DDI can support.

4. Display mode change can change the pipe connected to a DDI even if the monitor stays on the same DDI, 
  If we have an avsink device per pipe, the audio driver will have to check another avsink device for this case. It seems not convenient.

> > - And for the relationship between audio driver and the avsink device,
> > which would be the master and which would be the component?
> 
> 1:1 for avsink:alsa pin (iirc it's called a pin, not sure about the name).
> That way the audio driver has a clear point for getting at the eld and
> similar information.

Since the audio driver usually already binds to some device (PCI or platform device),
I think the audio driver cannot bind to the new avsink devices created by display driver, and we need a new driver to handle these device and communication.

While the display driver creates the new endpoint "avsink" devices, the audio driver can also create the same number of audio endpoint devices.
And we could let the audio endpoint device be the master and its peer display endpoint device be the component.
Thus the master/component framework can help us to bind/unbind each pair of display/audio endpoint devices.

Is it doable? If okay, I'll modify the RFC and see if there are other gaps.

> > In addition, the component framework does not touch PM now.
> > And introducing PM to the component framework seems not easy since
> > there can be potential conflict caused by parent-child relationship of
> > the involved devices.
> 
> Yeah, the entire PM situation seems to be a bit bad. It also looks like on
> resume/suspend we still have problems, at least on the audio side since
> we need to coordinate between 2 completel different underlying devices.
> But at least with the parent->child relationship we have a guranatee that
> the avsink won't be suspended after the gfx device is already off.
> -Daniel

Yes. You're right.
And we could find a way to hide the Intel-specific display "power well" from the audio driver by using runtime PM API on these devices.

Thanks
Mengdong
