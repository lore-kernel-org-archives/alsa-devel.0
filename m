From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Wed, 4 Nov 2015 14:17:45 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19765611@SHSMSX103.ccr.corp.intel.com>
References: <96A12704CE18D347B625EE2D4A099D1974C250@SHSMSX103.ccr.corp.intel.com>
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
 <96A12704CE18D347B625EE2D4A099D197574CE@SHSMSX103.ccr.corp.intel.com>
 <563716D7.3000502@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C7660260418
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:17:50 +0100 (CET)
In-Reply-To: <563716D7.3000502@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, "airlied@linux.ie" <airlied@linux.ie>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "Nikula, Jani" <jani.nikula@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "Lu, Han" <han.lu@intel.com>, Raymond Yau <superquad.vortex2@gmail.com>, "tanuk@iki.fi" <tanuk@iki.fi>
List-Id: alsa-devel@alsa-project.org

+ Jani, who is from Intel gfx team. 

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Monday, November 02, 2015 3:55 PM
> To: Yang, Libin; Takashi Iwai
> Cc: Lin, Mengdong; Raymond Yau; airlied@linux.ie; tanuk@iki.fi; ALSA
> Development Mailing List; Girdwood, Liam R; Lu, Han
> Subject: Re: [alsa-devel] DP1.2 MST audio support discussion
> 
> 
> 
> On 2015-11-02 08:30, Yang, Libin wrote:
> >
> >>> 4. power management
> >>> If we close the PCM when disconnecting monitor, the driver will
> >> return
> >>> -ENODEV, and we assume user space will close the PCM at once .
> >> ... if we implement it.  Actually this behavior (returning -ENODEV) is
> >> not mandatory and needs investigation beforehand, whether this
> >> breaks
> >> any applications, especially PA.
> > Yes. I heard that PA has dummy PCM and when there is no HW to
> > play the audio, PA can smoothly move the PCM from HW to dummy
> > PCM. If it's true, stopping PCM will not break PA, I think.
> 
> Well, in most cases (not all) there will be an analog output available,
> so we're more likely to move there than to a dummy PCM. The
> problem is
> that PA does not currently figure out that a -ENODEV means that one
> should switch from a digital to an analog profile. So, at least at this
> point, don't expect a "smooth move".
> 
> I'm not sure if this is a good idea or not, but just brainstorming here:
> 
> If PA (or other application) tries to play back to a PCM, and that PCM
> is currently unassigned. What would happen if we actually assigned a
> converter node at that point, but no pin node connected to that
> converter node? Would that give a backwards compatible behaviour? I
> e,
> audio userspace could successfully play back audio through the
> converter
> node, but then the audio goes nowhere because there is no pin node
> assigned?

GFX team hope us that if there is no monitor connected, audio
should release gfx so gfx driver can enter power save mode.
Based on the requirement, audio driver may need stop playback
as soon as the monitor is disconnected.

> 
> (Or perhaps we PA developers should actually start supporting this
> properly like we said that we should do, for like three years or
> something...)
> 
> // David
