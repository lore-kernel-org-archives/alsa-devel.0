From: Immanuel Litzroth <immanuell@enfocus.be>
Subject: Re: YES! :-) Was: Bug: ALSA Sequencer or MTPAV - easy to reproduce
Date: 13 Feb 2003 12:54:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m23cmsjszk.fsf@enfocus.be>
References: <20030212123025.12b1c582.rpav@nwlink.com>
	<Pine.LNX.4.44.0302122136400.30420-100000@pnote.perex-int.cz>
	<20030212134436.3b9e2f10.rpav@nwlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030212134436.3b9e2f10.rpav@nwlink.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Pavlik <rpav@nwlink.com>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The information about the emagic unitor8 has also this

	Der Befehl F5 gefolgt von einem Datenbyte bestimmt die gerade aktive
        Kabelnummer (0,1,2,3 ... 64).

	Ist die Kabelnummer=0 werden alle MIDI Messages auf allen MIDI Outs
	ausgegeben (alle Outs von allen Boxen).
	Nach einem Kaltstart ist die Kabelnummer=0.

        Die Kabelnummer '7F' (dumme MIDI Schnittstelle) verhaelt sich wie die
        Kabelnummer 0. Kabelnummer '7F' sollte beim Verlassen von LOGIC
        gesendet werden, da dadurch moegliche Filter(MIDI In/Out) geloescht
        werden. Siehe MOTU: Mute NON-CHANNEL Messages.


Since this device is supposed to be compatible with the MOTU (or have
a motu-compatible mode) the documentation at
http://www.math.tu-berlin.de/~sbartels/unitor/unitor8_doc.txt
could maybe help
Immanuel

*************************************************************************** 
I have always been fascinated by those who want to work.
Prunesquallor - Ghormenghast
Immanuel Litzroth
Software Development Engineer
Enfocus Software
Kleindokkaai 3-5
B-9000 Gent
Belgium
Voice: +32 9 269 23 90
Fax : +32 9 269 16 91
Email: Immanuell@enfocus.be
web : www.enfocus.be
***************************************************************************



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
