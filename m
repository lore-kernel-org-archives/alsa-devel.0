From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Fri, 23 Oct 2015 05:30:12 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84B862A5B@shsmsx102.ccr.corp.intel.com>
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
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EB36D260600
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 07:30:16 +0200 (CEST)
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
To: David Henningsson <david.henningsson@canonical.com>, "Yang, Libin" <libin.yang@intel.com>, Raymond Yau <superquad.vortex2@gmail.com>, Takashi
 Iwai <tiwai@suse.de>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "tanuk@iki.fi" <tanuk@iki.fi>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Thursday, October 22, 2015 4:53 PM

[snip] 

> I'll try to explain my suggestion (which I believe Takashi's buying too) one
> more time then:
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
> For monitors at dev indices > 2 (can that happen?), or if the PCM is already
> assigned to something else, try PCMs in this order: 9, 10, 3, 7, 8.
> (Subject to discussion perhaps, I don't think the order matters too much,
> because conflicts will be rare in practice.)

Hi David,

Would you please clarify why PA needs such a fixed binding between PCM 3,7, 8 and pin 0x05,6,7?

And how will PA handle PCM 9,10 in a different way?
They are not bound to pins, and even not able to dev indexes. 
In practice, a platform will usually support either a DP port or a HDMI port from the Intel integrated GPU for cost consideration.
But theoretically i915 can use same device index on two different pins to connect monitors, e.g. pin 0x05, dev index 2 for one monitor and pin 0x06, dev index 2 for the other.

On Intel platforms, the max dev indices is 2. Not sure about Nvidia and AMD.

Thanks
Mengdong
