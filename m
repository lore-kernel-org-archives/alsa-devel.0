From: Paul Marks <pmarks@employees.org>
Subject: Audigy2 Information
Date: 22 Mar 2003 02:47:00 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048319220.26234.59.camel@yevaud.ged.dynodns.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Okay, I don't mean to get anything wrong, but we seem to be doing a lot
of fiddling around with code here, but maybe looking at the diff between
the non-Audigy2 and with-Audigy2 versions of the emu10k1 (creative)
driver, we could glean more useful information?

http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/emu10k1/emu10k1/main.c.diff?r1=text&tr1=1.158.2.5&r2=text&tr2=1.169&diff_format=h

(This has probably already been done, but I'm trying to look
for options here :-)

But with that aside, this is probably a repeat message:

========================================================================

Here is a description of the jacks on the Audigy2, for future reference:

                                                        |
 _______________________________________________________|
/   ____       _      _      _      _      _      _     |
|  |____|     |_|    |_|    |_|    |_|    |_|    |_|    |
\_______________________________________________________|

     FW        6      5      4      3      2      1

FW - FireWire (Creative calls it: SB1394)

The connections are explained as follows:

1  - Digital Out   (External digital devices or digital speaker systems)
2  - Line In
3  - Mic In

4  - Line Out 1    (Front Speakers)
5  - Line Out 2    (Rear Speakers)
6  - Line Out 3    (Center, Subwoofer, Rear Center)

========================================================================

>From now on, I will try to refer to connectors by either their name or
number.
Here are my experiences with what mixer controls affect which outputs:
(For all of these, "Audigy Analog/Digital Output Jack" is ON)

Jack #1 (Digital Out)
------------------------------------------------------
    Well I don't have digital speakers but this generates lots
of noise on my headphones, which leads me to believe it's working.
I can actually make out the music I'm hearing, but just barely through
the static.  I don't know if that's normal or not.

Jack #4 (Line Out 1 / Front Speakers)
------------------------------------------------------
    Sound doesn't appear to work at all, but:
        Whenever "AA/DOJ" is turned on (from an off state),
        about 0.1 seconds of sound are heard, fading out to
        nothing.
    None of the mixer controls seem to affect this output

Jack #5 (Line Out 2 / Rear Speakers)
------------------------------------------------------
    "Wave Surround" affects RIGHT AND LEFT output channels.
        - Balance control works as expected.

Jack #6 (Line Out 3 / Center, Subwoofer, Rear Center)
------------------------------------------------------
    "Wave Center" affects LEFT output channel
    "Wave LFE" affects RIGHT output channel

========================================================================

In short, I can confirm that the only four things that seem to have
an effect are:
    - Wave Center
    - Wave LFE
    - Wave Surround
    - Audigy Analog/Digital Output Jack

========================================================================

I'd love to tinker with this if I had more time; I know my way around
C and such, but I don't know enough about hardware-level details to be
of much help, unless someone can give me some valuable pointers on where
to start looking.

I'd like to get my Audigy2 working just like anyone else, so I'll start
playing around if anyone can give me some pointers on where to start.

And I can't get patch loading to work, but I suppose wave playback needs
to work before MIDI/Synth/patches are worried about.

========================================================================

I hope this helps someone!
    - Paul Marks



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
