From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Fri, 23 Oct 2015 08:35:26 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84B862EAD@shsmsx102.ccr.corp.intel.com>
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
 <F46914AEC2663F4A9BB62374E5EEF8F84B862A5B@shsmsx102.ccr.corp.intel.com>
 <s5h7fmew2oj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A42C826153D
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 10:35:31 +0200 (CEST)
In-Reply-To: <s5h7fmew2oj.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "Yang, Libin" <libin.yang@intel.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "airlied@linux.ie" <airlied@linux.ie>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, Raymond Yau <superquad.vortex2@gmail.com>, "tanuk@iki.fi" <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, October 23, 2015 1:54 PM
> 
> On Fri, 23 Oct 2015 07:30:12 +0200,
> Lin, Mengdong wrote:
> >
> > > -----Original Message-----
> > > From: David Henningsson [mailto:david.henningsson@canonical.com]
> > > Sent: Thursday, October 22, 2015 4:53 PM
> >
> > [snip]
> >
> > > I'll try to explain my suggestion (which I believe Takashi's buying
> > > too) one more time then:
> > >
> > > First, when a monitor is plugged in, we need to dynamically assign
> > > this monitor to five PCM devices. I believe this scheme will be best:
> > >
> > > For a monitor at pin nid 0x05, dev index 0, it will prefer PCM 3.
> > > For a monitor at pin nid 0x06, dev index 0, it will prefer PCM 7.
> > > For a monitor at pin nid 0x07, dev index 0, it will prefer PCM 8.
> > > For a monitor at dev index 1 (any pin), it will prefer PCM 9.
> > > For a monitor at dev index 2 (any pin), it will prefer PCM 10.
> > >
> > > For monitors at dev indices > 2 (can that happen?), or if the PCM is
> > > already assigned to something else, try PCMs in this order: 9, 10, 3, 7, 8.
> > > (Subject to discussion perhaps, I don't think the order matters too
> > > much, because conflicts will be rare in practice.)
> >
> > Hi David,
> >
> > Would you please clarify why PA needs such a fixed binding between PCM
> 3,7, 8 and pin 0x05,6,7?
> 
> It's not PA's requirement.  The only concern here is for people who uses
> ALSA device directly, e.g. via aplay -Dhdmi:2.  The first monitor is
> guaranteed to be mapped to the compatible position for such people.

Excuse me, could you share more background info here?
Even before DP MST support, it seems that such people need to know what pin is used to connect a monitor. Why?

The user can enumerate the PCM devices, and the PCM's jack ioctl can show whether a monitor is available behind this PCM device, no matter the driver uses fixed or dynamic binding between the PCM and pins.
So people can always choose a PCM to use a monitor. I feel they need not care which pin is used for the monitor.

> > And how will PA handle PCM 9,10 in a different way?
> > They are not bound to pins, and even not able to dev indexes.
> > In practice, a platform will usually support either a DP port or a HDMI port
> from the Intel integrated GPU for cost consideration.
> > But theoretically i915 can use same device index on two different pins to
> connect monitors, e.g. pin 0x05, dev index 2 for one monitor and pin 0x06,
> dev index 2 for the other.
> >
> > On Intel platforms, the max dev indices is 2. Not sure about Nvidia and
> AMD.
> 
> The whole number should be min(pins * 2 - 1, pins * 64).  It's two for Intel,
> and 7 or more on AMD/Nvidia.
> 
> As we've discussed, this "reserved" area is basically optional.  We have them
> for keeping compatibility more easily.  Even if this are is exhausted, you can
> still try to map to any empty slot as the last resort.  So, in practice, maybe
> adding just two extra for this reserved area should suffice.  That is, the
> scheme is:
> 
> - Try a static mapping at first
> - If already occupied, try a dynamic mapping in reserved area
> - If a dynamic mapping area is exhausted, try to find any empty slot
> 
> The device index number doesn't matter.  If it conflicts, try another.
> 

Thanks for your clarification! This scheme should work.
I misunderstood "prefer" as "fixed binding" in David's suggestion.

Regards
Mengdong
