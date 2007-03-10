From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: pcm_multi broken in alsa-lib - no duplex
	mode	with	jackd
Date: Sat, 10 Mar 2007 14:17:13 +0000
Message-ID: <20070310141713.GA2868@localhost.localdomain>
References: <45F044D2.1060903@mnet-online.de> <s5hslcfmuk0.wl%tiwai@suse.de>
	<20070308215128.GA3349@localhost.localdomain>
	<s5hslcegynp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hslcegynp.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 09, 2007 at 05:38:34PM +0100, Takashi Iwai wrote:
> At Thu, 8 Mar 2007 21:51:28 +0000,
> John Rigg wrote:
> > 
> > On Thu, Mar 08, 2007 at 07:58:23PM +0100, Takashi Iwai wrote:
> > > At Thu, 08 Mar 2007 18:16:02 +0100,
> > > Simon Lewis wrote:
> > > > Many JACK users have successfully used the following patch:
> > > > 
> > > > http://www.sound-man.co.uk/linuxaudio/pcm_multi-patch
> > > 
> > > Well, the patch is no real fix.  It's likely a workaround for JACK,
> > > though.  Someone has to take time to track down this bug more deeply.
> > 
> > True, the patch is just a workaround for JACK. However, I would
> > argue that most users of pcm_multi are probably JACK users.
> 
> No, multi plugin is used in many surround PCM definitions as default.
> It's pretty hidden, but multi streams are no rare case.

I hadn't noticed that. Thanks for pointing it out (and thank you for
looking at this problem!)

> > Surely adding code that breaks something for the majority of users (no
> > matter how correct that code is in isolation) is not a good thing.
> 
> Sure.  However, this code addition was for bugfixes of major other use
> cases like above, IIRC.  The regression should be avoided and should
> be fixed.  But the point is, we (at least, I) haven't been enough
> informed, unfortunately (or simply burried in a big TODO list :)
> 
> Now, let's back to the original problem:  Could someone give a pointer
> describing for this problem, or just explain a bit details here?
> I vaguely remember but not precisely at all now...
> I'm willing to dig down after knowing how I can reproduce the bug.

To summarise, using multiple sound cards with pcm_multi and jackd
no longer works in duplex mode ever since extra linking code was
added to pcm_multi.c in alsa-lib-1.0.9rc1.

Trying to start jackd in duplex fails with a poll timeout message.
It still works in playback-only or capture-only modes.
The lack of duplex operation makes overdubbing in a recording studio,
for example, impossible.

A configuration which produces the problem with two ice1712 cards
set up as a 16 channel multi device is shown here:
http://www.sound-man.co.uk/linuxaudio/ice1712multi.html

With the .asoundrc described in the above link the following
command fails with a poll timeout message:

jackd -d alsa -P multi_playback -C multi_capture

The following still work:
jackd -d alsa -P multi_playback
jackd -d alsa -C multi_capture

John

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
