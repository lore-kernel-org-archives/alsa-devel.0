From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Thu, 22 Oct 2015 06:56:58 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19753A2D@SHSMSX103.ccr.corp.intel.com>
References: <96A12704CE18D347B625EE2D4A099D1974C250@SHSMSX103.ccr.corp.intel.com>
 <561CA911.7070405@canonical.com>
 <96A12704CE18D347B625EE2D4A099D1974C304@SHSMSX103.ccr.corp.intel.com>
 <s5hlhb7ktum.wl-tiwai@suse.de>
 <CAN8cciZJ_YJhHEoU9HovR=P7FsxiKMDQ7johrmFGEWHQK_ZYNg@mail.gmail.com>
 <s5htwpuj6f5.wl-tiwai@suse.de>
 <CAN8cciYqLBH=kXvPjrGTgGPg9p7euU5w9z=UYdvKk4Vnxf-YFw@mail.gmail.com>
 <96A12704CE18D347B625EE2D4A099D1975281F@SHSMSX103.ccr.corp.intel.com>
 <56288783.1080503@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D81D26059D
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 08:57:03 +0200 (CEST)
In-Reply-To: <56288783.1080503@canonical.com>
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
> Sent: Thursday, October 22, 2015 2:52 PM
> To: Yang, Libin; Raymond Yau; Takashi Iwai
> Cc: airlied@linux.ie; tanuk@iki.fi; Lin, Mengdong; Girdwood, Liam R;
> ALSA Development Mailing List
> Subject: Re: [alsa-devel] DP1.2 MST audio support discussion
> 
> 
> 
> On 2015-10-22 03:31, Yang, Libin wrote:
> > Hi Raymond,
> >
> >>
> >> From: Raymond Yau [mailto:superquad.vortex2@gmail.com]
> >> Sent: Friday, October 16, 2015 8:33 AM
> >> To: Takashi Iwai
> >> Cc: airlied@linux.ie; tanuk@iki.fi; David Henningsson; Yang, Libin;
> Lin,
> >> Mengdong; Girdwood, Liam R; ALSA Development Mailing List
> >> Subject: Re: [alsa-devel] DP1.2 MST audio support discussion
> >>
> >>
> >>>>
> >>>> Do it mean that only one DP MST port and no HDMI port on the
> >> same graphic
> >>>> card ?
> >>>
> >>> No.
> >> If there is only one HDMI and one Display Port, this mean that there
> >> are two pin complexes
> >> How about the name of jack detection kctl of three Display Port
> >> monitors  which are created on the same pin complex but different
> >> dev_index ?
> >
> > For the jack name, what do you think if we change to
> > "HDMI/DP, pin=n, dev=m" format? Will it impact on pulseaudio?
> 
> Yes, it will impact PulseAudio. It will require changes to files in
> 
> http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/
> alsa/mixer/paths

So does this mean we should not change the name "HDMI/DP,pcm=3 Jack"
to "HDMI/DP,pin=n, dev=m Jack", otherwise the old PA will not work with
the new driver?

Regards,
Libin

> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
