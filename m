From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: Need your advice: Add a new communication inteface
 between HD-Audio and Gfx drivers for hotplug notification/ELD update
Date: Wed, 19 Feb 2014 09:08:39 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B27B912@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B231778@SHSMSX101.ccr.corp.intel.com>
	<CAKMK7uFYNfVhXsEmikDZCaFGM8k7g7VMcGqGM4U+1bA_9MX1zQ@mail.gmail.com>
	<F46914AEC2663F4A9BB62374E5EEF8F82B23315E@SHSMSX101.ccr.corp.intel.com>
	<20140122141821.GI9772@phenom.ffwll.local>
	<s5hd2jkj5nt.wl%tiwai@suse.de>
	<F46914AEC2663F4A9BB62374E5EEF8F82B2342D7@SHSMSX101.ccr.corp.intel.com>
	<s5h38kfuo4a.wl%tiwai@suse.de>
	<CAKMK7uGT1My5hrVCZgnO5UGP5QQkXw=UBxxnaAdqTFTOxptCyw@mail.gmail.com>
	<F46914AEC2663F4A9BB62374E5EEF8F82B277FF5@SHSMSX101.ccr.corp.intel.com>
	<20140218142232.GS3852@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20140218142232.GS3852@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: Ville Syrj?l? <ville.syrjala@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, Takashi Iwai <tiwai@suse.de>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Barnes,
	Jesse" <jesse.barnes@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Ville Syrj=E4l=E4 [mailto:ville.syrjala@linux.intel.com]
> Sent: Tuesday, February 18, 2014 10:23 PM
> To: Lin, Mengdong
> Cc: Daniel Vetter; Takashi Iwai; alsa-devel@alsa-project.org; Barnes, Jes=
se;
> Zanoni, Paulo R; dri-devel; intel-gfx@lists.freedesktop.org
> Subject: Re: [Intel-gfx] Need your advice: Add a new communication
> inteface between HD-Audio and Gfx drivers for hotplug notification/ELD
> update
> =

> On Tue, Feb 18, 2014 at 01:58:22PM +0000, Lin, Mengdong wrote:
> > Sorry to pick up this thread after a long time.
> >
> > > -----Original Message-----
> > > From: daniel.vetter@ffwll.ch [mailto:daniel.vetter@ffwll.ch] On
> > > Behalf Of Daniel Vetter
> > > Sent: Thursday, January 23, 2014 4:27 PM
> > > To: Takashi Iwai
> >
> > > On Thu, Jan 23, 2014 at 8:57 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > > >> Thanks for clarification!
> > > >> Maybe we can add output info (eg. display port number) to the eld
> > > >> entries
> > > under /proc/asound/cardx. Is it okay?
> > > >
> > > > It's possible, but the proc file is just a help.  It can't be the A=
PI.
> > > > For accessing the information, we'll need some new API, or let
> > > > inform via sysfs of the new device.
> > >
> > > Links in sysfs sound like the best approach. drm already has nodes
> > > for each connector, so on the gfx side there's a natural endpoint
> already.
> > > sysfs links also avoids any naming issues from the start, e.g. the
> > > above DP connector id might lead to clashes with multiple cards.
> >
> > Hi Daniel,
> >
> > Is there a 1:1 mapping between these connector nodes and ports of Gfx
> display engine?
> > Eg. For Haswell Ultrabook, under
> > /sys/devices/pci0000:00/0000:00:02.0/drm/card0/
> > There are four connector nodes,
> > card0-DP-1		-> DDI port B
> > card0-eDP-1/		-> DDI port A
> > card0-HDMI-A-1/	-> DDI Port C
> > card0-HDMI-A-2/	-> Which DDI port ?  Haswell-ULT does not
> support port D, and I think port E is for VGA.
> =

> There's no fixed mapping with the port and the connector name. The
> number in the connector name is basically just a running number per
> connector type. However I do believe we do register the connectors in the
> order of the ports more or less always, so you can
> *sometimes* deduce the port name from the connector.
> =

> I suppose in this example HDMI-A-1 is port B, HDMI-A-2 is port C, and
> DP-1 can be either port B or port C. DP++ is the reason why we have
> overlapping DP and HDMI connectors for the same port.

Thanks for clarification, Ville!

Does Haswell support DP++ on port B/C/D?
And will the name of these connector node change after system boot, e.g. af=
ter S3/S4 cycles or hot-plug?


As long as the connector name is constant, it can help to find out the scre=
en status no matter the port works in HDMI or DP mode.

There is 1:1 mapping between audio output pins and DDI ports.
And the new ALSA PCM 'screen' control for a pin can reflect the connector n=
ame in right mode. E.g. for pin/port B, it can return HDMI-A-1 or DP-1 depe=
nding on what kind of monitor is connected.

Thanks
Mengdong

> >
> > Hi Takashi,
> >
> > To make user space figure out which audio output is connected to which
> screen (connector), maybe we can define a new ALSA control for each
> HDMI/DP PCM device:
> > e.g. numid=3Dx,iface=3DPCM,name=3D'Screen',device=3D3
> > Reading the control will return the name of the DRM connector nodes
> like ' card0-DP-1'. The audio driver can get the connector name from the
> gfx driver.
> >
> > For DP1.2 Multi-stream transport, it's not supported by i915 and HD-A
> driver now. But probably there will be sub-nodes for the DP connector
> node in the future and an index in their name can be used distinguish
> monitors connected to the same DP port, like card0-DP-1.1, card0-DP-1.2,
> card0-DP-1.3 ... These names can be used by the above ALSA PCM 'Screen'
> control, so we can still know which audio output is to which monitor.
> >
> > Thanks
> > Mengdong
> >
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > http://lists.freedesktop.org/mailman/listinfo/intel-gfx
> =

> --
> Ville Syrj=E4l=E4
> Intel OTC
