From: Mark Knecht <markknecht@attbi.com>
Subject: HDSP 9652 MIDI Timing - Much improved, but no Port 1...
Date: 23 Jan 2003 19:44:49 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1043351090.2341.13.camel@Godzilla>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul, Takashi-san and Clemens,
   Hi. A couple of days ago Fernando got a new RPM built for Alsa which
includes the recent HDSP 9652 MIDI timing fix that you worked together
on and supplied about 10 days ago. I wanted to report back that the
timing is now much improved. I haven't used it a lot yet, but I am
playing moderately complicated songs now and the timing seems fine.
Thanks.

   There is one problem that has come up new in this release. The HDSP
9652 has two MIDI ports. With this release I can only get MIDI out on
Port 2. I cannot get MIDI out at all on Port 1. Both ports used to work
on the previous version, albeit with bad timing, so this fix this has
changed this aspect of the driver.

   I also tried using kaconnect to look at the connections between
Rosegarden and the alsa_sequencer. It shows that Rosegarden is hooked to
64:32 External MIDI 0 only. A second group, 64:0 External MIDI 0 shows
up, but kaconnect will not connect to it. I do not know what that means,
but it seems to be part of it.

   It strikes me that I have not done any recording with this device, so
I should do some of that before we make any more driver changes.
However, I wanted to report back a big thanks for a step in the right
direction, even if we are not quite all the way there yet and allow you
to look at what might be causing this problem.

   If there is any specific testing you'd like me to do, please let me
know and I'll try to get to it as soon as possible. I'd like to get this
card fully supported (yes, the mixer too Paul!) ;-) as I get 2-3 emails
a week from people asking me if they should buy the card and I'd like to
tell them yes.

Thanks much,
Mark





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
