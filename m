From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Alsa and hdspmixer segfault
Date: Fri, 01 Oct 2004 14:16:07 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096654567.24868.46.camel@krustophenia.net>
References: <200410011808.i91I8cci001653@sanctuary.aproximation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200410011808.i91I8cci001653@sanctuary.aproximation.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: thewade <pdman@aproximation.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-10-01 at 14:08, thewade wrote:
> > > p.s. I have 2.6.9-rc3 kernel. I get errors when I try to apply the
> > > latest low latency patch:
> > > 
> > >http://people.redhat.com/mingo/voluntary-preempt/voluntary-preempt-full-2.6.9-rc2-mm4-S7
> > > Any tips? (hdspmixer is more important than this)
> > 
> > Well, it\'s obvious why it doesn\'t work.  You say you have 2.6.9-rc3, but
> > the S7 patch is against 2.6.9-rc2-mm4, as the name clearly indicates. 
> > You need to get that kernel to apply S7.
> 
> Yes, I realize that I have 2.6.9-rc3 kernel and this is a 2.6.9-rc2 patch.
> I was wondering if anybody had the patch files broken down into specific
> changes or if there was some way of patching the new code without doing it
> by hand.

Currently no.  You have to download and apply the patches in the order
spacified in my other email.  In particular the -mm patch is very
large.  The -mm kernel is basically filling the role of 2.7 for now.  It
is an experimental, development kernel that should not really be used on
production systems.

> Alternitvely one could tell me how fast developement is going on that thread
> of low-latenct patches and approximately how long it would be to wait to get
> the proper patch.

Once all the major bugs are resolved, Ingo will generate a patch against
the standard kernel.  For now you have to apply the -mm patch then the
VP patch.

> 
> I had simply run the patch to see if the affected files had not been changed,
> as I do not know how many or which files will be modified by the patch.
> 
> Lastly, what is the best way to determine the latency of my pesent kernel?

What is the smallest period size you can use without xruns?  Same
concept as ASIO, you set the latency (aka period size) to the lowest
value that doesn't cause clicks and pops.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
