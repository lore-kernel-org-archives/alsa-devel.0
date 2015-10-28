From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: Packages 1.0.30 - release pending
Date: Wed, 28 Oct 2015 15:06:20 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84B866C43@shsmsx102.ccr.corp.intel.com>
References: <561AB391.6030504@perex.cz> <s5hvbaca40c.wl-tiwai@suse.de>
 <s5hlhaomjem.wl-tiwai@suse.de> <1445959655.7199.12.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AA2AC261A80
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 16:06:32 +0100 (CET)
In-Reply-To: <1445959655.7199.12.camel@loki>
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
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Liam Girdwood [mailto:liam.r.girdwood@linux.intel.com]
> Sent: Tuesday, October 27, 2015 11:28 PM
> To: Takashi Iwai
> 
> On Tue, 2015-10-27 at 16:16 +0100, Takashi Iwai wrote:
> > On Mon, 12 Oct 2015 10:24:19 +0200,
> > Takashi Iwai wrote:
> > >
> > > On Sun, 11 Oct 2015 21:08:01 +0200,
> > > Jaroslav Kysela wrote:
> > > >
> > > > Hi all,
> > > >
> > > > 	I would like to release 1.0.30 version of all packages. Things to
> discuss:
> > >
> > > There are pending issues: one is about the topology ABI and this
> > > seems still in flux.  I suppose this will be stabilized in 4.4.
> > > Also, the documentation for BAT is utterly missing, and I expect
> > > we'll get this soonish.  Liam, Mengdong, any comments on these?
> >
> 
> BAT (stage1) is now upstream including documentation. Caleb and Han are
> working on new BAT features and these should be part of the 1.0.31 alsa
> package release.
> 
> > It seems that still topology stuff updates are missing in alsa-lib
> > side.  Liam, Mengdong, what's the status?  Jaroslav seems lifting up
> > the stuff now, starting tagging v1.1.0.
> >
> > Unless it's stabilized, we should disable the topology stuff in
> > configure level for alsa-* 1.1.0, IMO.
> >
> >
> 
> I think Mengdong is testing/polishing the final topology patches atm.
> Mengdong, are we good to start upstreaming soon ?
> 
> Liam

Hi Liam and Takashi,

For topology, most features for DAI & DAI links have been verified. 
I'll finish verifying the remaining ops binding features in this week.
Then I'll ask Vinod to double check we can meet request for SKL/BXT

Some of the kernel patches will be submitted by end if this week.
I expect the other kernel and user space patches will be submitted next week after the internal review.

Thanks
Mengdong
