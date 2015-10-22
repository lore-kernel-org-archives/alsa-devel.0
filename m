From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Thu, 22 Oct 2015 11:21:18 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19753B7A@SHSMSX103.ccr.corp.intel.com>
References: <96A12704CE18D347B625EE2D4A099D1974C250@SHSMSX103.ccr.corp.intel.com>
 <561CA911.7070405@canonical.com>
 <96A12704CE18D347B625EE2D4A099D1974C304@SHSMSX103.ccr.corp.intel.com>
 <s5hlhb7ktum.wl-tiwai@suse.de>
 <CAN8cciZJ_YJhHEoU9HovR=P7FsxiKMDQ7johrmFGEWHQK_ZYNg@mail.gmail.com>
 <s5htwpuj6f5.wl-tiwai@suse.de>
 <CAN8cciYqLBH=kXvPjrGTgGPg9p7euU5w9z=UYdvKk4Vnxf-YFw@mail.gmail.com>
 <96A12704CE18D347B625EE2D4A099D1975281F@SHSMSX103.ccr.corp.intel.com>
 <56288783.1080503@canonical.com>
 <96A12704CE18D347B625EE2D4A099D19753A2D@SHSMSX103.ccr.corp.intel.com>
 <56288FF7.9030400@canonical.com>
 <96A12704CE18D347B625EE2D4A099D19753A91@SHSMSX103.ccr.corp.intel.com>
 <5628A3EB.8050306@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1508D260455
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 13:21:22 +0200 (CEST)
In-Reply-To: <5628A3EB.8050306@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, Raymond Yau <superquad.vortex2@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "tanuk@iki.fi" <tanuk@iki.fi>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Thursday, October 22, 2015 4:53 PM
> To: Yang, Libin; Raymond Yau; Takashi Iwai
> Cc: airlied@linux.ie; tanuk@iki.fi; ALSA Development Mailing List;
> Girdwood, Liam R; Lin, Mengdong
> Subject: Re: [alsa-devel] DP1.2 MST audio support discussion
> 
> 
> 
> On 2015-10-22 09:40, Yang, Libin wrote:
> >
> >>>>>> From: Raymond Yau [mailto:superquad.vortex2@gmail.com]
> >>>>>> Sent: Friday, October 16, 2015 8:33 AM
> >>>>>> To: Takashi Iwai
> >>>>>> Cc: airlied@linux.ie; tanuk@iki.fi; David Henningsson; Yang,
> Libin;
> >>>> Lin,
> >>>>>> Mengdong; Girdwood, Liam R; ALSA Development Mailing List
> >>>>>> Subject: Re: [alsa-devel] DP1.2 MST audio support discussion
> >>>>>>
> >>>>>>
> >>>>>>>>
> >>>>>>>> Do it mean that only one DP MST port and no HDMI port on
> >> the
> >>>>>> same graphic
> >>>>>>>> card ?
> >>>>>>>
> >>>>>>> No.
> >>>>>> If there is only one HDMI and one Display Port, this mean that
> >> there
> >>>>>> are two pin complexes
> >>>>>> How about the name of jack detection kctl of three Display
> Port
> >>>>>> monitors  which are created on the same pin complex but
> >> different
> >>>>>> dev_index ?
> >>>>>
> >>>>> For the jack name, what do you think if we change to
> >>>>> "HDMI/DP, pin=n, dev=m" format? Will it impact on pulseaudio?
> >>>>
> >>>> Yes, it will impact PulseAudio. It will require changes to files in
> >>>>
> >>>>
> >>
> http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/
> >>>> alsa/mixer/paths
> >>>
> >>> So does this mean we should not change the name
> "HDMI/DP,pcm=3
> >> Jack"
> >>> to "HDMI/DP,pin=n, dev=m Jack", otherwise the old PA will not
> work
> >> with
> >>> the new driver?
> >>
> >> Yes. And I don't understand why you need to do it, either - if you
> have
> >> three display port monitors on one pin, then they will all get
> different
> >> PCMs (8, 9 and 10), and they will signal their Jack status through
> >> "HDMI/DP,pcm=8 Jack", "HDMI/DP,pcm=9 Jack" and
> >> "HDMI/DP,pcm=10 Jack".
> >
> > OK, I see. Thanks. I will not change the jack kctl name.
> > BTW, the PCM number will be the same as converter, which means
> > it will be 3 on Intel platforms.
> 
> I'll try to explain my suggestion (which I believe Takashi's buying too)
> one more time then:
> 
> First, when a monitor is plugged in, we need to dynamically assign this
> monitor to five PCM devices. I believe this scheme will be best:
> 
> For a monitor at pin nid 0x05, dev index 0, it will prefer PCM 3.
> For a monitor at pin nid 0x06, dev index 0, it will prefer PCM 7.
> For a monitor at pin nid 0x07, dev index 0, it will prefer PCM 8.
> For a monitor at dev index 1 (any pin), it will prefer PCM 9.
> For a monitor at dev index 2 (any pin), it will prefer PCM 10.
> 
> For monitors at dev indices > 2 (can that happen?), or if the PCM is
> already assigned to something else, try PCMs in this order: 9, 10, 3, 7,
> 8.
> (Subject to discussion perhaps, I don't think the order matters too
> much, because conflicts will be rare in practice.)

Oh, it seems my understand is wrong. OK, so the pcm number will be:
Pin number + max (device entry number per pin) - 1. For example,
on intel platform, it is 5.

> 
> The jack and ELD kctls - one per PCM device - will follow what monitor
> the PCM is currently assigned to. (kctls belonging to a PCM device that
> is unassigned will report presence_detect=0 and eld_valid=0.)

It makes sense. This should be mostly friendly to userspace. I will do it.

> 
> Then, at playback open time, a free converter node will be dynamically
> assigned to the PCM. If there are no free converter nodes, return -
> EBUSY.

Yes, this is what I think.

> 
> Now remains the case when an unassigned PCM is opened. This needs
> additional thinking, but the more backwards compatibility we can keep
> for this case, the better. But I'm not sure about how possible it is to
> let streams "freewheel" in this new DSP MST world?

Do you mean playing on unassigned PCM should work as the monitor is
connected? I remember Takashi mentioned disconnecting monitor when
playback should trigger stop PCM. This case should follow the same policy
and return -ENODEV or -EINVAL?

> 
> >> Given that my proposed mapping algorithm will never change pin to
> >> PCM
> >> mapping (unless you have two displayport outputs and use MST on
> >> both), I
> >> think we can get away with not exposing the actual pin to
> userspace.
> >> And should this later become necessary, we can add a separate kctl
> for
> >> that.
> >
> > My current thought is to expose the same jack kctls (same number
> and
> > same name) to userspace while we will create hda_jack_tbl for each
> device
> > entry. When pcm is bound to the device entry, the corresponding
> > jack kctl will be bound to the device entry.
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
