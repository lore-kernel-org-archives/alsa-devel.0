From: Richard Bown <bownie@bownie.com>
Subject: Re: sequencing ALSA ports and clients
Date: Wed, 10 Apr 2002 17:40:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204101643.AFH98801@msgdirector1.onetel.net.uk>
References: <200204101341.AFH83147@msgdirector1.onetel.net.uk> <s5hit6zlhmx.wl@alsa2.suse.de>
Reply-To: bownie@bownie.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hit6zlhmx.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Takashi Iwai wrote:

> what do you mean exactly "full polyphony"?

I just meant getting your hands on the full polyphony of the synth.
Now I've realised that the sequencer interface (sensibly) treats the
on-board synth like any other MIDI device.

> it's not difficult at all to reimplement the driver to allow
> multi-notes-on-a-channel, but i don't think it's common.

No, that's fine.  I got a good reply from Matthias on LAD about the same
subject and as I said to him I think I'm still suffering under the old OSS
delusion that synth devices were still somehow "special" and the application
had to deal with its own voice allocations.  I was looking for a complicated
explanation to the behaviour I was seeing in my undoubtedly buggy code!

It took me so long to get my head around that OSS synth idea that I'm having
trouble letting go.

> four ports are provided to support more than 16 channels.

This is good stuff.  It all makes sense now.

Thanks,
R
-- 
http://www.all-day-breakfast.com/rosegarden
http://www.bownie.com
