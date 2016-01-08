From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 4/4] ALSA: hda - hdmi monitor hotplug
 support for dynamic pcm assignment
Date: Fri, 8 Jan 2016 07:53:38 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D190464D2C0@SHSMSX103.ccr.corp.intel.com>
References: <1451524942-17288-1-git-send-email-libin.yang@linux.intel.com>
 <1451524942-17288-5-git-send-email-libin.yang@linux.intel.com>
 <s5hio35fp75.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D190464D209@SHSMSX103.ccr.corp.intel.com>
 <s5hbn8w8qga.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B967A260421
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 08:53:42 +0100 (CET)
In-Reply-To: <s5hbn8w8qga.wl-tiwai@suse.de>
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
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, January 08, 2016 3:45 PM
> To: Yang, Libin
> Cc: libin.yang@linux.intel.com; alsa-devel@alsa-project.org; Lin,
> Mengdong
> Subject: Re: [alsa-devel] [PATCH 4/4] ALSA: hda - hdmi monitor hotplug
> support for dynamic pcm assignment
> 
> On Fri, 08 Jan 2016 06:25:37 +0100,
> Yang, Libin wrote:
> >
> > Hi Takashi,
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Thursday, January 07, 2016 10:18 PM
> > > To: libin.yang@linux.intel.com
> > > Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> > > Subject: Re: [alsa-devel] [PATCH 4/4] ALSA: hda - hdmi monitor
> hotplug
> > > support for dynamic pcm assignment
> > >
> > > On Thu, 31 Dec 2015 02:22:22 +0100,
> > > libin.yang@linux.intel.com wrote:
> > > >
> > > > From: Libin Yang <libin.yang@linux.intel.com>
> > > >
> > > > This patch adds the support for monitor hotplug of dynamic pcm
> > > assignment.
> > > >
> > > > 1. unsol_event enabling
> > > >  - For codec_has_acomp, unsol_event is disabled.
> > > >  - For !codec_has_acomp && !dyn_pcm_assign, use the hda_jack
> > > helper to
> > > >    enable unsol_event
> > > >  - For !codec_has_acomp && dyn_pcm_assign, enable unsol_event
> > > with verb
> > > >    directly
> > > >
> > > > 2. unsol_event handling
> > > >  - For !dyn_pcm_assign, use hda_jack helper to report the event
> > > >  - For dyn_pcm_assign, use snd_jack_report() directly
> > >
> > > I guess we can reduce lots of codes if ignoring the case with
> > > dyn_pcm_assign but without audio component?  If so, for simplicity,
> we
> > > can limit dyn_pcm_assign only tied with audio component.  Just add a
> > > WARN_ON() in such a case.  Although the functionality is somehow
> > > unrelated, the actual testing and coding is more targeted with Intel
> > > chips that are only with audio component.
> >
> > My initial idea is to support:
> > 1. dyn_pcm_assign && acomp: Intel case
> > 2. dyn_pcm_assign && !acomp: other vendors MST case
> > 3. !dyn_pcm_assign && acomp: Intel non-mst case
> > 4. !dyn_pcm_assign && !acomp: other vendors current case
> >
> > Do you mean we can ignore other vendors' case so far? If so, the
> > code will be simpler.
> 
> Yes.  And give WARN_ON(dyn_pcm_assign && !acomp);

Get it. I will follow it.

Regards,
Libin

> 
> 
> Takashi
