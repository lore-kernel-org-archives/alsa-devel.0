From: Ove Kaaven <ovek@transgaming.com>
Subject: the emu10k1 midi bug
Date: Sat, 13 Mar 2004 18:09:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1079197776.962.683.camel@renegade>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Now for something completely different. I've seen in your sound card
info page for emu10k1 that there's a known bug:

- wavetable drops notes sometimes. (a good test example wanted.)

I've encountered this randomly sometimes, but I think I also have an
example of the opposite - a note that is never turned off - that
manifests every single time for me. So I'm wondering if anyone else can
reproduce.

1. Install MusE 0.6.3. (pmidi or aplaymidi does not exhibit the problem,
but MusE does; other sequencers are untested, though, as they all seem
to be for KDE, which I won't use)
2. Get the MIDI file at http://www.ping.uio.no/~ovehk/ABKEY_17.MID
3. Start MusE as an ordinary user. Do not start as root. The problem is
much more rarely seen if you let it have real-time privileges. For me it
doesn't even get at /dev/rtc when I run as ordinary user.
4. Load up the MIDI file. Hit the "Play" button.
5. After playback completes, you should still hear a faint sound of an
instrument which did not have note-off processed properly.
6. Hit the "Panic" button (crossed-out speaker on the right of the
toolbar) when you get tired of hearing it.

If it helps, I narrowed the note-on down to Track 6 (channel 10),
apparently start of beat 4, but did not see anything out of the ordinary
in the event list.

I haven't seen such issues in other MIDI files when I run as an ordinary
user, so it doesn't look much like a MusE bug to me, though I could be
wrong. If it's ALSA's bug, then I hope this recipe helps efforts in
debugging it.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
