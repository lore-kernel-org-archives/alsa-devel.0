From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Mon, 2 Nov 2015 07:54:45 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19757529@SHSMSX103.ccr.corp.intel.com>
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
 <96A12704CE18D347B625EE2D4A099D19755BE7@SHSMSX103.ccr.corp.intel.com>
 <s5hvb9or3zj.wl-tiwai@suse.de>
 <CAN8cciYwLyJcxh0QYOH0LgSD9NhWQ3JYy=TecYYFuTx-iA7SHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4355A260661
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 08:54:52 +0100 (CET)
In-Reply-To: <CAN8cciYwLyJcxh0QYOH0LgSD9NhWQ3JYy=TecYYFuTx-iA7SHQ@mail.gmail.com>
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
To: Raymond Yau <superquad.vortex2@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, "airlied@linux.ie" <airlied@linux.ie>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "tanuk@iki.fi" <tanuk@iki.fi>, "Lu,
 Han" <han.lu@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> bounces@alsa-project.org] On Behalf Of Raymond Yau
> Sent: Sunday, November 01, 2015 4:53 PM
> To: Takashi Iwai
> Cc: Yang, Libin; ALSA Development Mailing List; airlied@linux.ie; Lin,
> Mengdong; Girdwood, Liam R; tanuk@iki.fi; Lu, Han; David
> Henningsson
> Subject: Re: [alsa-devel] DP1.2 MST audio support discussion
> 
> > >
> > > There are still some opens. Would you please help to comment?
> > >
> > > 1. SPDIF kctl.
> > > This SPDIF number will be the same as PCM and be bound to the
> PCM.
> > > The pin nid of SPDIF will not be initialized. And the pin nid will be
> assigned
> > > After PCM is bound to the pin. (How to assign?)
> >
> > I don't understand the question.  Could you elaborate?
> 
> Are there any difference between three display ports in dasiy chain ?
> 
> As they are physically connected to the same complex, do they have
> own
> playback switches or only one mute switch for three displayports ?

I have tried: 2 monitors are connected to a DP MST hub, and the DP
MST hub is connected the computer. Each PCM can be muted
independently. 

I haven't tried: the first monitor is connected the computer
and another monitor is connected to the first monitor.

Suppose it should be the same (I'm not very sure).
As you know, we use converter to control the mute. Each 
PCM/device entry uses a different converter.

Regards,
Libin

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
