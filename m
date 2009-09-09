From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Problems with safe API and snd-cs46xx
Date: Wed, 9 Sep 2009 16:27:17 +0200
Message-ID: <20090909142717.GE14530@tango.0pointer.de>
References: <s5hbplmssrg.wl%tiwai@suse.de>
	<20090907224659.GA5917@tango.0pointer.de>
	<s5htyzej6fj.wl%tiwai@suse.de>
	<a080dbc80909080046p73207442ld8f6577ebbf37ba9@mail.gmail.com>
	<s5hws49rf58.wl%tiwai@suse.de> <s5hpra01is7.wl%tiwai@suse.de>
	<a080dbc80909090529w3e958f27g38d8238836e415e2@mail.gmail.com>
	<s5hk5081ekp.wl%tiwai@suse.de>
	<20090909140735.GC14530@tango.0pointer.de>
	<s5h63bs19yc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id E542A24472
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 16:27:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h63bs19yc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sophie Hamilton <sophie-alsa@theblob.org>, alsa-devel@alsa-project.org, Tony Vroon <tony@linx.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 09.09.09 16:14, Takashi Iwai (tiwai@suse.de) wrote:

> > > > I can confirm now that Audacious does indeed play correctly where it
> > > > didn't before. However, using mplayer with the "-ao openal" switch
> > > > still doesn't play correctly - in fact, it sounds the same as before -
> > > > so it looks like OpenAL is actually doing things slightly differently
> > > > than I thought. :/
> > > 
> > > Yes, likely.  The app like openal is usually more sensible regarding
> > > latency, so "safe API" described there wasn't appropriate at all.
> > 
> > Hmm, so are you suggesting I should change that little text about the
> > safe API subset I wrote?
> 
> Maybe a bit more addition would be helpful.  The realtime apps do
> care the latency.  So, obviously it's not the target of your
> description.

What I wrote is actually this:

    "Do not touch buffering/period metrics unless you have specific
    latency needs. Develop defensively, handling correctly the case
    when the backend cannot fulfill your buffering metrics requests. Be
    aware that the buffering metrics of the playback buffer only
    indirectly influence the overall latency in many cases. i.e. setting
    the buffer size to a fixed value might actually result in practical
    latencies that are much higher."

i.e. it already says "... unless you have specific latency needs". The
point of this is that RT apps should of course set the buffer size,
however stuff like media players where the latency does not matter at
all should not request artificially low latencies and thus decrease
battery time needlessly.

> 
> > So, users should always set first the buffer size, followed by the
> > period size, is that correct?
> 
> Yes, in general, this order gives more chance for a larger buffer
> size.  But, if you specify both buffer and period sizes, there
> shouldn't be much difference.  Specifying the buffer size is
> especially good if you don't give any period size.
> 
> The situation is improved now with 1.0.21a since I changed the
> determination order in alsa-lib.  You'll get the largest buffer size
> as default with 1.0.21a (let's see whether this gives any regressions
> ;)  But, if portability matters, setting thebuffer size would be
> safer.

This sounds good to me. Defaulting to large buffer sizes is certainly
good for power consumption.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
