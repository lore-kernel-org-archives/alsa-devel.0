From: Daniel Jacobowitz <drow@false.org>
Subject: Re: Surround sound and volume control question
Date: Mon, 9 Oct 2006 10:38:14 -0400
Message-ID: <20061009143814.GA14827@nevyn.them.org>
References: <20061008222726.GA23855@nevyn.them.org>
	<s5hiritr4nm.wl%tiwai@suse.de>
	<20061009134539.GA13343@nevyn.them.org>
	<1160402124.629.16.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1160402124.629.16.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 09, 2006 at 09:55:23AM -0400, Lee Revell wrote:
> On Mon, 2006-10-09 at 09:45 -0400, Daniel Jacobowitz wrote:
> > > alsactl save & restore should work for softvol.
> > > The softvol mixer element doesn't exist only at the very fresh state.
> > 
> > I see, I just tried it and alsactl will create a user control just
> > fine.  That's great.
> > 
> > I will give the softvol solution a try, and post the patches if it
> > works.
> > 
> 
> Isn't it inefficient to force all audio to go through a software volume
> control just to have a master volume?  Wouldn't it be better to make a
> ganged control in the driver (until the alsa-lib abstract mixer layer is
> ready)?

I did consider doing it this way over the weekend.  However, being able
to adjust the relative volumes of the different channels still seems
useful to me.  If you have a single unified control, then you mess up
trying to move the others.

What do you think?  Should I just slave them all together and remove
the other volume controls?  It's probably easier; it just seems somehow
lacking.

-- 
Daniel Jacobowitz
CodeSourcery

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
