From: Will <walsac@liam2.demon.co.uk>
Subject: Re: Please do not release ALSA 1.0 yet
Date: Tue, 11 Mar 2003 12:15:15 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303111215.MAA31644@koyuki.liam2.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: zero0w@yahoo.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Wily,

Thanks for your suggestions but I'm not sure I explained what I'm trying
to do clearly enough.  I use MIDI keyboards.
As I said in my earlier postings I need to use
ALSA's *OSS-mode* sequencer with a MIDI *keyboard* and
the original Rosegarden version 2.1p4 (or earlier)
e.g. http://www.liam2.demon.co.uk/rosegarden.tar.bz2
I do not want to use the sequencer to play MIDI files on my soundcard.

I know ALSA's ALSA-mode sequencer works fine with MIDI keyboards
but I cannot use it.  This is because the original OSS-mode Rosegarden
is the best large-scale score-based composition software.
I have tried alternative software for the ALSA-mode sequencer
such as the new Rosegarden, Brahms, Noteedit, and of course Muse
but frankly none of them is as efficient as the original Rosegarden
for handling *large-scale* score writing.

I've got a Soundblaster AWE64 Gold, whose OSS-mode sequencer works
fine with MIDI keyboards using OSSFree sound drivers and the
original OSS-mode Rosegarden.  The problem is that ALSA's
OSS-mode sequencer appears broken with MIDI keyboards.
The awemidi package from Takashi Iwai's AWE32 driver
provides drvmidi, txtplay, miditext and tkmidi but
none of these work with MIDI keyboards and ALSA's OSS-mode sequencer.

To anyone reading this, please try using a MIDI keyboard with ALSA's
OSS-mode sequencer.  You cannot see the bug without using a MIDI keyboard
and ALSA's OSS-mode sequencer.

Thanks Wily for replying to my question.

William



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
