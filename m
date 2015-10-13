From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Tue, 13 Oct 2015 07:34:49 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1974C304@SHSMSX103.ccr.corp.intel.com>
References: <96A12704CE18D347B625EE2D4A099D1974C250@SHSMSX103.ccr.corp.intel.com>
 <561CA911.7070405@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BF6E2606FB
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 09:35:39 +0200 (CEST)
In-Reply-To: <561CA911.7070405@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, 'Takashi Iwai' <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "tanuk@iki.fi" <tanuk@iki.fi>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi David

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Tuesday, October 13, 2015 2:48 PM
> To: Yang, Libin; 'Takashi Iwai'; Lin, Mengdong; tanuk@iki.fi; Girdwood,
> Liam R
> Cc: alsa-devel@alsa-project.org; airlied@linux.ie
> Subject: Re: DP1.2 MST audio support discussion
> 
> Hi Libin,
> 
> On 2015-10-13 08:25, Yang, Libin wrote:
> > Hi Takashi and all,
> >
> > We are planning to enable DP1.2 MST (Multi-Stream Transport)
> > audio.
> 
> This was also discussed during the audio mini-summit in Dublin last
> week.

Yes, Mengdong has talked with me. And I will implement the DP1.2
MST audio based on the audio mini-summit discussion.

> 
> >
> > Based on the previous discussion, we will extend the
> > struct hdmi_spec_per_pin to support MST audio device entry.
> > So the struct hdmi_spec_per_pin can be a real pin or a device
> > entry in the pin.  The idea is to add a member dev_idx in the
> > struct hdmi_spec_per_pin. Dev_idx, together with pin_nid,
> > can represent a device entry.
> >
> > 1. Dynamic PCM assignment
> > We will use dynamic PCM assignment for MST audio. This
> > means we will create a fixed number of PCMs (the number
> > is the same convertor number). All the created PCMs will not
> > be assigned to any pin (device entry). When there is a monitor
> > connected, an available PCM will be assigned to the pin. And
> > it will be de-assigned when the monitor is disconnected.
> > Userspace can fetch the HW param when monitor connection
> > status is changed.
> 
> For the dynamic PCM assignment, the suggestion is to try to use static
> as much as possible. That is, first try the existing static mapping
> (port B -> 3, port C -> 7, port D -> 8), and only if that PCM is already
> being used, try another PCM.

Do you mean the each pin has its prefer PCM? It should be OK.

> 
> One could then allocate two extra PCMs from the start (9 and 10) to
> try
> in case the other PCM is busy (my preference), or one could steal one
> of
> the existing non-busy ones (Takashi's preference).

We will create the PCMs based on converter. This means we will
create 3 PCMs. And it will not support dynamically allocating PCM.
As there are only 3 converters, no more PCMs will be supported.
Each PCM will use one converter. If 3 PCMs are all used, connecting
monitor will not create new PCM.

Yes, if we are not using the PCM, we can re-assign the PCM to another
monitor. Currently, user can't decide which PCM is used for which
monitor. Image the scenario PCM 3 is assigned to monitor 1, PCM 7 is 
assigned to monitor 2, PCM 8 is assigned to monitor 3. Monitor 4 is
connected, no PCM is available, and driver don't know whether it
should steal one PCM for the monitor 4 and user can't change the
mapping currently.

Actually, before sending the email, I was thinking to export
an interface to userspace to let user select which PCM will be bound
to the monitor. But it is a little complex.

> 
> > I'm not sure how to notify the userspace, such as notifying
> > pulseaudio the PCM is assigned or de-assigned. Any ideas?
> 
> Userspace will receive change events on Jack and ELD kctls which can
> be
> used for this. However, there's not yet code in PulseAudio that will
> re-probe a PCM when a Jack event is received.

Do you mean to use the existed notifiers for PCM and no
new notifier is needed?

> 
> > 2. Compatibility.
> > We will patch patch_hdmi.c to support the MST audio.
> > Will we use mst audio driver to support the old mode
> > or we use a flag, when HW doesn't support MST audio,
> > we will use the old code? Suppose MST audio driver should
> > be able support both MST audio and non-MST audio.
> 
> Apparently, the suggestion seems to be three hdmi codec drivers for
> the
> same hardware? One with MST audio, one without MST audio, and
> one ported
> to the ASoC framework :-/

Not sure, I think we can use one hdmi codec driver for HD Audio, another
one for ASoC. It's based on the conclusion of the discussion.

Regards,
Libin

> 
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
