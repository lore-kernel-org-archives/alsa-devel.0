From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Packages 1.0.30 - release pending
Date: Tue, 27 Oct 2015 15:27:35 +0000
Message-ID: <1445959655.7199.12.camel@loki>
References: <561AB391.6030504@perex.cz> <s5hvbaca40c.wl-tiwai@suse.de>
 <s5hlhaomjem.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 96472260603
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 16:30:09 +0100 (CET)
In-Reply-To: <s5hlhaomjem.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-10-27 at 16:16 +0100, Takashi Iwai wrote:
> On Mon, 12 Oct 2015 10:24:19 +0200,
> Takashi Iwai wrote:
> > 
> > On Sun, 11 Oct 2015 21:08:01 +0200,
> > Jaroslav Kysela wrote:
> > > 
> > > Hi all,
> > > 
> > > 	I would like to release 1.0.30 version of all packages. Things to discuss:
> > 
> > There are pending issues: one is about the topology ABI and this seems
> > still in flux.  I suppose this will be stabilized in 4.4.  Also, the
> > documentation for BAT is utterly missing, and I expect we'll get this
> > soonish.  Liam, Mengdong, any comments on these?
> 

BAT (stage1) is now upstream including documentation. Caleb and Han are
working on new BAT features and these should be part of the 1.0.31 alsa
package release.

> It seems that still topology stuff updates are missing in alsa-lib
> side.  Liam, Mengdong, what's the status?  Jaroslav seems lifting up
> the stuff now, starting tagging v1.1.0.
> 
> Unless it's stabilized, we should disable the topology stuff in
> configure level for alsa-* 1.1.0, IMO.
> 
> 

I think Mengdong is testing/polishing the final topology patches atm.
Mengdong, are we good to start upstreaming soon ?

Liam 
