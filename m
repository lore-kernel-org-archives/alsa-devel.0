From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [for-next] NULL pointer dereference in codec probe
Date: Thu, 30 Apr 2015 11:07:52 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A9055238D4@SHSMSX101.ccr.corp.intel.com>
References: <87fv7i9bgu.fsf@intel.com> <s5hr3r1ewyt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C7B0265CA5
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 13:08:00 +0200 (CEST)
In-Reply-To: <s5hr3r1ewyt.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "Nikula, Jani" <jani.nikula@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Tian,
 YeX" <yex.tian@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, April 30, 2015 6:23 PM
> To: Nikula, Jani
> Cc: Jaroslav Kysela; alsa-devel@alsa-project.org; Tian, YeX; Jie, Yang
> Subject: Re: [for-next] NULL pointer dereference in codec probe
> 
> At Thu, 30 Apr 2015 13:06:41 +0300,
> Jani Nikula wrote:
> >
> >
> > Hi all, our graphics QA found an issue [1] with the for-next branch of
> > [2] merged on top of v4.1-rc1. Backtrace in the bug. I didn't really
> > have time to look into the details, but just letting you know.
> 
> Looks like the new jack stuff broke something.  Keyon, could you take a look?

I noticed this today and root caused it. Will provide a patch for it tomorrow. 

~Keyon

> 
> 
> thanks,
> 
> Takashi
> 
> 
> >
> > BR,
> > Jani.
> >
> >
> > [1] https://bugs.freedesktop.org/show_bug.cgi?id=90229
> > [2] git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> >
> >
> > --
> > Jani Nikula, Intel Open Source Technology Center
> >
