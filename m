From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: MIDI velocity rewriting
Date: Tue, 7 Oct 2003 23:21:34 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031008042134.GB3451@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


Hi,

A problem that I have on some MIDI keyboards is that the velocity
information sent by the keyboard is just too low.  Banging on the
keyboard only results in a velocity of 90 for instance, instead of 127.
I can fix this in MIDI that I have captured by scanning for note-on
messages and adding either a fixed amount to them, or using a curve so
that notes closer to the max are only increased a little, where ones
that are very low get increased a lot.

The question is, does anyone know of any other way to make a MIDI louder
besides setting the master volume of the performer to highest, and doing
this rewriting of velocity information?  If not, I also had the idea
that perhaps this would be a useful thing to do in the ALSA MIDI layer.
For example, if the user specified to do so, the ALSA layer would
automatically increase velocity in the desired way for each note-on
message that comes from a given channel into the computer.

Of course there are probably things I haven't thought about, but
comments would be appreciated.

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
