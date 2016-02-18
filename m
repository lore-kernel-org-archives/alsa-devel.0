From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda - hdmi get jack from
 hda_jack_tbl when not dyn_pcm_assign
Date: Thu, 18 Feb 2016 08:23:43 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1904667C47@shsmsx102.ccr.corp.intel.com>
References: <1455773102-135817-1-git-send-email-libin.yang@linux.intel.com>
 <96A12704CE18D347B625EE2D4A099D1904667A3F@shsmsx102.ccr.corp.intel.com>
 <s5hk2m2313b.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D1904667B71@shsmsx102.ccr.corp.intel.com>
 <s5hfuwq30fn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 34366265D57
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 09:23:52 +0100 (CET)
In-Reply-To: <s5hfuwq30fn.wl-tiwai@suse.de>
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
> Sent: Thursday, February 18, 2016 4:09 PM
> To: Yang, Libin
> Cc: libin.yang@linux.intel.com; alsa-devel@alsa-project.org; Lin,
> Mengdong
> Subject: Re: [PATCH] ALSA: hda - hdmi get jack from hda_jack_tbl when
> not dyn_pcm_assign
> 
> On Thu, 18 Feb 2016 09:06:47 +0100,
> Yang, Libin wrote:
> >
> > Hi Takashi,
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Thursday, February 18, 2016 3:55 PM
> > > To: Yang, Libin
> > > Cc: libin.yang@linux.intel.com; alsa-devel@alsa-project.org; Lin,
> > > Mengdong
> > > Subject: Re: [PATCH] ALSA: hda - hdmi get jack from hda_jack_tbl
> when
> > > not dyn_pcm_assign
> > >
> > > On Thu, 18 Feb 2016 07:16:29 +0100,
> > > Yang, Libin wrote:
> > > >
> > > > Hi Takashi,
> > > >
> > > > I submitted the patch which can fix a regression involved from my
> > > > jack patch:
> > > > commit 25e4abb33df3aafa7d1efba8f82f9178268efab1
> > > > Author: Libin Yang <libin.yang@linux.intel.com>
> > > > Date:   Tue Jan 12 11:13:27 2016 +0800
> > > >
> > > >     ALSA: hda - hdmi jack created based on pcm
> > > >
> > > > I'm sorry for the inconvenience.
> > > >
> > > > As the dyn pcm patches are merged into the for-next branch, I'm
> asking
> > > > our QA to do the full test on it. They said they can start the stress
> test
> > > > from next week.
> > >
> > > One concern is the report from CI test about the crash at unloading
> > > the module.  I couldn't reproduce it locally.  Could you take a look?
> >
> > There is the same oops when unloading snd modules on my side
> > (it happens occasionally).
> > With the patch, the oops is fixed. But I didn't meet the crash.
> > The system is still alive.
> 
> Hmm.  I wonder it because the report was done for HSW, so your patch
> (I suppose you meaning the patch 'ALSA: hda - hdmi get jack from
> hda_jack_tbl when not dyn_pcm_assign') shouldn't change anything.

If so, my patch may not help.

BTW: could you tell me how you know that the report was done 
from the dmesg?

> 
> 
> Takashi
