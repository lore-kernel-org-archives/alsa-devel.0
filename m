From: Will <walsac2@liam2.demon.co.uk>
Subject: Re: [PATCH] add aplaymidi & arecordmidi utils
Date: Wed, 25 Feb 2004 13:02:15 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402251302.NAA11368@liam2.demon.co.uk>
References: <Pine.HPX.4.33n.0402241836390.5168-100000@studcom.urz.uni-halle.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0402241836390.5168-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: clemens@ladisch.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch <clemens@ladisch.de> wrote:
>Will wrote:
>> How easy would it be to make aplaymidi be able to adjust the playback speed
>> like playmidi?  (playmidi -t 0.5 music.mid plays at twice the default speed)
>
>Very easy.

1 hour of code changes?

>> How easy would it be to make aplaymidi be able to move forwards and backwards
>> during playback, e.g. by pressing f or b, like Takashi Iwai's drvmidi?
>
>Not so easy; even more so if you want to have correct controller
>values.  Adjusting settings changed by sysexs would be almost
>impossible.
>

I wonder whether drvmidi actually does correctly restore controller and sysex
when you move during MIDI playback.  I haven't studied the drvmidi code in
detail.  I know the sound quality always seems to be correct
even when you move forwards and backwards very often in a piece with
lots of sysex and controller settings.

>However, these tools are meant as basic command-line utilities (and
>examples).  I think your suggestions would fit better into some GUI
>player.

Yes, you're right a GUI player can be much more powerful but I also like
command-line players like drvmidi because you can always run them without X
and moving forwards and backwards using the ncurses interface is easy.
It's a useful minimum functionality (being able to move forwards and backwards
in a MIDI file while it's playing) but it sounds like it'd be difficult
to extend arecordmidi to do this.

William



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
