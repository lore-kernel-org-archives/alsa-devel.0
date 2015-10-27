From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Tue, 27 Oct 2015 08:45:17 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19755BE7@SHSMSX103.ccr.corp.intel.com>
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
 <562A1237.2090909@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F84B8632DF@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 98280260415
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 09:45:44 +0100 (CET)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F84B8632DF@shsmsx102.ccr.corp.intel.com>
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
To: "Lin, Mengdong" <mengdong.lin@intel.com>, David Henningsson <david.henningsson@canonical.com>, Raymond Yau <superquad.vortex2@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "tanuk@iki.fi" <tanuk@iki.fi>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi and David,

There are still some opens. Would you please help to comment?

1. SPDIF kctl.
This SPDIF number will be the same as PCM and be bound to the PCM.
The pin nid of SPDIF will not be initialized. And the pin nid will be assigned
After PCM is bound to the pin. (How to assign?)

2. chmap. 
The chmap will use the old method. Each virtual pin has its own chmap.

3. lock.
When accessing the register, the device entries in the same pin will impact on
each other. So when operating on a device entry, it need acquire a lock.
Do we need create each lock for each pin or just use one lock for all pins?

4. power management
If we close the PCM when disconnecting monitor, the driver will return 
-ENODEV, and we assume user space will close the PCM at once .
Thus the refcount will decrease automatically. So the codec has a chance
to enter D3 and release the shared power with GPU. GPU requires to
release the power as soon as the monitor is disconnected.
 

Regards,
Libin


> -----Original Message-----
> From: Lin, Mengdong
> Sent: Friday, October 23, 2015 8:35 PM
> To: David Henningsson; Yang, Libin; Raymond Yau; Takashi Iwai
> Cc: airlied@linux.ie; tanuk@iki.fi; ALSA Development Mailing List;
> Girdwood, Liam R
> Subject: RE: [alsa-devel] DP1.2 MST audio support discussion
> 
> > -----Original Message-----
> > From: David Henningsson [mailto:david.henningsson@canonical.com]
> > Sent: Friday, October 23, 2015 6:56 PM
> >
> > On 2015-10-23 07:30, Lin, Mengdong wrote:
> > >> -----Original Message-----
> > >> From: David Henningsson
> [mailto:david.henningsson@canonical.com]
> > >> Sent: Thursday, October 22, 2015 4:53 PM
> > >
> > > [snip]
> > >
> > >> I'll try to explain my suggestion (which I believe Takashi's buying
> > >> too) one more time then:
> > >>
> > >> First, when a monitor is plugged in, we need to dynamically assign
> > >> this monitor to five PCM devices. I believe this scheme will be best:
> > >>
> > >> For a monitor at pin nid 0x05, dev index 0, it will prefer PCM 3.
> > >> For a monitor at pin nid 0x06, dev index 0, it will prefer PCM 7.
> > >> For a monitor at pin nid 0x07, dev index 0, it will prefer PCM 8.
> > >> For a monitor at dev index 1 (any pin), it will prefer PCM 9.
> > >> For a monitor at dev index 2 (any pin), it will prefer PCM 10.
> > >>
> > >> For monitors at dev indices > 2 (can that happen?), or if the PCM is
> > >> already assigned to something else, try PCMs in this order: 9, 10, 3,
> 7, 8.
> > >> (Subject to discussion perhaps, I don't think the order matters too
> > >> much, because conflicts will be rare in practice.)
> > >
> > > Hi David,
> > >
> > > Would you please clarify why PA needs such a fixed binding
> between PCM
> > 3,7, 8 and pin 0x05,6,7?
> >
> > PulseAudio saves information about profile and volume, and does so
> on
> > what in PA terminology is called a "port". PA binds this port to a
> specific Jack
> > kctl and a PCM device. How this fits together is configured in the files
> in
> > /usr/share/pulseaudio/alsa-mixer/ .
> >
> > E g, if both one HDMI and one DP monitor are both connected, the
> user
> > might set the volume (through PA) of the HDMI monitor to high and
> the DP
> > monitor to low. The user then reboots. Now, the PCM-to-monitor
> (and Jack
> > kctl-to-monitor) mapping needs to remain the same after a reboot,
> > otherwise PA might restore the volume to the wrong monitor.
> 
> I see. Thank you for the info!
> Random binding can break static mapping since the order of hot-plug
> unsol events is out of our control.
> 
> >
> > > And how will PA handle PCM 9,10 in a different way?
> >
> > PA will handle PCM 9 and 10 in the same way.
> >
> > > They are not bound to pins, and even not able to dev indexes.
> > > In practice, a platform will usually support either a DP port or a
> HDMI port
> > from the Intel integrated GPU for cost consideration.
> > > But theoretically i915 can use same device index on two different
> pins to
> > connect monitors, e.g. pin 0x05, dev index 2 for one monitor and pin
> 0x06,
> > dev index 2 for the other.
> >
> > In theory, there are certainly cases where the PCM device allocation
> can
> > cause problems for PA. What I'm trying to achieve is that these cases
> will be
> > so few that no one will ever notice.
> 
> I agree. Your suggestion can keep static mapping between monitors
> and PCM devices during various display mode change and power cycle
> for common use cases.
> 
> Regards
> Mengdong
> 
> >
> > > On Intel platforms, the max dev indices is 2. Not sure about Nvidia
> and
> > AMD.
> >
> > Ok, thanks for the clarification.
> >
> > --
> > David Henningsson, Canonical Ltd.
> > https://launchpad.net/~diwic
