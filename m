From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Invalid MIDI recordings and silent external playback
Date: Mon, 26 Aug 2002 15:40:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D6A2FB0.3E66FC4C@ladisch.de>
References: <20020825235321.A8218@liam2.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Will <walsac@liam2.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Will wrote:
> 1) Every MIDI file recording from external MIDI instruments
>    contains invalid time values in each MIDI event,

The time values in your example file indeed look strange,
but a rawmidi device doesn't care about timing, the recording
application is responsible for measuring the time when some data
is available.

Try "cat /dev/midi???" with your device. This will output the
incoming data as ASCII (i.e. garbage), but the garbage should
appear at the same moment you press the keys on your MIDI
keyboard.

> 2) Valid MIDI files won't playback to external MIDI
>    instruments -- there is no sound output.

Please try the midiloop program in the alsa-lib/tests directory
with MIDI Out connected to MIDI In.

> Is anyone working on a patch for rawmidi.c?

On my machine (not a Soundblaster) rawmidi works, so the problem
is most likely not in rawmidi.c.


HTH
Clemens


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
