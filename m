From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: Re: controls for the ice1712
Date: Sat, 6 Jul 2002 15:34:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207061512430.11364-100000@pc40.e18.physik.tu-muenchen.de>
References: <m37kka5j0w.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m37kka5j0w.fsf@ccs.covici.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: John Covici <covici@ccs.covici.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 5 Jul 2002, John Covici wrote:

> Could some kind person answer a few questions about the controls of
> the ice1712. 
> 
I hope so ;-) Which card do you actually have? My experience is limited to 
the Hoontech SoundTrack DSP24 Value and I have yet to test the SPDIF 
capabilities. However, I dived somewhat into the code. Hope it helped;-)

> I have the manual for the card and I use it with that other operating
> system all the time, but I cannot figure out how the alsa controls
> correspond.
> 
> What I would like to do more specifically is playback through the
> spdiff out interface, set the sample rate to 44.100 khz, to record I
> have to set the clock and sample rate to spdiff and after recording
> is over set it back to internal.  I usually want to record from the
> sp/diff input as well.
> 
I don't know about the recording, but the selection of the source for the 
SPDIF output and external/internal clock can be made in /etc/asound.conf. 
You would have to create two versions of this file (it comes from alsactl 
-store) for internal/external clock and load them in turn with alsactl 
-restore (I have forgotten the flag to specify a filename, but it is in 
the manpage). These settings are near the end of the file and the names 
are "Multi Track IEC958 Master" for the internal/external clock setting 
and "IEC958 Playback Route" for the selection of what to play on the SPDIF 
output. You would have to set the Master setting to on/off in the two 
config files and the Route to "Digital Mixer" to get the best control over 
what happens.

There also is the ncurses based program alsamixer which lets you set the 
volume for the SPDIF input, and I think it even lets you change the 
internal/external clock master with the "mute" (m) switch, when the cursor 
is on the appropriate column. If this is overkill for you, I also remember 
to have switched things like that with amixer, but you would have to read 
the manpage as the command line syntax is not truly intuitive.

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Got root? We do.
http://thinkgeek.com/sf
