From: Gary Scavone <gary@ccrma.Stanford.EDU>
Subject: alsa sequencer event raw data
Date: Thu, 1 Jul 2004 11:38:09 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0407011127470.9743-100000@ccrma-gate.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I'm trying to figure out how ALSA sequencer events work.  I assumed
that raw8 and raw32 data would simply be the actual MIDI byte values
sent.  But when I read events from "Virtual Keyboard", the first byte
is always equal to the channel number, rather than the message type +
channel number.  Am I misunderstanding the purpose of these types?

What I want is the raw MIDI bytes but I want to use the convenience of 
the sequencer structure to allow virtual port connections.

--gary



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
