From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH v3 0/1] Codec driver for TI WL1273 FM Radio.
Date: Sat, 24 Jul 2010 13:19:57 +0300
Message-ID: <1279966797.12777.45.camel@masi.mnp.nokia.com>
References: <1279888971-14296-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1279909489.3076.17.camel@odin>
	<1279958725.12777.38.camel@masi.mnp.nokia.com>
	<1279964777.3097.9.camel@odin>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id B167F245C4
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Jul 2010 12:20:08 +0200 (CEST)
In-Reply-To: <1279964777.3097.9.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Ujfalusi Peter <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-07-24 at 11:46 +0200, ext Liam Girdwood wrote:
> On Sat, 2010-07-24 at 11:05 +0300, Matti J. Aaltonen wrote:
> > Hi.
> > 
> > On Fri, 2010-07-23 at 20:24 +0200, ext Liam Girdwood wrote:
> > > On Fri, 2010-07-23 at 15:42 +0300, Matti J. Aaltonen wrote:
> > > > Hello all.
> > > > 
> > > > Thank you for comments and thanks to Peter for advice on constraints
> > > > and ALSA in general.
> > > > 
> > > > New in this version:
> > > > 
> > > > 1. Now constraints are used in the start-up function. It wasn't as big
> > > > a deal as I thought... Also now the codec is always in full duplex
> > > > mode.  But it still refuses to do the wrong thing with FM as real full
> > > > duplex is then impossible.
> > > > 
> > > > 2. Fixed the exported mode support function. The name in now
> > > > wl1273_get_format and it returns the audio interface format.
> > > > 
> > > > 3. Removed the remaining obsolete functions.
> > > > 
> > > > 4. Not actually new but...
> > > > 
> > > > >> I didn't do this yet. But could you give me the git URL and then
> > > > >> I'll resend?
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/lrg/sound-2.6.git
> > > > 
> > > > I tried the corresponding http URL
> > > > 
> > > > http://www.kernel.org/pub/scm/linux/kernel/git/lrg/sound-2.6.git but
> > > > got
> > > > 
> > > > fatal: 
> > > > http://www.kernel.org/pub/scm/linux/kernel/git/lrg/sound-2.6.git/info/refs
> > > > not found: did you run git update-server-info on the server?
> > > > 
> > > 
> > > Oh, that's the wrong URL. The correct one is :-
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git
> > > 
> > > Can you re-do against multi-component. The changes all relate to probe()
> > > and remove(). 
> > 
> > Yes. No problem... I actually woke up last night and realized that the
> > format function I wrote didn't have a NULL pointer check for the value
> > parameter... So please ignore the v2. patch. I'll send version v2.B
> > soon...
> > 
> 
> Ok, thanks.
> 
> Btw, now that we have a naming convention for components how about this
> having a "-radio" or "-fm" device suffix ?

That's not a problem either. I also noticed when comparing to other
codecs that some function names could be better...

But I saw that there are quite a lot changes that need to be done... so
this is something I can't do in a couple of hours. I'll go back to my
vacation and do it properly when I come back... after one week.

B.R.
Matti






> 
> Liam
