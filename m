From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: midi clock + timers
Date: Sat, 8 Feb 2003 21:58:28 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302082157590.1141-100000@pnote.perex-int.cz>
References: <1044737075.31824.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1044737075.31824.9.camel@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: rob buse <rcbuse@filter24.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 8 Feb 2003, rob buse wrote:

> hello everyone.
> 
> I'm curious if anyone else has run into this problem, and perhaps what
> your solutions are.  I have my kernel, 2.4.20, timer set at 1000Hz, low
> latency patch + preempt patch.  
> 
> Now, I have my sequencer that prebuffers midi clock into the alsa
> sequencer, so they are in the queue way before they need to get played. 
> My problem is, I get all these little glitches from my delays that sync
> to midi clock, as if there is jitter in the clock.  I am not really sure
> what else to do..   is this a kernel issue?  I mean, I figure if the
> clocks triggering at ~1ms, and a tick has to go out every 20ms for a
> 120bpm song..  this shouldn't be an issue.  right ?
> 
> Any suggestions?  I'm out of ideas...

Hardware?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
