From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Invalid MIDI recordings and silent external playback
Date: Mon, 26 Aug 2002 10:55:07 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208261015290.567-100000@pnote.perex-int.cz>
References: <20020825235321.A8218@liam2.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020825235321.A8218@liam2.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Will <walsac@liam2.demon.co.uk>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Aug 2002, Will wrote:

> Raw MIDI input/output is not working in ALSA 0.9.0rc3 on a
> Soundblaster AWE64 Gold ISA and external MIDI instruments.
> Everything else works fine including MIDI file playback on
> the synth.  Playback on external MIDI gives total silence.
> For comparison, raw MIDI input works perfectly on the very
> same hardware on OSS/Linux 2.0.x [MIDI output was never
> implemented in OSS/2.0.x].   In detail:
> 
> 1) Every MIDI file recording from external MIDI instruments
>    contains invalid time values in each MIDI event,
>    meaning the file can't be played back.  The recorded
>    MIDI files do contain note-on and note-off events but
>    the files are useless without correct time values.
>    An example invalid MIDI files is in the attachment.
>    The recording was made in the Rosegarden sequencer
>    (it works ok on OSS/Linux 2.0.x)
> 
>    Is anyone working on a patch for rawmidi.c?

It should work. Can you verify that MIDI IN is broken for other software
as well? Note that rawmidi does not take care about timing at all. It
deliver events as fast as possible to application.

> 2) Valid MIDI files won't playback to external MIDI
>    instruments -- there is no sound output.

Note that throughput for MIDI output for SB16/AWE cards is only 200 bytes 
per second, because of hardware limitations when no loops are used in 
kernel. Try to increase your HZ value in linux/include/asm/params.h to 
1000 or 2000. You should have better results.

> 3) make install didn't install the ALSA headers
>    /usr/include/alsa/* like it did with old ALSA betas.
>    Is this new behaviour correct?  How do you get a
>    complete set of ALSA headers installed automatically?
>    rm -rf existing headers doesn't trigger a re-install.

New path is /usr/include/sound/*.

> 4) BTW, is anyone working on MIDI RESET for ALSA 1.0.0?
>    alsa-kernel/core/rawmidi.c says MIDI reset is in the
>    TODO stage. I have instruments that sometimes need
>    MIDI reset.  OSS/Linux 2.0.x had a handy seq_reset()
>    in drivers/sound/sequencer.c which mostly worked well.

I've removed these unimplemented functions. Actually, the current 
implementation sends 0xfe byte (active sensing) at close(). Sure, we
may modify this code to satisfy some non-standard devices.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
