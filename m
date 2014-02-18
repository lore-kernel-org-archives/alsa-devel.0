From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: Need your advice: Add a new communication inteface
 between HD-Audio and Gfx drivers for hotplug notification/ELD update
Date: Tue, 18 Feb 2014 13:58:22 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B277FF5@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B231778@SHSMSX101.ccr.corp.intel.com>
	<CAKMK7uFYNfVhXsEmikDZCaFGM8k7g7VMcGqGM4U+1bA_9MX1zQ@mail.gmail.com>
	<F46914AEC2663F4A9BB62374E5EEF8F82B23315E@SHSMSX101.ccr.corp.intel.com>
	<20140122141821.GI9772@phenom.ffwll.local>	<s5hd2jkj5nt.wl%tiwai@suse.de>
	<F46914AEC2663F4A9BB62374E5EEF8F82B2342D7@SHSMSX101.ccr.corp.intel.com>
	<s5h38kfuo4a.wl%tiwai@suse.de>
	<CAKMK7uGT1My5hrVCZgnO5UGP5QQkXw=UBxxnaAdqTFTOxptCyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <CAKMK7uGT1My5hrVCZgnO5UGP5QQkXw=UBxxnaAdqTFTOxptCyw@mail.gmail.com>
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
To: Daniel Vetter <daniel@ffwll.ch>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, dri-devel <dri-devel@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

Sorry to pick up this thread after a long time.

> -----Original Message-----
> From: daniel.vetter@ffwll.ch [mailto:daniel.vetter@ffwll.ch] On Behalf Of
> Daniel Vetter
> Sent: Thursday, January 23, 2014 4:27 PM
> To: Takashi Iwai
 
> On Thu, Jan 23, 2014 at 8:57 AM, Takashi Iwai <tiwai@suse.de> wrote:
> >> Thanks for clarification!
> >> Maybe we can add output info (eg. display port number) to the eld entries
> under /proc/asound/cardx. Is it okay?
> >
> > It's possible, but the proc file is just a help.  It can't be the API.
> > For accessing the information, we'll need some new API, or let inform
> > via sysfs of the new device.
> 
> Links in sysfs sound like the best approach. drm already has nodes for each
> connector, so on the gfx side there's a natural endpoint already.
> sysfs links also avoids any naming issues from the start, e.g. the above DP
> connector id might lead to clashes with multiple cards.

Hi Daniel,

Is there a 1:1 mapping between these connector nodes and ports of Gfx display engine?
Eg. For Haswell Ultrabook, under /sys/devices/pci0000:00/0000:00:02.0/drm/card0/
There are four connector nodes, 
card0-DP-1		-> DDI port B
card0-eDP-1/		-> DDI port A
card0-HDMI-A-1/	-> DDI Port C
card0-HDMI-A-2/	-> Which DDI port ?  Haswell-ULT does not support port D, and I think port E is for VGA.

Hi Takashi,

To make user space figure out which audio output is connected to which screen (connector), maybe we can define a new ALSA control for each HDMI/DP PCM device:
e.g. numid=x,iface=PCM,name='Screen',device=3
Reading the control will return the name of the DRM connector nodes like ' card0-DP-1'. The audio driver can get the connector name from the gfx driver.

For DP1.2 Multi-stream transport, it's not supported by i915 and HD-A driver now. But probably there will be sub-nodes for the DP connector node in the future and an index in their name can be used distinguish monitors connected to the same DP port, like card0-DP-1.1, card0-DP-1.2, card0-DP-1.3 ... These names can be used by the above ALSA PCM 'Screen' control, so we can still know which audio output is to which monitor.

Thanks
Mengdong
