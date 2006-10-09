From: Daniel Jacobowitz <drow@false.org>
Subject: Re: Surround sound and volume control question
Date: Mon, 9 Oct 2006 10:53:57 -0400
Message-ID: <20061009145357.GA15542@nevyn.them.org>
References: <20061008222726.GA23855@nevyn.them.org>
	<s5hiritr4nm.wl%tiwai@suse.de>
	<20061009134539.GA13343@nevyn.them.org>
	<1160402124.629.16.camel@mindpipe>
	<20061009143814.GA14827@nevyn.them.org>
	<1160404977.629.22.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1160404977.629.22.camel@mindpipe>
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

On Mon, Oct 09, 2006 at 10:42:56AM -0400, Lee Revell wrote:
> On Mon, 2006-10-09 at 10:38 -0400, Daniel Jacobowitz wrote:
> > I did consider doing it this way over the weekend.  However, being
> > able to adjust the relative volumes of the different channels still
> > seems useful to me.  If you have a single unified control, then you
> > mess up trying to move the others.
> > 
> > What do you think?  Should I just slave them all together and remove
> > the other volume controls?  It's probably easier; it just seems
> > somehow lacking.
> > 
> 
> How do other OSes do it?  Do they also force everything through a
> software volume control?

Unfortunately, I could find a program to dump the ice1724's IO space in
Windows, but I couldn't find anything to dump the vt1617a AC97
registers (which require writes to select the registers IIRC).  If
you've got a recommendation, I can boot this machine into Windows and
see what happens to the vt1617a's registers when the Windows driver
adjusts the volume.

> Is a ganged master control fundamentally incompatible with individual
> channel volumes?  If so, doesn't it mean that this problem can never be
> solved by an abstract mixer layer?

I don't know.  I guess you could preserve individual channel volumes by
saving them separately (outside the registers), and using a volume of
"master control plus channel control".  But I don't know how the
resulting quality would be or how tricky it would be to implement.
Right now we never cache the volumes corresponding to hardware
registers.

-- 
Daniel Jacobowitz
CodeSourcery

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
