From: rob buse <rcbuse@filter24.org>
Subject: Re: midi clock + timers
Date: 08 Feb 2003 15:59:08 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1044737949.32026.1.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0302082157590.1141-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302082157590.1141-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On Sat, 2003-02-08 at 15:58, Jaroslav Kysela wrote:
> On 8 Feb 2003, rob buse wrote:
> 
> > hello everyone.
> > 
> > I'm curious if anyone else has run into this problem, and perhaps what
> > your solutions are.  I have my kernel, 2.4.20, timer set at 1000Hz, low
> > latency patch + preempt patch.  
> > 
> > Now, I have my sequencer that prebuffers midi clock into the alsa
> > sequencer, so they are in the queue way before they need to get played. 
> > My problem is, I get all these little glitches from my delays that sync
> > to midi clock, as if there is jitter in the clock.  I am not really sure
> > what else to do..   is this a kernel issue?  I mean, I figure if the
> > clocks triggering at ~1ms, and a tick has to go out every 20ms for a
> > 120bpm song..  this shouldn't be an issue.  right ?
> > 
> > Any suggestions?  I'm out of ideas...
> 
> Hardware?
> 
oops..
using emu10k1 w/ 0.9.0rc6 drivers.





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
