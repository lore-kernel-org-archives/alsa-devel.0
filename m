From: Ryan Pavlik <rpav@nwlink.com>
Subject: MTP/AV / Sequencer MIDI problem... design issue?
Date: Fri, 10 Jan 2003 11:37:11 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030110113711.06e8ee2d.rpav@nwlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Basically, the problem is this.  The MTP/AV protocol takes messages
like this:

   Dn B1 ... Bn

Where Dn is the device number, and B1..Bn are the midi message bytes.
This, at least, is what I gather from talking to Michael Mayers, the
original driver developer.

You may see the problem now.  When multiple threads talk to the device
at once, you have a problem:

A:  Dn B1 ,, ,, B2 ...
B:        Dn B1 ,, ...

The userland solution, when writing raw midi, is to just put a mutex
on the device and never write an incomplete message.

That is, of course, not an acceptable solution, and it also doesn't
work when you're using the ALSA sequencer interface (at least from the
API calls I've seen).  Fixing it in the driver requires interpreting
much MIDI, possibly buffering, and has some problems (what if someone
writes an incomplete message and dies?).

I'd like to hear recommendations; I have a particular interest in
seeing this work and am more than willing to submit patches.

-- 
Ryan Pavlik <rpav@users.sf.net>

"Hey! Captain talks-too-much, quiet time is now."


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
